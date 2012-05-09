package de.bht.consilio.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;

import de.bht.consilio.exception.NoSuchUserAccountException;
import de.bht.consilio.model.UserAccount;
import de.bht.consilio.util.PersistenceManager;

public class EclipseLinkUserAccountDao {

	private static EclipseLinkUserAccountDao instance = null;
	EntityManagerFactory emf;
	EntityManager em;

	private EclipseLinkUserAccountDao() {
		emf = PersistenceManager.getInstance().createEntityManagerFactory();
		em = emf.createEntityManager();
	}

	public static EclipseLinkUserAccountDao getInstance() {
		if (instance != null) {
			instance.closeConnections();
		}
		instance = new EclipseLinkUserAccountDao();
		return instance;
	}

	public boolean create(UserAccount user) {
		EntityManagerFactory emf = PersistenceManager.getInstance()
				.createEntityManagerFactory();
		EntityManager em = emf.createEntityManager();

		EntityTransaction tx = em.getTransaction();

		tx.begin();

		em.persist(user);
		
		tx.commit();

		return true;
	}

	public boolean update(UserAccount user) {

		try {
			EntityManagerFactory emf = PersistenceManager.getInstance()
					.createEntityManagerFactory();
			EntityManager em = emf.createEntityManager();

			EntityTransaction tx = em.getTransaction();
			tx.begin();

			em.merge(user);

			tx.commit();

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public boolean delete(UserAccount user) {
		try {

			EntityManagerFactory emf = PersistenceManager.getInstance()
					.createEntityManagerFactory();
			EntityManager em = emf.createEntityManager();

			EntityTransaction tx = em.getTransaction();
			tx.begin();

			em.remove(user);

			tx.commit();

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public UserAccount getUserAccount(final String name, final String password)
			throws NoSuchUserAccountException {
		
		try {

			em.getTransaction().begin();
			UserAccount current = (UserAccount) em
					.createQuery(
							"select a from UserAccount a WHERE a.name=?1 AND a.password=?2")
					.setParameter(1, name).setParameter(2, password)
					.getSingleResult();
			em.getTransaction().commit();

			return current;

		} catch (Exception ex) {
			ex.printStackTrace();
			throw new NoSuchUserAccountException();
		}
	}

	public List<UserAccount> getAll() {
		EntityManagerFactory emf = PersistenceManager.getInstance()
				.createEntityManagerFactory();
		EntityManager em = emf.createEntityManager();
		ArrayList<UserAccount> users = new ArrayList<UserAccount>();

		EntityTransaction tx = em.getTransaction();
		tx.begin();

		List<?> fetchedComments = em.createQuery("select a from UserAccount a")
				.getResultList();

		for (Object fetchedIdea : fetchedComments) {
			if (fetchedIdea instanceof UserAccount) {
				UserAccount user = (UserAccount) fetchedIdea;
				users.add(user);
			}
		}

		tx.commit();

		return users;
	}

	private void closeConnections() {
		em.close();
		emf.close();
	}
}