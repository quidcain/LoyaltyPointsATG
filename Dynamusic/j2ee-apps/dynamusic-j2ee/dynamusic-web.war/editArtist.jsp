<%@ taglib uri="/dspTaglib" prefix="dsp" %>

<dsp:page>

<dsp:importbean bean="/dynamusic/ArtistFormHandler"/>

<!-------------------------------------------------------------
  Dynamusic Site                                DAF Site Mockup
  
  EDIT ARTIST
  
  Modify description of an artist and her/his list of albums.
  
  ------------------------------------------------------------->
  

<HTML>
  <HEAD>
    <TITLE>Dynamusic Artist</TITLE>
  </HEAD>
  <BODY>
  <dsp:include page="common/header.jsp">
    <dsp:param name="pagename" value="Edit Artist"/>
  </dsp:include>
    
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
        <dsp:include page="common/sidebar.jsp"></dsp:include>
        </td>
        <!-- Page Body -->
        <td valign="top">
          <font face="Verdana,Geneva,Arial" size="-1">
          
          <!-- *** Start page content *** -->

<dsp:setvalue bean="ArtistFormHandler.repositoryId" paramvalue="artistId"/>
            
					<dsp:form action="editArtist.jsp">

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

						<dsp:input bean="ArtistFormHandler.repositoryId" type="hidden" paramvalue="artistId"/>		
              
						<table cellpadding="10" border=0>
                <tr>
                  <td valign="middle" align="right">
                    Artist Name:
                  </td>
                  <td valign="middle">
                    <font face="Courier New" size="-1">
                      <dsp:input type="text" size="30" bean="ArtistFormHandler.value.name"/>	
                    </font>
                  </td>
                </tr>
                  <td valign="middle" align="right">
                    Photo URL:
                  </td>
                  <td valign="middle">
                    <font face="Courier New" size="-1">
                      <dsp:input type="text" size="30" bean="ArtistFormHandler.value.photoURL"/>	
                    </font>
                  </td>
                </tr>
                <tr>
                  <td valign="top" align="right">
                    Description:
                  </td>
                  <td valign="top" >
                      <dsp:textarea 
                         bean="/dynamusic/ArtistFormHandler.value.description" 
                         name="description" cols="60" rows="10" 
                         wrap="SOFT"/>
                  </td>
                </tr>
                <tr>
                  <td></td>
                  <td>
											<dsp:input type="hidden" bean="ArtistFormHandler.updateSuccessURL" value="success.jsp"/> 
											<dsp:input type="hidden" bean="ArtistFormHandler.deleteSuccessURL" value="success.jsp"/>
											<dsp:input type="submit" bean="ArtistFormHandler.update" value="Save Changes"/> &nbsp;
											<dsp:input type="submit" bean="ArtistFormHandler.delete" value="Delete This Artist"/>
                 	</td>
              </table>
            </dsp:form>
            
          <!-- *** End real content *** -->
          
          </font>
        </td>
      </tr>
    </table>
  </BODY>
</HTML>

</dsp:page>
