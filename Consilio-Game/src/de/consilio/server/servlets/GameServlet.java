package de.consilio.server.servlets;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.CharBuffer;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.channel.ChannelService;
import com.google.appengine.api.channel.ChannelServiceFactory;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import de.consilio.server.model.Game;
import de.consilio.server.persistence.PMF;
import de.consilio.server.util.ChannelId;
import de.consilio.server.util.Constants;
	
@SuppressWarnings("serial")
public class GameServlet extends HttpServlet {

	private static final Logger log = Logger.getLogger(GameServlet.class
			.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		String gameId = req.getParameter(Constants.GAME_ID);
		String userId = req.getParameter(Constants.USER_ID);
		String mode = req.getParameter(Constants.MODE);
		
		log.warning("GameServlet: [mode=" + mode + ", userId=" + userId + ", gameId=" + gameId + "]");

		if (userId != null && mode != null) {
			if (mode.equals(Constants.JOIN) && gameId != null) {
				joinGame(userId, gameId, resp);
			} else if (mode.equals(Constants.CREATE)) {
				createGame(userId, resp);
			}
		}
	}

	private void createGame(String userId, HttpServletResponse resp) {
		Game game = new Game(userId);
		PersistenceManager pm = PMF.get().getPersistenceManager();
		pm.makePersistent(game);
		pm.close();

		sendGameDataToUser(game, userId, "success", resp);

	}

	private void joinGame(String userId, String gameId, HttpServletResponse resp) {
		PersistenceManager pm = PMF.get().getPersistenceManager();

		Game game = null;
		Key key = KeyFactory.stringToKey(gameId);
		log.warning("JoinGame[Key=" + key.toString() + "]");
		game = pm.getObjectById(Game.class, KeyFactory.stringToKey(gameId));
		game.setBlack(userId);

		pm.makePersistent(game);

		pm.close();

		sendGameDataToUser(game, userId, "success", resp);

	}

	private void sendGameDataToUser(Game game, String userId, String message,
			HttpServletResponse resp) {

		ChannelService channelService = ChannelServiceFactory
				.getChannelService();

		String gameId = KeyFactory.keyToString(game.getKey());

		String token = channelService.createChannel(ChannelId.getChannelId(
				userId, gameId));

		try {
			FileReader reader = new FileReader("game-response.html");
			CharBuffer buffer = CharBuffer.allocate(16384);
			reader.read(buffer);
			String index = new String(buffer.array());
			index = index.replaceAll("\\{\\{ gameId \\}\\}", gameId);
			// userId needs to be real owner
			index = index.replaceAll("\\{\\{ owner \\}\\}", userId);
			index = index.replaceAll("\\{\\{ token \\}\\}", token);
			index = index.replaceAll("\\{\\{ initialMessage \\}\\}", message);

			resp.setContentType("text/html");
			resp.getWriter().write(index);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
