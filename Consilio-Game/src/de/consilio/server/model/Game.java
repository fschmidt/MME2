package de.consilio.server.model;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

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

	
	public Game(String name, String white) {
		this.white = white;
		this.name = name;
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

	@Override
	public String toString() {
		return "Game [Key=" + KeyFactory.keyToString(key) + ", Owner=" + white + "]";
	}
	
	
}
