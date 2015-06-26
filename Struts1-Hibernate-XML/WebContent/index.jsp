<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="${pageContext.request.contextPath}/styles/bootstrap.css" rel="stylesheet">
</head>
<body>
	<ul>
		<li>
			<html:link href="${pageContext.request.contextPath}/user.do?dispatch=goToSearchPage">
				Search user
			</html:link>
		</li>
		<li>
			<html:link href="${pageContext.request.contextPath}/user.do?dispatch=goToAddPage">
				Add user
			</html:link>
		</li>
	</ul>
</body>
</html>