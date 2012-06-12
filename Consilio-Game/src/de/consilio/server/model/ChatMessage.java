package de.consilio.server.model;

public class ChatMessage {
	public static final String PUBLIC = "public";
	public static final String PRIVATE = "private";
	
	private String userId;
	private String gameId;
	private String type;
	private String message;
	
	public ChatMessage() {
		
	}
	
	public ChatMessage(String userId, String gameId, String type, String message) {
		super();
		this.userId = userId;
		this.gameId = gameId;
		this.type = type;
		this.message = message;
	}
	
	public String getUserId() {
		return userId;
	}
	public String getGameId() {
		return gameId;
	}
	public String getType() {
		return type;
	}
	public String getMessage() {
		return message;
	}
	@Override
	public String toString() {
		return "ChatMessage [userId=" + userId + ", gameId=" + gameId
				+ ", type=" + type + ", message=" + message + "]";
	}
}
