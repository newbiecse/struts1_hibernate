package com.keylesson.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.keylesson.dao.UserDAO;
import com.keylesson.form.UserForm;

public class UserAction extends DispatchAction {

	public ActionForward goToSearchPage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("search");
	}

	public ActionForward goToAddPage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("add");
	}

	public ActionForward searchUsers(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserForm userForm = (UserForm) form;
		List users = new UserDAO().getUsers(userForm.getName());
		request.setAttribute("users", users);
		return mapping.findForward("search");
	}

	public ActionForward addUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserForm userForm = (UserForm) form;
		String result = new UserDAO().createUser(userForm.getName(),
				userForm.getAge());
		if (result.equals("success")) {
			request.setAttribute("success", true);
			userForm.reset();
		} else {
			request.setAttribute("failure", true);
		}
		return mapping.findForward("add");
	}

	public ActionForward indexUsers(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserDAO dao = new UserDAO();
		
		List users = dao.getListUsers();
		request.setAttribute("users", users);
		
		// update - hard code
		UserForm userToUpdate = new UserForm();
		userToUpdate.setId(1);
		userToUpdate.setName("BBB");
		userToUpdate.setAge(2);
		
		dao.update(userToUpdate);
		
		// DELETE
		dao.delete(2);
		
		return mapping.findForward("index");
	}

	public ActionForward indexUsersJson(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List users = new UserDAO().getListUsers();
		response.setContentType("JSON");

		PrintWriter out = null;
		
		try {			

			
			Gson gson = new Gson();
			JsonElement jsonElement = gson.toJsonTree(users);
			
			JsonObject o = new JsonObject();
			o.add("users", jsonElement);
			
						
			out = response.getWriter();
			
			out.println(o.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.flush();
			out.close();
		}

		return null;
	}
}
