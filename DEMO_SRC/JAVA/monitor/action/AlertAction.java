/**
 * Title       	: AlertAction.java
 * Description 	: 결과화면 - 팝업창
 * Copyright   	: Copyright (c) 2004
 * Company      : CyberImagination
 * @author 	    : Park - JH
 * @version 1.0
 */

package gtone.changeminer.monitor.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;


import gtone.changeminer.common.action.*;
import gtone.changeminer.common.utility.*;
import gtone.changeminer.monitor.form.AlertForm;


/**
 * @struts.action
 *      path="/alert"
 *      name="alertForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"
 
 */
public  class AlertAction extends Action
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ AlertAction Start ####################");

			DataSet input = new DataSet();	

			AlertForm alertForm = (AlertForm) form;
			FormToDataset.copyProperties(input, alertForm);

			String message 	= alertForm.getMessage();
			String toURL    = alertForm.getToURL();
			String check_form = alertForm.getCheck_form();
			
			request.setAttribute("message", message);
			request.setAttribute("toURL", toURL);
			request.setAttribute("check_form", check_form);
			
			return mapping.findForward("alert");
		}
		catch (Exception e)
		{
			throw(e);
		}
	}


}