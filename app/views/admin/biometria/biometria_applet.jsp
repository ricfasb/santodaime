<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">
	
		function capturaValor(){
		
			var valor = document.appletBiometria.retornoString();
			document.getElementById('param1').value = valor;
			alert(valor);
			document.formSubmit.submit();
			

		}
		
</script>
</head>
<body>
	<form action="../UsuarioCadastroDadosPessoaisServlet" id="formSubmit" method="post" >
	<applet alt="Biometria"  name="appletBiometria"  code="CadastrarDigitalApplet" archive="NBioBSPJNI.jar,aCadastrarDigitalApplet.jar,aCadastrarDigitalApplet$1.jar">
		<param name="teste" id="param1"> 
	</applet>
	
	<input type="button" onclick="capturaValor();" value="Ok" >
	</form>
	
</body>
</html>