<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<%@ page isELIgnored="false" %> 
<dsp:page>
<dsp:importbean bean="/loyalty/LoyaltyTransactionFormHandler"/>  

<HTML>
  <HEAD>
    <TITLE>Dynamusic Home</TITLE>
    <style>
    	form > *{
    		display: block;
    		margin-bottom: 10px;
    	}
    </style>
  </HEAD>
  <BODY>
  <dsp:include page="common/header.jsp">
    <dsp:param name="pagename" value="Add Loyalty points"/>
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
            <dsp:droplet name="/atg/dynamo/droplet/HasEffectivePrincipal">
            	<dsp:param name="type" value="role"/>
  						<dsp:param name="id" value="loyaltyAdministrator"/>            
            	<dsp:oparam name="output">  
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
		              <label for="user">User</label>
		              <dsp:select bean="LoyaltyTransactionFormHandler.value.profileId" id="user">
										<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
											<dsp:param name="queryRQL" value='ALL ORDER BY name'/>
											<dsp:param name="repository" value="/atg/userprofiling/ProfileAdapterRepository"/>
											<dsp:param name="itemDescriptor" value="user"/>
											<dsp:oparam name="output">
												<dsp:getvalueof var="elementId" param="element.id" />
										    <dsp:option value='${elementId}'>
										    	<dsp:valueof param="element.login" />
										    </dsp:option>
											</dsp:oparam>
											<dsp:oparam name="empty">
												<p>No artists currently available, sorry.</p>
											</dsp:oparam>
										</dsp:droplet>
									</dsp:select>
									<label for="amount">Amount</label>
									<dsp:input bean="LoyaltyTransactionFormHandler.value.amount" type="text"  id="amount"/>
									<label for ="description">Description</label>
									<dsp:textarea bean="LoyaltyTransactionFormHandler.value.description" maxlength="1000" id="description"></dsp:textarea>
		            	<dsp:input type="submit" bean="LoyaltyTransactionFormHandler.create"/>
	            	</dsp:form>
							</dsp:oparam>
							<dsp:oparam name="default">
						    Sorry, you do not have access to this page.
						  </dsp:oparam>
						  <dsp:oparam name="unknown">
						    Please log in.
						  </dsp:oparam>
							
						</dsp:droplet>  
          <!-- *** End real content *** -->
          
          </font>
        </td>
      </tr>
    </table>
  </BODY>
</HTML>
</dsp:page>