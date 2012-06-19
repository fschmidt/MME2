package de.consilio.server.util;

public abstract class ChannelId {
	public static String getChannelId(String userId, String gameKey) {
		return userId + ":game-" + gameKey;
	}
}
