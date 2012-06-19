package de.consilio.server.gsdl.model;

import de.consilio.server.model.AbstractMessage;

public class GsdlTurn extends AbstractMessage {
	private String action;
	private String source;
	private String target;
	
	public GsdlTurn(){
		super(GSDL_MESSAGE);
	};
	
	public GsdlTurn(String action, String source, String target) {
		super(GSDL_MESSAGE);
		this.action = action;
		this.source = source;
		this.target = target;
	}

	public String getAction() {
		return action;
	}

	public String getSource() {
		return source;
	}

	public String getTarget() {
		return target;
	}
}
