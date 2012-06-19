package de.consilio.server.model;

public class AbstractMessage {

	public static final String PUBLIC_CHAT_MESSAGE = "public_chat_message";
	public static final String PRIVATE_CHAT_MESSAGE = "private_chat_message";
	public static final String GSDL_MESSAGE = "gsdl_message";

	
	protected String type;

	public AbstractMessage(){};
	
	public AbstractMessage(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}
}