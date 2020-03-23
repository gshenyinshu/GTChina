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
import gtone.changeminer.receipt.form.SmscustomerForm;
import gtone.changeminer.receipt.manager.SmscustomerManager;

/**
 * @struts.action
 *      path="/smscustomer_manager" 
 *      name="smscustomerForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="smscustomer_manager"
 *      path="/smscustomer_manager.jsp"
 *
 */
public  class SmscustomerAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ SmscustomerAction Start ####################");

            DataSet input = new DataSet();
            
            SmscustomerForm smscustomerForm = (SmscustomerForm)form;
            ////FormToDataset.copyProperties(input, smscustomerForm);
            
	     String where = "";		
            String seq_no = request.getParameter("seq_no") == null ? "" : request.getParameter("seq_no");

   	      where 	=  " and  b.seq_no is not null ";
	       input.put("where", where);            
		
		SmscustomerManager manager = SmscustomerManager.getInstance();
	
	       DataSet smscustomer = manager.findSmscustomerList(input);		
		request.setAttribute("smscustomer", smscustomer);
		
            	////request.setAttribute("seq_no", seq_no);
		
            Logger.debug.println("################ SmscustomerAction End ####################");
            return mapping.findForward("smscustomer_manager");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}