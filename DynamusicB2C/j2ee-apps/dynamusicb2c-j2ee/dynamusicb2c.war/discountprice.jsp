<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- Fragment for displaying a SKU's discounted price -->
<!-- Last modified: 4 Apr 06 by KL -->

<!-- Title: Discount Price Page -->

<%-- Chapter 5, Exercise 1 --%>

<dsp:droplet name="/atg/commerce/pricing/PriceItem">
  <dsp:param name="item" param="sku"/>
  <dsp:param name="product" param="product"/>
  <dsp:oparam name="output">
		<dsp:param name="PricedItem" param="element"/>
		<dsp:droplet name="/atg/dynamo/droplet/Switch">
			<dsp:param name="value" param="PricedItem.priceInfo.onSale"/>
			<dsp:oparam name="true">
				<p>
					<b>Sale Price:</b> 
	    		<dsp:valueof converter="currency" param="PricedItem.priceInfo.salePrice"/>
    		</p>
			</dsp:oparam>
			<dsp:oparam name="false">
				<p>
					<b>List Price:</b> 
    			<dsp:valueof converter="currency" param="PricedItem.priceInfo.listPrice"/>
				</p>
			</dsp:oparam>
		</dsp:droplet>
    <p>
    	<b>Your Price:</b> 
     	<dsp:valueof converter="currency" param="PricedItem.priceInfo.amount"/>
    </p>
  </dsp:oparam>
</dsp:droplet>

</dsp:page>

