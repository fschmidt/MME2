package de.consilio.server.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import de.consilio.server.model.UserAccount;
import de.consilio.server.persistence.PMF;

public class UserAccountDao {

	@SuppressWarnings("unchecked")
	public List<UserAccount> getAll() {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		List<UserAccount> accounts;
		try {
			String query = "select from " + UserAccount.class.getName();
			accounts = (List<UserAccount>) pm.newQuery(query).execute();
		} finally {
			pm.close();
		}
		return accounts;
	}

	public UserAccount persist(UserAccount account) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		UserAccount newAccount = pm.makePersistent(account);
		pm.close();
		
		return newAccount;
	}

	@SuppressWarnings("unchecked")
	public UserAccount getAccountByName(String name) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query query = pm.newQuery(UserAccount.class, "name == nameParam");
		query.declareParameters("String nameParam");

		try {
			List<UserAccount> results = (List<UserAccount>) query.execute(name);
			if (!results.isEmpty()) {
				return results.get(0);
			} else {
				return null;
			}
		}

		finally {
			query.closeAll();
		}
	}
}
