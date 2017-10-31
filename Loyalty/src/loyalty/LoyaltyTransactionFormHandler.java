package loyalty;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Enumeration;

import javax.servlet.ServletException;

import atg.droplet.DropletException;
import atg.droplet.GenericFormHandler;
import atg.dtm.TransactionDemarcationException;
import atg.repository.RepositoryException;
import atg.repository.servlet.RepositoryFormHandler;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class LoyaltyTransactionFormHandler extends GenericFormHandler {
	private LoyaltyManager loyaltyManager;
	
	private Integer amount;
	private String description;
	private String date;
	private String profileId;
	
	protected boolean isValid() {
		if (this.amount == null) {
			addFormException(new DropletException("You must provide amount"));
			return false;
		} else if (profileId == null) {
			addFormException(new DropletException("You must specify profile to whom you want to add loyalty points"));
			return false;
		}
		return true;
	}
	
	public boolean handleCreate(DynamoHttpServletRequest arg0,
			DynamoHttpServletResponse arg1) throws ServletException,
			IOException {
		if (isValid()) {
			String loyaltyTransactionId = null;
			try{
				try {
					loyaltyTransactionId = loyaltyManager.createLoyaltyTransaction(amount, description, profileId);
				} catch(RepositoryException e) {
		            addFormException(new DropletException("Unable to create loyalty transaction"));	
				}
				try {
					if (loyaltyTransactionId != null)
						loyaltyManager.associateTransactionWithUser(loyaltyTransactionId, profileId);
				} catch(RepositoryException e) {
		            addFormException(new DropletException("Unable to associate loyalty transaction with user"));	
				}
			} catch (TransactionDemarcationException e) {
				addFormException(new DropletException("Creating of transaction demarcation failed, no loyalty points added"));	
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

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getProfileId() {
		return profileId;
	}

	public void setProfileId(String profileId) {
		this.profileId = profileId;
	}
	
}
