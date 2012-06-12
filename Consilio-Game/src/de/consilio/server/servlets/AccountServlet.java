package de.consilio.server.servlets;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import de.consilio.server.dao.UserAccountDao;
import de.consilio.server.model.AccountRegistrationException;
import de.consilio.server.model.UserAccount;
import de.consilio.server.util.Constants;

@SuppressWarnings("serial")
public class AccountServlet extends HttpServlet {

	private static final Logger log = Logger.getLogger(AccountServlet.class
			.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		String mode = req.getParameter(Constants.MODE);
		String params = req.getParameter("account");

		UserAccount account = new Gson().fromJson(params, UserAccount.class);
		
		if(mode.equals("login")) {
			handleLogin(account, resp);
		} else if(mode.equals("register")) {
			try {
				handleAccountRegistration(account, resp);
			} catch (AccountRegistrationException e) {
				resp.getWriter().write(e.getMessage());
			}
		}
	}

	private void handleLogin(UserAccount account, HttpServletResponse resp) {
		UserAccount accountByName = new UserAccountDao().getAccountByName(account.getName());
		if(accountByName != null) {
			if(accountsEqual(account, accountByName)){
				try {
					resp.getWriter().write(new Gson().toJson(accountByName));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		
	}

	private boolean accountsEqual(UserAccount account, UserAccount accountByName) {
		return accountByName.getEmail().equals(account.getEmail())&& accountByName.getPassword().equals(account.getPassword());
	}

	private void handleAccountRegistration(UserAccount account, HttpServletResponse resp) throws AccountRegistrationException {
		List<UserAccount> accounts = new UserAccountDao().getAll();
		for (UserAccount userAccount : accounts) {
			if(userAccount.getEmail().equals(account.getEmail())) {
				throw new AccountRegistrationException("The Email is already in use");
			} else if(userAccount.getName().equals(account.getName())) {
				throw new AccountRegistrationException("The UserName is already in use");
			}
		}
		UserAccount newAccount = new UserAccountDao().persist(account);
		try {
			resp.getWriter().write(new Gson().toJson(newAccount));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
