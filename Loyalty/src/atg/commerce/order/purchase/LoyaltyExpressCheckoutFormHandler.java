package atg.commerce.order.purchase;

import java.io.IOException;

import javax.servlet.ServletException;

import loyalty.LoyaltyConfig;
import loyalty.LoyaltyManager;
import atg.commerce.CommerceException;
import atg.commerce.order.LoyaltyPoints;
import atg.commerce.order.Order;
import atg.commerce.order.PaymentGroup;
import atg.dtm.TransactionDemarcationException;
import atg.repository.RepositoryException;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class LoyaltyExpressCheckoutFormHandler extends ExpressCheckoutFormHandler {
	private LoyaltyManager loyaltyManager;
	private LoyaltyConfig loyaltyConfig;
	
	public void preExpressCheckout(DynamoHttpServletRequest pRequest,
	        DynamoHttpServletResponse pResponse) throws ServletException, IOException {
	    Order order = getOrder();
	    if (order.getPaymentGroups().size() < 2) {
	        try {
	        	LoyaltyPoints loyaltyPoints = (LoyaltyPoints) getPaymentGroupManager().createPaymentGroup("loyaltyPoints");
	        	PaymentGroup existingPaymentGroup = (PaymentGroup) order.getPaymentGroups().get(0);
	        	loyaltyPoints.setAmount(existingPaymentGroup.getAmount() / 2);
	        	loyaltyPoints.setNumberOfPoints((int)loyaltyPoints.getAmount());
	        	existingPaymentGroup.setAmount(existingPaymentGroup.getAmount() / 2);
	            getPaymentGroupManager().addPaymentGroupToOrder(order, loyaltyPoints);
	        } catch (CommerceException e) {
	            if (isLoggingError()) {
	                logError(e);
	            }
	        }
	    }
	}
	
	public void postExpressCheckout(DynamoHttpServletRequest pRequest,
            DynamoHttpServletResponse pResponse) throws ServletException, IOException {
		if (isCommitOrder()){
			Order order = getOrder();
			int amount = getPrice(order);
			double lpEarnAmount = loyaltyConfig.getLpEarnAmount();
			int lpAmount = (int)(amount * lpEarnAmount);
			String profileId = order.getProfileId();
			String description = String.format("Earned %d loyalty points from order %s", lpAmount, order.getId());
			try {
				if (lpAmount > 0) {
					loyaltyManager.addLoyaltyPoints(lpAmount, description, profileId);
				}
			} catch (RepositoryException e) {
				e.printStackTrace();
			} catch (TransactionDemarcationException e) {
				e.printStackTrace();
			}
		}
	}

	public int getPrice(Order order) {
		return (int) order.getPriceInfo().getAmount();
	}
	
	public LoyaltyManager getLoyaltyManager() {
		return loyaltyManager;
	}

	public void setLoyaltyManager(LoyaltyManager loyaltyManager) {
		this.loyaltyManager = loyaltyManager;
	}

	public LoyaltyConfig getLoyaltyConfig() {
		return loyaltyConfig;
	}

	public void setLoyaltyConfig(LoyaltyConfig loyaltyConfig) {
		this.loyaltyConfig = loyaltyConfig;
	}
	
}
