package de.consilio.server.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import de.consilio.server.model.UserAccount;
import de.consilio.server.persistence.PMF;

public class UserAccountDao {

	private PersistenceManager pm;

	@SuppressWarnings("unchecked")
	public List<UserAccount> getAll() {
		pm = PMF.get().getPersistenceManager();
		List<UserAccount> accounts;
		Query q = pm.newQuery(UserAccount.class);
		accounts = (List<UserAccount>) q.execute();
		return accounts;
	}

	public UserAccount persist(UserAccount account) {
		pm = PMF.get().getPersistenceManager();
		UserAccount newAccount = pm.makePersistent(account);
		return newAccount;
	}

	@SuppressWarnings("unchecked")
	public UserAccount getAccountByName(String name) {
		pm = PMF.get().getPersistenceManager();
		Query query = pm.newQuery(UserAccount.class, "name == nameParam");
		query.declareParameters("String nameParam");

		List<UserAccount> results = (List<UserAccount>) query.execute(name);
		if (!results.isEmpty()) {
			return results.get(0);
		} else {
			return null;
		}
	}

	public void closeAllConnections() {
		pm.close();
	}
}
