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
import gtone.changeminer.payment.form.ReturnForm;
import gtone.changeminer.payment.manager.ReturnManager;
import gtone.changeminer.payment.manager.CybercenterManager;

import java.lang.*; 

////����
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;
/**
 * @struts.action
 *      path="/return_tbl"
 *      name="ReturnForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="return_tbl"
 *      path="/return_tbl.jsp"
 *
 */
public  class ReturnAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ ReturnAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();	
			DataSet input4  = new DataSet();	

			ReturnForm returnForm = (ReturnForm) form;
			////FormToDataset.copyProperties(input, returnForm);			
			
			String id   = request.getParameter("id")	== null ? "" : request.getParameter("id");			
			String policy_apln_no = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");		
			String where = "";
			String id1   = request.getParameter("id1")	== null ? "1" : request.getParameter("id1");	
			String errmsg   = request.getParameter("errmsg")	== null ? "1" : request.getParameter("errmsg");	
			String message   = request.getParameter("message")	== null ? "" : request.getParameter("message");
			String process   = request.getParameter("process")	== null ? "" : request.getParameter("process");	
			
			////���ǻ���ϱ�
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
			
			String proc_emp_no = emp_no;////ó���ڻ��	
			
			String tproc_emp_no = proc_emp_no.toUpperCase();			
			
			ReturnManager manager = ReturnManager.getInstance();
			CybercenterManager ksps2000 = CybercenterManager.getInstance();////KSPS2000
			
			anyframe.log.Logger.debug.println("ID3==========="+id1);					
				
			input.put("where",   where);
			DataSet returnval = manager.findReturn(input);
			request.setAttribute("returnval", returnval);	

			////�ݼ��϶� KSPS2000�� 91(��������)			
			input3.put("policy_apln_no", policy_apln_no);
			DataSet resrvc_cd = manager.findSrvc_cd(input3);
			request.setAttribute("resrvc_cd", resrvc_cd);	
			
			String srvc_cd = "";
			String procgb = "";
			String policy = "";
			policy = resrvc_cd.getText("policy");

			srvc_cd = resrvc_cd.getText("srvc_cd");
			anyframe.log.Logger.debug.println("���α���==========="+srvc_cd);
			if(srvc_cd.length() == 1)
			{
				if(srvc_cd.equals("1") || srvc_cd.equals("4") || srvc_cd.equals("5") || srvc_cd.equals("7"))
				{
					procgb = "OUT";
				}
				else
				{
					procgb = "IN";
				}
				
				if(srvc_cd.equals("1"))
				{
					srvc_cd = "L1";
				}
				else if(srvc_cd.equals("2") || srvc_cd.equals("3"))
				{
					srvc_cd = "P3";
				}
				else if(srvc_cd.equals("4") || srvc_cd.equals("7"))
				{
					srvc_cd = "D1";
				}
				else if(srvc_cd.equals("5"))
				{
					srvc_cd = "E1";
				}
				else if(srvc_cd.equals("6"))
				{
					srvc_cd = "R1";
				}
			}
			
												
			if(process.equals("S"))
			{
				
				input4.put("deptcd", "INT");////�ý����̸�      
				input4.put("init", "     "); ////�����ȣ        
				input4.put("gubun", "W");////ó������        
				input4.put("reqnum", "   "); ////��û�Ǽ�        
				input4.put("fromdt", "        ");////��ȸ���۱�������
				input4.put("policy", policy);////���ǹ�ȣ        
				input4.put("procdt", "        ");////����ó������    
				input4.put("proctm", "      ");////����ó���ð�    
				input4.put("inout", procgb);////����/���� ����  
				input4.put("procgb", srvc_cd);////��ü����        
				input4.put("lvlnum", "91");////ó������        
				input4.put("lvlbef", "  ");////ó��������      
				input4.put("mbkcd", "  ");////����� �����ڵ� 
				input4.put("mbkact" ,"               ");////����� ���¹�ȣ 
				input4.put("cltbk", "  "); ////�� �����ڵ�   
				input4.put("cltact", "               ");////�� ���¹�ȣ   
				input4.put("cltnum", "             ");////�� �ֹι�ȣ   
				input4.put("procamt", "0000000000000");////��ü�ݾ�
				input4.put("procno", "      ");////��ü������ȣ    
				input4.put("brltcd", "    ");////������        				
				anyframe.log.Logger.debug.println("�ݼ��϶� ksps2000�� 91�� �� write==========="+input4);
				DataSet ksps2000_91 = ksps2000.findKsps2000(input4);

////				2006.03.21 ������ 0600069 Cyberadmin ��ɰ��� 
				////errrtn ���� setting �� �Ǿ� ���� �ʾƼ� ���乮��.
				String errrtn = "";
				errrtn = ksps2000_91.getText("rtn");
				
				if(errrtn.equals("0"))
				{					
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "1");
					input1.put("err_msg", message);
					
					DataSet rtnsave = manager.findRtnsave(input1);
					request.setAttribute("rtnsave", rtnsave);	
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "1");
					input2.put("err_msg", message);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsave1 = manager.findRtnsave1(input2);
					request.setAttribute("rtnsave1", rtnsave1);	
				}
			}
			
			request.setAttribute("policy_apln_no",policy_apln_no);			
			request.setAttribute("id",id);
			request.setAttribute("id1",id1);
			request.setAttribute("errmsg",errmsg);
			request.setAttribute("message",message);
			request.setAttribute("process",process);
			
			Logger.debug.println("################ ReturnAction End ####################");
			return mapping.findForward("return_tbl");
	

			

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}

