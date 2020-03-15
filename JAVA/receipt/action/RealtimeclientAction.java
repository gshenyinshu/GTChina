
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
import gtone.changeminer.receipt.form.RealtimeclientForm;
import gtone.changeminer.receipt.manager.RealtimeclientManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/realtime_client"
 *      name="realtimeclientForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="realtime_client"
 *      path="/realtime_client.jsp"
 *
 * @struts.action-forward
 *      name="realtime_auto"
 *      path="/realtime_auto.jsp"
 * 
 * @struts.action-forward
 *      name="realtime_aplpay"
 *      path="/realtime_aplpay.jsp"
 * 
 * @struts.action-forward
 *      name="realtime_modx"
 *      path="/realtime_modx.jsp"
 * 
 * @struts.action-forward
 *      name="realtime_fund"
 *      path="/realtime_fund.jsp"
 *    
 * @struts.action-forward
 *      name="realtime_apl"
 *      path="/realtime_apl.jsp"
 *     
 */
public  class RealtimeclientAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ RealtimeclientAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1 = new DataSet();

			RealtimeclientForm realtimeclientForm = (RealtimeclientForm) form;
			FormToDataset.copyProperties(input, realtimeclientForm);			
			
			String indate = realtimeclientForm.getIndate();	
			String seq_no = realtimeclientForm.getSeq_no();
			String srvc_cd = realtimeclientForm.getSrvc_cd();
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ----  indate : "+indate);		
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ----  seq_no : "+seq_no);		
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ----  srvc_cd : "+srvc_cd);		

			input.put("indate",   indate);
			input.put("seq_no",   seq_no);
			input.put("prcode",   "0");

			input1.put("indate",  indate);
			input1.put("seq_no",  seq_no);
			input1.put("prcode",  "1");

			request.setAttribute("srvc_cd", srvc_cd);
											
			RealtimeclientManager manager = RealtimeclientManager.getInstance();
			
			if(srvc_cd.equals("A"))////�7�9�7�4�3�4�1�5�1�3�7�4
			{
				anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ---- �7�9�7�4�3�4�1�5�1�3�7�4");		
				DataSet client1 	= manager.findClient(input);
				DataSet client2 	= manager.findClient(input1);			
								
				request.setAttribute("client1", client1); 
				request.setAttribute("client2", client2); 
				request.setAttribute("srvc_cd",srvc_cd);
				return mapping.findForward("realtime_client");
			}
			else if(srvc_cd.equals("N"))////�9�4�3�5�4�7�6�7/�2�1�2�1�7�7�1�5
			{
				anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ---- �9�4�3�5�4�7�6�7/�2�1�2�1�7�7�1�5");		
				DataSet client1 	= manager.findPrivate(input);
				DataSet client2 	= manager.findPrivate(input1);			
								
				request.setAttribute("client1", client1); 
				request.setAttribute("client2", client2);   
				request.setAttribute("srvc_cd",srvc_cd);
				
				return mapping.findForward("realtime_client");
			}
			else if(srvc_cd.equals("B") || srvc_cd.equals("C") || srvc_cd.equals("D"))////�3�1�9�4�3�3�4�7�7�1�0�7,�8�9�0�6�1�9�0�6
			{
				anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ----  �3�1�9�4�3�3�4�7�7�1�0�7,�8�9�0�6�1�9�0�6");		
				DataSet account1 	= manager.findAccount(input);
				DataSet account2 	= manager.findAccount(input1);			
								
				request.setAttribute("account1", account1); 
				request.setAttribute("account2", account2); 
				
				return mapping.findForward("realtime_auto");
			}
			else if(srvc_cd.equals("E") || srvc_cd.equals("F"))////�2�0�9�7�0�6 APL�3�1�9�4�1�8�6�5
			{
				anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ----  �2�0�9�7�0�6 APL�3�1�9�4�1�8�6�5");		
				DataSet repayment1 = manager.findRepayment(input1);				
				
				request.setAttribute("repayment1", repayment1); 				
				return mapping.findForward("realtime_aplpay");
			}
			
			else if(srvc_cd.equals("G")||srvc_cd.equals("K")||srvc_cd.equals("L")||srvc_cd.equals("M"))////�8�8�3�5�1�3�7�4,SNC�5�8�1�5�2�1�4�0, LNB�5�8�1�5�2�1�4�0,FNB�5�8�1�5�2�1�4�0
			{
				anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ----  �8�8�3�0�3�5�8�5�1�3�7�4");		
				DataSet billingfre1 = manager.findBillingfre(input);
				DataSet billingfre2 = manager.findBillingfre(input1);
				
				request.setAttribute("billingfre1", billingfre1); 
				request.setAttribute("billingfre2", billingfre2); 
				return mapping.findForward("realtime_modx");
			}
			else if(srvc_cd.equals("H"))
			{
				anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ---- �1�3�2�2�1�5�6�7�5�7�9�3�1�3�7�4");		
				DataSet fundchg1 = manager.findFundchg(input);
				DataSet fundchg2 = manager.findFundchg(input1);
				
				request.setAttribute("fundchg1", fundchg1); 
				request.setAttribute("fundchg2", fundchg2); 
				return mapping.findForward("realtime_fund");				
			}
			else if(srvc_cd.equals("I") || srvc_cd.equals("J"))
			{
				anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6 ---- APL�2�1�4�0");		
				DataSet aplin1 = manager.findAplin(input1);
				
				request.setAttribute("aplin1", aplin1); 		
				return mapping.findForward("realtime_apl");								
			}
			 else 
			{
				return mapping.findForward("realtime_auto");
			}

			////Logger.debug.println("################ RealtimeclientAction End ####################");

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}