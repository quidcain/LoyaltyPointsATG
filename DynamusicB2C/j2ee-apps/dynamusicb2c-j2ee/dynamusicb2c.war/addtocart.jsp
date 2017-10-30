<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- fragment to configure Add To Cart button -->
<!-- Last modified: 7 Apr 06 by KL -->

<!-- Title: Add to Cart Fragment -->


<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
	
<%-- Import CartModifierFormHandler component --%>
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />

<%-- Form to choose quantity and add SKU to cart --%>
	skuId=<dsp:valueof param="skuId"/>
	<dsp:form action="genericproduct.jsp" method="post">
		<dsp:input type="hidden" bean="CartModifierFormHandler.catalogRefIds" paramvalue="skuId"/>
		<dsp:input type="hidden" bean="CartModifierFormHandler.productId" paramvalue="productId"/>
		<dsp:input type="text" size="5" bean="CartModifierFormHandler.quantity" value="1"/>
		<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="cart.jsp"/>
		<dsp:input type="submit" bean="CartModifierFormHandler.addItemToOrder" value="Add to Cart"/>
		
	</dsp:form>

</dsp:page>
