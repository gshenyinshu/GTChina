
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
import gtone.changeminer.payment.form.PlpaymentinfoForm;
import gtone.changeminer.payment.manager.PlpaymentinfoManager;
import gtone.changeminer.payment.form.PlpaymentForm;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.ReturnManager;
import java.lang.*; 
import java.util.Calendar;


import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 
import gtone.changeminer.common.manager.DeathRegistrationManager;

/**
 * @struts.action
 *      path="/pl_payment_info"
 *      name="plpaymentinfoForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="pl_payment_info"
 *      path="/pl_payment_info.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class PlpaymentinfoAction extends CybercenterAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ PlpaymentinfoAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();	
			DataSet input4  = new DataSet();
			DataSet input5  = new DataSet();
			DataSet input6  = new DataSet();
			DataSet input7  = new DataSet();
			DataSet input8 = new DataSet();
			
			

			PlpaymentinfoForm plpaymentinfoForm = (PlpaymentinfoForm) form;
			ReturnManager returns = ReturnManager.getInstance();
			////FormToDataset.copyProperties(input, plpaymentinfoForm);			
			
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");	
			
			////Session Management
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
								
			String proc_emp_no = emp_no;
			String tproc_emp_no = proc_emp_no.toUpperCase();
			
			////Date
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);

			String cnvdate	= to_year;
			cnvdate = "        ";
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
			
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);
			
			String deptcd = plpaymentinfoForm.getDeptcd();
			String init       = plpaymentinfoForm.getInit();
			String ssn   = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");	
			
			String sbkcda	= request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
			String sbknoa  = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
			String pyrna    = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");						

			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");	
			String regdate  = request.getParameter("regdate")	== null ? "" : request.getParameter("regdate");	
			String cash =  request.getParameter("cash")	== null ? "" : request.getParameter("cash");	
			String bnkclt =  request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");	
			String bnkcode  = request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");	
			String bnkacct = request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");	
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");	
			String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");	
			String bnkyn	= request.getParameter("bnkyn")	== null ? "" : request.getParameter("bnkyn");	
			
			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "";
			String returnurl =  request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");	
			
			input1.put("deptcd", deptcd);
			input1.put("init", init);
			input1.put("plyno", policy);
			
			input2.put("deptcd", deptcd);
			input2.put("init", init);
			input2.put("ssn", ssn);
			
			input3.put("policy_apln_no", policy_apln_no);
			input3.put("recon_id", proc_emp_no);
			input5.put("proc_emp_no", proc_emp_no);

			PlpaymentinfoManager manager = PlpaymentinfoManager.getInstance();
			
			DataSet plpaymentinfo 	= manager.findPlpaymentinfo(input);
			DataSet userinfo		= manager.findUserinfo(input1, input2);
			
			PlpaymentManager managers = PlpaymentManager.getInstance();
			DataSet  payment   = managers.Inpayment(input3, input5);
			
			////20080201 : METHOD=P
			DataSet  contractDetail   	= managers.ContractDetail(input1);
			request.setAttribute("contractDetail", contractDetail);	
						
			////20060530 
			anyframe.log.Logger.debug.println(" policy==========="+policy);										
			DataSet checkopt  = managers.Chkpayment(policy);
			
			////20060530 workingday
			////
			////step1. 
			Calendar cal = Calendar.getInstance();                 
			String days = ""; 
			String month = ""; 
			String year = ""; 
			String today = "";
			    
			//// Step2.
			days = String.valueOf( cal.get(Calendar.DATE) ); 
			month = String.valueOf( cal.get(Calendar.MONTH) + 1 ); 
			year = String.valueOf( cal.get(Calendar.YEAR) );
			             
			//// Step3-1.Days
			if( days.length() == 1 )        days = "0" + days;                 
			//// Step3-2.Month
			if( month.length() == 1 ) 	month = "0" + month; 
			
			//// Step4. 
			today = year + month + days;
				
			anyframe.log.Logger.debug.println("약관대출 Action에서 추가항목2today==========="+today);										
			DataSet  workinginfo = managers.Workinginfo(today);
			
			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input4.put("musera", "INTUSER");
				input4.put("sbkcda", sbkcda);
				input4.put("sbknoa", sbknoa);
				input4.put("amount", "00000000001");
				input4.put("pyrna", pyrna);
				input4.put("procgb", "O");
				DataSet bankconf = manager.confBank(input4, input3);
				request.setAttribute("bankconf", bankconf);
				payment   = managers.Inpayment(input3, input5);
				
				bankerr = bankconf.getText("rtn").trim();
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);
				
				bankerrmsg = bankconf.getText("errmsg").trim();
				payorna = bankconf.getText("payorna").trim();
				
				if(!bankerr.equals("0"))
				{
					input6.put("policy_apln_no", policy_apln_no);
					input6.put("proc_emp_no", proc_emp_no);
					input6.put("proc_status", "2");
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
				
				 /******  - S ******/ 
				int success = Integer.parseInt(bankerr);
		    		
		    		switch(success)
		    		{
		        		case(0) :
		            			////message =  "action..";
						message = "pay : " + payorna;
		            			break;
		        		case(1) :
		            			////message = payorna + "pay";
						message = bankerrmsg;
		            			break;
		        		default :
		            			////message = payorna + "pay";
						message = bankerrmsg;
		            			break;
		    		}
				
			}				
									
			

			input8.put("policy",    policy);
			input8.put("cnvdate",   "        ");
			DataSet plpayment = managers.findPlpayment(input8);
			request.setAttribute("plpayment", plpayment);

			input.put("cnvdate", Util.replaceStr(payment.getText("apln_dt").trim(), ".", ""));
			anyframe.log.Logger.debug.println("Debug : [" + Util.replaceStr(payment.getText("apln_dt").trim(), ".", "") + " ==========="+input);
			DataSet plpaymentApln 	= managers.findPlpayment(input);  ////m0161sp1 
			anyframe.log.Logger.debug.println("Debug : [" + Util.replaceStr(payment.getText("apln_dt").trim(), ".", "") + " ==========="+plpaymentApln);
			request.setAttribute("plpaymentApln", plpaymentApln);
	
				
			if(process.equals("R"))
			{
				DataSet recognize = managers.getRecon(input3);
				request.setAttribute("recognize", recognize);		
				payment   = managers.Inpayment(input3, input5);				
			}	
					
			if(process.equals("Y")|| process.equals("K"))
			{
							
				payment   = managers.Inpayment(input3, input5);
			}
					
					
					
					

			
			/*
			if(process.equals("Y")|| process.equals("K"))
			{
				/*
				input6.put("deptcd", "INT");
				input6.put("init", tproc_emp_no);
				input6.put("opt1", opt1);
				input6.put("opt2", "U");
				input6.put("policy", policy);
				input6.put("regdate", indate);
				input6.put("paydate", to_year);
				input6.put("cash", cash);
				input6.put("prmsusp", "00000000000");
				input6.put("susp", "00000000000");
				input6.put("plpay", "00000000000");
				input6.put("tax", "00000000000");
				input6.put("sndseq", "      ");
				input6.put("bnkclt", bnkclt);
				input6.put("bnkcode", bnkcode);
				input6.put("bnkacct", bnkacct);
				
				input5.put("proc_emp_no", proc_emp_no);
				
				anyframe.log.Logger.debug.println("Action M0181SP1  input3==========="+input3);
				
				DataSet approval = managers.getApproval(input6, input3, input5);
				request.setAttribute("approval", approval);				
				*/
				/*
				payment   = managers.Inpayment(input3, input5);
			}
			
			
			if(process.equals("R"))
			{
				DataSet recognize = managers.getRecon(input3);
				request.setAttribute("recognize", recognize);		
				payment   = managers.Inpayment(input3, input5);				
			}	
			else if(process.equals("L"))
			{
				userinfo		= manager.findUserinfo(input1, input2);	
				plpaymentinfo 	= manager.findPlpaymentinfo(input);
				
				

				int loanval  = 0;////현대출가능액
				int cnt = plpayment.getCount("rid_nam");
				for(int i=0;i<cnt;i++)
				{
					loanval   = loanval  + Integer.parseInt(plpayment.getText("loanval",i).trim());		
				}
				int amt1 = loanval;
				int amt2 = payment.getInt("apln_amt");
				Logger.debug.println("PlpaymentAction --- amt1:"+amt1);	
				Logger.debug.println("PlpaymentAction --- amt2:"+amt2);	
				if( amt1 < amt2 )
				{
					bankerr = "1";
					message = " ";				
				}

			}
			
			*/

			DataSet  working2after = managers.Working2after(Util.replaceStr(payment.getText("apln_dt"), ".", "")); 
			request.setAttribute("working2after",working2after.getText("comp_after")); 

			DataSet ohterInput = new DataSet();
			ohterInput.put("deptcd", "INT");
			ohterInput.put("init", "     ");
			ohterInput.put("policy", policy);
			ohterInput.put("aplndate", Util.replaceStr(payment.getText("apln_dt").trim(), ".", ""));


			DataSet  otherSystemStatus = managers.getOhterSystemStatus(ohterInput);

			////20060530 
			request.setAttribute("checkopt", checkopt);
			request.setAttribute("workinginfo", workinginfo);
			request.setAttribute("otherSystemStatus", otherSystemStatus);
			
			request.setAttribute("plpaymentinfo", plpaymentinfo); 
			request.setAttribute("userinfo", userinfo); 
			request.setAttribute("payment", payment);

			request.setAttribute("policy",policy);
 			request.setAttribute("policy_apln_no",policy_apln_no);
 			request.setAttribute("ssn",ssn);
 			
 			request.setAttribute("sbkcda",sbkcda);
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
			request.setAttribute("plancd",plpayment.getText("plancd"));

			//// 2008.02.25 
			String deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"P");
			request.setAttribute("deathResult",deathResult);

			Logger.debug.println("################ PlpaymentinfoAction End ####################");
			
			Logger.debug.println("##### message ##### " + message);
		    Logger.debug.println("##### bankerr ##### " + bankerr);
		    	
			if( !bankerr.equals("-1") )
			{
    			String msg = message;
    			String url = "/payment/pl_payment_info.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
    			request.setAttribute("message", msg);	
    			request.setAttribute("toURL", url);	
    			return mapping.findForward("alert");
			}
	    	else
	    	{
				Logger.debug.println("################ PlpaymentAction Action End ####################");
				return mapping.findForward("pl_payment_info");
			}
			/****** - E ******/ 		

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
