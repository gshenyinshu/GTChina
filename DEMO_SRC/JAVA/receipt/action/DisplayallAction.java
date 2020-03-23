package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.DisplayallForm;
import gtone.changeminer.receipt.manager.DisplayallManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/displayall"
 *      name="displayallForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="displayall"
 *      path="/displayall.jsp"
 *
 */
 
 
public  class DisplayallAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ DisplayallAction Start ####################");

			DataSet input  = new DataSet();	

			DisplayallForm displayallForm = (DisplayallForm) form;
			
			String policy_apln_no = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");		
			
			DisplayallManager manager = DisplayallManager.getInstance();
				
			input.put("policy_apln_no",   policy_apln_no);
			DataSet displayall = manager.displayAll(input);
			request.setAttribute("displayall", displayall);	
			
			return mapping.findForward("displayall");

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}