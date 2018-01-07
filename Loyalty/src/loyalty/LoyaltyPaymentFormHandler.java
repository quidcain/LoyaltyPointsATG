package loyalty;

import java.io.IOException;

import atg.commerce.CommerceException;
import atg.commerce.order.LoyaltyPoints;
import atg.commerce.order.Order;
import atg.commerce.order.PaymentGroup;
import atg.commerce.order.purchase.PurchaseProcessFormHandler;
import atg.droplet.DropletException;
import atg.dtm.TransactionDemarcation;
import atg.dtm.TransactionDemarcationException;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class LoyaltyPaymentFormHandler extends PurchaseProcessFormHandler {
	private LoyaltyConfig loyaltyConfig;
	private LoyaltyManager loyaltyManager;
	
	private String successURL;
	private Integer numberOfLoyaltyPoints;
	
	protected boolean isValid() {
		if (numberOfLoyaltyPoints == null || numberOfLoyaltyPoints == 0)
			return true;
		Order order = getOrder();
		double total = order.getPriceInfo().getTotal();
		int loyaltyAmount = loyaltyManager.getLoyaltyPointsOfUser(order.getProfileId());
		if (loyaltyAmount < numberOfLoyaltyPoints) {
			addFormException(new DropletException("You don't have enough loyalty points"));
			return false;
		} else if (numberOfLoyaltyPoints * loyaltyConfig.getPurchaseRate() > total * loyaltyConfig.getMaxLpOrderPart()) {
			addFormException(new DropletException("Loyalty points cannot pay for more than "
					+ loyaltyConfig.getMaxLpOrderPart()  + " of an order"));
			return false;
		}
		return true;
	}
	
	public boolean handleSubmit(DynamoHttpServletRequest req,
			DynamoHttpServletResponse resp) throws IOException { 
		if (isValid() && numberOfLoyaltyPoints != null && numberOfLoyaltyPoints != 0) {
			Order order = getOrder();
			if (order.getPaymentGroups().size() < 2) {
				try {
		        	LoyaltyPoints loyaltyPoints = (LoyaltyPoints) getPaymentGroupManager().createPaymentGroup("loyaltyPoints");
		        	loyaltyPoints.setNumberOfPoints(numberOfLoyaltyPoints);
		        	PaymentGroup existingPaymentGroup = (PaymentGroup) order.getPaymentGroups().get(0);
		        	double loyaltyPrice = numberOfLoyaltyPoints * loyaltyConfig.getPurchaseRate();
		        	loyaltyPoints.setAmount(loyaltyPrice);
		        	getPaymentGroupManager().addPaymentGroupToOrder(order, loyaltyPoints);
		        	getOrderManager().addOrderAmountToPaymentGroup(order, loyaltyPoints.getId(), loyaltyPrice);
		        	getOrderManager().addRemainingOrderAmountToPaymentGroup(order, existingPaymentGroup.getId());
		        } catch (CommerceException e) {
		            if (isLoggingError()) {
		                logError(e);
		            }
		        }
			}
		} else if (numberOfLoyaltyPoints != null && numberOfLoyaltyPoints != 0) {
			return true; 
		}
		if (getSuccessURL() != null) {
			resp.sendLocalRedirect(getSuccessURL(), req);
			return false;
		}
		return true;
	}

	public LoyaltyConfig getLoyaltyConfig() {
		return loyaltyConfig;
	}

	public void setLoyaltyConfig(LoyaltyConfig loyaltyConfig) {
		this.loyaltyConfig = loyaltyConfig;
	}

	public LoyaltyManager getLoyaltyManager() {
		return loyaltyManager;
	}

	public void setLoyaltyManager(LoyaltyManager loyaltyManager) {
		this.loyaltyManager = loyaltyManager;
	}

	public String getSuccessURL() {
		return successURL;
	}

	public void setSuccessURL(String successURL) {
		this.successURL = successURL;
	}

	public Integer getNumberOfLoyaltyPoints() {
		return numberOfLoyaltyPoints;
	}

	public void setNumberOfLoyaltyPoints(Integer numberOfLoyaltyPoints) {
		this.numberOfLoyaltyPoints = numberOfLoyaltyPoints;
	}
}
