package de.consilio.server.util;

public final class ErrorCode {
	
	private static int ACCOUNT_ERROR = 2000;
	
	public static final int NO_SUCH_USER = ACCOUNT_ERROR + 1;
	public static final int PASSWORD_MISMATCH = ACCOUNT_ERROR + 2; 
	public static final int EMAIL_ALREADY_IN_USE = ACCOUNT_ERROR + 3;
	public static final int USER_NAME_ALREADY_IN_USE = ACCOUNT_ERROR + 4;

	public static final int UNKNOWN_ERROR = ACCOUNT_ERROR;
	
	private ErrorCode(){};
}
