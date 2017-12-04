package loyalty;

public class LoyaltyConfig {

	private int displayedTransactionsAmount;
	private double lpEarnAmount;
	private double purchaseRate;
	private double maxLpOrderPart;
	
	public LoyaltyConfig() {
	}

	public int getDisplayedTransactionsAmount() {
		return displayedTransactionsAmount;
	}

	public void setDisplayedTransactionsAmount(int displayedTransactionsAmount) {
		this.displayedTransactionsAmount = displayedTransactionsAmount;
	}

	public double getLpEarnAmount() {
		return lpEarnAmount;
	}

	public void setLpEarnAmount(double lpEarnAmount) {
		this.lpEarnAmount = lpEarnAmount;
	}

	public double getPurchaseRate() {
		return purchaseRate;
	}

	public void setPurchaseRate(double purchaseRate) {
		this.purchaseRate = purchaseRate;
	}

	public double getMaxLpOrderPart() {
		return maxLpOrderPart;
	}

	public void setMaxLpOrderPart(double maxLpOrderPart) {
		this.maxLpOrderPart = maxLpOrderPart;
	}
	
	
}
