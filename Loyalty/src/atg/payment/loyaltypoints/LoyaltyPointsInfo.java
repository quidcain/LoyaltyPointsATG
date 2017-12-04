package atg.payment.loyaltypoints;

public class LoyaltyPointsInfo {
	private String userId;
	private String orderId;
	private int numberOfPoints;
	private double amount;
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public int getNumberOfPoints() {
		return numberOfPoints;
	}
	
	public void setNumberOfPoints(int numberOfPoints) {
		this.numberOfPoints = numberOfPoints;
	}
	
	public double getAmount() {
		return amount;
	}
	
	public void setAmount(double amount) {
		this.amount = amount;
	}
}
