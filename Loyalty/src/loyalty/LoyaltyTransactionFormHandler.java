package loyalty;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;

import atg.droplet.DropletException;
import atg.repository.servlet.RepositoryFormHandler;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class LoyaltyTransactionFormHandler extends RepositoryFormHandler{
	private LoyaltyManager loyaltyManager;
	private String userId;
	
	@Override
	public boolean handleCreate(DynamoHttpServletRequest arg0,
			DynamoHttpServletResponse arg1) throws ServletException,
			IOException {
		if (getValue().get("AMOUNT") == null)
			addFormException(new DropletException("You must provide amount"));
		return true;
	}

	@Override
	protected void postCreateItem(DynamoHttpServletRequest pRequest,
			DynamoHttpServletResponse pResponse) throws ServletException,
			IOException {
		// TODO Auto-generated method stub
		super.postCreateItem(pRequest, pResponse);
	}
	
	public LoyaltyManager getLoyaltyManager() {
		return loyaltyManager;
	}

	public void setLoyaltyManager(LoyaltyManager loyaltyManager) {
		this.loyaltyManager = loyaltyManager;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	

}
