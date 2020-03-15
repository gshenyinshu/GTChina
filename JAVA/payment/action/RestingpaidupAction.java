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
import gtone.changeminer.payment.form.RestingpaidupForm;
import gtone.changeminer.payment.manager.RestingpaidupManager;

import gtone.changeminer.payment.form.RestingsearchForm;
import gtone.changeminer.payment.manager.RestingsearchManager;

import gtone.changeminer.payment.form.PlpaymentForm;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.ReturnManager;
import java.lang.*; 

////�1�7�1�9
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 �1�7�0�4�3�1�7�1�0�7
import gtone.changeminer.common.manager.DeathRegistrationManager;

/**
 * @struts.action
 *      path="/resting_paidup"
 *      name="restingpaidupForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="resting_paidup"
 *      path="/resting_paidup.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class RestingpaidupAction extends CyberpayAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ RestingpaidupAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1 = new DataSet();
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			DataSet input5 = new DataSet();
			DataSet input6  = new DataSet();

			RestingpaidupForm restingpaidupForm = (RestingpaidupForm) form;
			FormToDataset.copyProperties(input, restingpaidupForm);
			
			String deptcd  = "INT";
			String init		= "     ";
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");						
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");		
			
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8); 
			String cnvdate	= to_year;
			cnvdate = "        ";

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
			String strAcctSsn    = request.getParameter("strAcctSsn")	== null ? "" : request.getParameter("strAcctSsn");

			init  = proc_emp_no;////�5�5�0�3�8�1�2�3�3�3�9�9
			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");////�4�9�0�5�2�4�1�9(�6�7�2�0,�4�9�0�5(I)				
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
						
			RestingpaidupManager manager = RestingpaidupManager.getInstance();
			PlpaymentManager managerp = PlpaymentManager.getInstance();////�2�9�8�5�3�5�6�2�3�7 �5�5�0�9�1�7�2�1
			RestingsearchManager rmanager = RestingsearchManager.getInstance();////M0191SP1�4�9�0�5 �5�5�0�9�1�7�2�1
			ReturnManager returns = ReturnManager.getInstance();////�0�5�2�2	
															
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);

			input1.put("deptcd", deptcd);
			input1.put("init", init);
			input1.put("policy", policy);

			input2.put("policy_apln_no", policy_apln_no);
			input2.put("recon_id", proc_emp_no);
			input4.put("proc_emp_no", proc_emp_no);

			DataSet  payment   	= rmanager.Inpayment(input2, input4);
			DataSet plcynoinfo 	= manager.findPlcynoinfo(input);
			DataSet restingpaidup 	= manager.findRestingpaidup(input1);	
						
			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input3.put("musera", "INTUSER");
				input3.put("sbkcda", sbkcda);
				input3.put("sbknoa", sbknoa);
				input3.put("amount", "00000000001");

				System.out.println("�3�0�8�5�3�1 �6�2�3�7 strAcctSsn : [" + strAcctSsn + "] pyrna : [" + pyrna + "]");

				//// �3�9�8�5�3�1 �3�5�0�7�0�7�6�3�7�5 �3�3�3�5�9�5�8�9 �8�9�7�5�0�9 �6�3�9�9. �6�5�0�5�1�5�6�7�8�5 1�0�7�3�9 �3�3�6�9�3�1�9�5 �9�9�0�3 �3�0�8�5�3�1�0�9 �1�5�8�9�3�5�8�5 �3�1�6�5.
				if("".equals(Utility.nvl(strAcctSsn)) == false) {
					input3.put("pyrna", strAcctSsn);
				}else {
					input3.put("pyrna", pyrna);
				}

				input3.put("procgb", "O");
				System.out.println("�3�0�8�5�3�1 �3�0�0�4 input3 : " + input3);

				DataSet bankconf = managerp.confBank(input3, input2);
				request.setAttribute("bankconf", bankconf);
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);

				payment   	= rmanager.Inpayment(input2, input4);
				
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
					/*
					input6.put("policy_apln_no", policy_apln_no);				
					input6.put("proc_status", "2");
					input6.put("err_msg", bankerrmsg);
					DataSet rtnsave1 = returns.findRtnsave1(input6);
					request.setAttribute("rtnsave1", rtnsave1);					
					*/
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
									
			if(process.equals("Y"))
			{
				/*
				input5.put("deptcd", "INT");
				input5.put("init",tproc_emp_no );
				input5.put("policy", policy);
				input5.put("opt1", opt1);
				input5.put("divocc", "");
				input5.put("rcvdate", rcvdate);
				input5.put("date", to_year);
				input5.put("sndseq", "      ");////�3�7�0�1�0�7�6�3(�4�9�0�5�0�7�6�3)
				input5.put("bk_clt", bk_clt);
				input5.put("bk_cod", bk_cod);
				input5.put("bk_acct", bk_acct);
								
				anyframe.log.Logger.debug.println("Action M0191SP1  input3==========="+input5);
				
				DataSet approval = rmanager.getApproval(input5, input2, input4);////�7�1�3�9,policy_apln_no,proc_emp_no
				request.setAttribute("approval", approval);	
				*/
				payment   	= rmanager.Inpayment(input2, input4);			
			} 
			else if(process.equals("R"))
			{
				anyframe.log.Logger.debug.println("�6�5�0�5�1�5�6�7�8�5 �3�1�3�1�8�6�8�9�2�2�2�3�1�9 �3�0�2�1�0�7�6�3==========="+input2);
				
				DataSet recognize = managerp.getRecon(input2);
				request.setAttribute("recognize", recognize);		
				payment   = rmanager.Inpayment(input2, input4);
			}
			else if(process.equals("L"))
			{
				plcynoinfo 	= manager.findPlcynoinfo(input);
				restingpaidup 	= manager.findRestingpaidup(input1);	
			}									
											
			request.setAttribute("plcynoinfo", plcynoinfo); 
			request.setAttribute("restingpaidup", restingpaidup); 
			request.setAttribute("payment", payment);
			
			request.setAttribute("policy",policy);
 			request.setAttribute("policy_apln_no",policy_apln_no);
 			request.setAttribute("ssn",ssn);				

			request.setAttribute("sbkcda",sbkcda);
 			request.setAttribute("sbknoa",sbknoa);
 			request.setAttribute("pyrna",pyrna);
			request.setAttribute("strAcctSsn",strAcctSsn);

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
			Logger.debug.println("################ RestingpaidupAction End ####################");

			if( !bankerr.equals("-1") )
			{
            			String msg = message;
            			String url = "/payment/resting_paidup.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
            			request.setAttribute("message", msg);	
            			request.setAttribute("toURL", url);	
            			return mapping.findForward("alert");
			}
		    	else
		    	{
				Logger.debug.println("################ PlpaymentAction Action End ####################");
				return mapping.findForward("resting_paidup");
			}

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
