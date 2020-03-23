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
import gtone.changeminer.receipt.form.SmsmsgaddForm;
import gtone.changeminer.receipt.manager.SmsmsgaddManager;

import java.lang.*; 

////����
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;
/**
 * @struts.action
 *      path="/smsmsg_add1"
 *      name="SmsmsgaddForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="smsmsg_add1"
 *      path="/smsmsg_add1.jsp"
 *
 * @struts.action-forward
 *      name="smslp_manager"
 *      path="/smslp_manager.jsp"
 */
 
public  class SmsmsgaddlpAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ SmsmsgaddlpAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	

			SmsmsgaddForm smsmsgaddForm = (SmsmsgaddForm)form;
			
			SmsmsgaddManager manager = SmsmsgaddManager.getInstance();
			
			String srvc_name   = request.getParameter("srvc_name")	== null ? "" : request.getParameter("srvc_name");	
			String cpflag   = request.getParameter("cpflag")	== null ? "" : request.getParameter("cpflag");					
			String smsgubun   = request.getParameter("smsgubun")	== null ? "" : request.getParameter("smsgubun");					
			String call_back     = request.getParameter("call_back")	== null ? "" : request.getParameter("call_back");	
			String send_msg   = request.getParameter("send_msg")	== null ? "" : request.getParameter("send_msg");	
			String send_err   = request.getParameter("send_err")	== null ? "" : request.getParameter("send_err");	
			String seq_no   = request.getParameter("seq_no")	== null ? "" : request.getParameter("seq_no");
			
			////���ǻ���ϱ�
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);				
			
			String prname = emp_no;////ó���ڻ��			
													
			if(smsgubun.equals("I"))
			{
				input.put("cpflag", "P");
				input.put("srvc_name", srvc_name);
				input.put("call_back", call_back);
				input.put("send_msg", send_msg);
				input.put("send_err", send_err);
				input.put("prname", prname);
				
				DataSet smssave = manager.findSmssave(input);
				request.setAttribute("smssave", smssave);					
			}
			else if(smsgubun.equals("U"))
			{
				input1.put("seq_no", seq_no);
				DataSet smsupt = manager.displayMsg(input1);
				request.setAttribute("smsupt", smsupt);					
			}
			else if(smsgubun.equals("UW"))
			{
				input2.put("seq_no",seq_no);
				input2.put("send_msg", send_msg);
				input2.put("send_err", send_err);
				input2.put("prname", prname);
				
				DataSet smsmodify = manager.findModify(input2);
				request.setAttribute("smsmodify", smsmodify);					
			}
			
			request.setAttribute("smsgubun",smsgubun);			
			request.setAttribute("srvc_name",srvc_name);
			request.setAttribute("call_back",call_back);
			request.setAttribute("send_msg",send_msg);
			request.setAttribute("send_err",send_err);
			
			if((smsgubun.equals("I")|| smsgubun.equals("UW")) && cpflag.equals("P"))
			{
				return mapping.findForward("smslp_manager");
			}
			else
			{
				return mapping.findForward("smsmsg_add1");
			}	
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}