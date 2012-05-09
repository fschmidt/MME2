package de.bht.consilio.exception;

public class NoSuchUserAccountException extends Exception {

	private static final long serialVersionUID = 4794860976592867983L;

	public NoSuchUserAccountException() {
		super("No such User Account");
	}

}
