package loyalty;

import java.sql.Timestamp;
import java.util.List;

import javax.transaction.SystemException;
import javax.transaction.TransactionManager;

import atg.dtm.TransactionDemarcation;
import atg.dtm.TransactionDemarcationException;
import atg.nucleus.GenericService;
import atg.repository.MutableRepository;
import atg.repository.MutableRepositoryItem;
import atg.repository.Repository;
import atg.repository.RepositoryException;
import atg.repository.RepositoryItem;

public class LoyaltyManager extends GenericService {
	private TransactionManager mTransactionManager;
	private Repository mRepository;
	private Repository mUserRepository;

	public void setTransactionManager(TransactionManager pTransactionManager) {
		mTransactionManager = pTransactionManager;
	}

	public TransactionManager getTransactionManager() {
		return mTransactionManager;
	}

	public void setRepository(Repository pRepository) {
		mRepository = pRepository;
	}

	public Repository getRepository() {
		return mRepository;
	}

	public void setUserRepository(Repository pUserRepository) {
		mUserRepository = pUserRepository;
	}

	public Repository getUserRepository() {
		return mUserRepository;
	}

	public void addLoyaltyPoints(int amount, String description, String profileId) throws RepositoryException, TransactionDemarcationException {
		TransactionDemarcation td = new TransactionDemarcation();
		td.begin(getTransactionManager(), td.REQUIRES_NEW);
		boolean rollback = true;
		try {
			String loyaltyTransactionId = createLoyaltyTransaction(amount, description, profileId);
			associateTransactionWithUser(loyaltyTransactionId, profileId);
			rollback = false;
		} catch(RepositoryException e) {
			try {
				getTransactionManager().setRollbackOnly();
			}
			catch (SystemException se) {
				if (isLoggingError())
					logError("Unable to set rollback for transaction", se);
			}
			throw e;
		} finally {
			td.end(rollback);
		} 
	}
	
	public int getLoyaltyPointsOfUser(String profileId) {
		Repository userRepository = getUserRepository();
		Integer loyaltyAmount;
		try {
			RepositoryItem user = userRepository.getItem(profileId, "user");
			loyaltyAmount = (Integer) user.getPropertyValue("loyaltyAmount");
		} catch (RepositoryException e) {
			e.printStackTrace();
			return 0;
		}
		return loyaltyAmount;
	}
	
	private String createLoyaltyTransaction(int amount, String description, String profileId) throws RepositoryException {
		if (isLoggingDebug()) 
			logDebug("creating loyalty transaction with amount '" + amount + "' and description '" + description + "'");
		MutableRepository mutableRepository = (MutableRepository) getRepository();
		MutableRepositoryItem loyaltyTransactionItem = mutableRepository.createItem("loyaltyTransaction");
		loyaltyTransactionItem.setPropertyValue("amount", amount);
		loyaltyTransactionItem.setPropertyValue("description", description);
		loyaltyTransactionItem.setPropertyValue("profileId", profileId);
		loyaltyTransactionItem.setPropertyValue("date", new Timestamp(System.currentTimeMillis()));
		mutableRepository.addItem(loyaltyTransactionItem);
		return loyaltyTransactionItem.getRepositoryId();
	}

	private void associateTransactionWithUser(String loyaltyTransactionId, String pUserid) throws RepositoryException {
		if (isLoggingDebug()) 
			logDebug("associating loyalty transaction " + loyaltyTransactionId + " to user " + pUserid);
		MutableRepository mutableUserRepository = (MutableRepository) getUserRepository();
		Repository loyaltyRepository = getRepository();
		MutableRepositoryItem userItem = mutableUserRepository.getItemForUpdate(pUserid,"user");  
		RepositoryItem loyaltyTransactionItem = loyaltyRepository.getItem(loyaltyTransactionId, "loyaltyTransaction");
		List loyaltyTransactions = (List) userItem.getPropertyValue("loyaltyTransactions");
		loyaltyTransactions.add(loyaltyTransactionItem);
		mutableUserRepository.updateItem(userItem);
	}

	public LoyaltyManager() {
		if (isLoggingDebug()) {
			logDebug("LoyaltyManager constructor called");
		}
	}
}
