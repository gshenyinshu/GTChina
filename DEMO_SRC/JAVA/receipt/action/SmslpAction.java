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
import gtone.changeminer.receipt.form.SmslpForm;
import gtone.changeminer.receipt.manager.SmslpManager;

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
 *
 */
public  class SmslpAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ SmslpAction Start ####################");

            DataSet input = new DataSet();
            
            SmslpForm smslpForm = (SmslpForm)form;
            
	     String where = "";		
            String seq_no = request.getParameter("seq_no") == null ? "" : request.getParameter("seq_no");

   	      where 	=  " and  b.seq_no is not null ";
	       input.put("where", where);            
		
		SmslpManager manager = SmslpManager.getInstance();
	
	       DataSet smslp = manager.findSmslpList(input);		
		request.setAttribute("smslp", smslp);
		
            	//////request.setAttribute("seq_no", seq_no);
		
            Logger.debug.println("################ SmslpAction End ####################");
            return mapping.findForward("smslp_manager");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}