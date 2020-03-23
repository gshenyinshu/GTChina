
package gtone.changeminer.payment.action;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gtone.changeminer.common.constant.Constant;
import gtone.changeminer.common.dao.Executor;
import gtone.changeminer.common.manager.SessionManager;
import gtone.changeminer.common.utility.Util;
import gtone.changeminer.payment.form.PlpaymentForm;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.ReturnManager;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.Logger;

import gtone.changeminer.common.manager.DeathRegistrationManager;
/**
 * @struts.action
 *      path="/pl_payment_search"
 *      name="plpaymentForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="pl_payment_search"
 *      path="/pl_payment_search.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class PlpaymentAction  extends CybercenterAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ PlpaymentAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			DataSet input5 = new DataSet();
			DataSet input6 = new DataSet();
			DataSet input10 = new DataSet();
			DataSet bankupt = new DataSet();
			
			PlpaymentForm plpaymentForm = (PlpaymentForm) form;
			////FormToDataset.copyProperties(input, plpaymentForm);			
			
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");	
			

			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
					
			String proc_emp_no = emp_no;
			String tproc_emp_no = proc_emp_no.toUpperCase();
			

			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);

			String cnvdate	= to_year;
			cnvdate = "        ";
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");			
			String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");	
			
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
			
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);
			
			input1.put("policy_apln_no", policy_apln_no);
			input1.put("recon_id", proc_emp_no);
			input4.put("proc_emp_no", proc_emp_no);

			PlpaymentManager manager = PlpaymentManager.getInstance();
			ReturnManager returns = ReturnManager.getInstance();
			
			DataSet  payment   			= manager.Inpayment(input1, input4);

			anyframe.log.Logger.debug.println(" ==========="+input);
			DataSet plpayment 	= manager.findPlpayment(input);  
			anyframe.log.Logger.debug.println(" output==========="+plpayment);
			input.put("cnvdate", Util.replaceStr(payment.getText("apln_dt").trim(), ".", ""));
			anyframe.log.Logger.debug.println("  : [" + Util.replaceStr(payment.getText("apln_dt").trim(), ".", "") + "] ==========="+input);
			DataSet plpaymentApln 	= manager.findPlpayment(input);  ////m0161sp1 
			anyframe.log.Logger.debug.println("  : [" + Util.replaceStr(payment.getText("apln_dt").trim(), ".", "") + "]  output==========="+plpaymentApln);

			////20061208 
			Executor executor = Executor.getInstance();
		    DataSet input22 = new DataSet();
		    input22.put("deptcd", "INT");
		    input22.put("init", "     ");	
		    input22.put("plyno", policy);

			////20080201 : METHOD=P
			DataSet  contractDetail   	= manager.ContractDetail(input22);
			request.setAttribute("contractDetail", contractDetail);	
		    
		    DataSet output0 = executor.execute("/changeminer/ksps0790", input22);  
		    String plancd = output0.getText("plancd",0).trim() ; 
		    String sts = output0.getText("sts",0).trim(); 
		    anyframe.log.Logger.debug.println(" ==========="+output0);
		    
			////20060530 
			anyframe.log.Logger.debug.println(" policy==========="+policy);										
			DataSet checkopt  = manager.Chkpayment(policy);
			
////			20061208  
			if("**RPU".equals(plancd) 
					&& "3".equals(sts)){ 
				checkopt.put("advcnt","1");
			}
			if("**RPU".equals(plancd) 
					&& "4".equals(sts)){ 
				checkopt.put("advcnt","1");
			}
			anyframe.log.Logger.debug.println(" ==========="+checkopt);
			
			////20060530 
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
				
			anyframe.log.Logger.debug.println("==========="+today);										
			DataSet  workinginfo = manager.Workinginfo(today);
			
			
			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input2.put("musera", "INTUSER");
				input2.put("sbkcda", sbkcda);
				input2.put("sbknoa", sbknoa);
				input2.put("amount", "00000000001");
				input2.put("pyrna", pyrna);
				input2.put("procgb", "O");
				DataSet bankconf = manager.confBank(input2, input1);  
				request.setAttribute("bankconf", bankconf);
				
				payment   = manager.Inpayment(input1, input4);
								
				bankerr = bankconf.getText("rtn").trim();
				bnkyn = bankconf.getText("rtn").trim();
				
				request.setAttribute("bnkyn", bnkyn);
				
				bankerrmsg = bankconf.getText("errmsg").trim();
				payorna = bankconf.getText("payorna").trim();
								
								
				anyframe.log.Logger.debug.println("--------------------bankerr------------------- : "+bankerr);						
								
				if(!bankerr.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "60");
					input5.put("err_msg", bankerrmsg);
					
					DataSet rtnsave = returns.findRtnsave(input5);
					request.setAttribute("rtnsave", rtnsave);	
				}
				
				
				
				anyframe.log.Logger.debug.println(" /******  - S ******/ ");		
				
				
				 /******  - S ******/ 
				int success = Integer.parseInt(bankerr);
	    			switch(success)
	    			{
		        		case(0) :
		            			////message =  "..";
						message = "pay : " + payorna;
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
			anyframe.log.Logger.debug.println(" ==========="+process);	
			
			anyframe.log.Logger.debug.println("Loc	: R");	
			anyframe.log.Logger.debug.println("Loc: L");	
			anyframe.log.Logger.debug.println("Loc			: ");	
			anyframe.log.Logger.debug.println("Loc			: Y");	
			anyframe.log.Logger.debug.println("Loc	: K");	
			
			


			if(process.equals("R"))
			{
				DataSet recognize = manager.getRecon(input1);				
				request.setAttribute("recognize", recognize);		
				payment   = manager.Inpayment(input1, input4);						
			}
					
			if(process.equals("Y") || process.equals("K"))  //// 
			{
	
				payment   = manager.Inpayment(input1, input4);				
					
			}

			DataSet  working2after = manager.Working2after(Util.replaceStr(payment.getText("apln_dt"), ".", "")); ////
			request.setAttribute("working2after",working2after.getText("comp_after")); ////

			DataSet ohterInput = new DataSet();
			ohterInput.put("deptcd", "INT");
			ohterInput.put("init", "     ");
			ohterInput.put("policy", policy);
			ohterInput.put("aplndate", Util.replaceStr(payment.getText("apln_dt").trim(), ".", ""));


			DataSet  otherSystemStatus = manager.getOhterSystemStatus(ohterInput); 

			////20060530
			request.setAttribute("checkopt", checkopt);
			request.setAttribute("workinginfo", workinginfo);
			request.setAttribute("otherSystemStatus", otherSystemStatus);

			request.setAttribute("plpayment", plpayment);
			request.setAttribute("plpaymentApln", plpaymentApln);
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
			System.out.println("[#############] : policy - " + policy);
			String deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"P");
			////String deathResult =  DeathRegistrationManager.DeathRegistration("7501161552617");
			System.out.println("[#############] : deathResult - " + deathResult);
			Logger.debug.println("[###]" + deathResult);
			
			request.setAttribute("deathResult",deathResult);

			Logger.debug.println("################ PlpaymentAction End ####################");	
			
		    Logger.debug.println("##### message ##### " + message);
		    Logger.debug.println("##### bankerr ##### " + bankerr);
		    
		    if( !bankerr.equals("-1") )  
		    {
		    	
		    	
	           	String msg = message;
	        	String url = "/payment/pl_payment_search.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
	        	request.setAttribute("message", msg);	
	        	request.setAttribute("toURL", url);	
	        	return mapping.findForward("alert");
	        	
	        	
	        	
		    }
		    else
		    {   
		    	
			Logger.debug.println("################ PlpaymentAction Action End ####################");
				
					return mapping.findForward("pl_payment_search"); 
					
		    }
		    /******  - E ******/ 								
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
