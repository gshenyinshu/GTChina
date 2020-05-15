/**
 * Title       	: ConfirmAction.java
 * Description 	: 결과화면 - 팝업창
 * Copyright   	: Copyright (c) 2004
 * Company      : CyberImagination
 * @author 	    : Park - JH
 * @version 1.0
 */

package gtone.changeminer.payment.action;

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
import gtone.changeminer.payment.form.ConfirmForm;


/**
 * @struts.action
 *      path="/confirm"
 *      name="confirmForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="confirm"
 *      path="/confirm.jsp"
 
 */
public  class ConfirmAction extends Action
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ ConfirmAction Start ####################");

			DataSet input = new DataSet();	

			ConfirmForm confirmForm = (ConfirmForm) form;
			FormToDataset.copyProperties(input, confirmForm);

			String message 	= confirmForm.getMessage();
			String toURL    = confirmForm.getToURL();
			String check_form = confirmForm.getCheck_form();
			
			request.setAttribute("message", message);
			request.setAttribute("toURL", toURL);
			request.setAttribute("check_form", check_form);
			
			return mapping.findForward("confirm");
		}
		catch (Exception e)
		{
			throw(e);
		}
	}


}