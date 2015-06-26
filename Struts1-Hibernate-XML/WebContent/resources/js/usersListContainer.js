//$(document).ready(function(){
	// doms
	$userList = $("#userList");
	$userForm = $("#userForm");	
	$userDeleteForm = $("#userDeleteForm");
	
	// get list user
//	renderListUsers($userList);
	
	// handle 4 add button
	$("#btn-add").on("click", function(){
		$userForm.find("#txtUserId").val(-1);
		clearValue4Form($userForm);
	});
	
	// handle 4 edit button
//	$userList.find(".btn-edit").on("click", function(){
	$userList.on("click", ".btn-edit", function(){
		var userId = $(this).closest("tr").attr("data-userId");
		renderValue4UserForm(userId, $userForm);
	});
	
	// handle 4 delete button
//	$userList.find(".btn-delete").on("click", function(){
	$userList.on("click", ".btn-delete", function(){
		var userId = $(this).closest("tr").attr("data-userId");
		renderValue4UserDeleteForm(userId, $userDeleteForm);
	});	
	
	// handle 4 hide modal
	$("#userFormModal").on('hidden.bs.modal', function () {
		clearValidate($userForm);
    });
	
	// handle submit form
	$userForm.validator().on('submit', function(event){
		/* stop form from submitting normally */
		if (!event.isDefaultPrevented()) {
			// submit
			doSubmitForm($userForm);			
		}
		
		/* stop form from submitting normally */
		event.preventDefault();
	});
	

	// handle submit delete form
	$userDeleteForm.submit(function(event){
		 /* stop form from submitting normally */
		event.preventDefault();
		
		// submit
		doSubmitFormDelete($userDeleteForm);
	});
	
	
//});


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
			$rowClone.find(".td-email").text(user.email);
			$rowClone.find(".td-firstName").text(user.firstName);
			$rowClone.find(".td-lastName").text(user.lastName);
			$rowClone.find(".td-phone").text(user.phone);
			
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
	$userForm.find("#txtEmail").val(user.email);
	$userForm.find("#txtFirstName").val(user.firstName);
	$userForm.find("#txtLastName").val(user.lastName);
	$userForm.find("#txtPhone").val(user.phone);
}


/**
*	description: render data for delete form
*/
function renderValue4UserDeleteForm(userId, $deleteForm) {
	$deleteForm.find("#txtUserId").val(userId);
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
		$(this).find('.help-block').html('');
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

function doSubmitFormDelete($form) {
	$.ajax({
		type: "POST",
		data: $form.serialize(),
		async: false,
		url: $form.attr("action"),
		cache: false,
		success: function(data){
			$form.closest('#deleteConfirmModal').modal('hide');
			renderListUsers($("#userList"));
		}
	});	
}