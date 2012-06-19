package de.consilio.server.model;

public class GameNVP {
	private String gameId;
	private String gameKey;
	private String owner;
	
	public GameNVP() {
	}

	public GameNVP(String gameId, String gameKey, String owner) {
		this.gameId = gameId;
		this.gameKey = gameKey;
		this.owner = owner;
	}

	public String getGameId() {
		return gameId;
	}
	
	public String getGameKey() {
		return gameKey;
	}

	public String getOwner() {
		return owner;
	}
}
