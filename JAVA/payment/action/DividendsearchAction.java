
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
import gtone.changeminer.payment.form.DividendsearchForm;
import gtone.changeminer.payment.manager.DividendsearchManager;

import gtone.changeminer.payment.form.RestingsearchForm;
import gtone.changeminer.payment.manager.RestingsearchManager;
import gtone.changeminer.payment.form.PlpaymentForm;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.ReturnManager;
import java.lang.*; 
import java.util.Calendar;

////�1�7�1�9
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 �1�7�0�4�3�1�7�1�0�7
import gtone.changeminer.common.manager.DeathRegistrationManager;
/**
 * @struts.action
 *      path="/dividend_search" 
 *      name="dividendsearchForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="dividend_search"
 *      path="/dividend_search.jsp"
 * 
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class DividendsearchAction extends CyberpayAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ DividendsearchAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			DataSet input5 = new DataSet();
			DataSet input6  = new DataSet();

			DividendsearchForm dividendsearchForm = (DividendsearchForm) form;
			FormToDataset.copyProperties(input, dividendsearchForm);			
			
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");						
			
			////�6�1�3�9�8�9�3�9 �7�5�3�9�2�7�8�5
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);
			String cnvdate	= to_year;
			
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
			String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");	
						
			////�1�7�1�9�1�7�3�0�6�9�8�5
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);			

			String proc_emp_no = emp_no;////�4�9�0�5�3�1�1�7�0�7	
			
			String tproc_emp_no = proc_emp_no.toUpperCase();			
			
			////�2�9�8�5�3�5 �6�2�3�7�6�9�8�9 �5�5�0�9�1�7�2�1			
			String sbkcda	= request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
			String sbknoa  = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
			String pyrna    = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");	

			String init  = proc_emp_no;////�5�5�0�3�8�1�2�3�3�3�9�9
			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");////�4�9�0�5�2�4�1�9(�6�7�2�0,�4�9�0�5(I)				
			opt1 = "S";////�0�9�9�0�3�1 �7�4�3�7 S(�4�9�0�5)
			String rcvdate = request.getParameter("rcvdate")	== null ? "" : request.getParameter("rcvdate");////�3�0�2�1�3�1�3�1	
			String date = request.getParameter("date")	== null ? "" : request.getParameter("date");////�3�1�8�6�3�1�3�1										
			String bk_clt = request.getParameter("bk_clt")	== null ? "" : request.getParameter("bk_clt");////�2�9�8�5�3�5�0�7�0�7�6�3	
			String bk_cod = request.getParameter("bk_cod")	== null ? "" : request.getParameter("bk_cod");////�3�1�6�8�4�9�9�3	
			String bk_acct = request.getParameter("bk_acct")	== null ? "" : request.getParameter("bk_acct");////�7�1�3�3�0�7�6�3										
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");////�3�0�2�1�3�1�3�1										
			String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////�4�9�0�5�7�9�1�9							

			String sndseq  = request.getParameter("sndseq")	== null ? "" : request.getParameter("sndseq");////�3�7�2�2�0�7�6�3			
			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "";////�2�9�8�5�3�5�0�2	
			String bnkyn	= request.getParameter("bnkyn")	== null ? "" : request.getParameter("bnkyn");	

			RestingsearchManager Rmanager = RestingsearchManager.getInstance();////�7�1�3�9
			PlpaymentManager Pmanager = PlpaymentManager.getInstance();////�2�9�8�5�3�5�6�2�3�7 �5�5�0�9�1�7�2�1
			ReturnManager returns = ReturnManager.getInstance();////�0�5�2�2	
			
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);
			
			input1.put("policy_apln_no", policy_apln_no);
			input1.put("recon_id", proc_emp_no);
			input2.put("proc_emp_no", proc_emp_no);
			
			DividendsearchManager manager = DividendsearchManager.getInstance();			
			DataSet dividendsearch 	= manager.findDividendsearch(input);
			DataSet  payment   = manager.Inpayment(input1, input2);	
					
			////20060530 �8�1�1�5�2�2 0601081 �3�9�2�9/�2�5�6�5(�7�1/�2�9)�4�7�5�9�4�1�7�5	
			anyframe.log.Logger.debug.println("�2�0�7�1�9�7�4�9 Action�2�3�1�9 �4�1�7�5�6�0�0�81 policy==========="+policy);										
			DataSet checkopt  = Pmanager.Chkpayment(policy);
			
			////20060530 �8�1�1�5�2�2 0601081 workingday�3�5 �3�9�2�9/�2�5�6�5(�7�1/�2�9)�4�7�5�9�4�1�7�5	
			////�2�7�8�3 �8�9�3�9 �1�5�8�9�1�9 workingday �3�4�1�5 �7�5�3�9�2�7�8�5 
			////step1. �8�9�3�9 �7�1�1�1�2�3 �6�9�3�9�6�3 �1�3�2�1 �1�3�2�9 
			Calendar cal = Calendar.getInstance();                 
			String days = ""; 
			String month = ""; 
			String year = ""; 
			String today = "";
			    
			//// Step2. �8�9�3�9 �3�3�3�2 (�3�1-�3�3-�8�3 �2�5) 
			days = String.valueOf( cal.get(Calendar.DATE) ); 
			month = String.valueOf( cal.get(Calendar.MONTH) + 1 ); 
			year = String.valueOf( cal.get(Calendar.YEAR) );
			             
			//// Step3-1.Days�0�7 �9�3�3�1�0�5�0�9 �0�1�8�3 [�2�9 : 1 -> 01] 
			if( days.length() == 1 )        days = "0" + days;                 
			//// Step3-2.Month�0�7 �9�3�3�1�0�5�0�9 �0�1�8�3 [�2�9 : 1 -> 01]                        
			if( month.length() == 1 ) 	month = "0" + month; 
			
			//// Step4. �8�9�3�9 �0�5�6�5 
			today = year + month + days;
				
			anyframe.log.Logger.debug.println("�2�0�7�1�9�7�4�9 Action�2�3�1�9 �4�1�7�5�6�0�0�82today==========="+today);										
			DataSet  workinginfo = Pmanager.Workinginfo(today);
				
			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input3.put("musera", "INTUSER");
				input3.put("sbkcda", sbkcda);
				input3.put("sbknoa", sbknoa);
				input3.put("amount", "00000000001");
				input3.put("pyrna", pyrna);
				input3.put("procgb", "O");
				DataSet bankconf = Pmanager.confBank(input3, input1);
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);
				
				request.setAttribute("bankconf", bankconf);
				payment   = manager.Inpayment(input1, input2);	
				
				bankerr = bankconf.getText("rtn").trim();////�2�3�0�7�4�9�9�3
				bankerrmsg = bankconf.getText("errmsg").trim();////�2�3�0�7�0�3�1�7�3�1
				payorna = bankconf.getText("payorna").trim();////�2�9�8�5�3�5�0�2
				
				if(!bankerr.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "2");
					input5.put("err_msg", bankerrmsg);
					
					DataSet rtnsave = returns.findRtnsave(input5);
					request.setAttribute("rtnsave", rtnsave);	

				}
				
				 /****** �0�3�2�7�3�1 - S ******/ 
				int success = Integer.parseInt(bankerr);
		    		
		    		switch(success)
		    		{
		        		case(0) :
		            			////message =  "�2�9�8�5�3�5 �6�2�3�7�3�3 �9�7�2�5�2�8�9�1�9�9..";
						message = "�2�9�8�5�3�5�0�2 : " + payorna;
		            			break;
		        		case(1) :
		            			////message = payorna + "�2�9�8�5�3�5 �6�2�3�7�3�3 �2�5�5�9�6�9�2�1�2�8�9�1�9�9.";
						message = bankerrmsg;
		            			break;
		        		default :
		            			////message = payorna + "�2�9�8�5�3�5 �6�2�3�7�3�3 �2�5�5�9�6�9�2�1�2�8�9�1�9�9.";
						message = bankerrmsg;
		            			break;
		    		}	
			}				
			
			
			/*  �4�9�0�5�3�7 �3�5�6�7 Host �1�8�3�5 �0�9�9�0�2�9�4�7�8�5 �3�9�3�9 �2�1�1�5 �4�7�5�9, �2�3�3�5 �7�4�3�7 �4�9�0�5 �3�5�6�8 �1�3�7�5 */
		
			if(process.equals("Y")||process.equals("R"))
			{
				
				Logger.debug.println("################�0�9�9�0�2�9�4�7�8�5####################");		
				
				dividendsearch 	= manager.findDividendsearch(input);

				int amt1 = dividendsearch.getInt("acu_div");
		
				
				if( amt1 > 0 )
				{
					bankerr = "1";
					message = "�0�9�9�0�2�9�4�7�8�5�3�3 �2�3�2�8�9�1�9�9.";		
					Logger.debug.println("################�0�9�9�0�2�9�4�7�8�5�3�3 �2�3�2�8�9�1�9�9.####################");		
				}
				
				////	�4�9�0�5�3�7 �3�5�6�7�7�5 �1�0�7�0�3�4�3�3�0�5 �2�5�6�8�6�3�9�9. 			  
				if(bankerr.equals("-1")){		  
							  
					if(process.equals("Y"))
					{
		
						payment   = manager.Inpayment(input1, input2);		
						Logger.debug.println("################�0�9�9�0�2�9�4�7�8�5�4�9�0�5####################");		
								
					}	
					else if(process.equals("R"))
					{
						DataSet recognize = Pmanager.getRecon(input1);
						request.setAttribute("recognize", recognize);		
						payment   = manager.Inpayment(input1, input2);		
						Logger.debug.println("################�0�9�9�0�2�9�4�7�8�5�7�1�3�9�3�9�4�0####################");				
					}		
				}	
		
			}
			////20060530 �8�1�1�5�2�2
			request.setAttribute("checkopt", checkopt);
			request.setAttribute("workinginfo", workinginfo);
			////
			
			request.setAttribute("dividendsearch", dividendsearch);
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

			//// 2008.02.25 �8�1�3�6�0�2 �4�1�7�5 (�1�7�0�4�3�1�7�1�0�7 �3�4�1�5 �1�6�5�4)
			String deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"P");
			request.setAttribute("deathResult",deathResult);			
			Logger.debug.println("################ DividendsearchAction End ####################");

			if( !bankerr.equals("-1") )
			{
            			String msg = message;
            			String url = "/payment/dividend_search.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
            			request.setAttribute("message", msg);	
            			request.setAttribute("toURL", url);	
            			return mapping.findForward("alert");
			}
		    	else
		    	{
				Logger.debug.println("################ PlpaymentpaidupAction Action End ####################");
				return mapping.findForward("dividend_search");
			}


		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
