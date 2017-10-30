<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<!-- ATG Training -->
<!-- Creating Commerce Applications Part I -->
<!-- Simple keyword product search form -->
<!-- Last modified: 13 Aug 02 by KL -->

<dsp:importbean bean="/atg/commerce/catalog/ProductSearch"/>

<HTML>
  <HEAD>
    <TITLE>Dynamusic Search Page</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Dynamusic Search Page"/>
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

Search for keywords:
<dsp:form action="searchResults.jsp" method="post">
<dsp:input bean="ProductSearch.keywords" size="50" type="text" value=""/>
<dsp:input bean="ProductSearch.search" type="submit" value="Search"/>
<dsp:input bean="ProductSearch.search" type="hidden" value="Search"/>
</dsp:form>

</td></tr></table>
</BODY> </HTML>

</dsp:page>
