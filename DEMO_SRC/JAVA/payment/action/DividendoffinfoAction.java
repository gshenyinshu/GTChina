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
import gtone.changeminer.payment.form.DividendoffinfoForm;
import gtone.changeminer.payment.manager.DividendoffinfoManager;

import gtone.changeminer.payment.manager.RestingsearchManager;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.DividendsearchManager;

import gtone.changeminer.payment.form.DividendoffsearchForm;
import gtone.changeminer.payment.manager.DividendoffsearchManager;
import gtone.changeminer.payment.manager.ReturnManager;

////import lib
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 ? change
import gtone.changeminer.common.manager.DeathRegistrationManager;

/**
 * @struts.action
 *      path="/dividend_setoff_info"
 *      name="dividendoffinfoForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="dividend_setoff_info"
 *      path="/dividend_setoff_info.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class DividendoffinfoAction extends CyberpayAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ DividendoffinfoAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();	
			DataSet input4  = new DataSet();	
			DataSet input5 = new DataSet();
			
			DividendoffinfoForm dividendoffinfoForm = (DividendoffinfoForm) form;
			FormToDataset.copyProperties(input, dividendoffinfoForm);			
			
			RestingsearchManager Rmanager = RestingsearchManager.getInstance();
			PlpaymentManager Pmanager = PlpaymentManager.getInstance();
			DividendsearchManager Wmanager = DividendsearchManager.getInstance();////WB_PAYMENT READ
			DividendoffinfoManager manager = DividendoffinfoManager.getInstance();
			
			////Comment
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);
			String cnvdate	= to_year;
			cnvdate = "        ";
			
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");	
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
						
			String deptcd = "INT";
			String init      = "     ";
			String ssn =  request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");

			////Comment
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

			String proc_emp_no = emp_no;
			String tproc_emp_no = proc_emp_no.toUpperCase();			

			init  = proc_emp_no;
			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");
			opt1 = "SSN";
			String rcvdate = request.getParameter("rcvdate")	== null ? "" : request.getParameter("rcvdate");
			String date = request.getParameter("date")	== null ? "" : request.getParameter("date");										
			String bk_clt = request.getParameter("bk_clt")	== null ? "" : request.getParameter("bk_clt");
			String bk_cod = request.getParameter("bk_cod")	== null ? "" : request.getParameter("bk_cod");
			String bk_acct = request.getParameter("bk_acct")	== null ? "" : request.getParameter("bk_acct");
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");
			String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");

			String sndseq  = request.getParameter("sndseq")	== null ? "" : request.getParameter("sndseq");
			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "interesting rate";
			
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);
			
			input1.put("deptcd", deptcd);
			input1.put("init", init);
			input1.put("plyno", policy);

			input2.put("deptcd", deptcd);
			input2.put("init", init);
			input2.put("ssn", ssn);
			
			input3.put("policy_apln_no", policy_apln_no);
			input3.put("recon_id", proc_emp_no);
			input4.put("proc_emp_no", proc_emp_no);
			
			DataSet dividendoffinfo 	= manager.findDividendoffinfo(input);
			DataSet userinfo		= manager.findUserinfo(input1, input2);
			DataSet  payment   	= Wmanager.Inpayment(input3, input4);
			ReturnManager returns = ReturnManager.getInstance();
			
			
			if(process.equals("Y"))
			{
				/*
				input5.put("deptcd", "INT");
				input5.put("init", tproc_emp_no);
				input5.put("policy", policy);
				input5.put("opt1", opt1);
				input5.put("divocc", "9");
				input5.put("rcvdate", rcvdate);
				input5.put("date", to_year);
				input5.put("sndseq", "      ");
				input5.put("bk_clt", bk_clt);
				input5.put("bk_cod", bk_cod);
				input5.put("bk_acct", bk_acct);
				
				anyframe.log.Logger.debug.println("배당금상계 Action M0191SP1  input4==========="+input5);
				
				DataSet approval = Rmanager.getApproval(input5, input3, input4);////결재,policy_apln_no,proc_emp_no
				request.setAttribute("approval", approval);				
				*/
				payment   	= Wmanager.Inpayment(input3, input4);
			}
			else if(process.equals("L"))			
			{
				dividendoffinfo 	= manager.findDividendoffinfo(input);
				userinfo		= manager.findUserinfo(input1, input2);					
			} 
			else if(process.equals("R"))
			{
				DataSet recognize = Pmanager.getRecon(input3);
				request.setAttribute("recognize", recognize);		
				payment   	= Wmanager.Inpayment(input3, input4);						
			}
						
			
			request.setAttribute("dividendoffinfo", dividendoffinfo); 
			request.setAttribute("userinfo", userinfo); 
			request.setAttribute("payment" , payment);
			
			request.setAttribute("policy",policy);
 			request.setAttribute("policy_apln_no",policy_apln_no);
 			request.setAttribute("ssn",ssn);	
 			
			request.setAttribute("opt1",opt1);
			request.setAttribute("rcvdate",rcvdate);
			request.setAttribute("date",date);
			request.setAttribute("bk_clt",bk_clt);
			request.setAttribute("bk_cod",bk_cod);
			request.setAttribute("bk_acct",bk_acct);
			request.setAttribute("process",process); 
			request.setAttribute("indate",indate);
			 							
			//// 2008.02.25 
			String deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"P");
			request.setAttribute("deathResult",deathResult);
			Logger.debug.println("################ DividendoffinfoAction End ####################");

			return mapping.findForward("dividend_setoff_info");

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
