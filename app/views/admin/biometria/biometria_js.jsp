<%@ page import="java.util.ResourceBundle"%>
<%
ResourceBundle resourceBundle=null;
resourceBundle = (ResourceBundle)getServletContext().getAttribute("propriedades"+session.getAttribute("language"));
%>


<html>
<head>
<script lang='javascript'>

function fechar(){
	
	window.close('this');
}


function regist()
{
	
    var err, payload;
    try // Exception handling
    {
        // Open device. [AUTO_DETECT]
        // You must open device before enroll.
        DEVICE_FDP02 = 1;
        DEVICE_FDU01 = 2;
        DEVICE_AUTO_DETECT = 255;
        var objDevice = document.objNBioBSP.Device;
        var objExtraction = document.objNBioBSP.Extraction;

        objDevice.Open(DEVICE_AUTO_DETECT);
        err = document.objNBioBSP.ErrorCode;// Get error code
        if ( err != 0 ) // Device open failed
        {
           fechar();
           return false;
        }

        // Enroll user's fingerprint.
        objExtraction.Enroll(payload);
        err = objExtraction.ErrorCode; // Get error code
        if ( err != 0 ) // Enroll failed
        {
           alert('<%=resourceBundle.getString("msgBiometriaDesconectado")%>');
           objDevice.Close(DEVICE_AUTO_DETECT);
           fechar();
           return false;
        }
        else // Enroll success
        {
        // Get text encoded FIR data from NBioBSP module.
          document.getElementById('biometria').value = objExtraction.TextEncodeFIR;
          document.frm.submit();
      	  fechar();
          return false;
        }

        // Close device. [AUTO_DETECT]
        objDevice.Close(DEVICE_AUTO_DETECT);
        objExtraction = 0;
        objDevice = 0;
        
    }
    catch(e)
    {
    	alert(e.message);
        return false;
        fechar();
    }
}
</script>
</head>
<OBJECT id="objNBioBSP" height="14" width="14" classid="clsid:F66B9251-67CA-4d78-90A3-28C2BFAE89BF" VIEWASTEXT></OBJECT>
<body onload="return regist();" id="bdBio">

<%
String codPessoa = request.getParameter("codPess");
%>

<form action="../UsuarioCadastroDadosPessoaisServlet" id="frm" name="frm" method="post">
<input type="hidden" name="stringBio" id="biometria"/>
<input type="hidden" name="acao" value="biometria"/>
<input type="hidden" name="codPess" value="<%=codPessoa%>"/>
</form>
</body>
</html>