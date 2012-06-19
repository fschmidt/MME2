package de.consilio.server.servlets;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import de.consilio.server.dao.UserAccountDao;
import de.consilio.server.model.UserAccount;
import de.consilio.server.util.Constants;
import de.consilio.server.util.ErrorCode;
import de.consilio.server.util.ResponseHelper;

@SuppressWarnings("serial")
public class AccountServlet extends HttpServlet {

	private static final Logger log = Logger.getLogger(AccountServlet.class
			.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		String mode = req.getParameter(Constants.MODE);
		String params = req.getParameter("account");

		UserAccount account = new Gson().fromJson(params, UserAccount.class);

		log.warning(account.toString());

		if (mode.equals("login")) {
			writeResponse(handleLogin(account), resp);
		} else if (mode.equals("register")) {
			writeResponse(handleAccountRegistration(account), resp);
		}
	}

	private String handleLogin(UserAccount account) {
		UserAccountDao uad = new UserAccountDao();
		try {
			UserAccount accountByName = uad
					.getAccountByName(account.getName());
			if (accountByName != null) {
				if (accountsEqual(account, accountByName)) {
					String response = ResponseHelper.createSuccess(accountByName);
					// TODO Debug
					log.warning("Response:" + response);
					return response;
				} else {
					String response = ResponseHelper.createFailure(
							ErrorCode.PASSWORD_MISMATCH, "Wrong password");
					// TODO Debug
					log.warning("Response:" + response);
					return response;
				}
			} else {
				String response = ResponseHelper.createFailure(
						ErrorCode.NO_SUCH_USER, "The user does not exist");
				// TODO Debug
				log.warning("Response:" + response);
				return response;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			uad.closeAllConnections();
		}
	}

	private boolean accountsEqual(UserAccount account, UserAccount accountByName) {
		return accountByName.getPassword().equals(account.getPassword());
	}

	private String handleAccountRegistration(UserAccount account) {
		UserAccountDao uad = new UserAccountDao();
		try {
			List<UserAccount> accounts = uad.getAll();
			if(accounts == null) {
				String response = ResponseHelper.createFailure(
						ErrorCode.UNKNOWN_ERROR,
						"Something bad happened");
				return response;
			}
			for (UserAccount userAccount : accounts) {
				if (userAccount.getEmail().equals(account.getEmail())) {
					String response = ResponseHelper.createFailure(
							ErrorCode.EMAIL_ALREADY_IN_USE,
							"The Email is already in use");
					return response;

				} else if (userAccount.getName().equals(account.getName())) {
					String response = ResponseHelper.createFailure(
							ErrorCode.EMAIL_ALREADY_IN_USE,
							"The User Name is already in use");
					return response;
				}
			}

			UserAccount newAccount = new UserAccountDao().persist(account);

			String response = ResponseHelper.createSuccess(newAccount);
			// TODO Debug
			log.warning("Response:" + response);
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			uad.closeAllConnections();
		}
	}

	private void writeResponse(String response, HttpServletResponse resp) {
		try {
			resp.getWriter().write(response);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
