package atg.payment.loyaltypoints;

import java.util.Date;

import loyalty.LoyaltyManager;
import atg.dtm.TransactionDemarcationException;
import atg.nucleus.GenericService;
import atg.payment.PaymentStatus;
import atg.payment.PaymentStatusImpl;
import atg.repository.RepositoryException;



public class LoyaltyPointsProcessorImpl extends GenericService implements LoyaltyPointsProcessor {
	private LoyaltyManager loyaltyManager;
	
	public PaymentStatus authorize(LoyaltyPointsInfo loyaltyPointsInfo) {
		if (isLoggingDebug())
			logDebug("Authorizing payment with"
					+ loyaltyPointsInfo.getNumberOfPoints() + "loyalty points for user with id"
					+ loyaltyPointsInfo.getUserId());
		return new PaymentStatusImpl(Long.toString(System.currentTimeMillis()), 
				loyaltyPointsInfo.getAmount(), true, "", new Date());
	}

	public PaymentStatus debit(LoyaltyPointsInfo loyaltyPointsInfo,
			PaymentStatus paymentStatus) {
		if (isLoggingDebug())
			logDebug("Debiting payment with"
					+ loyaltyPointsInfo.getNumberOfPoints() + "loyalty points for user with id"
					+ loyaltyPointsInfo.getUserId());
		return new PaymentStatusImpl(Long.toString(System.currentTimeMillis()), 
				loyaltyPointsInfo.getAmount(), true, "", new Date());
	}

	public PaymentStatus credit(LoyaltyPointsInfo loyaltyPointsInfo,
			PaymentStatus paymentStatus) {
		if (isLoggingDebug())
			logDebug("Crediting payment with"
					+ loyaltyPointsInfo.getNumberOfPoints() + "loyalty points for user with id"
					+ loyaltyPointsInfo.getUserId());
		
		return new PaymentStatusImpl(Long.toString(System.currentTimeMillis()), 
				loyaltyPointsInfo.getAmount(), true, "", new Date());
	}

	public PaymentStatus credit(LoyaltyPointsInfo loyaltyPointsInfo) {
		if (isLoggingDebug())
			logDebug("Crediting payment with"
					+ loyaltyPointsInfo.getNumberOfPoints() + "loyalty points for user with id"
					+ loyaltyPointsInfo.getUserId());
		try {
			loyaltyManager.addLoyaltyPoints(-loyaltyPointsInfo.getNumberOfPoints(), 
					loyaltyPointsInfo.getOrderId(), loyaltyPointsInfo.getUserId());
		} catch (RepositoryException e) {
			e.printStackTrace();
		} catch (TransactionDemarcationException e) {
			e.printStackTrace();
		}
		return new PaymentStatusImpl(Long.toString(System.currentTimeMillis()), 
				loyaltyPointsInfo.getAmount(), true, "", new Date());
	}

	public LoyaltyManager getLoyaltyManager() {
		return loyaltyManager;
	}

	public void setLoyaltyManager(LoyaltyManager loyaltyManager) {
		this.loyaltyManager = loyaltyManager;
	}
}
