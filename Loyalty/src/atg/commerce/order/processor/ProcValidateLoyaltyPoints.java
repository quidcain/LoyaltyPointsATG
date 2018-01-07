package atg.commerce.order.processor;

import loyalty.LoyaltyConfig;
import loyalty.LoyaltyManager;
import atg.commerce.order.LoyaltyPoints;
import atg.commerce.order.Order;
import atg.nucleus.GenericService;
import atg.service.pipeline.PipelineProcessor;
import atg.service.pipeline.PipelineResult;

public class ProcValidateLoyaltyPoints extends GenericService implements PipelineProcessor {
    private static int SUCCESS_CODE = 1;
    private static int[] RETURN_CODES = { SUCCESS_CODE };
	private LoyaltyConfig loyaltyConfig;
    private LoyaltyManager loyaltyManager;
    
	public int runProcess(Object param, PipelineResult pipelineResult) throws Exception {
		ValidatePaymentGroupPipelineArgs args = (ValidatePaymentGroupPipelineArgs) param;
		try {
			LoyaltyPoints lp = (LoyaltyPoints) args.getPaymentGroup();
			int paymentLoyaltyAmount = lp.getNumberOfPoints();
			double amount = lp.getAmount();
			Order order = args.getOrder();
			double orderPrice = getPrice(order);
			int loyaltyAmount = loyaltyManager.getLoyaltyPointsOfUser(order.getProfileId());
			if (paymentLoyaltyAmount <= 0) {
				pipelineResult.addError("NoPointsUsed", "The number of points should be greater than zero.");
			} else if(loyaltyAmount < paymentLoyaltyAmount) {
				pipelineResult.addError("NoEnoughPoints", "The user doesn't have enough loyalty points");
			} else if(amount > orderPrice * loyaltyConfig.getMaxLpOrderPart()) {
				pipelineResult.addError("PointsValueExceeded", "Store points cannot pay for more than "
						+ loyaltyConfig.getMaxLpOrderPart()  + " of an order");
			} else if (amount < loyaltyConfig.getPurchaseRate() * paymentLoyaltyAmount) {
				pipelineResult.addError("WrongExchangeRate", "Payment groups's loyalty points were wrong calculated"
						+ loyaltyConfig.getMaxLpOrderPart()  + " of an order");
			}
		} catch(ClassCastException e) {
			pipelineResult.addError("ClassNotRecognized", "Expected a LoyaltyPoints payment group, but got " + 
					args.getPaymentGroup().getClass().getName());
		}
		return 0;
	}
	
	private double getPrice(Order order) {
		return order.getPriceInfo().getTotal();
	}
	
	public int[] getRetCodes() {
		return RETURN_CODES;
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

}
