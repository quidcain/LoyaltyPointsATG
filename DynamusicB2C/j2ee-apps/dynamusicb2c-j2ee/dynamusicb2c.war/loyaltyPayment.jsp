<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/loyalty/LoyaltyPaymentFormHandler"/>
<html>
	<head>
		<title>Loyalty payment</title>
	</head>
	<body>
	  <dsp:include page="common/header.jsp">
    	<dsp:param name="pagename" value="Loyalty payment"/>
  	</dsp:include>
  	<table width="700" cellpadding="8">
      <tr>
        <td width="100" bgcolor="ghostwhite" valign="top">
          <jsp:include page="navbar.jsp" flush="true"></jsp:include>
        </td>
        <td valign="top">
        	<h1>my h1</h1>
        	Order amount:
        	<dsp:valueof bean="/atg/commerce/ShoppingCart.current.priceInfo.total" converter="currency">no total</dsp:valueof><br>
        	Your amount of loyalty points:
        	<dsp:valueof bean="/atg/userprofiling/Profile.loyaltyAmount"/><br>
        	Exchange rate loyalty points to dollar:
        	<dsp:valueof bean="/loyalty/LoyaltyConfig.purchaseRate"/><br>
        	Please enter amount of loyalty you want to pay with:
        	<dsp:form action="<%=request.getRequestURI()%>" method="post">
        	<!-- Default form error handling support -->
            <dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
              <dsp:oparam name="output">
                <b><dsp:valueof param="message"/></b><br>
              </dsp:oparam>
              <dsp:oparam name="outputStart">
                <LI>
              </dsp:oparam>
              <dsp:oparam name="outputEnd">
                </LI>
              </dsp:oparam>
            </dsp:droplet>
        		<dsp:input type="hidden" bean="LoyaltyPaymentFormHandler.successURL" value="orderconfirm.jsp"/>
        		<dsp:input bean="LoyaltyPaymentFormHandler.numberOfLoyaltyPoints" type="text" id="numberOfLoyaltyPoints"/>
        		<dsp:input type="submit" bean="LoyaltyPaymentFormHandler.submit"/>
        	</dsp:form>
        </td>
      </tr>
    </table>
	</body>
</html>
</dsp:page>