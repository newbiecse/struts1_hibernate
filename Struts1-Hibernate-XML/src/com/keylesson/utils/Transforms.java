package com.keylesson.utils;

import com.keylesson.form.UserForm;
import com.keylesson.persistence.User;

public class Transforms {
	public static void transformUserForm2User(User user, UserForm userForm) {
//		user.setId(userForm.getId());
		user.setFirstName(userForm.getFirstName());
		user.setLastName(userForm.getLastName());
		user.setEmail(userForm.getEmail());
		user.setPhone(userForm.getPhone());
	}
}
