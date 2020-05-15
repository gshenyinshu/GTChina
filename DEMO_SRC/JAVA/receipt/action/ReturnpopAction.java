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
import gtone.changeminer.receipt.form.ReturnpopForm;
import gtone.changeminer.receipt.manager.ReturnpopManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/return_pop"
 *      name="returnpopForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="return_pop"
 *      path="/return_pop.jsp"
 *
 *     
 */
public  class ReturnpopAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ ReturnpopAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1 = new DataSet();

			ReturnpopForm returnpopForm = (ReturnpopForm) form;
			FormToDataset.copyProperties(input, returnpopForm);			
			
			String indate = returnpopForm.getIndate();	
			String seq_no = returnpopForm.getSeq_no();
			String srvc_cd = returnpopForm.getSrvc_cd();
			anyframe.log.Logger.debug.println("����͸� ----  indate : "+indate);		
			anyframe.log.Logger.debug.println("����͸� ----  seq_no : "+seq_no);		
			anyframe.log.Logger.debug.println("����͸� ----  srvc_cd : "+srvc_cd);		

			input.put("indate",   indate);
			input.put("seq_no",   seq_no);
			input.put("prcode",   "0");

			input1.put("indate",  indate);
			input1.put("seq_no",  seq_no);
			input1.put("prcode",  "1");

												
			ReturnpopManager manager = ReturnpopManager.getInstance();
			
			if(srvc_cd.equals("A"))////����������
			{
				anyframe.log.Logger.debug.println("����͸� ---- ����������");		
				DataSet client1 	= manager.findClient(input);
				DataSet client2 	= manager.findClient(input1);			
								
				request.setAttribute("client1", client1); 
				request.setAttribute("client2", client2); 
				
				return mapping.findForward("realtime_client");
			}
			else if(srvc_cd.equals("B") || srvc_cd.equals("C") || srvc_cd.equals("D"))////�ڵ���ü����,�׷����
			{
				anyframe.log.Logger.debug.println("����͸� ----  �ڵ���ü����,�׷����");		
				DataSet account1 	= manager.findAccount(input);
				DataSet account2 	= manager.findAccount(input1);			
								
				request.setAttribute("account1", account1); 
				request.setAttribute("account2", account2); 
				
				return mapping.findForward("realtime_auto");
			}
			else if(srvc_cd.equals("E") || srvc_cd.equals("F"))////���� APL�ڵ���ȯ
			{
				anyframe.log.Logger.debug.println("����͸� ----  ���� APL�ڵ���ȯ");		
				DataSet repayment1 = manager.findRepayment(input1);				
				
				request.setAttribute("repayment1", repayment1); 				
				return mapping.findForward("realtime_aplpay");
			}
			
			else if(srvc_cd.equals("G"))////���ֺ���
			{
				anyframe.log.Logger.debug.println("����͸� ----  �����ֱ⺯��");		
				DataSet billingfre1 = manager.findBillingfre(input);
				DataSet billingfre2 = manager.findBillingfre(input1);
				
				request.setAttribute("billingfre1", billingfre1); 
				request.setAttribute("billingfre2", billingfre2); 
				return mapping.findForward("realtime_modx");
			}
			else if(srvc_cd.equals("H"))
			{
				anyframe.log.Logger.debug.println("����͸� ---- ���׺����ݵ庯��");		
				DataSet fundchg1 = manager.findFundchg(input);
				DataSet fundchg2 = manager.findFundchg(input1);
				
				request.setAttribute("fundchg1", fundchg1); 
				request.setAttribute("fundchg2", fundchg2); 
				return mapping.findForward("realtime_fund");				
			}
			else if(srvc_cd.equals("I") || srvc_cd.equals("J"))
			{
				anyframe.log.Logger.debug.println("����͸� ---- APL��û");		
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