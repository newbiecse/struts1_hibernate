package com.keylesson.dao;

import java.util.List;

import org.hibernate.Session;

import com.keylesson.form.UserForm;
import com.keylesson.hibernate.HibernateUtil;
import com.keylesson.persistence.User;
import com.keylesson.utils.Transforms;

public class UserDAO {

	public String createUser(UserForm userForm) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			
			User user = new User();
			Transforms.transformUserForm2User(user, userForm);
			
			session.save(user);
			session.getTransaction().commit();
		} catch (Exception e) {
			System.err.println("Error creating User :" + e.getMessage());
			session.getTransaction().rollback();
			return "failure" ;
		}
		return "success";
	}

	public List getUsers(String name) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		List users = null;
		try {
			session.beginTransaction();
			users = session
					.createQuery("from User where name like :name")
					.setParameter("name", "%" + name + "%").list();
			session.getTransaction().commit();
		} catch (Exception e) {
			System.err.println("Error getting Users :" + e);
			session.getTransaction().rollback();
		}
		return users;
	}
	
	public List getListUsers() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		List users = null;
		try {
			session.beginTransaction();
			users = session
					.createQuery("from User")
					.list();
			session.getTransaction().commit();
		} catch (Exception e) {
			System.err.println("Error getting Users :" + e);
			session.getTransaction().rollback();
		}
		return users;
	}	
	
	public void update(UserForm userForm ) {
		Session session = null;
		try {
			session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			
			User user = this.findById(userForm.getId());
			Transforms.transformUserForm2User(user, userForm);
			
			session.saveOrUpdate(user);
			session.getTransaction().commit();

			
//			String sql = String.format("update from User set name='%s', age=%d where id=%d ",
//					userForm.getName(),
//					userForm.getAge(),
//					userForm.getId());
//			
//			SQLQuery sqlQuery = session.createSQLQuery(sql);
//			sqlQuery.executeUpdate();			
//			
//			session.getTransaction().commit();
		} catch (Exception e) {
			System.err.println("Error getting Users :" + e);
			session.getTransaction().rollback();
		}
	}	

	public void delete(int id) {
		Session session = null;
		try {
			session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			
			User user = this.findById(id);
			
			session.delete(user);
			session.getTransaction().commit();
			
			
//			String sql = String.format("delete User where id=%d ", id);
//			
//			SQLQuery sqlQuery = session.createSQLQuery(sql);
//			sqlQuery.executeUpdate();			
//			
//			session.getTransaction().commit();
		} catch (Exception e) {
			System.err.println("Error getting Users :" + e);
			session.getTransaction().rollback();
		}
	}
	
	public User findById(int userId) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		User user = null;
		try {
			session.beginTransaction();
//			String sql = String.format("select * from User where id=%d ", userId);
			String sql = String.format("from User where id=%d ", userId);
			user = (User) session
					.createQuery(sql)
					.list().get(0);
//			session.getTransaction().commit();
		} catch (Exception e) {
			System.err.println("Error getting Users :" + e);
			session.getTransaction().rollback();
		}
		return user;
	}	
}
