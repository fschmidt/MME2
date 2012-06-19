package de.consilio.server.model;

import java.util.LinkedList;
import java.util.List;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.gson.Gson;

import de.consilio.server.gsdl.GsdlException;
import de.consilio.server.gsdl.GsdlValidation;
import de.consilio.server.gsdl.model.GsdlTurn;

@PersistenceCapable
public class Game {
	
	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key key;

	@Persistent
	private String name;

	@Persistent
	private String white;

	@Persistent
	private String black;
	
	@Persistent
	private Boolean whiteTurn;
	
	@Persistent
	private List<String> turns;

	public Game(String name, String white) {
		this.white = white;
		this.name = name;
		whiteTurn = true;
		turns  = new LinkedList<String>();
		turns.add(new Gson().toJson(new GsdlTurn("opening", "none", "none")));;
	}

	public Key getKey() {
		return key;
	}

	public String getName() {
		return name;
	}

	public String getWhite() {
		return white;
	}

	public String getBlack() {
		return black;
	}

	public void setBlack(String black) {
		this.black = black;
	}
	
	public String addTurn(GsdlTurn turn, String userId) throws GsdlException {
		if(isOwnTurn(userId) && GsdlValidation.isValidTurn(turn)) {
			turns.add(new Gson().toJson(turn));
			whiteTurn = !whiteTurn;
			return userId.equals(white)?black:white;
		} else {
			throw new GsdlException("It's not " + userId + "s Turn.");
		}
	}
	
	private boolean isOwnTurn(String userId) {
		return (white.equals(userId) && whiteTurn || black.equals(userId) && !whiteTurn);
	}

	public List<String> getTurns() {
		return turns;
	}

	@Override
	public String toString() {
		return "Game [Key=" + KeyFactory.keyToString(key) + ", Owner=" + white + "]";
	}
	
	
}
