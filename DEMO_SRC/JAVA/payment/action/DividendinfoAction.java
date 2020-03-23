
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
import gtone.changeminer.payment.form.DividendinfoForm;
import gtone.changeminer.payment.manager.DividendinfoManager;


import gtone.changeminer.payment.manager.RestingsearchManager;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.DividendsearchManager;
import gtone.changeminer.payment.manager.ReturnManager;
import java.lang.*; 
import java.util.Calendar;

////Comment
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 
import gtone.changeminer.common.manager.DeathRegistrationManager;
/**
 * @struts.action
 *      path="/dividend_info"
 *      name="dividendinfoForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="dividend_info"
 *      path="/dividend_info.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class DividendinfoAction extends CyberpayAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ DividendinfoAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();
			DataSet input4  = new DataSet();	
			DataSet input5 = new DataSet();
			DataSet input6 = new DataSet();

			DividendinfoForm dividendinfoForm = (DividendinfoForm) form;
			FormToDataset.copyProperties(input, dividendinfoForm);			
			
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");						
			
			////Comment
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);
			String cnvdate	= to_year;
			cnvdate = "        ";
			
			String deptcd = "INT";
			String init       = "     ";
			String ssn	 = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");			
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");		
			
			////Session Manager
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

			String proc_emp_no = emp_no;
			String tproc_emp_no = proc_emp_no.toUpperCase();			
			
			////request			
			String sbkcda	= request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
			String sbknoa  = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
			String pyrna    = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");					

			init  = proc_emp_no;
			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");
			opt1 = "S";
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
			String payorna = "";
			String bnkyn	= request.getParameter("bnkyn")	== null ? "" : request.getParameter("bnkyn");	
			
			RestingsearchManager Rmanager = RestingsearchManager.getInstance();
			PlpaymentManager Pmanager = PlpaymentManager.getInstance();
			DividendsearchManager Wmanager = DividendsearchManager.getInstance();////WB_PAYMENT READ
			DividendinfoManager manager = DividendinfoManager.getInstance();
			ReturnManager returns = ReturnManager.getInstance();

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

			DataSet dividendinfo 	= manager.findDividendinfo(input);
			DataSet userinfo		= manager.findUserinfo(input1, input2);
			DataSet  payment   	= Wmanager.Inpayment(input3, input4);						


			////20060530 	
			anyframe.log.Logger.debug.println("debug policy==========="+policy);										
			DataSet checkopt  = Pmanager.Chkpayment(policy);
			
			////20060530  0601081 workingday
			////workingday 
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
				
			anyframe.log.Logger.debug.println("debug today==========="+today);										
			DataSet  workinginfo = Pmanager.Workinginfo(today);
			
			
			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input5.put("musera", "INTUSER");
				input5.put("sbkcda", sbkcda);
				input5.put("sbknoa", sbknoa);
				input5.put("amount", "00000000001");
				input5.put("pyrna", pyrna);
				input5.put("procgb", "O");
				DataSet bankconf = Pmanager.confBank(input5, input3);
				request.setAttribute("bankconf", bankconf);
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);

				payment   	= Wmanager.Inpayment(input3, input4);	
				
				bankerr = bankconf.getText("rtn").trim();
				bankerrmsg = bankconf.getText("errmsg").trim();
				payorna = bankconf.getText("payorna").trim();
				
				if(!bankerr.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "2");
					input5.put("err_msg", bankerrmsg);
					
					DataSet rtnsave = returns.findRtnsave(input5);
					request.setAttribute("rtnsave", rtnsave);	
					/*
					input6.put("policy_apln_no", policy_apln_no);				
					input6.put("proc_status", "2");
					input6.put("err_msg", bankerrmsg);
					DataSet rtnsave1 = returns.findRtnsave1(input6);
					request.setAttribute("rtnsave1", rtnsave1);					
					*/
				}
				
				 /****** - S ******/ 
				int success = Integer.parseInt(bankerr);
		    		
		    		switch(success)
		    		{
		        		case(0) :
		            			////message =  " ";
						message = "예금주명 : " + payorna;
		            			break;
		        		case(1) :
		            			////message = payorna + " ";
						message = bankerrmsg;
		            			break;
		        		default :
		            			////message = payorna + " ";
						message = bankerrmsg;
		            			break;
		    		}						
			}				
			
			

						
			if(process.equals("Y"))
			{
				/*
				input6.put("deptcd", "INT");
				input6.put("init", tproc_emp_no);
				input6.put("policy", policy);
				input6.put("opt1", opt1);
				input6.put("divocc", "9");
				input6.put("rcvdate", rcvdate);
				input6.put("date", to_year);
				input6.put("sndseq", "      ");
				input6.put("bk_clt", bk_clt);
				input6.put("bk_cod", bk_cod);
				input6.put("bk_acct", bk_acct);
				
				anyframe.log.Logger.debug.println("Action M0191SP1  input4==========="+input6);
				
				DataSet approval = Rmanager.getApproval(input6, input3, input4);
				request.setAttribute("approval", approval);				
				*/

				
				payment   	= Wmanager.Inpayment(input3, input4);						
			}	
			else if(process.equals("L"))
			{
				dividendinfo 	= manager.findDividendinfo(input);
				userinfo		= manager.findUserinfo(input1, input2);
			}
			else if(process.equals("R"))
			{
				DataSet recognize = Pmanager.getRecon(input3);
				request.setAttribute("recognize", recognize);		
				payment   	= Wmanager.Inpayment(input3, input4);				
			}		
			

			////20060530 
			request.setAttribute("checkopt", checkopt);
			request.setAttribute("workinginfo", workinginfo);
			////
			
			request.setAttribute("dividendinfo", dividendinfo); 
			request.setAttribute("userinfo", userinfo); 
			request.setAttribute("payment", payment);
			
			request.setAttribute("policy",policy);
 			request.setAttribute("policy_apln_no",policy_apln_no);
 			request.setAttribute("ssn",ssn);				

			request.setAttribute("sbkcda",sbkcda);
 			request.setAttribute("sbknoa",sbknoa);
 			request.setAttribute("pyrna",pyrna);

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
			Logger.debug.println("################ DividendinfoAction End ####################");

			if( !bankerr.equals("-1") )
			{
            			String msg = message;
            			String url = "/payment/dividend_info.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
            			request.setAttribute("message", msg);	
            			request.setAttribute("toURL", url);	
            			return mapping.findForward("alert");
			}
		    	else
		    	{
				Logger.debug.println("################ PlpaymentpaidupAction Action End ####################");
				return mapping.findForward("dividend_info");
			}

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
