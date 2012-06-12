package de.consilio.server.servlets;

import java.io.IOException;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.channel.ChannelMessage;
import com.google.appengine.api.channel.ChannelService;
import com.google.appengine.api.channel.ChannelServiceFactory;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.gson.Gson;

import de.consilio.server.model.ChatMessage;
import de.consilio.server.model.Game;
import de.consilio.server.persistence.PMF;
import de.consilio.server.util.ChannelId;

@SuppressWarnings("serial")
public class MessageServlet extends HttpServlet {

	private static final Logger log = Logger.getLogger(MessageServlet.class
			.getName());
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		String params = req.getParameter("params");

		log.warning("params: " + params);
		
		ChatMessage message = null;
			message = new Gson().fromJson(params, ChatMessage.class);

		if (message != null && message.getUserId() != null) {
			
			log.warning(message.toString());
			
			if (message.getType().equals(ChatMessage.PUBLIC)) {
				handlePublicMessage(message);
			} else if (message.getType().equals(ChatMessage.PRIVATE)) {
				handlePrivateMessage(message);
			}
		} else {
			// try to build a test message
			message = new ChatMessage("Frank", "something", ChatMessage.PRIVATE, "HelloWorld");
			log.warning("Constructed :: " + message.toString());
		}

	}

	private void handlePrivateMessage(ChatMessage message) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Game game = null;
		game = pm.getObjectById(Game.class,
				KeyFactory.stringToKey(message.getGameId()));
		if (game != null) {
			ChannelService channelService = ChannelServiceFactory
					.getChannelService();
			channelService.sendMessage(new ChannelMessage(ChannelId
					.getChannelId(game.getWhite(), message.getGameId()),
					message.getMessage()));
			channelService.sendMessage(new ChannelMessage(ChannelId
					.getChannelId(game.getBlack(), message.getGameId()),
					message.getMessage()));
		}
	}

	private void handlePublicMessage(ChatMessage message) {
		// TODO Auto-generated method stub
	}

}
