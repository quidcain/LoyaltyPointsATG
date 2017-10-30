<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- final order page showing status -->
<!-- Last modified: 1 May 07 by RM -->

<!-- Title: Order Status -->

<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<dsp:importbean bean="/atg/commerce/ShoppingCart"/>

<HTML>
  <HEAD>
    <TITLE>Dynamusic Order Status</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Order Status"/>
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

<%-- Ch. 8, Ex. 2, Step 2: Display order number --%>
Your order number is <font size=+1># <dsp:valueof bean="ShoppingCart.last.id"/></font>. 
Thank you for your order. Please come back soon!



</body>
</html>

</dsp:page>
