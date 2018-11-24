package com.pall.mts.common.i18n;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Component;

@Component
public class ResourceUtils {

	@Autowired
	private  MessageSource messageSource;
	private static Locale locale = new Locale("zh", "CN");
	public  String getMessage(String key){
	    //Locale locale = LocaleContextHolder.getLocale();
	    return getMessage(key, locale);
	  }

	  public  String getMessage(String key, Locale locale){
	    String msg = getMessage(key, null, locale);
	    return msg;
	  }

	  public  String getMessage(String key, Object[] args){
		//Locale locale = LocaleContextHolder.getLocale();
	    return getMessage(key, args, locale);
	  }

	  public  String getMessage(String key, Object[] args, Locale locale){
	    String msg =messageSource.getMessage(key, args, locale);
	    return msg;
	  }
}

