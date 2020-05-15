
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
import gtone.changeminer.payment.form.PlpaymentlistForm;
import gtone.changeminer.payment.manager.PlpaymentlistManager;
import gtone.changeminer.payment.form.PlpaymentForm;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.ReturnManager;
import java.lang.*; 
import java.util.Calendar;

//Payment List Action Class
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 Mr Lee
import gtone.changeminer.common.manager.DeathRegistrationManager;

/**
 * @struts.action
 *      path="/pl_payment_list"
 *      name="plpaymentlistForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="pl_payment_list"
 *      path="/pl_payment_list.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class PlpaymentlistAction extends CybercenterAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ PlpaymentlistAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1 = new DataSet();
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
    		DataSet input5 = new DataSet();
    		DataSet input6 = new DataSet();
    		DataSet input7 = new DataSet();
    		DataSet input8 = new DataSet();
    		
            
			PlpaymentlistForm plpaymentlistForm = (PlpaymentlistForm) form;
			FormToDataset.copyProperties(input, plpaymentlistForm);			
			
			String deptcd  = "INT";
			String init		= "     ";
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");	
			
			////Session Management
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
			
			String proc_emp_no = emp_no;//
			String tproc_emp_no = proc_emp_no.toUpperCase();
								
			String option 	= "P";
			deptcd = "INT";
			init = "     ";

			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);

			String cnvdate	= to_year;
			cnvdate = "        ";
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");						
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
			
			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "";
			String returnurl =  request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");	
			String bnkyn	= request.getParameter("bnkyn")	== null ? "" : request.getParameter("bnkyn");	
			
			PlpaymentlistManager manager = PlpaymentlistManager.getInstance();
			PlpaymentManager managers = PlpaymentManager.getInstance();	
			ReturnManager returns = ReturnManager.getInstance();
						
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);				
			
			input1.put("deptcd", deptcd);
			input1.put("init", init);
			input1.put("policy", policy);
			////input1.put("plyno", policy);
			input1.put("option",   option);			

			input2.put("policy_apln_no", policy_apln_no);
			input2.put("recon_id", proc_emp_no);
			input5.put("proc_emp_no", proc_emp_no);

			DataSet plcynoinfo 	= manager.findPlcynoinfo(input);
			DataSet plpaymentlist 	= manager.findPlpaymentlist(input1);	
			DataSet  payment   = managers.Inpayment(input2, input5);	
			
			
			////20060530 change1	
			anyframe.log.Logger.debug.println("policy==========="+policy);
			DataSet checkopt  = managers.Chkpayment(policy);
			
			////20080201 change2
			input1.put("plyno", policy);

			DataSet  contractDetail   	= managers.ContractDetail(input1);
			request.setAttribute("contractDetail", contractDetail);	
			
			////20060530 change3 
			Calendar cal = Calendar.getInstance();                 
			String days = ""; 
			String month = ""; 
			String year = ""; 
			String today = "";
			    
			//// Step2. 
			days = String.valueOf( cal.get(Calendar.DATE) ); 
			month = String.valueOf( cal.get(Calendar.MONTH) + 1 ); 
			year = String.valueOf( cal.get(Calendar.YEAR) );
			             
			//// Step3-1.Days?
			if( days.length() == 1 )        days = "0" + days;                 
			//// Step3-2.Month                        
			if( month.length() == 1 ) 	month = "0" + month; 
			
			//// Step4. 
			today = year + month + days;
				
			anyframe.log.Logger.debug.println("today==========="+today);										
			DataSet  workinginfo = managers.Workinginfo(today);
			
			
			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input3.put("musera", "INTUSER");
				input3.put("sbkcda", sbkcda);
				input3.put("sbknoa", sbknoa);
				input3.put("amount", "00000000001");
				input3.put("pyrna", pyrna);
				input3.put("procgb", "O");
				DataSet bankconf = manager.confBank(input3, input2);
				request.setAttribute("bankconf", bankconf);
				payment   = managers.Inpayment(input2, input5);	

				bankerr = bankconf.getText("rtn").trim();//
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);

				bankerrmsg = bankconf.getText("errmsg").trim();//
				payorna = bankconf.getText("payorna").trim();//
				
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
				
				 /****** 메시지 - S ******/ 
				int success = Integer.parseInt(bankerr);
		    		
		    		switch(success)
		    		{
		        		case(0) :
		            			message = "예금주명 : " + payorna;
		            			break;
		        		case(1) :
		            			message = bankerrmsg;
		            			break;
		        		default :
		            			message = bankerrmsg;
		            			break;
		    		}			
			}	
			
			
			input8.put("policy",    policy);
			input8.put("cnvdate",   "        ");

			DataSet plpayment = managers.findPlpayment(input8);
			request.setAttribute("plpayment", plpayment);
			
			input.put("cnvdate", Util.replaceStr(payment.getText("apln_dt").trim(), ".", "")); //
			anyframe.log.Logger.debug.println("접수일자 : [" + Util.replaceStr(payment.getText("apln_dt").trim(), ".", "") + "] 기준 약관대출 Action에서 기본항목 입력==========="+input);
			DataSet plpaymentApln 	= managers.findPlpayment(input);  //
			anyframe.log.Logger.debug.println("접수일자 : [" + Util.replaceStr(payment.getText("apln_dt").trim(), ".", "") + "] 기준 약관대출 Action에서 기본항목 output==========="+plpaymentApln);
			request.setAttribute("plpaymentApln", plpaymentApln);
				
			if(process.equals("Y"))
			{
				payment   = managers.Inpayment(input2, input5);	
			}	
												
												
											
			if(process.equals("R"))
			{Logger.debug.println("@@@12311");
				DataSet recognize = managers.getRecon(input2);
				request.setAttribute("recognize", recognize);		
				payment   = managers.Inpayment(input2, input5);
							
			}	

			/*
			if(process.equals("Y"))
			{
				/*
				input4.put("deptcd", "INT"); 
				input4.put("init", tproc_emp_no);
				input4.put("opt1", opt1);
				input4.put("opt2", "U");
				input4.put("policy", policy);
				input4.put("regdate", indate);
				input4.put("paydate", to_year);
				input4.put("cash", cash);
				input4.put("prmsusp", "00000000000");
				input4.put("susp", "00000000000");
				input4.put("plpay", "00000000000");
				input4.put("tax", "00000000000");
				input4.put("sndseq", "      ");
				input4.put("bnkclt", bnkclt);
				input4.put("bnkcode", bnkcode);
				input4.put("bnkacct", bnkacct);
				
				anyframe.log.Logger.debug.println("Action M0181SP1  input3==========="+input3);
				
				DataSet approval = managers.getApproval(input4, input2, input5);////policy_apln_no,proc_emp_no
				request.setAttribute("approval", approval);				
				*/
				/*
				payment   = managers.Inpayment(input2, input5);	
			}											

			
			if(process.equals("R"))
			{
				DataSet recognize = managers.getRecon(input2);
				request.setAttribute("recognize", recognize);		
				payment   = managers.Inpayment(input2, input5);
						
			}
			else if(process.equals("L"))
			{
				plcynoinfo 	= manager.findPlcynoinfo(input);
				plpaymentlist 	= manager.findPlpaymentlist(input1);	
				
				
				int loanval  = 0;//
				int cnt = plpayment.getCount("rid_nam");//
				for(int i=0;i<cnt;i++)
				{
					loanval   = loanval  + Integer.parseInt(plpayment.getText("loanval",i).trim());		
				}
				int amt1 = loanval;//
				int amt2 = payment.getInt("apln_amt");//
				Logger.debug.println("PlpaymentAction --- amt1:"+amt1);	
				Logger.debug.println("PlpaymentAction --- amt2:"+amt2);	
				if( amt1 < amt2 )
				{
					bankerr = "1";
					message = "Message";				
				}
			}
			*/

			DataSet  working2after = managers.Working2after(Util.replaceStr(payment.getText("apln_dt"), ".", "")); //// 
			request.setAttribute("working2after",working2after.getText("comp_after")); ////

			DataSet ohterInput = new DataSet();
			ohterInput.put("deptcd", "INT");
			ohterInput.put("init", "     ");
			ohterInput.put("policy", policy);
			ohterInput.put("aplndate", Util.replaceStr(payment.getText("apln_dt").trim(), ".", ""));

			//// 
			DataSet  otherSystemStatus = managers.getOhterSystemStatus(ohterInput);

			////20060530 김보영
			request.setAttribute("checkopt", checkopt);
			request.setAttribute("workinginfo", workinginfo);
			request.setAttribute("otherSystemStatus", otherSystemStatus);
			
			request.setAttribute("plcynoinfo", plcynoinfo); 
			request.setAttribute("plpaymentlist", plpaymentlist); 
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


			Logger.debug.println("################ PlpaymentlistAction End ####################");

			if( !bankerr.equals("-1") )
			{
    			String msg = message;
    			String url = "/payment/pl_payment_list.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
    			request.setAttribute("message", msg);	
    			request.setAttribute("toURL", url);	
    			return mapping.findForward("alert");
			}
	    	else
	    	{
				Logger.debug.println("################ PlpaymentAction Action End ####################");
				return mapping.findForward("pl_payment_list");
			}

      /*
        call Mainframe Cobol program      
      */
      String result = Utility.callLegacy("JAPA1");
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
