package de.consilio.server.dao;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.google.appengine.api.datastore.KeyFactory;

import de.consilio.server.model.Game;
import de.consilio.server.persistence.PMF;

public class GameDao {

	private PersistenceManager pm;

	@SuppressWarnings("unchecked")
	public List<Game> getAll() {
		pm = PMF.get().getPersistenceManager();
		List<Game> games;
		Query q = pm.newQuery(Game.class);
		games = (List<Game>) q.execute();
		return games;
	}

	public Game persist(Game game) {
		pm = PMF.get().getPersistenceManager();
		Game newGame = pm.makePersistent(game);
		return newGame;
	}

	public Game getGameById(String gameId) {
		pm = PMF.get().getPersistenceManager();
		return pm.getObjectById(Game.class, KeyFactory.stringToKey(gameId));
	}

	public void closeAllConnections() {
		pm.close();
	}
}
