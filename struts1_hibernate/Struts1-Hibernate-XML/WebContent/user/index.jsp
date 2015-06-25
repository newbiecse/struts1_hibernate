<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<br>
	<logic:notEmpty name="users" >
	<table width="100%">
		<tr>
			<td bgcolor="#FF9900">Name</td>
			<td bgcolor="#FF9900">Age</td>
		</tr>
		<logic:iterate name="users" id="user">
			<tr>
				<td bgcolor="#DBEAF9"><bean:write name="user" property="name" /></td>
				<td bgcolor="#DBEAF9"><bean:write name="user" property="age" /></td>
			</tr>
		</logic:iterate>
	</table>
	</logic:notEmpty>
		
	<br><br>
	<html:link href="${pageContext.request.contextPath}/"> Home </html:link>
</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			  type: "GET",
			  url: "http://localhost:8080/Struts1-Hibernate-XML/user.do?dispatch=indexUsersJson",
			  cache: false,
			  success: function(data){
			     alert(data);
			  }
			});
	});
</script>

</html>