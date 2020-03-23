// Session Manager Class
/**
 * Title       : 
 * Description : 
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author 
 * @version 1.0
 */

package gtone.changeminer.common.manager;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gtone.changeminer.common.utility.*;



public  class SessionManager
{
	HttpSession session;

	public SessionManager(HttpServletRequest request)
	{
		session = request.getSession();

	}

/*
	public boolean isValid()
	{
		String lpId = getString(Constant.SESSION_LPID);
		if (lpId == null || lpId.trim().equals(""))
			return false;

		return true;
	}
*/

	public void set(String key, int value)
	{
		session.setAttribute(key, String.valueOf(value));
	}


	public void set(String key, Object value)
	{
		session.setAttribute(key, value);
	}

	public Object get(String key)
	{
		return session.getAttribute(key);
	}

	public String getString(String key)
	{
		String v = Utility.nvl((String) get(key));
		return v;
	}

	public void remove(String key)
	{
		session.removeAttribute(key);
	}

	public void invalidate()
	{
		session.invalidate();
	}

}




