package atg.commerce.payment.processor;

import atg.commerce.order.LoyaltyPoints;
import atg.commerce.order.Order;
import atg.commerce.payment.PaymentManagerPipelineArgs;
import atg.nucleus.GenericService;
import atg.payment.loyaltypoints.LoyaltyPointsInfo;
import atg.service.pipeline.PipelineProcessor;
import atg.service.pipeline.PipelineResult;

public class ProcCreateLoyaltyPointsInfo extends GenericService implements PipelineProcessor {
	private static final int SUCCESS_CODE = 1;
	private static int[] RETURN_CODES = { SUCCESS_CODE };
	private static final String LOYALTY_POINT_INFO_CLASS = "atg.payment.loyaltypoints.LoyaltyPointsInfo";

	protected LoyaltyPointsInfo getStorePointsInfo() throws Exception {
		if (isLoggingDebug()) {
			logDebug("Making a new instance of type: " + LOYALTY_POINT_INFO_CLASS);
		}
		LoyaltyPointsInfo loyaltyPointsInfo = (LoyaltyPointsInfo) Class.forName(LOYALTY_POINT_INFO_CLASS).newInstance();
    	return loyaltyPointsInfo;
	}
	
	protected void addDataToStorePointsInfo(Order order, LoyaltyPoints paymentGroup, double amount, 
			LoyaltyPointsInfo loyaltyPointsInfo) {
		loyaltyPointsInfo.setUserId(order.getProfileId());
		loyaltyPointsInfo.setOrderId(order.getId());
		loyaltyPointsInfo.setNumberOfPoints(paymentGroup.getNumberOfPoints());
		loyaltyPointsInfo.setAmount(paymentGroup.getAmount());
	}
	
	public int runProcess(Object param, PipelineResult result) throws Exception {
	    PaymentManagerPipelineArgs params = (PaymentManagerPipelineArgs) param;
	    Order order = params.getOrder();
	    LoyaltyPoints storePoints = (LoyaltyPoints) params.getPaymentGroup();
	    double amount = params.getAmount();
	    LoyaltyPointsInfo loyaltyPointsInfo = getStorePointsInfo();
	    addDataToStorePointsInfo(order, storePoints, amount, loyaltyPointsInfo);
	    if (isLoggingDebug()) {
	      logDebug("Putting LoyaltyPointsInfo object into pipeline: " + loyaltyPointsInfo.toString());
	    }
	    params.setPaymentInfo(loyaltyPointsInfo);
	    return SUCCESS_CODE;
	}
	
	public int[] getRetCodes() {
		return RETURN_CODES;
	}

}
