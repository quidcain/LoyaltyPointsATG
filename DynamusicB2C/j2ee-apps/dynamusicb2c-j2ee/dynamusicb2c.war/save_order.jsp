<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>
<dsp:importbean bean="/atg/commerce/order/OrderLookup"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/atg/commerce/order/purchase/SaveOrderFormHandler"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler"/>

<%/* expect a order number to be passed in, we could be acceepting a orderid but run the risk of users trying random orderId's and
seeing other people's orders. We might use the obfuscated id generator, but this is safter then even that*/%>

<DECLAREPARAM NAME="orderId" CLASS="java.lang.Integer" DESCRIPTION="number of the saved order">
<HTML>
  <HEAD>
    <TITLE>Save Order Page</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Save Order"/>
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

     <dsp:a href="cart.jsp">Current Order</dsp:a> &gt;
     Save Order 
    </td>

     <td><table width="700" cellpadding="8">
    <tr><td width="75" valign="center"><font face="Verdana,Geneva,Arial" color="midnightblue"><span class="big">Current Order</span></td>
      </tr>

      <tr>
        <td colspan=2><table width=100% cellpadding=3 cellspacing=0 border=0>
        <tr><td class=box-top>&nbsp;Save Current Order</td>
      </tr>
    <tr>
      <td><b>Order # <dsp:valueof bean="ShoppingCart.current.id"/></b>
                  <dsp:form action="saved_orders.jsp">
                  Enter a name to identify this order:<p>
                  <dsp:input bean="SaveOrderFormHandler.description" type="text"/> 
                  <dsp:input bean="SaveOrderFormHandler.saveOrder" type="submit" value="Save order"/>
                  <dsp:input bean="SaveOrderFormHandler.saveOrder" type="hidden" value="save"/>
                  <dsp:input bean="SaveOrderFormHandler.saveOrderSuccessURL" type="hidden" value="../user/saved_orders.jsp"/> 
                  <dsp:input bean="SaveOrderFormHandler.saveOrderErrorURL" type="hidden" value="../user/save_order.jsp"/>
      </td>
    </tr>
    <tr>
      <td>    
<table cellspacing=0 cellpadding=0 border=0 width=100%>
<tr valign=top><td><table cellspacing=2 cellpadding=0 border=0>
<tr>
<td><b>Quantity</b></td>
<td></td>
<td>&nbsp;</td>
<td><b>Product</b></td>

<td>&nbsp;&nbsp;</td>
<td align=right><b>Total Price</b></td>
</tr>


  <dsp:droplet name="/atg/dynamo/droplet/ForEach">
    <dsp:param name="array" bean="CartModifierFormHandler.order.ShippingGroups"/>
      
      <dsp:oparam name="output">
 	<dsp:param param="element" name="ShippingGroup"/>
    	<dsp:droplet name="/atg/dynamo/droplet/ForEach">
          <dsp:param name="array" param="ShippingGroup.CommerceItemRelationships"/>
	  
      	  <dsp:oparam name="output">
		<dsp:param param="element" name="CIRelationship"/>
	    <tr><td><<dsp:valueof param="CIRelationship.quantity"/>' size="2">&nbsp;
</td> 
<td>             <dsp:valueof param="CIRelationship.commerceItem.auxiliaryData.catalogRef.displayName"/><br>
</td>
<td>             <dsp:valueof param="CIRelationship.commerceItem.priceInfo.amount" converter="currency"/><br><br>
</td></tr></table>
      	  </dsp:oparam>
      	  <dsp:oparam name="empty">
            Cart is Empty!!!!
      	  </dsp:oparam>
    	</dsp:droplet>
      </dsp:oparam>
  </dsp:droplet>

    
           <tr>
             <td colspan=8>
               <table border=0 cellpadding=0 cellspacing=0 width=100%>
                 <tr bgcolor="#666666"><td><img src="../images/d.gif"></td></tr>
               </table>
             </td>
           </tr>
           <tr>
             <td colspan=4>&nbsp; </td>
             <td>Subtotal</td>
             <td></td>
             <td align="right">
             <b><dsp:valueof bean="ShoppingCart.current.priceInfo.amount" converter="currency" locale="Profile.priceList.locale"/></b>
             </td>
           </tr>
         </table>
         </dsp:form>
         </td>
       </tr>
     </table>
     </td>
   </tr>
 </table>
 </td>
 </tr>
</table>

</body>
</html>
</dsp:page>
<%-- @version $Id: //edu/ILT-Courses/main/Commerce/StudentFiles/Commerce/setup/DynamusicB2C/j2ee-apps/dynamusicb2c-j2ee/dynamusicb2c.war/save_order.jsp#11 $$Change: 514668 $--%>
