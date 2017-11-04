package com.pall.portal.common.exception;
/*
 * 数据访问异常类
 */
public class DaoException extends Exception{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public DaoException() {
        super();
    }

    public DaoException(String msg, Throwable throwable) {
        super(msg, throwable);
    }

    public DaoException(String msg) {
        super(msg);
    }

    public DaoException(Throwable throwable) {
        super(throwable);
    }
}
