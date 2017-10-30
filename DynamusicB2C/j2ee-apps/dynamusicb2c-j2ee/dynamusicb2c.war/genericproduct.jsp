<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- storefront page to loop through rootCategories property -->
<!-- Last modified: 1 May 07 by RM -->

<!-- this is a holder page for the chapter 3, Exercise 4 -->
<!-- for creating a page to display a product -->

<!-- Title: DynamusicB2C Product Page -->


<HTML>
  <HEAD>
    <TITLE>Dynamusic Product Page</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Dynamusic Product Page"/>
    </dsp:include>
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" valign="top">
          <jsp:include page="navbar.jsp" flush="true"></jsp:include>
        </td>
        <!-- Page Body -->
        <td valign="top">
          <font face="Verdana,Geneva,Arial" color="midnightblue">
          <table width="500" cellpadding="8">
            <tr>
              <td width="100" valign="center">
                <font face="Verdana,Geneva,Arial" size="+2" color="midnightblue">

<%-- Chapter 3, Exercise 4 --%>
<%-- Insert ProductLookup droplet --%>

								<dsp:droplet name="/atg/commerce/catalog/ProductLookup"> 
								  <dsp:oparam name="output">
								  	<dsp:droplet name="/atg/commerce/catalog/ProductBrowsed">
							      	<dsp:param name="eventobject" param="element"/>
							      </dsp:droplet>
							      <dsp:droplet name="/atg/commerce/catalog/CatalogNavHistoryCollector">            
											<dsp:param name="item" param="element"/>
										</dsp:droplet>
										<dsp:include page="breadcrumbs.jsp" flush="true"/>
										<dsp:valueof param="element.itemDisplayName"/><p>
								    <img src='<dsp:valueof param="element.smallImage.url"/>' >
								    <dsp:valueof param="element.longDescription"/><P>
<%-- Chapter 3, Exercise 5 --%>
<%-- Display SKU information --%>
								    <dsp:include page="skulist.jsp" flush="true">
									 		<dsp:param name="product" param="element"/>
								    </dsp:include>
								  </dsp:oparam>
									<dsp:oparam name="error">
									      There was an error retrieving product: <dsp:valueof param="id"/>
									</dsp:oparam>
									<dsp:oparam name="empty">
									      Unable to find product: <dsp:valueof param="id"/>
									</dsp:oparam>   
								</dsp:droplet>
</td></tr></table>
</BODY> </HTML>

</dsp:page>
