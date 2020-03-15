
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
import gtone.changeminer.payment.form.DividendlistForm;
import gtone.changeminer.payment.manager.DividendlistManager;

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
 *      path="/dividend_list"
 *      name="dividendlistForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="dividend_list"
 *      path="/dividend_list.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class DividendlistAction extends CyberpayAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ DividendlistAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1 = new DataSet();
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			DataSet input5 = new DataSet();
			DataSet input6  = new DataSet();

			DividendlistForm dividendlistForm = (DividendlistForm) form;
			FormToDataset.copyProperties(input, dividendlistForm);			
			
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);
			String recvdat  = "";
			recvdat		= to_year;
			recvdat		= "        ";
			String cnvdate	= to_year;			
			cnvdate = "        ";
				
			String deptcode = "INT";
			String init		= "     ";
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");			
			String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");							
			String screen 	= "B";
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
			
			////Comment
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

			String proc_emp_no = emp_no;////처리자사번
			String tproc_emp_no = proc_emp_no.toUpperCase();	
			
			////Comment			
			String sbkcda	= request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
			String sbknoa  = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
			String pyrna    = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");	
			
			init  = proc_emp_no;////Comment
			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");
			opt1 = "S";////Comment
			String rcvdate = request.getParameter("rcvdate")	== null ? "" : request.getParameter("rcvdate");
			String date = request.getParameter("date")	== null ? "" : request.getParameter("date");										
			String bk_clt = request.getParameter("bk_clt")	== null ? "" : request.getParameter("bk_clt");
			String bk_cod = request.getParameter("bk_cod")	== null ? "" : request.getParameter("bk_cod");
			String bk_acct = request.getParameter("bk_acct")	== null ? "" : request.getParameter("bk_acct");
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");
			String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");

			String sndseq  = request.getParameter("sndseq")	== null ? "" : request.getParameter("sndseq");////전송번호			
			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "";////예금주명	
			String bnkyn	= request.getParameter("bnkyn")	== null ? "" : request.getParameter("bnkyn");
						
			RestingsearchManager Rmanager = RestingsearchManager.getInstance();
			PlpaymentManager Pmanager = PlpaymentManager.getInstance();
			DividendsearchManager Wmanager = DividendsearchManager.getInstance();
			DividendlistManager manager = DividendlistManager.getInstance();
			ReturnManager returns = ReturnManager.getInstance();
						
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);
			
			input1.put("deptcode", deptcode);
			input1.put("init", "     ");
			input1.put("policy", policy);
			input1.put("recvdat", recvdat);
			input1.put("screen",   screen);			
			
			input2.put("policy_apln_no", policy_apln_no);
			input2.put("recon_id", proc_emp_no);
			input3.put("proc_emp_no", proc_emp_no);

			DataSet plcynoinfo 	= manager.findPlcynoinfo(input);
			DataSet dividendlist = manager.findDividendlist(input1);	
			DataSet  payment   = Wmanager.Inpayment(input2, input3);				


			////20060530 
			anyframe.log.Logger.debug.println("change policy==========="+policy);										
			DataSet checkopt  = Pmanager.Chkpayment(policy);
			
			////20060530 
			////workingday calcuration
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
			             
			//// Step3-1.Days?[Mon : 1 -> 01] 
			if( days.length() == 1 )        days = "0" + days;                 
			//// Step3-2.Month?                        
			if( month.length() == 1 ) 	month = "0" + month; 
			
			//// Step4.  
			today = year + month + days;
				
			anyframe.log.Logger.debug.println("Action today==========="+today);										
			DataSet  workinginfo = Pmanager.Workinginfo(today);
			
			
			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input4.put("musera", "INTUSER");
				input4.put("sbkcda", sbkcda);
				input4.put("sbknoa", sbknoa);
				input4.put("amount", "00000000001");
				input4.put("pyrna", pyrna);
				input4.put("procgb", "O");
				DataSet bankconf = Pmanager.confBank(input4, input2);
				request.setAttribute("bankconf", bankconf);
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);
				
				payment   = Wmanager.Inpayment(input2, input3);		
				
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
				
				 /******  - S ******/ 
				int success = Integer.parseInt(bankerr);
		    		
		    		switch(success)
		    		{
		        		case(0) :
		            			////message =  ;
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
			
					
			/*			
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
				
				anyframe.log.Logger.debug.println("Action M0191SP1  input4==========="+input5);
				
				DataSet approval = Rmanager.getApproval(input5, input2, input3);////policy_apln_no,proc_emp_no
				request.setAttribute("approval", approval);			
				*/
				/*
				payment   = Wmanager.Inpayment(input2, input3);					
			}	
			else if(process.equals("L"))
			{
				plcynoinfo 	= manager.findPlcynoinfo(input);
				dividendlist = manager.findDividendlist(input1);	
			}
			else if(process.equals("R"))
			{
				DataSet recognize = Pmanager.getRecon(input2);
				request.setAttribute("recognize", recognize);		
				payment   = Wmanager.Inpayment(input2, input3);				
			}		
			*/
			
			
			/* Host  */
		
			if(process.equals("Y")||process.equals("R"))
			{
				plcynoinfo 	= manager.findPlcynoinfo(input);
				dividendlist = manager.findDividendlist(input1);	
	
				int amt1 = plcynoinfo.getInt("acu_div");
		
				
				if( amt1 > 0 )
				{
					bankerr = "1";
					message = "message";				
				}
				
				////	Comment 
				if(bankerr.equals("-1")){		  
							  
					if(process.equals("Y"))
					{
		
						payment   = Wmanager.Inpayment(input2, input3);			
								
					}	
					else if(process.equals("R"))
					{
						
						DataSet recognize = Pmanager.getRecon(input2);
						request.setAttribute("recognize", recognize);		
						payment   = Wmanager.Inpayment(input2, input3);					
					
					}		
				}	
		
			}							
						
			////20060530 김보영
			request.setAttribute("checkopt", checkopt);
			request.setAttribute("workinginfo", workinginfo);
			////
														
			request.setAttribute("plcynoinfo", plcynoinfo); 
			request.setAttribute("dividendlist", dividendlist); 
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
			Logger.debug.println("################ DividendlistAction End ####################");

			if( !bankerr.equals("-1") )
			{
            			String msg = message;
            			String url = "/payment/dividend_list.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
            			request.setAttribute("message", msg);	
            			request.setAttribute("toURL", url);	
            			return mapping.findForward("alert");
			}
		    	else
		    	{
				Logger.debug.println("################ PlpaymentpaidupAction Action End ####################");
				return mapping.findForward("dividend_list");
			}

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
