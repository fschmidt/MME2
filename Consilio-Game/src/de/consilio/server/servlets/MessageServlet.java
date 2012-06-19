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

import de.consilio.server.model.AbstractMessage;
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
			
			if (message.getType().equals(AbstractMessage.PUBLIC_CHAT_MESSAGE)) {
				handlePublicMessage(message);
			} else if (message.getType().equals(AbstractMessage.PRIVATE_CHAT_MESSAGE)) {
				handlePrivateMessage(message);
			}
		}

	}

	private void handlePrivateMessage(ChatMessage message) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Game game = null;
		game = pm.getObjectById(Game.class,
				KeyFactory.stringToKey(message.getGameId()));
		if (game != null) {
			String msg = new Gson().toJson(message);
			ChannelService channelService = ChannelServiceFactory
					.getChannelService();
			channelService.sendMessage(new ChannelMessage(ChannelId
					.getChannelId(game.getWhite(), message.getGameId()),
					msg));
			channelService.sendMessage(new ChannelMessage(ChannelId
					.getChannelId(game.getBlack(), message.getGameId()),
					msg));
		}
	}

	private void handlePublicMessage(AbstractMessage message) {
		// TODO Auto-generated method stub
	}

}
