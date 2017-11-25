package loyalty;

public class LoyaltyConfig {

	private int displayedTransactionsAmount;
	private double lpEarnAmount;
	private double purchaseRate;
	private int maxLpOrderPart;
	
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

	public int getMaxLpOrderPart() {
		return maxLpOrderPart;
	}

	public void setMaxLpOrderPart(int maxLpOrderPart) {
		this.maxLpOrderPart = maxLpOrderPart;
	}
	
	
}
