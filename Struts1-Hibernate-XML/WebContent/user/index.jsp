<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Demo</title>

    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<style>
		#tr-template{
			display: none;
		}
	</style>
</head>
<body>

    <nav class="navbar navbar-default">
	  <div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
		  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		  </button>
		  <a class="navbar-brand" href="#">ABCV</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		  <ul class="nav navbar-nav">
			<li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>
			<li><a href="#">Link</a></li>
			<li class="dropdown">
			  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
			  <ul class="dropdown-menu">
				<li><a href="#">Action</a></li>
				<li><a href="#">Another action</a></li>
				<li><a href="#">Something else here</a></li>
				<li role="separator" class="divider"></li>
				<li><a href="#">Separated link</a></li>
				<li role="separator" class="divider"></li>
				<li><a href="#">One more separated link</a></li>
			  </ul>
			</li>
		  </ul>
		  <form class="navbar-form navbar-left" role="search">
			<div class="form-group">
			  <input type="text" class="form-control" placeholder="Search">
			</div>
			<button type="submit" class="btn btn-default">Submit</button>
		  </form>
		  <ul class="nav navbar-nav navbar-right">
			<li><a href="#">Link</a></li>
			<li class="dropdown">
			  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
			  <ul class="dropdown-menu">
				<li><a href="#">Action</a></li>
				<li><a href="#">Another action</a></li>
				<li><a href="#">Something else here</a></li>
				<li role="separator" class="divider"></li>
				<li><a href="#">Separated link</a></li>
			  </ul>
			</li>
		  </ul>
		</div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>


	<div class="container">
		<h1>Manage users</h1>
		
		<div class="row">
			<button id="btn-add" type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#userFormModal"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Create</button>
		</div>
		
		<div class="row">		
			<table id="userList" class="table table-condensed table-bordered table-hover">
				<thead>
					<th>Id</th>
					<th>Name</th>
					<th>Age</th>
					<th>Actions</th>
				</thead>
				<tbody>
				
					<tr id="tr-template" data-userId="0">
						<td class="td-userId">1</td>
						<td class="td-name">user1</td>
						<td class="td-age">user1@abcv.com</td>
						<td>
							<button type="button" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> Details</button>
							<button type="button" class="btn btn-warning btn-sm btn-edit" data-toggle="modal" data-target="#userFormModal" data-userId="1"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit</button>
							<button type="button" class="btn btn-danger btn-sm btn-delete" data-toggle="modal" data-target="#deleteConfirmModal" data-userId="1"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Delete</button>
						</td>
					</tr>
					
					<logic:notEmpty name="users" >
						<logic:iterate name="users" id="user">
							<tr data-userId="<bean:write name="user" property="id" />">
								<td class="td-userId"><bean:write name="user" property="id" /></td>
								<td class="td-name"><bean:write name="user" property="name" /></td>
								<td class="td-age"><bean:write name="user" property="age" /></td>
								<td>
									<button type="button" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> Details</button>
									<button type="button" class="btn btn-warning btn-sm btn-edit" data-toggle="modal" data-target="#userFormModal" data-userId="1"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit</button>
									<button type="button" class="btn btn-danger btn-sm btn-delete" data-toggle="modal" data-target="#deleteConfirmModal" data-userId="1"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Delete</button>
								</td>
							</tr>
						</logic:iterate>
					</logic:notEmpty>
					
				</tbody>
			</table>
		</div>
		
		
	</div>
	
	
	
	<!-- Mode add/edit -->
	<div class="modal fade" id="userFormModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	
	  <div class="modal-dialog">
		<div class="modal-content">
			<form id="userForm" method="post" role="form" data-toggle="validator" action="http://localhost:8080/Struts1-Hibernate-XML/user.do?dispatch=addUserJson">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">User form</h4>
			  </div>
			  <div class="modal-body">
					
					  <input type="hidden" value="-1" id="txtUserId" name="id" />
					
					  <div class="form-group">
						<label for="txtName">Name</label>
						<input type="text" name="name" class="form-control" id="txtName" placeholder="Name" data-minlength="5" data-minlength-error="Name at least 8 characters" required />
						<div class="help-block with-errors"></div>
					  </div>
				
					  <!--  	  
					  <div class="form-group">
						<label for="txtEmail">Email</label>
						<input type="email" class="form-control" id="txtEmail" placeholder="Email" data-minlength="8" data-minlength-error="Email at least 8 characters" required />
						<div class="help-block with-errors"></div>
					  </div>
					  -->
					  
					  <div class="form-group">
						<label for="txtAge">Age</label>
						<input type="text" name="age" class="form-control" id="txtAge" placeholder="Age" required />
						<div class="help-block with-errors"></div>
					  </div>				  
							
			  </div>
			  <div class="modal-footer">
				<button type="button" class="btn btn-warning" data-dismiss="modal"><span class="glyphicon glyphicon-floppy-remove" aria-hidden="true"><span> Cancel</button>
				<button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-floppy-save" aria-hidden="true"><span> Save</button>
			  </div>
		  
			</form>
		  
		</div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->	
	
	
	<!-- delete confirm modal -->
	<div class="modal fade" id="deleteConfirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-body">
				<h5>Are you sure delete this user?</h5>
			</div>
			<div class="modal-footer">
				<form id="userDeleteForm" method="post" role="form" action="http://localhost:8080/Struts1-Hibernate-XML/user.do?dispatch=deleteUserJson">
					<input type="hidden" value="-1" id="txtUserId" name="id" />
					<button type="button" class="btn btn-success btn-sm" data-dismiss="modal"><span class="glyphicon glyphicon-floppy-remove" aria-hidden="true"><span> No</button>
					<button type="submit" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-floppy-save" aria-hidden="true"><span> Yes</button>				
				</form>
			</div>
		</div>
	  </div>
	</div>	
	
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/validator.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/userForm.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/usersListContainer.js"></script>
  </body>
</html>