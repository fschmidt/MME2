package de.bht.consilio.service;

import de.bht.consilio.dao.EclipseLinkUserAccountDao;
import de.bht.consilio.exception.NoSuchUserAccountException;
import de.bht.consilio.model.UserAccount;

public class UserAccountService {

	public UserAccount getUserAccount(final String name, final String password) {

		try {

			UserAccount current = EclipseLinkUserAccountDao.getInstance().getUserAccount(name, password);

			return current;

		} catch (NoSuchUserAccountException e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
	
	public boolean registerUserAccount(final String name, final String password, final String email) {
		
		UserAccount newUserAccount = new UserAccount(name, password, email);
		
		EclipseLinkUserAccountDao.getInstance().create(newUserAccount);
		
		return true;
	}

}
