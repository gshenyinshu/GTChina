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
import gtone.changeminer.receipt.form.PlrepaymentinfoForm;
import gtone.changeminer.receipt.manager.PlrepaymentinfoManager;

import gtone.changeminer.payment.form.PlpaymentForm;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.ReturnManager;
import java.lang.*; 

////����
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 ����ڰ���
import gtone.changeminer.common.manager.DeathRegistrationManager;
/**
 * @struts.action
 *      path="/pl_repayment_info"
 *      name="plrepaymentinfoForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="pl_repayment_info"
 *      path="/pl_repayment_info.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class PlrepaymentinfoAction extends CyberReturnAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ PlrepaymentinfoAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();
			DataSet input4  = new DataSet();
			DataSet input5  = new DataSet();
			DataSet input6  = new DataSet();
			DataSet input7  = new DataSet();

			PlrepaymentinfoForm plrepaymentinfoForm = (PlrepaymentinfoForm) form;
			FormToDataset.copyProperties(input, plrepaymentinfoForm);			
			
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");				
			String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");				
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");	
			
			////���糯¥ ��������
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);
			String cnvdate	= to_year;
			cnvdate = "        ";

			String deptcd = "INT";
			String init       = "     ";
			
			////���ǻ���ϱ�
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

			String proc_emp_no = emp_no;////ó���ڻ��	
			String tproc_emp_no = proc_emp_no.toUpperCase();	
	
			////������Ȯ�� ó�� ���μ���
			String sbkcda	= request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
			String sbknoa  = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
			String pyrna    = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");							

			String regdate  = request.getParameter("regdate")	== null ? "" : request.getParameter("regdate");	
			String cash =  request.getParameter("cash")	== null ? "" : request.getParameter("cash");	
			String bnkclt =  request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");	
			String bnkcode  = request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");	
			String bnkacct = request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");	
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");	
			String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");	
			String opt1 = "P3";
			
			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "";////�����ָ�
			String returnurl =  request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");	
			String bnkyn	= request.getParameter("bnkyn")	== null ? "" : request.getParameter("bnkyn");	
			
			PlpaymentManager Pmanager = PlpaymentManager.getInstance();////������Ȯ�� ���μ���, WEBDB���� ������� ��ȯ ���� READ, ����
			PlrepaymentinfoManager manager = PlrepaymentinfoManager.getInstance();
			ReturnManager returns = ReturnManager.getInstance();////�ݼ�	
			
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);
						
			input1.put("deptcd", deptcd);
			input1.put("init", init);
			input1.put("plyno", policy);

			input2.put("deptcd", deptcd);
			input2.put("init", init);
			input2.put("ssn", ssn);
			
			input3.put("policy_apln_no", policy_apln_no);
			input4.put("proc_emp_no", proc_emp_no);

			DataSet plrepaymentinfo 	= manager.findPlrepaymentinfo(input);
			DataSet userinfo			= manager.findUserinfo(input1, input2);////����ó���ڵ�, policy_apln_no
			DataSet  payment   		= Pmanager.Inpayment(input3, input4);

			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input5.put("musera", "INTUSER");
				input5.put("sbkcda", sbkcda);
				input5.put("sbknoa", sbknoa);
				input5.put("amount", "00000000001");
				input5.put("pyrna", pyrna);
				input5.put("procgb", "I");
				DataSet bankconf = Pmanager.confBank(input5, input3);
				request.setAttribute("bankconf", bankconf);	
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);
			
				bankerr = bankconf.getText("rtn").trim();////�����ڵ�
				bankerrmsg = bankconf.getText("errmsg").trim();////�����޼���
				payorna = bankconf.getText("payorna").trim();////�����ָ�								
				
				if(!bankerr.equals("0"))
				{
					input6.put("policy_apln_no", policy_apln_no);
					input6.put("proc_emp_no", proc_emp_no);
					input6.put("proc_status", "60");
					input6.put("err_msg", bankerrmsg);
					
					DataSet rtnsave = returns.findRtnsave(input6);
					request.setAttribute("rtnsave", rtnsave);	
					/*
					input7.put("policy_apln_no", policy_apln_no);				
					input7.put("proc_status", "2");
					input7.put("err_msg", bankerrmsg);
					DataSet rtnsave1 = returns.findRtnsave1(input7);
					request.setAttribute("rtnsave1", rtnsave1);					
					*/
				}
				
				payment   		= Pmanager.Inpayment(input3, input4);
				
				int success = Integer.parseInt(bankerr);
		    		
		    		switch(success)
		    		{
		        		case(0) :
		            			////message =  "������ Ȯ���� �Ǿ����ϴ�..";
						message = "�����ָ� : " + payorna;
		            			break;
		        		case(1) :
		            			////message = payorna + "������ Ȯ���� �����Ͽ����ϴ�.";
						message = bankerrmsg;
		            			break;
		        		default :
		            			////message = payorna + "������ Ȯ���� �����Ͽ����ϴ�.";
						message = bankerrmsg;
		            			break;
		    		}				
			}				
			
			if(process.equals("Y"))
			{
				payment   		= Pmanager.Inpayment(input3, input4);	
			}
			else if(process.equals("L"))	
			{
				plrepaymentinfo 	= manager.findPlrepaymentinfo(input);
				userinfo			= manager.findUserinfo(input1, input2);////����ó���ڵ�, policy_apln_no
			}			
			
			request.setAttribute("plrepaymentinfo", plrepaymentinfo); 
			request.setAttribute("userinfo", userinfo); 
			request.setAttribute("payment", payment);
			
			request.setAttribute("policy",policy);
 			request.setAttribute("policy_apln_no",policy_apln_no);
 			request.setAttribute("ssn",ssn);			

			request.setAttribute("sbkcda", sbkcda);
 			request.setAttribute("sbknoa",sbknoa);
 			request.setAttribute("pyrna",pyrna);

 			request.setAttribute("opt1",opt1);
 			request.setAttribute("regdate",regdate);
 			request.setAttribute("cash",cash);
 			request.setAttribute("indate",indate);
 			request.setAttribute("bnkclt",bnkclt);
 			request.setAttribute("bnkcode",bnkcode);
 			request.setAttribute("process",process);
 			request.setAttribute("returnurl",returnurl);	

			//// 2008.02.25 ������ �߰� (����ڰ��� ���� ����)
			String deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"R");
			request.setAttribute("deathResult",deathResult);

			Logger.debug.println("################ PlrepaymentinfoAction End ####################");

		    	if( !bankerr.equals("-1") )
		    	{
	           		String msg = message;
	        		String url = "/receipt/pl_repayment_info.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
	        		request.setAttribute("message", msg);	
	        		request.setAttribute("toURL", url);	
	        		return mapping.findForward("alert");
		    	}
		    	else
		    	{
				Logger.debug.println("################ PlpaymentAction Action End ####################");
				return mapping.findForward("pl_repayment_info");
		    	}

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
