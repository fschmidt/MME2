package de.consilio.server.model;

public class ChatMessage extends AbstractMessage {
	private String userId;
	private String gameId;
	private String message;
	
	public ChatMessage() {}
	
	public ChatMessage(String userId, String gameId, String type, String message) {
		super(type);
		this.userId = userId;
		this.gameId = gameId;
		this.message = message;
	}
	
	public String getUserId() {
		return userId;
	}
	public String getGameId() {
		return gameId;
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
