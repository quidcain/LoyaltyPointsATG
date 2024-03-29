<!-- ATG Training -->
<!-- Creating Commerce Applications Part I -->
<!-- page to gather shipping and payment information for express checkout -->
<!-- Last modified: 1 May 07 by RM -->

<!-- Title: Purchase Information Page -->

<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/atg/commerce/order/purchase/ExpressCheckoutFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/commerce/pricing/AvailableShippingMethods"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>

<HTML>
  <HEAD>
    <TITLE>Dynamusic Purchase Information</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Purchase Information"/>
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


<!-- Error handling -->
<dsp:droplet name="/atg/dynamo/droplet/Switch">
<dsp:param bean="ExpressCheckoutFormHandler.formError" name="value"/>
<dsp:oparam name="true">
  <font color=cc0000><STRONG><UL>
    <dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
      <dsp:param bean="ExpressCheckoutFormHandler.formExceptions" name="exceptions"/>
      <dsp:oparam name="output">
	<LI> <dsp:valueof param="message"/>
      </dsp:oparam>
    </dsp:droplet>
    </UL></STRONG></font>
</dsp:oparam>
</dsp:droplet>
<!-- Start of form to capture shipping and billing information -->
<dsp:form action="purchaseinfo.jsp" method="post">

<%-- Chapter 8, Ex. 1, Step 1: Insert hidden inputs --%>
	<dsp:input type="hidden" bean="ExpressCheckoutFormHandler.commitOrder" value="false"/>
	<dsp:input type="hidden" bean="ExpressCheckoutFormHandler.paymentGroupNeeded" value="false"/>
	<dsp:input type="hidden" bean="ExpressCheckoutFormHandler.shippingGroupNeeded" value="false"/>
	<dsp:input type="hidden" bean="ExpressCheckoutFormHandler.expressCheckoutSuccessURL" value="loyaltyPayment.jsp"/>
	
  <font face="Verdana,Geneva,Arial" size="+2" color="midnightblue">Shipping Method</font><br>
<%-- Shipping Methods Select Box --%>
                <dsp:droplet name="AvailableShippingMethods">
                  <dsp:param name="shippingGroup" bean="ExpressCheckoutFormHandler.shippingGroup"/>
                  
                  <dsp:oparam name="output">
                    <dsp:select bean="ExpressCheckoutFormHandler.shippingGroup.shippingMethod">
                    <dsp:droplet name="ForEach">
                      <dsp:param name="array" param="availableShippingMethods"/>
                      
                      <dsp:oparam name="output">
                      <dsp:param name="method" param="element"/>
                      	<option value='<dsp:valueof param="method"/>'><dsp:valueof param="method"/>
                        
                      </dsp:oparam>
                    </dsp:droplet>
                    </dsp:select>
                  </dsp:oparam>
                </dsp:droplet>


  <p>
  <font face="Verdana,Geneva,Arial" size="+2" color="midnightblue">Shipping Information</font><br>
<%-- Chapter 8, Ex. 1, Step 2: Insert Name and address information here --%>
  <b>First Name:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.firstName"
  	beanvalue="Profile.firstName" size="30"/><br>
  <b>Middle Name:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.middleName"
  	beanvalue="Profile.shippingAddress.middleName" size="30"/><br>
  <b>Last Name:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.lastName"
  	beanvalue="Profile.shippingAddress.lastName" size="30"/><br>
  <b>Address 1:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.address1"
  	beanvalue="Profile.shippingAddress.address1" size="30"/><br>
  <b>Address 2:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.address2"
  	beanvalue="Profile.shippingAddress.address2" size="30"/><br>
  <b>City:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.city"
  	beanvalue="Profile.shippingAddress.city" size="30"/><br>
  <b>State:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.state"
  	beanvalue="Profile.shippingAddress.state" size="30"/><br>
  <b>Postal Code:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.postalCode"
  	beanvalue="Profile.shippingAddress.postalCode" size="30"/><br>
  <b>Country:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.country"
  	beanvalue="Profile.shippingAddress.country" size="30"/><br>
  <b>Email:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.email"
  	beanvalue="Profile.email" size="30"/><br>
  <b>Phone:</b>
  <dsp:input type="text" bean="ExpressCheckoutFormHandler.shippingGroup.shippingAddress.phoneNumber"
  	beanvalue="Profile.shippingAddress.phoneNumber" size="30"/><P>
	</p>
<!-- Billing information -->  
  <font face="Verdana,Geneva,Arial" size="+2" color="midnightblue">Billing Information</font><br>
  Please enter your name as it appears on your credit card.<br>
  <b>First Name:</b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.billingAddress.firstName" beanvalue="Profile.firstName" size="30" type="text" required="<%=true%>"/><br>
  <b>Middle Name:</b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.billingAddress.middleName" beanvalue="Profile.middleName" size="30" type="text"/><br>
  <b>Last Name:<b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.billingAddress.lastName" beanvalue="Profile.lastName" size="30" type="text" required="<%=true%>"/><br>
  <b>Address 1:</b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.billingAddress.address1" beanvalue="Profile.billingAddress.address1" size="30" type="text"/><br>
  <b>Address 2:</b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.billingAddress.address2" beanvalue="Profile.billingAddress.address2" size="30" type="text"/><br>
  <b>City:</b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.billingAddress.city" beanvalue="Profile.billingAddress.city" size="30" type="text" required="<%=true%>"/><br>
  <b>State:</b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.billingAddress.state" maxsize="2" beanvalue="Profile.billingAddress.state" size="2" type="text" required="<%=true%>"/><br>
  <b>Postal Code:</b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.billingAddress.postalCode" beanvalue="Profile.billingAddress.postalCode" size="10" type="text" required="<%=true%>"/><br>
  <b>Country:</b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.billingAddress.country" beanvalue="Profile.billingAddress.country" size="10" type="text"/><br>
<p>
  <font face="Verdana,Geneva,Arial" size="+2" color="midnightblue">Credit Card Type:</font><br>
  <dsp:select bean="ExpressCheckoutFormHandler.paymentGroup.creditCardType" required="<%=true%>">
    <dsp:option value="Visa"/>Visa
    <dsp:option value="MasterCard"/>Master Card
    <dsp:option value="American Express"/>American Express
  </dsp:select><br>
  <b>Number:</b> <dsp:input bean="ExpressCheckoutFormHandler.paymentGroup.creditCardNumber" maxsize="20" size="20" type="text" value="4111111111111111" required="<%=true%>"/><br>
  <b>Expiration Date:</b>
  Month: <dsp:select bean="ExpressCheckoutFormHandler.paymentGroup.expirationMonth">
    <dsp:option value="1"/>January
    <dsp:option value="2"/>February
    <dsp:option value="3"/>March
    <dsp:option value="4"/>April
    <dsp:option value="5"/>May
    <dsp:option value="6"/>June
    <dsp:option value="7"/>July
    <dsp:option value="8"/>August
    <dsp:option value="9"/>September
    <dsp:option value="10"/>October
    <dsp:option value="11"/>November
    <dsp:option value="12"/>December
  </dsp:select>
  Year: <dsp:select bean="ExpressCheckoutFormHandler.paymentGroup.expirationYear">  
    <dsp:option value="2017"/>2017
    <dsp:option value="2018"/>2018
    <dsp:option value="2019" selected="true"/>2019
    <dsp:option value="2020"/>2020
  </dsp:select>
</p>
<p>  

<%-- Chapter 8, Ex. 1, Step 3: Create submit button --%>

<dsp:input bean="ExpressCheckoutFormHandler.expressCheckout" type="submit" value="Confirm Order"/>
</p>
</dsp:form>
</font>
</td></tr></table>
</body>
</html>

</dsp:page>
