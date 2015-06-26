package com.keylesson.form;

import org.apache.struts.action.ActionForm;

//public class UserForm extends ValidatorForm {
public class UserForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String dispatch;
	private Integer id;
	private String firstName;
	private String lastName;
	private String email;
	private String phone;

//	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
//        ActionErrors errors = new ActionErrors();
//        if (name == null || name.length() < 1) {
//            errors.add("name", new ActionMessage("error.name.required"));
//        }
//        if (age == null) {
//            errors.add("age", new ActionMessage("error.age.required"));
//        }
//        return errors;
//    }	
	
	public void reset() {
		this.firstName = null;
		this.lastName = null;
		this.email = null;
		this.phone = null;
	}

	public String getDispatch() {
		return dispatch;
	}

	public void setDispatch(String dispatch) {
		this.dispatch = dispatch;
	}


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

}
