package loyalty;

import java.util.Collection;

import atg.repository.RepositoryItem;
import atg.repository.RepositoryItemImpl;
import atg.repository.RepositoryPropertyDescriptor;

public class LoyaltyAmountPropertyDescriptor extends RepositoryPropertyDescriptor {

	@Override
	public Object getPropertyValue(RepositoryItemImpl pItem, Object pValue) {
		if (pValue != null)
			return pValue;
		Collection<RepositoryItem> loyaltyTransactions = (Collection<RepositoryItem>) pItem.getPropertyValue("loyaltyTransactions");
		int loyaltyAmount = 0;
		for (RepositoryItem transaction : loyaltyTransactions) {
			loyaltyAmount += (Integer) transaction.getPropertyValue("amount");
		}
		pItem.setPropertyValueInCache(this, loyaltyAmount);
		return new Integer(loyaltyAmount);
	}

	@Override
	public boolean isQueryable() {
		return false;
	}

	@Override
	public boolean isWritable() {
		return false;
	}
	
}
