<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<dsp:importbean bean="/atg/commerce/catalog/CatalogNavHistory"/>

<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- storefront page to loop through rootCategories property -->
<!-- Last modified: 1 May 07 by RM -->

<!-- this is a holder page for the chapter 4, Exercise 2 -->
<!-- for creating a page to display a category -->
<!-- This fragment shows a "bread crumb trail", showing the user's navigation 
     history, and allowing them to link to the previous products and categories
     they have viewed. -->
<!-- Title: Breadcrumbs -->

<font face="Verdana,Geneva,Arial" size="1" color="midnightblue">

<%-- Chapter 4, Exercise 2 --%>
<%-- Insert ForEach droplet to iterate through the navHistory --%>

<dsp:droplet name="/atg/dynamo/droplet/ForEach">
   <dsp:param bean="CatalogNavHistory.navHistory" name="array"/>
   
   <dsp:oparam name="output">
   <dsp:param name="historyElement" param="element"/>
      <dsp:getvalueof id="templateURL" param="historyElement.template.url" idtype="java.lang.String">
       <dsp:a href="<%=templateURL%>">
         <dsp:param name="id" param="historyElement.repositoryId"/>
         <dsp:param name="navAction" value="pop"/>
         <dsp:param bean="CatalogNavHistory.navCount" name="navCount"/>
         <dsp:valueof param="historyElement.displayName"/>
       </dsp:a> 
       
       <%-- text to display between breadcrumb links --%>       
       		->
      </dsp:getvalueof>
   </dsp:oparam>
   <dsp:oparam name="empty">
       No navigation history.
   </dsp:oparam>
</dsp:droplet>
</font>
</dsp:page>
