<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler"/>

<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- fragment to loop through a list of SKUs and display SKU info -->
<!-- Last modified: 1 May 07 by RM -->

<!-- this is a holder page for the chapter 3 labs -->

<!-- Title: Sku List -->

<%-- Chapter 3, Exercise 5 --%>
<%-- Insert ForEach droplet to loop through product.childSKUs --%>

<font face="Verdana,Geneva,Arial" size="-1" color="midnightblue">
<dsp:droplet name="/atg/dynamo/droplet/ForEach">
  <dsp:param name="array" param="product.childSKUs"/>
  
  <dsp:oparam name="outputStart">
    <p>Skulist: <ul>
  </dsp:oparam>
  <dsp:oparam name="outputEnd">
    </ul>
  </dsp:oparam>
  <dsp:oparam name="output">
  <dsp:param name="sku" param="element"/>
  <!-- display SKU name -->
    <li><dsp:valueof param="sku.displayName"/>,
    
      <%-- Chapter 5, Ex. 1: include discountedprice.jsp to display list and discounted price --%>
      <%-- pass product (passed in from genericproduct.jsp) and sku (from the ForEach here) as parameters named product and sku --%>
    
		<dsp:include page="discountprice.jsp" flush="true">
			<dsp:param name="product" param="product"/>
			<dsp:param name="sku" param="sku"/>
		</dsp:include>
 		<dsp:include page="addtocart.jsp">
			<dsp:param name="productId" param="product.repositoryId" />
			<dsp:param name="skuId" param="sku.repositoryID" />
		</dsp:include>	
  </dsp:oparam>
  <dsp:oparam name="empty">
    There are no SKUS to display for this product.



  </dsp:oparam>
</dsp:droplet>


</dsp:page>
