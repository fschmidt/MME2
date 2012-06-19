package de.consilio.server.util;

import com.google.gson.Gson;

import de.consilio.server.model.Response;

public class ResponseHelper {
	public static <T> String createSuccess(T data) {
		return new Gson().toJson(new Response<T>(true, "success", 0, data));
	}
	
	public static <T> String createFailure(int errorCode, String message) {
		return new Gson().toJson(new Response<T>(false, message, errorCode, null));
	}
}
