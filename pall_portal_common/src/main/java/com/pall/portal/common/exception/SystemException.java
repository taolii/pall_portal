package com.pall.portal.common.exception;
/*
 * 系统异常类
 */
public class SystemException extends Exception{
	
	private static final long serialVersionUID = 1L;

	public SystemException() {
        super();
    }

    public SystemException(String msg, Throwable throwable) {
        super(msg, throwable);
    }

    public SystemException(String msg) {
        super(msg);
    }

    public SystemException(Throwable throwable) {
        super(throwable);
    }
}
