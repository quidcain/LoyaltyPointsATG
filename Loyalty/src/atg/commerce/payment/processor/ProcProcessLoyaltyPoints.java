package atg.commerce.payment.processor;

import atg.commerce.CommerceException;
import atg.commerce.order.PaymentGroup;
import atg.commerce.payment.PaymentManagerPipelineArgs;
import atg.commerce.payment.processor.ProcProcessPaymentGroup;
import atg.payment.PaymentStatus;
import atg.payment.loyaltypoints.LoyaltyPointsInfo;
import atg.payment.loyaltypoints.LoyaltyPointsProcessor;

public class ProcProcessLoyaltyPoints extends ProcProcessPaymentGroup {
	private LoyaltyPointsProcessor loyaltyPointsProcessor;
	
	@Override
	public PaymentStatus authorizePaymentGroup(PaymentManagerPipelineArgs params) throws CommerceException {
	    LoyaltyPointsInfo loyaltyPointsInfo = null;
	    try {
	    	loyaltyPointsInfo = (LoyaltyPointsInfo) params.getPaymentInfo();
	    }
	    catch (ClassCastException cce) {
	      if (isLoggingError())
	        logError("Expecting class of type LoyaltyPointsInfo but got: " +
	        		params.getPaymentInfo().getClass().getName());
	      throw cce;
	    }
	    return loyaltyPointsProcessor.authorize(loyaltyPointsInfo);
	}

	@Override
	public PaymentStatus debitPaymentGroup(PaymentManagerPipelineArgs params) throws CommerceException {
	    LoyaltyPointsInfo loyaltyPointsInfo = null;
	    try {
	      loyaltyPointsInfo = (LoyaltyPointsInfo)params.getPaymentInfo();
	    }
	    catch (ClassCastException cce) {
	      if (isLoggingError())
	        logError("Expecting class of type LoyaltyPointsInfo but got: " +
	                  params.getPaymentInfo().getClass().getName());
	      throw cce;
	    }
	    PaymentGroup pg = params.getPaymentGroup();
	    PaymentStatus authStatus = params.getPaymentManager().getLastAuthorizationStatus(pg);
	    return loyaltyPointsProcessor.debit(loyaltyPointsInfo, authStatus);
	}

	@Override
	public PaymentStatus creditPaymentGroup(PaymentManagerPipelineArgs params) throws CommerceException {
	    LoyaltyPointsInfo loyaltyPointsInfo = null;
	    try {
	      loyaltyPointsInfo = (LoyaltyPointsInfo)params.getPaymentInfo();
	    }
	    catch (ClassCastException cce) {
	      if (isLoggingError())
	        logError("Expecting class of type LoyaltyPointsInfo but got: " +
	                  params.getPaymentInfo().getClass().getName());
	      throw cce;
	    }
	    PaymentGroup pg = params.getPaymentGroup();
	    PaymentStatus debitStatus =	params.getPaymentManager().getLastDebitStatus(pg);
	    return loyaltyPointsProcessor.credit(loyaltyPointsInfo, debitStatus);
	}

	public LoyaltyPointsProcessor getLoyaltyPointsProcessor() {
		return loyaltyPointsProcessor;
	}

	public void setLoyaltyPointsProcessor(LoyaltyPointsProcessor loyaltyPointsProcessor) {
		this.loyaltyPointsProcessor = loyaltyPointsProcessor;
	}

}
