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
			return true;
		}
		getValue().put("DATE", new Timestamp(System.currentTimeMillis()));
		return super.handleCreate(arg0, arg1);
	}

	@Override
	protected void postCreateItem(DynamoHttpServletRequest pRequest,
			DynamoHttpServletResponse pResponse) throws ServletException,
			IOException {
		try {
			loyaltyManager.associateTransactionWithUser(getRepositoryItem(), getValue().get("PROFILEID").toString());
		} catch(RepositoryException e) {
			if (isLoggingError())
				logError("Unable to associate loyalty transaction to user", e);
            addFormException(new DropletException("Unable to associate loyalty transaction to user"));	
		}
	}
	
	public LoyaltyManager getLoyaltyManager() {
		return loyaltyManager;
	}

	public void setLoyaltyManager(LoyaltyManager loyaltyManager) {
		this.loyaltyManager = loyaltyManager;
	}
}
