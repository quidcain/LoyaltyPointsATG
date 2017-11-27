package loyalty.commerce.order;

import atg.commerce.order.PaymentGroupImpl;

public class LoyaltyPoints extends PaymentGroupImpl {
	public int getNumberOfPoints() {
		return ((Integer) getPropertyValue("numberOfPoints")).intValue();
	}

	public void setNumberOfPoints(int pNumberOfPoints) {
		setPropertyValue("numberOfPoints", new Integer(pNumberOfPoints));
	}
}
