package gtone.changeminer.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;


import gtone.changeminer.common.utility.*;
import gtone.changeminer.payment.form.ReturnreasonForm;
import gtone.changeminer.payment.manager.ReturnreasonManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/return_reason"
 *      name="returnreasonForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="return_reason"
 *      path="/return_reason.jsp"
 *     
 */
public  class ReturnreasonAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ ReturnreasonAction Start ####################");

			DataSet input  = new DataSet();	

			ReturnreasonForm returnreasonForm = (ReturnreasonForm) form;
			////FormToDataset.copyProperties(input, returnreasonForm);			
			
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");							
						
			input.put("policy_apln_no",   policy_apln_no);
												
			ReturnreasonManager manager = ReturnreasonManager.getInstance();
			
			DataSet returnreason 	= manager.findReturnreason(input);
			request.setAttribute("returnreason", returnreason); 
			request.setAttribute("policy_apln_no", policy_apln_no); 
			return mapping.findForward("return_reason");

			////Logger.debug.println("################ ReturnreasonAction End ####################");

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}