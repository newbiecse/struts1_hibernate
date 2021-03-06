$(document).ready(function(){
	// doms
	$userList = $("#userList");
	$userForm = $("#userForm");	
	$userDeleteForm = $("#userDeleteForm");
	
	// get list user
//	renderListUsers($userList);
	
	// handle 4 add button
	$("#btn-add").on("click", function(){
		$userForm.find("#txtUserId").val(-1);
		$userForm.attr("action", "http://localhost:8080/Struts1-Hibernate-XML/user.do?dispatch=addUserJson");
		clearValue4Form($userForm);
	});
	
	// handle 4 edit button
	$userList.find(".btn-edit").on("click", function(){
		var userId = $(this).closest("tr").attr("data-userId");
		$userForm.attr("action", "http://localhost:8080/Struts1-Hibernate-XML/user.do?dispatch=addUserJson");
		renderValue4UserForm(userId, $userForm);
	});
	
	// handle 4 delete button
	$userList.find(".btn-delete").on("click", function(){
		var userId = $(this).closest("tr").attr("data-userId");
		renderValue4UserDeleteForm(userId, $userDeleteForm);
	});	
	
	// handle 4 hide modal
	$("#userFormModal").on('hidden.bs.modal', function () {
		clearValidate($userForm);
    });
	
	// handle submit form
	$userForm.submit(function(event){
		 /* stop form from submitting normally */
		event.preventDefault();
		
		// submit
		doSubmitForm($userForm);
	});
	
	
});


/**
*	description: get list user
*/
function getUsers() {
	var listUsers = new Array();
	$.ajax({
		type: "GET",
		async: false,
		url: "http://localhost:8080/Struts1-Hibernate-XML/user.do?dispatch=indexUsersJson",
		cache: false,
		success: function(data){
			listUsers = data.users;
		}
	});	
	
	return listUsers;
}


/**
*	description: render list user
*/
function renderListUsers($domTable) {
	// doms
	var $rowTemplate = $domTable.find("#tr-template");
	var $tbody = $domTable.find("tbody");
	
	// clear old data
	$tbody.find("tr:gt(0)").remove();
	
	// render users
	var listUsers = getUsers();
	if(typeof listUsers != "undefined" && listUsers != null) {
		listUsers.forEach(function(user){
			var $rowClone = $rowTemplate.clone();
			
			// process display
			$rowClone.removeAttr('id');
			$rowClone.attr('data-userId', user.id);
			$rowClone.show();
			
			// render data
			$rowClone.find(".td-userId").text(user.id);
			$rowClone.find(".td-name").text(user.name);
			$rowClone.find(".td-age").text(user.age);
			
			$tbody.append($rowClone);
		});
	}
}

/**
*	description: get detail user by id's user
*/
function getUser(userId) {
	var user = null;
	$.ajax({
		type: "GET",
		data: "id=" + userId,
		async: false,
		url: "http://localhost:8080/Struts1-Hibernate-XML/user.do?dispatch=getUserJson",
		cache: false,
		success: function(data){
			user = data;
		}
	});
	
	return user;
}


/**
*	description: render value for edit user
*/
function renderValue4UserForm(userId, $userForm) {
	// get user
	var user = getUser(userId);
	
	// set values
	$userForm.find("#txtUserId").val(userId);
	$userForm.find("#txtName").val(user.name);
	$userForm.find("#txtAge").val(user.age);
}


/**
*	description: render data for delete form
*/
function renderValue4UserDeleteForm(userId, $deleteForm) {
	$deleteForm.attr("action", "urlDelete?userId=" + userId);
}


/**
*	description: clear validate
*/
function clearValidate($form) {
	
	//$form.find('.form-group').each(function(){
	$('.form-group').each(function(){
		// clear error shadow
		$(this).removeClass('has-error');
		
		// clear error message
		$(this).find('.help-block').html('')
	});
}


/**
*	description: clear value form
*/
function clearValue4Form($form) {
	$form.find("input:not([type=image],[type=button],[type=submit]), textarea").val("");
}

/**
*	description: add user
*/
function doSubmitForm($form) {
	$.ajax({
		type: "POST",
		data: $form.serialize(),
		async: false,
		url: $form.attr("action"),
		cache: false,
		success: function(data){
			$form.closest('#userFormModal').modal('hide');
			renderListUsers($("#userList"));
		}
	});
	
}