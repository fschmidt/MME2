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
import de.consilio.server.model.ChatMessage;
import de.consilio.server.model.Game;
import de.consilio.server.model.GameNVP;
import de.consilio.server.persistence.PMF;
import de.consilio.server.util.ChannelId;
import de.consilio.server.util.Constants;
import de.consilio.server.util.ResponseHelper;

@SuppressWarnings("serial")
public class GameServlet extends HttpServlet {

	private static final Logger log = Logger.getLogger(GameServlet.class
			.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		String gameId = req.getParameter(Constants.GAME_ID);
		String gameKey = req.getParameter(Constants.GAME_KEY);
		String userId = req.getParameter(Constants.USER_ID);
		String mode = req.getParameter(Constants.MODE);

		log.warning("GameServlet: [mode=" + mode + ", userId=" + userId
				+ ", gameId=" + gameId +  ", gameKey=" + gameKey + "]");

		if (mode.equals(Constants.LIST_GAMES)) {
			listGames(resp);
		}

		if (userId != null && mode != null) {
			if (mode.equals(Constants.JOIN) && gameKey != null ) {
				joinGame(userId, gameKey, resp);
			} else if (mode.equals(Constants.CREATE) && gameId != null) {
				createGame(userId, gameId, resp);
			}
		}
	}

	private void listGames(HttpServletResponse resp) {

		GameDao gd = new GameDao();
		List<Game> games = gd.getAll();
		List<GameNVP> result = new LinkedList<GameNVP>();
		for (Game game : games) {
			if(game.getBlack() == null){
			result.add(new GameNVP(game.getName(), KeyFactory.keyToString(game.getKey()), game.getWhite()));
			}
		}
		log.warning(result.toString());
		String response = ResponseHelper.createSuccess(result);
		log.warning("Response: " + response);
		writeResponse(response, resp);
		gd.closeAllConnections();
	}

	private void createGame(String userId, String gameId, HttpServletResponse resp) {
		Game game = new Game(gameId, userId);
		PersistenceManager pm = PMF.get().getPersistenceManager();
		pm.makePersistent(game);
		pm.close();

		sendGameDataToUser(game, userId, "success", resp);

	}

	private void joinGame(String userId, String gameKey, HttpServletResponse resp) {
		PersistenceManager pm = PMF.get().getPersistenceManager();

		Game game = null;
		Key key = KeyFactory.stringToKey(gameKey);
		log.warning("JoinGame[Key=" + key.toString() + "]");
		game = pm.getObjectById(Game.class, KeyFactory.stringToKey(gameKey));
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
			index = index.replaceAll("\\{\\{ owner \\}\\}", game.getWhite());
			index = index.replaceAll("\\{\\{ token \\}\\}", token);
			index = index.replaceAll("\\{\\{ initialMessage \\}\\}", message);

			resp.setContentType("text/html");
			resp.getWriter().write(index);
			
			// tell the white player someone joined the game
			String msg = new Gson().toJson(new ChatMessage(game.getBlack(), gameId, "join_message", "unused"));
			channelService.sendMessage(new ChannelMessage(ChannelId
					.getChannelId(game.getWhite(), gameId),
					msg));
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
