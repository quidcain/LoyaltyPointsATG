package loyalty;

import java.sql.Timestamp;
import java.util.List;

import javax.transaction.TransactionManager;

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

	public String createLoyaltyTransaction(int amount, String description) throws RepositoryException {
		if (isLoggingDebug()) 
			logDebug("creating loyalty transaction with amount '" + amount + "' and description '" + description + "'");
		MutableRepository mutableRepository = (MutableRepository) getRepository(); 
		try {
			MutableRepositoryItem loyaltyTransactionItem = mutableRepository.createItem("loyaltyTransaction");
			loyaltyTransactionItem.setPropertyValue("amount", amount);
			loyaltyTransactionItem.setPropertyValue("description", description);
			loyaltyTransactionItem.setPropertyValue("date", new Timestamp(System.currentTimeMillis()));
			mutableRepository.addItem(loyaltyTransactionItem);
			return loyaltyTransactionItem.getRepositoryId();
		} catch(RepositoryException e) {
			if (isLoggingError()) {
				logError(e);
			}
			throw e;
		}
	}

	public void associateTransactionWithUser(String pLoyaltyTransactionid, String pUserid) throws RepositoryException {
		if (isLoggingDebug()) 
			logDebug("associating loyalty transaction " + pLoyaltyTransactionid + " to user " + pUserid);
		MutableRepository mutableRepository = (MutableRepository) getRepository();
		try {
			MutableRepositoryItem userItem = mutableRepository.getItemForUpdate(pUserid,"user");  
			RepositoryItem loyaltyTransactionItem = mutableRepository.getItem(pLoyaltyTransactionid,"loyaltyTransaction");
			List loyaltyTransactions = (List) userItem.getPropertyValue("loyaltyTransactions");
			loyaltyTransactions.add(loyaltyTransactionItem);
			userItem.setPropertyValue("loyaltyTransactions", loyaltyTransactions);
			mutableRepository.updateItem(userItem);
		} catch(RepositoryException e) {
			if (isLoggingError()) {
				logError(e);
			}
			throw e;
		}
	}

	public LoyaltyManager() {
		if (isLoggingDebug()) {
			logDebug("LoyaltyManager constructor called");
		}
	}
}
