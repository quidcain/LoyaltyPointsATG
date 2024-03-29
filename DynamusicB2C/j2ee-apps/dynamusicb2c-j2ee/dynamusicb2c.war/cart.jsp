<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>

<!-- ATG Training -->
<!-- Creating Commerce Applications Part I -->
<!-- Cart Page -->
<!-- Last modified: 1 May 07 by RM -->

<HTML>
  <HEAD>
    <TITLE>Dynamusic Shopping Cart</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Your Shopping Cart"/>
    </dsp:include>
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
          <jsp:include page="navbar.jsp" flush="true"></jsp:include>
        </td>
        <!-- Page Body -->
        <td valign="top">
          <font face="Verdana,Geneva,Arial" color="midnightblue">
          
<%-- Chapter 7, Exercise 4, Step 3: Reprice the order when the page is loaded --%>

<dsp:droplet name="/atg/commerce/order/purchase/RepriceOrderDroplet">
	<dsp:param name="pricingOp" value="ORDER_TOTAL" />
</dsp:droplet>


<%-- Chapter 7, Exercise 3, Step 1: Error Handling --%>

<dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
   <dsp:param name="exceptions" bean="CartModifierFormHandler.formExceptions"/>
   <dsp:oparam name="outputStart">
      <font color=cc0000><strong><ul>
   </dsp:oparam>
   <dsp:oparam name="outputEnd">
      </ul></strong></font>
   </dsp:oparam>
   <dsp:oparam name="output">
      <li>Error:<dsp:valueof param="message"/><br>
   </dsp:oparam>
</dsp:droplet>

<%-- Chapter 7, Exercise 2 --%>
<%-- Loop through Commerce Items in the current Order object. Place in form. --%>
<p>
<dsp:form method="post" action="cart.jsp">
  <dsp:droplet name="/atg/dynamo/droplet/ForEach">
    <dsp:param name="array" bean="CartModifierFormHandler.order.commerceItems"/>
      
      <dsp:oparam name="output">
      	<dsp:param name="Ci" param="element" />
	    <b>Quantity:</b>
	      <input name='<dsp:valueof param="Ci.id"/>' value='<dsp:valueof param="Ci.quantity"/>' size="2">&nbsp;
<br> 
            <b>Name:</b> <dsp:valueof param="Ci.auxiliaryData.catalogRef.displayName"/><br>
            <b>Original Price:</b> <dsp:valueof param="Ci.priceInfo.rawTotalPrice" converter="currency"/><br>
            <b>Your Price:</b> <dsp:valueof param="Ci.priceInfo.amount" converter="currency"/><br><br>

      </dsp:oparam>
      <dsp:oparam name="empty">
            Cart is Empty!!!!
 
      </dsp:oparam>
  </dsp:droplet>

</font><p>
  <hr size="0">
  <font face="Verdana,Geneva,Arial" size="+2" color="midnightblue">Shopping Cart Totals:</font><p>
  <font face="Verdana,Geneva,Arial" color="midnightblue">

<%-- Chapter 7, Exercise 4: Display Order Subtotal and Recalculate Button --%>
<!-- Order Subtotal -->
  <b>Order Subtotal:</b> <dsp:valueof bean="ShoppingCart.current.priceInfo.amount" converter="currency">no price</dsp:valueof><br>

<!-- Recalculate Button -->
<p>
  <dsp:input type="submit" bean="CartModifierFormHandler.setOrderByCommerceId" value="Recalculate"/>

<%-- Chapter 9, Exercise 1, Step 5: Test ShippingGroupCount --%>


<%-- Chapter 7, Exercise 3, Step 2: Add Checkout Button --%>
  <dsp:input type="submit" bean="CartModifierFormHandler.moveToPurchaseInfoByCommerceId" value="Checkout"/>
  
  <dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoSuccessURL" value="purchaseinfo.jsp"/>

</dsp:form>
<p>
<%-- Chapter 7, Optional Exercise 7: Display User's Promotions --%>
<b>Your current Promotions are:</b>
<p>

<dsp:droplet name="/atg/dynamo/droplet/ForEach">
  <dsp:param bean="/atg/commerce/pricing/UserPricingModels.allPromotions" name="array"/>
  <dsp:oparam name="output">
    <li><dsp:valueof param="element.displayName"/>
  </dsp:oparam>
  <dsp:oparam name="empty">
    You do not have any Promotions!
  </dsp:oparam>
</dsp:droplet>
</font>
</td></tr>
</table>
</body>
</html>


</dsp:page>
