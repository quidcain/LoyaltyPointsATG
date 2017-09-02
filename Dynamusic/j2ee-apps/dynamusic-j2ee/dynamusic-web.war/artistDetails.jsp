<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<dsp:importbean bean="/atg/targeting/RepositoryLookup"/>

<!-------------------------------------------------------------
  Dynamusic Site Mockup
  
  ARTIST DETAILS
  
  Description of an artist and list of albums.
  
  ------------------------------------------------------------->
  
<HTML>
  <HEAD>
    <TITLE>Dynamusic Artist</TITLE>
  </HEAD>
  <BODY>


  <dsp:droplet name="/dynamusic/ArtistLookupDroplet">
    <dsp:param name="id" param="itemId"/>
    <dsp:oparam name="empty">
      Artist with ID <dsp:valueof param="itemId">NONE</dsp:valueof> not found.
    </dsp:oparam>
    <dsp:oparam name="output">

		<dsp:droplet name="/dynamusic/ViewItemEventSender">
       <dsp:param name="eventobject" param="element"/>
		</dsp:droplet>

    <!-- (replace this entire table by dynamically including 
          common/header.html) -->
    <dsp:include page="common/header.jsp">
        <dsp:param name="pagename" param="element.name"/>
    </dsp:include>
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
          <dsp:include page="common/sidebar.jsp"></dsp:include> 
          <br>
          <font face="Verdana,Geneva,Arial" size="-1" color="steelblue">
            <dsp:a href="editArtist.jsp">
              <dsp:param name="artistId" param="element.id"/>
              <b>Edit Artist Info</b>
            </dsp:a></font>     
        </td>


<!-- Page Body -->


  <!-- *** Start page content *** -->

          <td valign="top">
             <font face="Verdana,Geneva,Arial" size="-1">
          
             <!-- *** Start page content *** -->
            

             <table cellpadding="10" border="1">
              <tr>
                <td valign="top"> 
                  <img src="<dsp:valueof param='element.photoURL'/>">
                </td>
                <td><font face="Geneva,Arial">
                    <dsp:valueof param="element.description"/>
                  </font>
                </td>
              </tr>
            </table>

            <dsp:setvalue param="artistId" paramvalue="element.id"/>
            <dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
              <dsp:param name="queryRQL" value="artist.id = :artistId"/>
              <dsp:param name="repository" value="/dynamusic/SongsRepository"/>
              <dsp:param name="itemDescriptor" value="album"/>
              <dsp:setvalue param="album" paramvalue="element"/>
                            
              <dsp:oparam name="outputStart">
                <ul>
              </dsp:oparam>
              <dsp:oparam name="outputEnd">
                </ul>
              </dsp:oparam>
              <dsp:oparam name="output">

                <li><dsp:a href="albumDetails.jsp">
                      <dsp:param name="itemId" param="album.id"/>
                      <dsp:param name="dsource" value="artist-details"/>
                      <dsp:valueof param="album.title"/>
                    </dsp:a>
            
              </dsp:oparam>
              <dsp:oparam name="empty">
                No albums found for this artist.
              </dsp:oparam>
                              
            </dsp:droplet>

          
         </font>
      </td>



<!-- *** End real content *** --></td>
</tr>
</table>

   </dsp:oparam>
 </dsp:droplet>

  </BODY>
</HTML>
</dsp:page>