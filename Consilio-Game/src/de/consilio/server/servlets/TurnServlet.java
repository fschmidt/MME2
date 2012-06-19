package de.consilio.server.servlets;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.CharBuffer;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.channel.ChannelMessage;
import com.google.appengine.api.channel.ChannelService;
import com.google.appengine.api.channel.ChannelServiceFactory;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.gson.Gson;

import de.consilio.server.dao.GameDao;
import de.consilio.server.gsdl.GsdlException;
import de.consilio.server.gsdl.model.GsdlTurn;
import de.consilio.server.model.Game;
import de.consilio.server.model.GameNVP;
import de.consilio.server.persistence.PMF;
import de.consilio.server.util.ChannelId;
import de.consilio.server.util.Constants;
import de.consilio.server.util.ErrorCode;
import de.consilio.server.util.ResponseHelper;

@SuppressWarnings("serial")
public class TurnServlet extends HttpServlet {
	
	

	private static final Logger log = Logger.getLogger(TurnServlet.class
			.getName());
	
	private static final String TURN = "turn";

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		String gameKey = req.getParameter(Constants.GAME_KEY);
		String userId = req.getParameter(Constants.USER_ID);
		String gsdlTurn = req.getParameter(TURN);

		log.warning("TurnServlet: [turn=" + gsdlTurn + ", userId=" + userId +
				", gameKey=" + gameKey + "]");
		
		GsdlTurn turn = new Gson().fromJson(gsdlTurn, GsdlTurn.class);
		
		GameDao gd = new GameDao();
		Game game = gd.getGameByKey(gameKey);
		
		if(game != null) {
			try {
				String userToNotify = game.addTurn(turn, userId);
				String response = ResponseHelper.createSuccess(turn);
				sendResponseToChannel(gameKey, userToNotify, response);
				log.warning(response);
			} catch (GsdlException e) {
				String response = ResponseHelper.createFailure(ErrorCode.GSDL_ERROR, e.getMessage());
				sendResponseToChannel(gameKey, userId, response);
				log.warning(e.getMessage());
			}
		}
		
		gd.closeAllConnections();
	}

	private void sendResponseToChannel(String gameKey, String userId,
			String response) {
		ChannelService channelService = ChannelServiceFactory
				.getChannelService();
		channelService.sendMessage(new ChannelMessage(ChannelId
				.getChannelId(userId, gameKey), response
				));
	}

}
