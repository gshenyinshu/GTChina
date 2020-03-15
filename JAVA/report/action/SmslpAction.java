package gtone.changeminer.report.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.utility.*;
import gtone.changeminer.report.form.SmslpForm;
import gtone.changeminer.report.manager.SmslpManager;
import java.lang.*; 

////ksps2000
import gtone.changeminer.report.action.*;
import gtone.changeminer.report.manager.*;

/**
 * @struts.action
 *      path="/smslp_manager"
 *      name="smslpForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="smslp_manager"
 *      path="/smslp_manager.jsp"

 */
 
public  class SmslpAction  extends Action
{
	public ActionForward Execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ SmslpAction Start ####################");
		
			DataSet input  = new DataSet();					
			SmslpForm  smslpForm = ( SmslpForm) form;
			////FormToDataset.copyProperties(input,  smslpForm);			
			
			String seq_no   = request.getParameter("seq_no")	== null ? "1" : request.getParameter("seq_no");			
			input.put("seq_no", seq_no);
			
			SmslpManager manager =  SmslpManager.getInstance();			
			DataSet smslp 	= manager.findSmslp(input);	
					
			request.setAttribute("smslp", smslp);
			request.setAttribute("seq_no",seq_no);
			
			Logger.debug.println("################ SmslpAction End ####################");	
						
			return mapping.findForward("smslp_manager");
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}