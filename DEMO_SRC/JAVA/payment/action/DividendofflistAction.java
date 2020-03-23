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
import gtone.changeminer.payment.form.DividendofflistForm;
import gtone.changeminer.payment.manager.DividendofflistManager;

import gtone.changeminer.payment.manager.RestingsearchManager;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.DividendsearchManager;

import gtone.changeminer.payment.form.DividendoffsearchForm;
import gtone.changeminer.payment.manager.DividendoffsearchManager;
import gtone.changeminer.payment.manager.ReturnManager;

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 사망자관련
import gtone.changeminer.common.manager.DeathRegistrationManager;

/**
 * @struts.action
 *      path="/dividend_setoff_list"
 *      name="dividendofflistForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="dividend_setoff_list"
 *      path="/dividend_setoff_list.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class DividendofflistAction extends CyberpayAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ DividendofflistAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1 = new DataSet();
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			
			DividendofflistForm dividendofflistForm = (DividendofflistForm) form;
			FormToDataset.copyProperties(input, dividendofflistForm);			
						
			String deptcode  = "INT";
			String init		   = "     ";
			String policy       = request.getParameter("policy")	== null ? "" : request.getParameter("policy");						
			String screen 	= "B";
			
			String recvdat  = "";
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);			
			recvdat		= to_year;
			recvdat		= "        ";			
			String cnvdate	= to_year;			
			cnvdate = "        ";

			String ssn =  request.getParameter("ssn")	== null ? "" : request.getParameter("ssn"); 			
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
			
			////세션사용하기
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
			
			String proc_emp_no = emp_no;////처리자사번
			String tproc_emp_no = proc_emp_no.toUpperCase();		

			init  = proc_emp_no;////터미널아이디
			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");////처리옵션(해약,처리(I)				
			opt1 = "S";////배당일 경우 S(처리)
			String rcvdate = request.getParameter("rcvdate")	== null ? "" : request.getParameter("rcvdate");////접수일자	
			String date = request.getParameter("date")	== null ? "" : request.getParameter("date");////지급일자										
			String bk_clt = request.getParameter("bk_clt")	== null ? "" : request.getParameter("bk_clt");////예금주민번호	
			String bk_cod = request.getParameter("bk_cod")	== null ? "" : request.getParameter("bk_cod");////은행코드	
			String bk_acct = request.getParameter("bk_acct")	== null ? "" : request.getParameter("bk_acct");////계좌번호										
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");////접수일자										
			String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////처리구분	

			String sndseq  = request.getParameter("sndseq")	== null ? "" : request.getParameter("sndseq");////전송번호			
			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "";////예금주명	
			
			RestingsearchManager Rmanager = RestingsearchManager.getInstance();////결재
			PlpaymentManager Pmanager = PlpaymentManager.getInstance();////예금주확인 프로세스
			DividendsearchManager Wmanager = DividendsearchManager.getInstance();////WB_PAYMENT READ
			DividendofflistManager manager = DividendofflistManager.getInstance();
			ReturnManager returns = ReturnManager.getInstance();////반송									
										
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);

			input1.put("deptcode", deptcode);
			input1.put("init", init);
			input1.put("policy", policy);
			input1.put("recvdat", recvdat);
			input1.put("screen",   screen);			
			
			input2.put("policy_apln_no", policy_apln_no);
			input2.put("recon_id", proc_emp_no);
			input3.put("proc_emp_no", proc_emp_no);
			
			DataSet plcynoinfo 		= manager.findPlcynoinfo(input);
			DataSet dividendofflist 	= manager.findDividendofflist(input1);	
			DataSet  payment   	= Wmanager.Inpayment(input2, input3);
						
			if(process.equals("Y"))
			{
				/*
				input4.put("deptcd", "INT");
				input4.put("init", tproc_emp_no);
				input4.put("policy", policy);
				input4.put("opt1", opt1);
				input4.put("divocc", "9");
				input4.put("rcvdate", rcvdate);
				input4.put("date", to_year);
				input4.put("sndseq", "      ");////전문번호(처리번호)
				input4.put("bk_clt", bk_clt);
				input4.put("bk_cod", bk_cod);
				input4.put("bk_acct", bk_acct);
				
				anyframe.log.Logger.debug.println("배당금상계 Action M0191SP1  input4==========="+input4);
				
				DataSet approval = Rmanager.getApproval(input4, input2, input3);////결재,policy_apln_no,proc_emp_no
				request.setAttribute("approval", approval);				
				*/
				payment   	= Wmanager.Inpayment(input2, input3);
			}			
			else if(process.equals("L"))	
			{
				plcynoinfo 		= manager.findPlcynoinfo(input);
				dividendofflist 	= manager.findDividendofflist(input1);					
			}
			else if(process.equals("R"))
			{
				DataSet recognize = Pmanager.getRecon(input2);
				request.setAttribute("recognize", recognize);		
				payment   	= Wmanager.Inpayment(input2, input3);										
			}

			request.setAttribute("plcynoinfo", plcynoinfo); 
			request.setAttribute("dividendofflist", dividendofflist); 
			request.setAttribute("payment", payment);

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
			
			//// 2008.02.25 김종명 추가 (사망자관련 정보 셋팅)
			String deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"P");
			request.setAttribute("deathResult",deathResult);
			Logger.debug.println("################ DividendofflistAction End ####################");

			return mapping.findForward("dividend_setoff_list");

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
