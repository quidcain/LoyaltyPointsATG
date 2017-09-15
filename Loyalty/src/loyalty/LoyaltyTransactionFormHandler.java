package loyalty;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Enumeration;

import javax.servlet.ServletException;

import atg.droplet.DropletException;
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
		} else {
			String loyaltyTransactionId = null;
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
