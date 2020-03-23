/*
 * Title       : RedirectAction
 * Description : redirect="true" 
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author Dong-hyun Sohn test
 * @version 1.0
 */


package gtone.changeminer.common.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import gtone.changeminer.common.action.ActionRedirect;

public abstract class CudAction extends Action
{
	public ActionForward execute(ActionMapping mapping,
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			ActionRedirect redirect = doExecute(mapping, form, request, response);

			//////	query string ---- this is added 
			return new ActionForward(redirect.getPath(), true);
		}
		catch (Exception e)
		{
			throw(e);
		}
	}

	/**
	* RedirectAction ? doExecute. -----------------
	*/
	protected abstract ActionRedirect doExecute(ActionMapping mapping,
											 ActionForm form,
											 HttpServletRequest request,
											 HttpServletResponse response)
		throws Exception;
}

