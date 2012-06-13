package de.consilio.server.model;

public class Response<T> {
	private Boolean success;
	private String message;
	private String errorCode;
	private T data;
	
	public Response(Boolean success, String message, String errorCode, T data) {
		this.success = success;
		this.message = message;
		this.errorCode = errorCode;
		this.data = data;
	}
	
	public Response() {
	}
	
	public Boolean getSuccess() {
		return success;
	}
	
	public void setSuccess(Boolean success) {
		this.success = success;
	}
	
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getErrorCode() {
		return errorCode;
	}
	
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	
	public T getData() {
		return data;
	}
	
	public void setData(T data) {
		this.data = data;
	}
	
	@Override
	public String toString() {
		return "Response [success=" + success + ", message=" + message
				+ ", errorCode=" + errorCode + ", data=" + data + "]";
	}
}
