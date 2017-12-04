package atg.payment.loyaltypoints;

import atg.payment.PaymentStatus;


public interface LoyaltyPointsProcessor {
	PaymentStatus authorize(LoyaltyPointsInfo loyaltyPointsInfo);
	PaymentStatus debit(LoyaltyPointsInfo loyaltyPointsInfo, PaymentStatus loyaltyPointsStatus);
	PaymentStatus credit(LoyaltyPointsInfo loyaltyPointsInfo, PaymentStatus loyaltyPointsStatus);
	PaymentStatus credit(LoyaltyPointsInfo loyaltyPointsInfo);
}
