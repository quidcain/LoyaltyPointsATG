package loyalty;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Enumeration;

import javax.servlet.ServletException;

import atg.droplet.DropletException;
import atg.dtm.TransactionDemarcationException;
import atg.repository.RepositoryException;
import atg.repository.servlet.RepositoryFormHandler;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class LoyaltyTransactionFormHandler extends RepositoryFormHandler{
	private LoyaltyManager loyaltyManager;
	
	@Override
	public boolean handleCreate(DynamoHttpServletRequest arg0,
			DynamoHttpServletResponse arg1) throws ServletException,
			IOException {
		if (getValue().get("AMOUNT") == null) {
			addFormException(new DropletException("You must provide amount"));
		} else if (getValue().get("PROFILEID") == null) {
			addFormException(new DropletException("You must specify profile to whom you want to add loyalty points"));
		} else {
			String loyaltyTransactionId = null;
			try{
				try {
					int amount = (Integer) getValue().get("AMOUNT");
					String description = (String) getValue().get("DESCRIPTION");
					String profileId = (String) getValue().get("PROFILEID");
					loyaltyTransactionId = loyaltyManager.createLoyaltyTransaction(amount, description, profileId);
				} catch(RepositoryException e) {
					if (isLoggingError())
						logError("Unable to create loyalty transaction", e);
		            addFormException(new DropletException("Unable to create loyalty transaction"));	
				}
				try {
					if (loyaltyTransactionId != null)
						loyaltyManager.associateTransactionWithUser(loyaltyTransactionId, getValue().get("PROFILEID").toString());
				} catch(RepositoryException e) {
					if (isLoggingError())
						logError("Unable to associate loyalty transaction to user", e);
		            addFormException(new DropletException("Unable to associate loyalty transaction to user"));	
				}
			} catch (TransactionDemarcationException e) {
				if (isLoggingError()) 
					logError("creating transaction demarcation failed, no loyalty points added", e);
				addFormException(new DropletException("creating transaction demarcation failed, no loyalty points added"));	
			}
		}
		return true;
	}
	
	public LoyaltyManager getLoyaltyManager() {
		return loyaltyManager;
	}

	public void setLoyaltyManager(LoyaltyManager loyaltyManager) {
		this.loyaltyManager = loyaltyManager;
	}
}
