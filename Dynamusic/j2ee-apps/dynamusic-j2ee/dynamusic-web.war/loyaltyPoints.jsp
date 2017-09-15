<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<%@ page isELIgnored="false" %> 
<dsp:page>
<dsp:importbean bean="/loyalty/LoyaltyTransactionFormHandler"/>  

<HTML>
  <HEAD>
    <TITLE>Dynamusic Home</TITLE>
    <style>
    	table.lp-transactions{
    		border: 1px solid black;
    		border-collapse: collapse;
    	}
    	table.lp-transactions tr:nth-of-type(3n) {
    		border-bottom: 1px solid black;
    	}
    </style>
  </HEAD>
  <BODY>
  <dsp:include page="common/header.jsp">
    <dsp:param name="pagename" value="Loyalty points"/>
  </dsp:include>    
  </table>
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
          <!-- (replace contents of this table cell by 
                dynamically including common/sidebar.html) -->
             <dsp:include page="common/sidebar.jsp"></dsp:include>
        </td>
        <!-- Page Body -->
        <td valign="top">
          <font face="Verdana,Geneva,Arial" size="-1">
          
          <!-- *** Start page content *** -->
          <h2>Total amount: 3</h2>
          <dsp:valueof bean="/atg/userprofiling/Profile.id"/>
          <table class="lp-transactions">
	          <dsp:droplet name="/atg/dynamo/droplet/RQLQueryRange">
	          	<dsp:setvalue param="profileId" beanvalue="/atg/userprofiling/Profile.id"/>
							<dsp:param name="queryRQL" value='profileId = :profileId'/>
							<dsp:param name="repository" value="/loyalty/LoyaltyRepository"/>
							<dsp:param name="itemDescriptor" value="loyaltyTransaction"/>
							<dsp:param name="howMany" value="3" />
							<dsp:oparam name="output">
						  		<tr>
						  			<td>Amount</td>
						  			<td><dsp:valueof param="element.amount"/></td>
						  		</tr>
						  		<tr>
						  			<td>Date</td>
						  			<td><dsp:valueof param="element.date"/></td>
						  		</tr>
						  		<tr>
						  			<td>Description</td>
						  			<td><dsp:valueof param="element.description"/></td>
						  		</tr>
							</dsp:oparam>
							<dsp:oparam name="empty">
								<p>Currently you have no loyalty points</p>
							</dsp:oparam>
						</dsp:droplet> 
					</table>           
          <!-- *** End real content *** -->
          
          </font>
        </td>
      </tr>
    </table>
  </BODY>
</HTML>
</dsp:page>