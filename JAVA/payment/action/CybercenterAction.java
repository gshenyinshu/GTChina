// modified by wihyuk yi 2005.08.22
//package gtone.home.common.action;
package gtone.changeminer.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.*;


////comment
import anyframe.data.DataSet;
import anyframe.log.*;
import gtone.changeminer.common.utility.*;

import java.util.*;////StringTokenizer�2�3 �1�7�3�0
import anyframe.util.*;////StringFormater

////ksps2000
import gtone.changeminer.payment.manager.CybercenterManager;
import gtone.changeminer.payment.manager.ReturnManager;
import gtone.changeminer.payment.manager.PlpaymentManager;

////SMS message
import gtone.changeminer.payment.manager.CyberSmsManager;

////comment
import gtone.changeminer.receipt.manager.AuthManager;
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.common.utility.Variable;////prumail.xml

////comment
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

public abstract class CybercenterAction extends Action
{


	/**
	 * action forward
	 * action forward
	 * action forward
	 */

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)throws Exception
	{

		/**************************************
		 * ksps2000 - S
		 ***************************************/

		DataSet input = new DataSet();
		DataSet input1 = new DataSet();
		DataSet input2 = new DataSet();
		DataSet input3 = new DataSet();
		DataSet input4 = new DataSet();
		DataSet input5 = new DataSet();
		DataSet input7 = new DataSet();
		DataSet input8 = new DataSet();////KSPS0450
		DataSet input9 = new DataSet();
		DataSet input10 = new DataSet();
		DataSet input11 = new DataSet();
		DataSet smscu    = new DataSet();
		DataSet realpay  = new DataSet();
		DataSet inAppv   = new DataSet();
		DataSet	outAppv1 = new DataSet();
		DataSet	outAppv2 = new DataSet();

		String errrtn = "-1";
		String message = "";
		String message1 = "";
		String bankerr = "-1";

		String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////�4�9�0�5�7�9�1�9
		String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
		String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");

		////�1�7�1�9�1�7�3�0�6�9�8�5
		SessionManager sessionManager = new SessionManager(request);
		String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		String emp_no = sessionManager.getString(Constant.SESSION_USERID);
		String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

		String proc_emp_no = emp_no;////�4�9�0�5�3�1�1�7�0�7

		String deptcd  		= "INT";
		String init	   		= "     ";
		String gubun    	= "";////�4�9�0�5�7�9�1�9(C,W)
		String reqnum  	= "   ";////�3�9�4�0�7�1�2�1
		String fromdt 		=    request.getParameter("indate")	== null ? "" : request.getParameter("indate");////�3�5�6�7�8�5�3�9�3�1�3�1
		String policy	 	=    request.getParameter("policy")	== null ? "" : request.getParameter("policy");////�3�6�7�1�0�7�6�3
		String procdt   		= "        ";////�2�5�3�1�4�9�0�5�3�1�3�1
		String proctm   	= "      ";////�2�5�3�1�4�9�0�5�2�7�7�9
		String inout 		= "OUT";////�2�1�8�8(IN), �3�1�8�6(OUT)
		String procgb  		= "L1";////�2�0�9�7�3�1�8�6
		String lvlnum  		= "";////�4�9�0�5�1�8�5�1
		String lvlbef   		= "  ";////�4�9�0�5�3�7�1�8�5�1
		String mbkcd    	= "  ";////�0�7�7�1�3�3 �3�1�6�8�4�9�9�3
		String mbkact   	= "               ";////�0�7�7�1�3�3 �7�1�3�3�0�7�6�3
		String cltbk    		=  request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");////�3�1�6�8�4�9�9�3
		String cltact   		= request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");////�7�9�7�4 �7�1�3�3�0�7�6�3
		String cltnum   	= request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");////�7�9�7�4 �3�5�0�7�0�7�6�3
		String procamt  	= request.getParameter("cash")	== null ? "" : request.getParameter("cash");////�3�3�4�7�8�5�2�2
		String procno   	= "      ";////�3�3�4�7�3�7�0�1�0�7�6�3
		String brltcd   		= "    ";////�3�1�6�8�7�1�7�7

		String returnurl = request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");
		String urlname =  returnurl + "?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy;
		anyframe.log.Logger.debug.println("�0�5�5�9 url�3�5 �7�3===================>"+urlname);

		////�2�2�3�7�2�7 M0181SP1�2�3 �1�7�5�4�6�7�7�3�9�1
		String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");
		String regdate  = request.getParameter("regdate")	== null ? "" : request.getParameter("regdate");
		String cash =  request.getParameter("cash")	== null ? "" : request.getParameter("cash");
		String bnkclt =  request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");
		String bnkcode  = request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");
		String bnkacct = request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");
		String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");
		String tproc_emp_no = proc_emp_no.toUpperCase();
		String v_toyear = Util.getTodayToYMD();
		String  to_year = v_toyear.substring(0,8);

		//// 0800133 �2�7�1�0�6�7 : �1�3�2�2�3�1�7�4�3�7 �7�6�3�1�4�9�0�5�0�7 �6�7�2�1 �3�3�9�3�0�0 �4�9�0�5 M018SP1 -> M018SP5 �0�9 �2�5�6�8�6�7�2�1�3�3�9�3�0�0 �2�1�3�4�6�5.	
		String variable_div = request.getParameter("variable_div")	== null ? "" : request.getParameter("variable_div");

		String sending_num = "";
		String msg = "";
		String url  = "";
		String sendingnum = "";
		String date = "";
		String rtn0450 = "";

		input.put("deptcd", deptcd);
		input.put("init", init);
		input.put("reqnum", reqnum );
		input.put("fromdt", fromdt );
		input.put("policy", policy ); 
		input.put("procdt", procdt );
		input.put("proctm", proctm );
		input.put("inout", inout  );
		input.put("procgb", procgb );
		input.put("lvlnum", lvlnum );
		input.put("lvlbef", lvlbef );
		input.put("mbkcd", mbkcd  );
		input.put("mbkact", mbkact );
		input.put("cltbk", "  ");
		input.put("cltact", "               " );
		input.put("cltnum", "             ");
		input.put("procamt", "0000000000000");
		input.put("procno", procno );
		input.put("brltcd", brltcd );

		int procamt1 	      = 0;////�3�3�4�7�8�5�2�2(1000�0�7�3�9)

		CybercenterManager manager = CybercenterManager.getInstance();
		ReturnManager returns = ReturnManager.getInstance();                 ////�0�5�2�2
		PlpaymentManager Pmanager = PlpaymentManager.getInstance();////M0181SP1�3�5 �2�5�6�8(�3�1�6�8�3�3�4�7�4�9�0�5)
		PolicychangeManager mailsend = PolicychangeManager.getInstance();////�0�3�3�1�0�9�2�2
		CyberSmsManager manager2 = CyberSmsManager.getInstance(); ////�0�1�3�1�3�7�2�2

		anyframe.log.Logger.debug.println("PROCESS*****************====>"+process);
		
		DataSet inputp1  = new DataSet();
		DataSet inputp2  = new DataSet();
		DataSet inputp3  = new DataSet();	

		String cnvdate	= to_year;
		cnvdate = "        ";

		inputp1.put("policy", policy);
		inputp1.put("cnvdate",   cnvdate);

		anyframe.log.Logger.debug.println("�4�9�0�5 �5�5�0�9�1�7�2�1.... �4�9�9�3 ==========="+process);	
		inputp2.put("policy_apln_no", policy_apln_no);
		inputp2.put("recon_id", proc_emp_no);
		inputp3.put("proc_emp_no", proc_emp_no);


		////�4�9�0�5�3�7 �3�5�6�7 �8�5�8�6 �4�1�7�5.. (�2�2�4�7�2�3�1�9 �2�1�3�4�6�7�3�3 )...
		////�7�1�3�9�3�9�4�0(R) , �2�2�3�7(Y)
		if(process.equals("R")||process.equals("Y")){
			anyframe.log.Logger.debug.println("=============== �4�9�0�5�3�7 �3�5�6�7 �6�9�8�5 ==================");	
			
				
			PlpaymentManager manager1 = PlpaymentManager.getInstance();		
			DataSet plpayment 	= manager1.findPlpayment(inputp1); ////ysg123 m0161sp1
	
			DataSet  payment   = manager1.Inpayment(inputp2, inputp3); ////ysg123 CYBER_TBL_wb_payment�3�5�6�7
	
			int loanval  = 0;////�6�1�9�7�4�9�7�5�8�6�2�2
			int cntno = plpayment.getCount("rid_nam");////�1�5�3�6�0�2
	
			for(int i=0;i<cntno;i++)
			{
				loanval   = loanval  + Integer.parseInt(plpayment.getText("loanval",i).trim());		
			}
			int amt1 = loanval;////�6�1�9�7�4�9�7�5�8�6�8�5�2�2
			int amt2 = payment.getInt("apln_amt");////�2�1�4�0�8�5�2�2
			anyframe.log.Logger.debug.println("PlpaymentAction --- amt1:"+amt1);	
			anyframe.log.Logger.debug.println("PlpaymentAction --- amt2:"+amt2);	
			String strPlnCode = plpayment.getText("plancd");
			if("".equals(strPlnCode) == false || strPlnCode != null) strPlnCode = strPlnCode.substring(0,2);
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!! �1�5�3�6�4�9�9�3 : [" + strPlnCode + "]");
			//// �1�3�2�2�9�7�4�9�3�1�7�4�3�7�8�9 �4�9�0�5�3�7�3�5�6�7�0�7 �6�9�3�1 �2�9�3�3.
			if( amt1 < amt2 && ("51".equals(strPlnCode) || "53".equals(strPlnCode) || "54".equals(strPlnCode) || "55".equals(strPlnCode) || "56".equals(strPlnCode)) == false)
			{
	
				 message = "[�4�9�0�5�3�7�3�5�6�7]�2�1�4�0�8�5�2�2�3�3 �6�1�9�7�4�9�7�5�8�6�8�5�2�2�1�5�9�9 �0�9�2�8�9�1�9�9.";
				msg = message;
				url = urlname;
				request.setAttribute("message", msg);
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");	
	
			}
			
		}	
		
		
		
		
		
		////�7�1�3�9�3�9�4�0
		if(process.equals("R"))
		{
			input.put("gubun", "C"); ////       I - �3�5�6�7 / W - �2�1�8�1�3�2�1�0 / C - CHECK (�3�1�8�6,�2�1�8�8 �4�9�0�5�2�7 �4�7�5�9)
			input.put("lvlnum", "21");

			DataSet ksps2000_10 = manager.findKsps2000(input);
			
			
			////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
			try
			{
				
				/*�2�2�0�7�7�9�1�9�4�9�9�3*/
															   /*
																* �2�0�9�7�3�1�8�6		1
																* �0�9�9�0�8�5�3�1�8�6		4
																* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																* �0�9�9�0�8�5�1�8�7�1		7
																* �1�5�6�7�0�1�2�1�8�8		6
																* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																* �2�0�9�7�1�8�6�5		2
																* APL�1�8�6�5		3 
																* �5�8�2�0�1�5�7�5 1		A
																* �5�8�2�0�1�5�7�5 2 	B
																* �5�8�2�0�1�5�7�5 3		C 
																* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																*/
																
																
				DataSet spinputp  = new DataSet();
				
				spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
				spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
				spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
				spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
				spinputp.put("sp_in_put",input.toString()); ////sp_in_put
				spinputp.put("sp_out_put",ksps2000_10.toString()); ////sp_out_put
				
				returns.findSpLogsave(spinputp);
						
			}catch(Exception e)
			{
			
				System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
			}
			
			////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
			

			errrtn = "";
			errrtn = ksps2000_10.getText("rtn",0);

////�7�1�3�9�3�9�4�0�2�7�3�2
			if(errrtn.equals("0") || errrtn.equals("6"))
			{
				/* 2007�8�3 5�3�3 16�3�1 �2�7�1�0�6�7 1�3�1�6�3�9�3 1000�0�7�3�9�3�7�0�9 �2�1�3�4
								int cnt = ksps2000_10.getCount("procamt");
								if(cnt > 0)
								{
									for(int i =0; i<cnt; i++)
									{
										procamt1 = procamt1 + Integer.parseInt(ksps2000_10.getText("procamt",i));
									}
								}
				*/

				//// WB_PAYMENT�2�3�1�9 �3�0�2�1�0�7�6�3�0�9 �6�3 ROW �7�3�1�6
				DataSet nameSet = new DataSet();
				nameSet.put("policy_apln_no", policy_apln_no);

				DataSet selPayment = manager.findRecei(nameSet);

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				////[20070220] 1. webdb�2�3�1�9 �2�7�8�3 �3�1�3�1�0�9 �8�9 �3�5�0�7�0�7�6�3�2�3 �9�7�6�7�1�9 �9�7�4�9�0�8�3�1 �8�9�2�2 �3�5�6�7�6�9�8�9 �7�6 �4�1�7�5
				////- �2�7�8�3 �4�9�0�5�7�1 �3�6 �7�1�3�9�2�9�0�1 �1�0�7�00�3�7 �7�6�3�5 mode:1(�3�1�8�6)/srvc_cd:1(�2�0�9�7�3�1�8�6)�3�7 �7�6 �3�5�6�7
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////S/
				DataSet procamt_input 	= new DataSet();
				procamt_input.put("mode", 		"1"); ////�3�1�8�6
				procamt_input.put("srvc_cd", 	selPayment.getText("srvc_cd")); ////�2�0�7�1�9�7�4�9, �9�4�9�4
				////procamt_input.put("rslt", 		"0"); ////�1�0�7�0
				procamt_input.put("ssn", 		ssn);
				DataSet procamt_info 	= manager.getProcamtInfo(procamt_input);
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////E/

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				////[20070220] 2. procamt_sum �7�1�1�1
				////- �8�5�3�1 �1�7�3�3�0�3�1�1�5�5 �2�0�7�1�9�7�4�9 �6�6 + �6�1�3�9 �2�1�4�0�8�5�2�2 = procamt_sum
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				int procamt_sum = 0;////�3�3�4�7�8�5�2�2(1000�0�7�3�9)
				int cnt = procamt_info.getCount("payor_ssn");

				if(cnt > 0){
					for(int i =0; i<cnt; i++){
						procamt_sum = procamt_sum + Integer.parseInt(procamt_info.getText("apln_amt",i));
					}
				}
				anyframe.log.Logger.debug.println(" (procamt_info - �3�5�6�7)----  applymoney  : "+Integer.parseInt(procamt) );
				anyframe.log.Logger.debug.println(" (procamt_info - �3�5�6�7)----  pay_amt  : "+procamt_sum );
				////ocamt_sum = procamt_sum + Integer.parseInt(procamt);
				anyframe.log.Logger.debug.println(" (procamt_info - �3�5�6�7)----  procamt_sum  : "+procamt_sum );

				////procamt1 = 10000001;
////				if(procamt1 >10000000)
				if(procamt_sum > 10000000)
				{
					message =  "1�3�1 �3�1�8�6�6�3�9�3 1000�0�7�3�9�3�5 �4�1�7�7�6�9�2�1  �1�3�7�5�8�6�6�6�9�1�9�9.";
					input.put("gubun", "W" );
					input.put("lvlnum", "30");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);

					DataSet ksps2000_30 = manager.findKsps2000(input);
					////request.setAttribute("ksps2000_30", ksps2000_30);


					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
					try
					{
				
						/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																	   /*
																		* �2�0�9�7�3�1�8�6		1
																		* �0�9�9�0�8�5�3�1�8�6		4
																		* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																		* �0�9�9�0�8�5�1�8�7�1		7
																		* �1�5�6�7�0�1�2�1�8�8		6
																		* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																		* �2�0�9�7�1�8�6�5		2
																		* APL�1�8�6�5		3 
																		* �5�8�2�0�1�5�7�5 1		A
																		* �5�8�2�0�1�5�7�5 2 	B
																		* �5�8�2�0�1�5�7�5 3		C 
																		* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																		*/
																
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
						spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
						spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
						spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_30.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
					}
			
					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
					
					errrtn = "";
					errrtn = ksps2000_30.getText("rtn",0);

					////WEB �9�9�1�1�2�3 �0�5�2�2 �3�3�3�2
					if(errrtn.equals("0"))
					{
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "30");
						input1.put("err_msg", message);
						DataSet rtnsave = returns.findRtnsave(input1);

						input2.put("policy_apln_no", policy_apln_no);
						input2.put("proc_status", "1");
						input2.put("err_msg", message);
						input2.put("recon_id", proc_emp_no);
						DataSet rtnsave1 = returns.findRtnsave1(input2);

					}////WEB �9�9�1�1�2�3 �0�5�2�2 �3�3�3�2

							msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}////1000�0�7�3�9�2�3�0�7
				else
				{
					
					anyframe.log.Logger.debug.println("KSPS2000 �2�5�6�8 1�4�7�7�1�3�9�2�9�0�1 �4�9�0�5�7�9�1�9(C)=======================================>");
					////KSPS2000�2�5�6�8 1�4�7�7�1�3�9�2�9�0�1:21(�3�5�6�7)
					input.put("gubun", "C");
					input.put("lvlnum", "21");

					DataSet ksps2000_21C = manager.findKsps2000(input);////�3�3�3�2
					
					
					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
					try
					{
				
						/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																	   /*
																		* �2�0�9�7�3�1�8�6		1
																		* �0�9�9�0�8�5�3�1�8�6		4
																		* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																		* �0�9�9�0�8�5�1�8�7�1		7
																		* �1�5�6�7�0�1�2�1�8�8		6
																		* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																		* �2�0�9�7�1�8�6�5		2
																		* APL�1�8�6�5		3 
																		* �5�8�2�0�1�5�7�5 1		A
																		* �5�8�2�0�1�5�7�5 2 	B
																		* �5�8�2�0�1�5�7�5 3		C 
																		* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																		*/
																
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
						spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
						spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
						spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_21C.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
					}
			
					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
					
					
					String rtn21 = ksps2000_21C.getText("rtn").trim();
					anyframe.log.Logger.debug.println("�7�1�3�9�3�9�4�0�6�7�3�5�9�5 �8�1�2�7�8�9�7�3 �3�1�0�9 �9�7�9�5=======================================>"+rtn21);
					int success = Integer.parseInt(rtn21);

						switch(success)
						{
							case(0) :
									message =  "�7�1�3�9�3�9�4�0�3�3 �4�9�0�5�9�7�2�5�2�8�9�1�9�9..";
									break;
							case(5) :
									message = "�8�5�3�0�2�1�9�7�2�5 �4�9�0�5�3�6�3�7�7�1�3�3 �3�9�3�9�6�6�9�1�9�9.";
									break;
							case(6) :
									message =  "�7�1�3�9�3�9�4�0�3�3 �4�9�0�5�9�7�2�5�2�8�9�1�9�9..";
									break;
							default :
									message =  "�8�5�5�3�2�7�0�1�7�5 �0�9�1�6�6�9�2�1�2�8�9�1�9�9. �2�7�2�1�5�9�7�3�0�9�3�1�2�3�7�5 �0�1�3�5�6�9�1�7�3�9..";
									break;
						}
						////KSPS2000�2�5�6�8 1�4�7�7�1�3�9�2�9�0�1 21(�3�3�3�2)
						if(rtn21.equals("0") || rtn21.equals("6"))
						{
						input.put("gubun", "W" );
						input.put("lvlnum", "21");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);
						
						DataSet ksps2000_21W = manager.findKsps2000(input);
						
						
						////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
						try
						{
				
							/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																		   /*
																			* �2�0�9�7�3�1�8�6		1
																			* �0�9�9�0�8�5�3�1�8�6		4
																			* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																			* �0�9�9�0�8�5�1�8�7�1		7
																			* �1�5�6�7�0�1�2�1�8�8		6
																			* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																			* �2�0�9�7�1�8�6�5		2
																			* APL�1�8�6�5		3 
																			* �5�8�2�0�1�5�7�5 1		A
																			* �5�8�2�0�1�5�7�5 2 	B
																			* �5�8�2�0�1�5�7�5 3		C 
																			* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																			*/
																
																
							DataSet spinputp  = new DataSet();
				
							spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
							spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
							spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
							spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
							spinputp.put("sp_in_put",input.toString()); ////sp_in_put
							spinputp.put("sp_out_put",ksps2000_21W.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
						}
			
						////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
						
						
						
						////request.setAttribute("ksps2000_21W", ksps2000_21W);
					
							errrtn = "";
							errrtn = ksps2000_21W.getText("rtn",0);
							if(errrtn.equals("0"))
							{
								input1.put("policy_apln_no", policy_apln_no);
								input1.put("proc_emp_no", proc_emp_no);
								input1.put("proc_status", "21");
								input1.put("err_msg", message);
								DataSet rtnsave2 = returns.findRtnsave(input1);
	
								input2.put("policy_apln_no", policy_apln_no);
								input2.put("proc_status", "A");
								input2.put("err_msg", message);
								input2.put("recon_id", proc_emp_no);
								DataSet rtnsave3 = returns.findRtnsave1(input2);
							}
						}
						else if(rtn21.equals("5"))	////�8�5�3�0�2�1�9�7�2�5�3�3�8�9�7�1
						{
							input1.put("policy_apln_no", policy_apln_no);
							input1.put("proc_emp_no", proc_emp_no);
							input1.put("proc_status", "1");
							input1.put("err_msg", message);
							DataSet rtnsave4 = returns.findRtnsave(input1);

							input2.put("policy_apln_no", policy_apln_no);
							input2.put("proc_status", "1");
							input2.put("err_msg", message);
							input2.put("recon_id", proc_emp_no);
							DataSet rtnsave5 = returns.findRtnsave1(input2);
						}
					
					msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}////KSPS2000�2�5�6�8 1�4�7�7�1�3�9 �2�9�0�1:21
			}
		}////�7�1�3�9�3�9�4�0 END
		////�2�2�3�7�3�9�4�0�1�5�1�9-�2�7�3�2
		else if(process.equals("Y"))
		{
			//// 2007�8�3 5�3�3 15�3�1 �2�7�1�0�6�7 : �3�6�1�6�3�9�4�0 �0�4�3�3. saveToken �3�3�3�0
			//// �1�5�0�9�7�9�4�3 �6�7�3�5�7�4�3�7�8�1 �9�1�1�3�5�7�0�6�4�9�0�3 �9�3�0�7 �3�9�4�0 �9�7�2�5�3�5�7�4�3�7 �3�6�1�6�2�2�3�7�3�9�4�0�3�5 �0�4�8�9 �1�5�1�9.
			if (!isTokenValid(request)) {
				url = urlname;
				Logger.debug.println("saveToken �1�5�0�9�7�9�4�3 �6�7�3�5�7�4�3�7�8�1 �9�1�1�3�5�7�0�6�4�9�0�3 �9�3�0�7 �3�9�4�0 �9�7�2�5�3�5�7�4�3�7 �0�4�6�5.");
				request.setAttribute("message", "�2�2�3�7�3�9�4�0 �3�5�6�8�3�6�2�3 �9�1 �9�9�0�3 �2�2�3�7�3�9�4�0�3�3 �3�6�1�6�2�1�4�0 �9�7�2�5�3�7�0�7�0�9 �3�5�6�8�9�7�3�1 �2�9�2�8�9�1�9�9.");
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			resetToken(request); //// �1�7�1�9�2�3 �3�3�8�9 �5�7�5�3�7�3�3�5 �4�1�8�5�6�1 �6�3�9�9. �3�6�1�6�3�9�4�0�2�7 �3�1�3�5 if�0�1�2�3 �7�5�0�5�7�5 �6�9�8�5 �3�1�6�5.

			input.put("gubun", "C");
			input.put("lvlnum", "22");
			DataSet ksps2000_10 = manager.findKsps2000(input);
			
			
			
			////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
			try
			{
				
				/*�2�2�0�7�7�9�1�9�4�9�9�3*/
															   /*
																* �2�0�9�7�3�1�8�6		1
																* �0�9�9�0�8�5�3�1�8�6		4
																* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																* �0�9�9�0�8�5�1�8�7�1		7
																* �1�5�6�7�0�1�2�1�8�8		6
																* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																* �2�0�9�7�1�8�6�5		2
																* APL�1�8�6�5		3 
																* �5�8�2�0�1�5�7�5 1		A
																* �5�8�2�0�1�5�7�5 2 	B
																* �5�8�2�0�1�5�7�5 3		C 
																* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																*/
																
																
				DataSet spinputp  = new DataSet();
				
				spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
				spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
				spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
				spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
				spinputp.put("sp_in_put",input.toString()); ////sp_in_put
				spinputp.put("sp_out_put",ksps2000_10.toString()); ////sp_out_put
				
				returns.findSpLogsave(spinputp);
						
			}catch(Exception e)
			{
			
				System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
			}
			
			////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
			
			
			

			errrtn = "";
			errrtn = ksps2000_10.getText("rtn",0);
			/*
			 * KSPS2000 errrtn �7�1�7�7�7�3 �1�7�0�2
			 *  �2�4�1�9 I �9�1�8�9 W �2�3 �9�7�6�3 �7�1�7�7 ***
				0 - �3�4�1�8
				1 - �8�5�5�3�2�7�0�1
			  ** �2�4�1�9 C �2�3 �9�7�6�3 �7�1�7�7 **********
				0 - �3�4�1�8
				1 - �8�5�5�3�2�7�0�1
				5 - �8�5�3�0�2�1�9�7�2�5 �4�9�0�5�3�6�3�7 �7�1�3�3 �3�9�3�9�6�3�9�9.
				6 - �2�7�8�3�8�9�3�9�0�9 �2�9�0�1�4�9�0�5 �9�1 �7�1�3�3 �3�9�3�9�6�3�9�9.
			 * */
			 
			message = "";

			////2006-09-07:�8�1�1�5�2�2:0601914:�2�2�3�7 �2�7�2�3 WEBDB�2�3�1�9 �3�3�0�3 �2�2�3�7 �9�1 �7�1�3�3 �2�3�8�9�3�1 �4�7�5�9�6�9�8�9 �1�5�1�9 �4�1�7�5
			inAppv.put("policy_apln_no", 	policy_apln_no);

			outAppv1 = manager.findAppvProcessStatus(inAppv);
			outAppv2 = manager.findAppvPaymentStatus(inAppv);

			String appv_cnt 	= outAppv1.getText("appv_cnt");////�1�8�5�1�4�9�9�3 �2�9�0�1 80�3�7 �7�1�3�3 0�3�1 �7�4�3�7
			String appv_rslt	= outAppv2.getText("rslt");////�7�1�7�7�4�9�9�3 �2�9�0�1 0�3�7 �7�1�3�3 0 �3�1 �7�4�3�7 , �6�1�3�9 �2�1�2�1�2�3�1�9�8�9 �1�7�3�0�6�9�8�9 �1�5�1�9�3�3 �2�3�3�3...

			
			if(errrtn.equals("0") || errrtn.equals("6")){  ////�3�4�1�8�3�7�7�4�3�7

////				�3�4�1�8�3�7 �7�4�3�7�2�3 WEBDB �2�2�3�7 �9�1 �7�1 �3�9�0�7 �4�7�5�9 �4�1�7�5
////				�0�3�3�1�0�4 �1�8�5�1�7�5 �7�1�3�9�2�1�4�0 �9�3�7�1�3�5 �5�5�0�9�1�7�2�1 �3�1�9�5 �2�3�0�7�4�9�0�5 �9�7�9�3�0�0 �6�5.
				if(!appv_cnt.equals("0")){
					////�4�9�0�5 �0�3�1�7�3�1

					message = "�8�5�2�2�3�7�9�1 �7�1 �3�3�7�7�8�1 �4�9�0�5�3�6�3�0�9�1�9�9. �6�2�3�7 �6�3 �4�9�0�5�6�7�3�5�1�7�3�9.";
					url = urlname;
					request.setAttribute("message", message);
					request.setAttribute("toURL", url);
					return mapping.findForward("alert");

				}else{

					//// 2007�8�3 5�3�3 23�3�1 �2�7�1�0�6�7 : �2�2�3�7�3�9�4�0 �2�7�3�2�2�7 22�4�9�9�3�0�7 �8�0�8�9�9�9.
					DataSet newSet = new DataSet();
					newSet.put("policy_apln_no", policy_apln_no);
					newSet.put("proc_emp_no", proc_emp_no);
					newSet.put("proc_status", "22");
					newSet.put("err_msg", message);
					DataSet rtnsave10 = returns.findRtnsave(newSet);

/* 2007�8�3 5�3�3 16�3�1 �2�7�1�0�6�7 1�3�1�6�3�9�3 1000�0�7�3�9�3�7�0�9 �2�1�3�4
					int cnt = ksps2000_10.getCount("procamt");
					if(cnt > 0)
					{
						for(int i =0; i<cnt; i++)
						{
							procamt1 = procamt1 + Integer.parseInt(ksps2000_10.getText("procamt",i));
						}
					}
*/
					//// WB_PAYMENT�2�3�1�9 �3�0�2�1�0�7�6�3�0�9 �6�3 ROW �7�3�1�6
					DataSet nameSet = new DataSet();
					nameSet.put("policy_apln_no", policy_apln_no);
					
					DataSet selPayment = manager.findRecei(nameSet);
					
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					////[20070220] 1. webdb�2�3�1�9 �2�7�8�3 �3�1�3�1�0�9 �8�9 �3�5�0�7�0�7�6�3�2�3 �9�7�6�7�1�9 �9�7�4�9�0�8�3�1 �8�9�2�2 �3�5�6�7�6�9�8�9 �7�6 �4�1�7�5
					////- �2�7�8�3 �4�9�0�5�7�1 �3�6 �7�1�3�9�2�9�0�1 �1�0�7�00�3�7 �7�6�3�5 mode:1(�3�1�8�6)/srvc_cd:1(�2�0�9�7�3�1�8�6)�3�7 �7�6 �3�5�6�7
					///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////S/
					DataSet procamt_input 	= new DataSet();
					procamt_input.put("mode", 		"1"); ////�3�1�8�6
					procamt_input.put("srvc_cd", 	selPayment.getText("srvc_cd")); ////�2�0�7�1�9�7�4�9, �9�4�9�4
					
					procamt_input.put("ssn", 		ssn);
					DataSet procamt_info 	= manager.getProcamtInfo(procamt_input);
					///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////E/

					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					////[20070220] 2. procamt_sum �7�1�1�1
					////- �8�5�3�1 �1�7�3�3�0�3�1�1�5�5 �2�0�7�1�9�7�4�9 �6�6 + �6�1�3�9 �2�1�4�0�8�5�2�2 = procamt_sum
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					int procamt_sum = 0;////�3�3�4�7�8�5�2�2(1000�0�7�3�9)
					int cnt = procamt_info.getCount("payor_ssn");

					if(cnt > 0){
						for(int i =0; i<cnt; i++){
							procamt_sum = procamt_sum + Integer.parseInt(procamt_info.getText("apln_amt",i));
						}
					}
					anyframe.log.Logger.debug.println(" (procamt_info - �3�5�6�7)----  applymoney  : "+Integer.parseInt(procamt) );
					anyframe.log.Logger.debug.println(" (procamt_info - �3�5�6�7)----  pay_amt  : "+procamt_sum );
					anyframe.log.Logger.debug.println(" (procamt_info - �3�5�6�7)----  procamt_sum  : "+procamt_sum );


					if(procamt_sum > 10000000)
					{
						message =  "1�3�1 �3�1�8�6�6�3�9�3 1000�0�7�3�9�3�5 �4�1�7�7�6�9�2�1  �1�3�7�5�8�6�6�6�9�1�9�9.";
						input.put("gubun", "W" );
						input.put("lvlnum", "30");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);

						DataSet ksps2000_30 = manager.findKsps2000(input);
						
						
						
						////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
						try
						{
				
							/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																		   /*
																			* �2�0�9�7�3�1�8�6		1
																			* �0�9�9�0�8�5�3�1�8�6		4
																			* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																			* �0�9�9�0�8�5�1�8�7�1		7
																			* �1�5�6�7�0�1�2�1�8�8		6
																			* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																			* �2�0�9�7�1�8�6�5		2
																			* APL�1�8�6�5		3 
																			* �5�8�2�0�1�5�7�5 1		A
																			* �5�8�2�0�1�5�7�5 2 	B
																			* �5�8�2�0�1�5�7�5 3		C 
																			* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																			*/
																
																
							DataSet spinputp  = new DataSet();
				
							spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
							spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
							spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
							spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
							spinputp.put("sp_in_put",input.toString()); ////sp_in_put
							spinputp.put("sp_out_put",ksps2000_30.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
						}
			
						////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
						
						
						
						
						////request.setAttribute("ksps2000_30", ksps2000_30);

						errrtn = "";
						errrtn = ksps2000_30.getText("rtn",0);

						////WEB �9�9�1�1�2�3 �0�5�2�2 �3�3�3�2
						if(errrtn.equals("0"))
						{
							input1.put("policy_apln_no", policy_apln_no);
							input1.put("proc_emp_no", proc_emp_no);
							input1.put("proc_status", "30");
							input1.put("err_msg", message);
							DataSet rtnsave8 = returns.findRtnsave(input1);

							input2.put("policy_apln_no", policy_apln_no);
							input2.put("proc_status", "1");
							input2.put("err_msg", message);
							input2.put("recon_id", proc_emp_no);
							DataSet rtnsave9 = returns.findRtnsave1(input2);

						}////WEB �9�9�1�1�2�3 �0�5�2�2 �3�3�3�2

								msg = message;
								url = urlname;
								request.setAttribute("message", msg);
								request.setAttribute("toURL", url);
								return mapping.findForward("alert");
					}
					else
					{
						////KSPS2000�2�5�6�8 2�4�7�7�1�3�9�2�9�0�1:22(�3�3�3�2)
						input.put("gubun", "W" );
						input.put("lvlnum", "22");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);

						DataSet ksps2000_22W = manager.findKsps2000(input);////�3�3�3�2
						
						
						
						////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
						try
						{
				
							/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																		   /*
																			* �2�0�9�7�3�1�8�6		1
																			* �0�9�9�0�8�5�3�1�8�6		4
																			* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																			* �0�9�9�0�8�5�1�8�7�1		7
																			* �1�5�6�7�0�1�2�1�8�8		6
																			* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																			* �2�0�9�7�1�8�6�5		2
																			* APL�1�8�6�5		3 
																			* �5�8�2�0�1�5�7�5 1		A
																			* �5�8�2�0�1�5�7�5 2 	B
																			* �5�8�2�0�1�5�7�5 3		C 
																			* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																			*/
																
																
							DataSet spinputp  = new DataSet();
				
							spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
							spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
							spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
							spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
							spinputp.put("sp_in_put",input.toString()); ////sp_in_put
							spinputp.put("sp_out_put",ksps2000_22W.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
						}
			
						////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
						
						
						
						String rtn22 = ksps2000_22W.getText("rtn").trim();

						errrtn = "";
						errrtn = ksps2000_22W.getText("rtn",0);
						if(errrtn.equals("0"))
						{
							/*
							 *		2007�8�3 5�3�3 23 �2�7�1�0�6�7 : �2�2�3�7�3�9�4�0 �2�7�3�2�2�7 22�0�9 �0�1�8�5�3�5�0�7�0�9 insert �6�9�3�1 �2�9�3�3. WEBDB.CYBER�3�5 PROCESS �5�3�3�3�1�3.. 
							
														input1.put("policy_apln_no", policy_apln_no);
														input1.put("proc_emp_no", proc_emp_no);
														input1.put("proc_status", "21");
														input1.put("err_msg", message);
														DataSet rtnsave10 = returns.findRtnsave(input1);
							*/
							input2.put("policy_apln_no", policy_apln_no);
							input2.put("proc_status", "A");
							input2.put("err_msg", message);
							input2.put("recon_id", proc_emp_no);
							DataSet rtnsave11 = returns.findRtnsave1(input2);

							////2006-12-27 �8�1�1�5�2�2 : M0181SP1�3�5 �4�9�0�5�6�9�8�5 �3�7�2�3 �3�1�6�8�4�9�0�5 �1�5�8�9�9�9�8�9 40�0�7 CODE�0�7 �1�6�5�4�6�7�3�9�9�9.
							////KSPS2000�2�5�6�8 �3�1�6�8�4�9�0�5�3�7�2�2�1�8�5�1:40(�3�3�3�2)
							input.put("gubun", "W" );
							input.put("lvlnum", "40");
							input.put("cltbk", cltbk);
							input.put("cltact", cltact);
							input.put("cltnum", cltnum);
							input.put("procamt", procamt);

							////KSPS2000�2�5�6�8(�3�1�6�8�3�7�0�1�2�2�2�1:40)
							DataSet ksps2000_40 = manager.findKsps2000(input);
							
							
							////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
							try
							{
				
								/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																			   /*
																				* �2�0�9�7�3�1�8�6		1
																				* �0�9�9�0�8�5�3�1�8�6		4
																				* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																				* �0�9�9�0�8�5�1�8�7�1		7
																				* �1�5�6�7�0�1�2�1�8�8		6
																				* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																				* �2�0�9�7�1�8�6�5		2
																				* APL�1�8�6�5		3 
																				* �5�8�2�0�1�5�7�5 1		A
																				* �5�8�2�0�1�5�7�5 2 	B
																				* �5�8�2�0�1�5�7�5 3		C 
																				* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																				*/
																
																
								DataSet spinputp  = new DataSet();
				
								spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
								spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
								spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
								spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
								spinputp.put("sp_in_put",input.toString()); ////sp_in_put
								spinputp.put("sp_out_put",ksps2000_40.toString()); ////sp_out_put
				
								returns.findSpLogsave(spinputp);
						
							}catch(Exception e)
							{
			
								System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
							}
			
							////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
							
							
							
							
							errrtn = "";
							errrtn = ksps2000_40.getText("rtn");

							////WEBDB �3�3�3�2(�3�1�6�8�3�7�0�1�2�2�2�1:40)
							if(errrtn.equals("0")){
								input1.put("policy_apln_no", policy_apln_no);
								input1.put("proc_emp_no", proc_emp_no);
								input1.put("proc_status", "40");
								input1.put("err_msg", message);
								DataSet rtnsave10_40 = returns.findRtnsave(input1);  ////CYBER_TBL_wb_process �1�8�5�1�7�3 �3�0�0�4.

								////�2�1�8�5�2�3�1�9 �1�5�5�5 �2�2�3�7�3�5 �0�8�2�3�3�5�9�5 �1�9�7�4�3�4�3�7 M0181SP1�3�5 �2�5�6�8�6�3�9�9.
								input3.put("deptcd", "INT");
								input3.put("init", tproc_emp_no);
								input3.put("opt1", opt1);
								input3.put("opt2", "U");
								input3.put("policy", policy);

								//// [05-B-353] 2005-08-22 �3�3�3�1�6�8. regdate �3�4�1�8�3�4�3�7�0�9 �8�9�2�5�2�7�3�1�2�9�2�3 indate�0�9 �9�7�4�7
								input3.put("regdate", indate);
								input3.put("paydate", to_year);
								input3.put("cash", cash);
								input3.put("prmsusp", "00000000000");
								input3.put("susp", "00000000000");
								input3.put("plpay", cash);
								input3.put("tax", "00000000000");
								input3.put("sndseq", "      ");
								input3.put("bnkclt", bnkclt);
								input3.put("bnkcode", bnkcode);
								input3.put("bnkacct", bnkacct);
								input3.put("agency", "   ");

								input4.put("policy_apln_no", policy_apln_no);
								input5.put("proc_emp_no", proc_emp_no);
								input5.put("variable_div", variable_div);
								System.out.println("�1�3�2�2�9�7�4�9�3�6 �7�6�3�1�4�9�0�5 �3�1�7�4�3�7 �7�3 : [" + variable_div + "]");

								anyframe.log.Logger.debug.println("Action M0181SP1  input3==========="+input3);
								DataSet approval = Pmanager.getApproval(input3, input4, input5);////�7�1�3�9,policy_apln_no,proc_emp_no




////								sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
										  try
										  {
				
											  /*�2�2�0�7�7�9�1�9�4�9�9�3*/
																							 /*
																							  * �2�0�9�7�3�1�8�6		1
																							  * �0�9�9�0�8�5�3�1�8�6		4
																							  * �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																							  * �0�9�9�0�8�5�1�8�7�1		7
																							  * �1�5�6�7�0�1�2�1�8�8		6
																							  * �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																							  * �2�0�9�7�1�8�6�5		2
																							  * APL�1�8�6�5		3 
																							  * �5�8�2�0�1�5�7�5 1		A
																							  * �5�8�2�0�1�5�7�5 2 	B
																							  * �5�8�2�0�1�5�7�5 3		C 
																							  * �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																							  */
											 					
																
											  DataSet spinputp  = new DataSet();
				
											  spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
											  spinputp.put("sp_nm","M0181SP1"); ////sp�0�2
											  spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
											  spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
											  spinputp.put("sp_in_put",input3.toString()); ////sp_in_put
											  spinputp.put("sp_out_put",approval.toString()); ////sp_out_put
				
											  returns.findSpLogsave(spinputp);
						
										  }catch(Exception e)
										  {
			
											  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
										  }
			
										  ////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
										  
										  
										  
								sending_num = approval.getText("sndseq");////�3�7�2�2�0�7�6�3
								input9.put("policy_apln_no", policy_apln_no);
								input9.put("sending_num", sending_num);
								input9.put("pay_dt", Util.getTodayToYMD().substring(0,8));
								anyframe.log.Logger.debug.println("�3�1�2�5�3�3 �9�7�2�5�3�9�9�5 input�7�3�9�1==========="+input9);
								DataSet sending = manager.Sendingsave(input9);////�3�7�2�2�0�7�6�3 �3�3�3�2

								realpay.put("policy_apln_no", policy_apln_no);////�3�7�2�2�0�7�6�3
								////realpay.put("pay_amt", approval.getText("netpay"));////�2�5�3�1�8�6�8�5
								realpay.put("pay_amt", cash);

								errrtn = approval.getText("rtn");

								message1 = Util.superTrim(approval.getText("errmsg1")) + Util.superTrim(approval.getText("errmsg2")) + Util.superTrim(approval.getText("errmsg3"));

								//// 2007.5.15 �2�7�1�0�6�7
								//// �2�3�0�7 �0�3�1�7�3�1�3�6 AAAA�7�5 �5�5�6�5�9�1 �0�1�3�1�7�5 �3�3�3�5�7�4�3�7 SMS �0�9�2�2.
								anyframe.log.Logger.debug.println("�0�5�5�9 �4�9approval.getText(errmsg1)====>"+approval.getText("errmsg1"));
////								AAAA�5�3�2�1�5�7
////								approval.put("errmsg1", "DGAAAA�3�3�3�4�9�1�9�9.");
								if(Util.superTrim(approval.getText("errmsg1")).indexOf("AAAA") != -1) {
									System.out.println("########################## CybercenterAction.java AAAA �2�3�0�7�2�7 �0�9�3�2 �2�1�6�8 #############################");

									String srvc_gubunc = selPayment.getText("srvc_cd");
									String strGubun = "";
									if(srvc_gubunc.equals("1"))////�2�0�7�1�9�7�4�9�2�1�4�0
									{
										strGubun = "�2�0�7�1�9�7�4�9�2�1�4�0";
									}
									else if(srvc_gubunc.equals("2"))////�2�0�7�1�9�7�4�9�1�8�6�5
									{
										strGubun = "�2�0�7�1�9�7�4�9�1�8�6�5";
									}
									else if(srvc_gubunc.equals("3"))////�3�1�9�4�9�7�4�9�8�8�1�5�1�8�6�5
									{
										strGubun = "�3�1�9�4�9�7�4�9�8�8�1�5�1�8�6�5";
									}
									else if(srvc_gubunc.equals("4"))////�0�9�9�0�8�5
									{
										strGubun = "�0�9�9�0�8�5";
									}
									else if(srvc_gubunc.equals("5"))////�6�5�0�5�1�5�6�7�8�5
									{
										strGubun = "�6�5�0�5�1�5�6�7�8�5";
									}
									else if(srvc_gubunc.equals("6"))////�1�5�6�7�0�1�2�1�8�8
									{
										strGubun = "�1�5�6�7�0�1�2�1�8�8";
									}
									else if(srvc_gubunc.equals("7"))////�0�9�9�0�8�5�1�8�7�1
									{
										strGubun = "�0�9�9�0�8�5�1�8�7�1";
									}

									String payor_nm = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm"))); //// �7�9�7�4�0�2

									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// SMS �0�9�2�2
									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// �7�1�6�3 �3�5�6�7�2�3�1�9 �6�1�9�3�5�9 �2�1�2�1�3�3 �9�7�3�3�8�9 �0�7�9�7 �0�5�2�1�5�7�0�7 �7�5�3�9�2�3.
									DataSet smsSet = new DataSet();
									smsSet.put("page", "0");
									smsSet.put("where", " and hand_phone_yn = 'Y'");
									smsSet.put("subwhere", "");

									AuthManager managerSms = AuthManager.getInstance();
									DataSet authval = managerSms.findAuth(smsSet);

									anyframe.log.Logger.debug.println("�7�9�7�4�0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3 strGubun : "+strGubun);

									//// SMS �0�9�2�2
									for(int i=0;i<authval.getCount("emp_no");i++) {

										//// ex) �1�7�3�3�0�3 �3�3�3�6�3�1�8�6 �6�2�3�7�3�9�0�4 100500000 �6�4�8�3�9�4, �2�0�7�1�9�7�4�9 (or�6�7�2�0, �6�5�0�5) 00000�3�9 [�3�1�5�3�3�9�1�7�3�3�0�3]�2�2�3�7�3�9�4�0�3�6 AAAA�7�5 �0�9�7�7�9�7�2�5�2�8�9�1�9�9.");" +
										String strMsg = "[�3�1�5�3�3�9�1�7�3�3�0�3]�3�3�3�6�3�1�8�6�6�2�3�7" + policy + payor_nm + " " + strGubun + Integer.parseInt(procamt) + "�3�9 AAAA�0�9�7�7";

										DataSet sendSmsInput = new DataSet();
										sendSmsInput.put("RECEIVER_MOBILE", authval.getText("hand_phone", i));
										sendSmsInput.put("CUS_CALL_BACK",   "15883374");
										sendSmsInput.put("CUS_MSG",         strMsg);
										sendSmsInput.put("TRAN_ETC1",       to_year);
										sendSmsInput.put("TRAN_ETC2",       "");
										sendSmsInput.put("TRAN_ETC3",       "CU");
										
										
										////2007.06.14 �4�1�7�5....
										/*�2�2�0�7�7�9�1�9�4�9�9�3*/
												   /*
													* �2�0�9�7�3�1�8�6		1
													* �0�9�9�0�8�5�3�1�8�6		4
													* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
													* �0�9�9�0�8�5�1�8�7�1		7
													* �1�5�6�7�0�1�2�1�8�8		6
													* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
													* �2�0�9�7�1�8�6�5		2
													* APL�1�8�6�5		3 
													* �5�8�2�0�1�5�7�5 1		A
													* �5�8�2�0�1�5�7�5 2 	B
													* �5�8�2�0�1�5�7�5 3		C 
													* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
													*/
										sendSmsInput.put("srvc_cd", srvc_gubunc);  ////�2�2�0�7�4�9�9�3
            
										sendSmsInput.put("policy_no", policy); ////�3�6�7�1�0�7�6�3
										sendSmsInput.put("tran_ssn",authval.getText("emp_no", i)); ////�4�9�0�5�2�1�4�0�3�1�3�5�0�7�0�6�1�7�0�7
										sendSmsInput.put("tran_nm",authval.getText("emp_nm", i));  ////�4�9�0�5�2�1�4�0�3�1�1�0�0�2 

										manager2.sendSimpleSms(sendSmsInput);
									}

									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// �3�3�0�3�3�1 �0�9�2�2
									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// �7�1�6�3 �3�5�6�7�2�3�1�9 �3�3�0�3�3�1 �2�1�2�1�3�3 �9�7�3�3�8�9 �0�7�9�7 �0�5�2�1�5�7�0�7 �7�5�3�9�2�3.
									smsSet = new DataSet();
									smsSet.put("page", "0");
									smsSet.put("where", " and email_yn = 'Y'");
									smsSet.put("subwhere", "");

									authval = managerSms.findAuth(smsSet);

									////�3�3�0�3�3�1 �0�9�2�2
									for(int i=0;i<authval.getCount("emp_no");i++) {
										//// ex) �1�7�3�3�0�3 �3�3�3�6�3�1�8�6 �6�2�3�7�3�9�0�4 100500000 �6�4�8�3�9�4, �2�0�7�1�9�7�4�9 (or�6�7�2�0, �6�5�0�5) 00000�3�9 [�3�1�5�3�3�9�1�7�3�3�0�3]�2�2�3�7�3�9�4�0�3�6 AAAA�7�5 �0�9�7�7�9�7�2�5�2�8�9�1�9�9.");" +
										String strSubject = policy + " " + payor_nm + ", " + strGubun + " " + Integer.parseInt(procamt) + "�3�9 [�3�1�5�3�3�9�1�7�3�3�0�3]�2�2�3�7�3�9�4�0�3�6 AAAA�7�5 �0�9�7�7�9�7�2�5�2�8�9�1�9�9.";
										//// ex)
										////	�1�7�3�3�0�3 �3�3�3�6�3�1�8�6 �7�5�8�6�1�0 �3�3�3�7�9�1 �6�2�3�7 �0�1�9�2�9�1�9�9.
										////	�3�6�0�7 : 100500000
										////	�7�1�2�0�3�1�0�2 : �6�4�8�3�9�4
										////	�2�0�7�1�9�7�4�9 (or �6�7�2�0, �6�5�0�5) 00000�3�9
										////	�4�9�0�5�3�1 : OOO
										////	�4�9�0�5�2�7�7�9 OO:OO:OO

										String strContent = strSubject + "|" + "�1�7�3�3�0�3 �3�3�3�6�3�1�8�6 �7�5�8�6�1�0 �3�3�3�7�9�1 �6�2�3�7 �0�1�9�2�9�1�9�9. <br>"
																	+ "�3�6�0�7 : " + policy + "<br>"
																	+ "�7�1�2�0�3�1�0�2 : " + payor_nm + "<br>"
																	+ strGubun + " : " + Integer.parseInt(procamt) + "�3�9<br>"
																	+ "�4�9�0�5�3�1 : " + authval.getText("emp_nm", i) + "<br>"
																	+ "�4�9�0�5�2�7�7�9 : " + gtone.changeminer.common.utility.Utility.getToday();

										DataSet emailSet = new DataSet();
										////�0�3�3�1�1�5�8�9�8�5(�7�9�7�4)
										emailSet.put("param1", "05");
										////emailSet.put("param2", "12"); //// �7�3�0�9
										emailSet.put("param2", "01"); //// �2�5�1�9�0�3
										emailSet.put("param3", "00000029");
										emailSet.put("to_name", authval.getText("emp_nm", i));//// �3�3�0�5
										emailSet.put("to_email_addr", authval.getText("email", i));//// �3�3�0�3�3�1
										emailSet.put("content", strContent); //// �8�9�3�0





										anyframe.log.Logger.debug.println("�7�9�7�4�0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3 CyberAction Input : "+emailSet);
										DataSet mailcu = mailsend.sendSimpleMail(emailSet);
									}

									////�7�9�7�4�2�3�7�5 �0�5�2�2�1�7�3�9 �0�1�3�1 �1�5�8�9�8�5 �2�9�0�1
								}

								if(errrtn.equals("0"))
								{
									DataSet netpay = manager.Realpaysave(realpay);////�2�5�3�1�8�6�8�5�3�3�3�2

									////KSPS2000 �2�5�6�8(�3�1�6�8,HOST�4�9�0�5�1�0�7�0 :80)
									input.put("gubun", "W" );
									input.put("lvlnum", "80");
									input.put("cltbk", cltbk);
									input.put("cltact", cltact);
									input.put("cltnum", cltnum);
									input.put("procamt", procamt);
									DataSet ksps2000_80 = manager.findKsps2000(input);
									
									
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
									try
									{
				
										/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																					   /*
																						* �2�0�9�7�3�1�8�6		1
																						* �0�9�9�0�8�5�3�1�8�6		4
																						* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																						* �0�9�9�0�8�5�1�8�7�1		7
																						* �1�5�6�7�0�1�2�1�8�8		6
																						* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																						* �2�0�9�7�1�8�6�5		2
																						* APL�1�8�6�5		3 
																						* �5�8�2�0�1�5�7�5 1		A
																						* �5�8�2�0�1�5�7�5 2 	B
																						* �5�8�2�0�1�5�7�5 3		C 
																						* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
										spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
										spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
										spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
									}
			
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
									
									
									
									message = "�3�4�1�8�3�4�3�7�0�9 �2�2�3�7�9�7�2�5�2�8�9�1�9�9.";

									////WEB DB�3�3�3�2(�3�1�6�8-HOST�4�9�0�5�1�0�7�0 80)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "80");
									input1.put("err_msg", message1);
									DataSet rtnsave12 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "0");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave13 = returns.findRtnsave1(input2);

									////WB_PAYMENT�2�3�1�9 �3�0�2�1�0�7�6�3�0�7 �5�5�7�3�3�7�0�9 �6�7�9�0 �3�1�0�1�0�7 Search
									input11.put("policy_apln_no", policy_apln_no);

									selPayment = manager.findRecei(input11);

									String payor_nm = Util.superTrim(selPayment.getText("payor_nm").trim());
									String v_to_mail = selPayment.getText("payor_email");
									String mapping1 = "";
									String apln_dt = selPayment.getText("apln_dt").substring(0,10);
									apln_dt = StringFormater.removeZero(apln_dt.substring(0,4)) +" �8�3 " + StringFormater.removeZero(apln_dt.substring(5,7)) +" �3�3 "+ StringFormater.removeZero(apln_dt.substring(8,10)) +" �3�1";

									to_year = null;
									v_toyear = Util.getTodayToYMD();
									to_year = v_toyear.substring(0,8);
									String pay_dt  = "";
									pay_dt = to_year;
									if(pay_dt.length() == 8)
									{
										pay_dt = StringFormater.removeZero(pay_dt.substring(0,4)) + " �8�3 "+ StringFormater.removeZero(pay_dt.substring(4,6)) +" �3�3 "+ StringFormater.removeZero(pay_dt.substring(6,8)) +" �3�1";
									}
									String apln_amt = "";
									apln_amt = selPayment.getText("apln_amt");
									apln_amt = selPayment.getText("apln_amt");
									apln_amt = Util.addComma(apln_amt);
									mapping1 = payor_nm +"|"+ selPayment.getText("srvc_name") +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+ apln_dt+"|"+pay_dt+"|"+apln_amt + "�3�9" +"|"+ selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";

									anyframe.log.Logger.debug.println("�7�9�7�4�2�3�7�5 �0�3�3�1�1�5�8�9�8�5 �3�1�6�3 CyberAction�3�9");
									////�0�3�3�1�1�5�8�9�8�5(�7�9�7�4)
									input10.put("v_mail_type", "03");
									input10.put("v_mail_type_seq", Variable.get("email-id.cyber03"));////54
									input10.put("v_channel_code", "00000030");
									input10.put("v_member_id", cltnum);////�7�9�7�4�3�5�0�7�0�7�6�3
									input10.put("v_to_name", payor_nm);////�7�9�7�4�0�2
									input10.put("v_to_email",  selPayment.getText("payor_email"));////�7�9�7�4�3�3�0�3�3�1

									input10.put("v_mapping", mapping1);
									input10.put("v_lp_code", selPayment.getText("lp_id"));
									input10.put("v_policy_number", selPayment.getText("policy_no"));
									input10.put("v_channel", "cyber");
									input10.put("v_ilips_client_id", "");

									anyframe.log.Logger.debug.println("�7�9�7�4�0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3 CyberAction Input : "+input10);
									DataSet mailcu = mailsend.sendMail(input10);
									request.setAttribute("mailcu",mailcu);
									anyframe.log.Logger.debug.println("�7�9�7�4�0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3 CyberAction output : "+mailcu);



									////LP�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5
									anyframe.log.Logger.debug.println("LP�2�3�7�5 �0�3�3�1�1�5�8�9�8�5 �3�1�6�3 CyberAction�3�9");
									input10.put("v_mail_type", "03");
									input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
									input10.put("v_channel_code", "00000030");
									input10.put("v_member_id", cltnum);

									input10.put("v_to_email", selPayment.getText("lp_email"));
									mapping1 = "";
									String lpname = "";
									lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname").trim()));
									mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
									input10.put("v_mapping", mapping1);

									anyframe.log.Logger.debug.println("LP�0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3 CyberAction Input : "+input10);
									input10.put("v_lp_code", selPayment.getText("lp_id"));
									DataSet maillp = mailsend.sendMail(input10);
									request.setAttribute("maillp",maillp);
									anyframe.log.Logger.debug.println("LP�0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3 CyberAction output : "+maillp);



									anyframe.log.Logger.debug.println("�7�9�7�4�2�3�7�5 SMS �1�5�8�9�8�5 �3�1�6�3 �6�9�9�31 CyberAction");
									////�7�9�7�4�2�3�7�5 SMS�1�5�8�9�8�5
									String owner_mobile  	= selPayment.getText("payor_phone");////�6�1�9�3�5�9
									String lp_code       	= "";////LP�1�7�0�7
									String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////�8�5�2�2
									String gubun1         = selPayment.getText("pay_cd");////�1�8�6�5�7�9�1�9
									String sms_code = "";
									String srvc_gubunc = "";
									String owner = "";
									owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));

									srvc_gubunc = selPayment.getText("srvc_cd");
									if(srvc_gubunc.equals("1"))////�2�0�7�1�9�7�4�9�2�1�4�0
									{
										sms_code = "5";
									}
									else if(srvc_gubunc.equals("2"))////�2�0�7�1�9�7�4�9�1�8�6�5
									{
										sms_code = "9";
									}
									else if(srvc_gubunc.equals("3"))////�3�1�9�4�9�7�4�9�8�8�1�5�1�8�6�5
									{
										sms_code = "11";
									}
									else if(srvc_gubunc.equals("4"))////�0�9�9�0�8�5
									{
										sms_code = "6";
									}
									else if(srvc_gubunc.equals("5"))////�6�5�0�5�1�5�6�7�8�5
									{
										sms_code = "25";
									}
									else if(srvc_gubunc.equals("6"))////�1�5�6�7�0�1�2�1�8�8
									{
										sms_code = "8";
									}
									else if(srvc_gubunc.equals("7"))////�0�9�9�0�8�5�1�8�7�1
									{
										sms_code = "7";
									}


////									/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SMS�0�9�2�2
									String indate1 = "";
									indate1 = selPayment.getText("policy_apln_no").substring(0,8);

									smscu.put("v_sms_code",  		sms_code);////SMS �0�3�2�7�3�1 �2�2�0�7�4�9�9�3
									smscu.put("v_success_yn",  	"0");////0-�1�0�7�0,1-�2�5�5�9
									smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
									smscu.put("v_name",  			owner);
									smscu.put("v_owner",  		owner);
									smscu.put("v_owner_mobile",  	owner_mobile);
									smscu.put("v_lp_code",  		lp_code);
									smscu.put("v_amt",  			amt);
									smscu.put("v_gubun",  		gubun1);

									smscu.put("tran_etc1",  		indate1);////�3�0�0�4�8�9�3�9
									smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));////�2�5�3�9 �2�5�0�7
									smscu.put("v_pr",  			"CU");
									anyframe.log.Logger.debug.println("�7�9�7�4�2�3�7�5 SMS �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3 CyberAction input==>"+smscu);
									
									
									
									
									
									
									
									
									DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU�0�7
									anyframe.log.Logger.debug.println("�7�9�7�4�2�3�7�5 SMS �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3 CyberAction output==>"+sms_ins_cu);

									////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
									message = "�3�4�1�8�3�4�3�7�0�9 �2�2�3�7�9�7�2�5�2�8�9�1�9�9.";
									msg = message;
											url = urlname;
											request.setAttribute("message", msg);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");

								}
								else if(errrtn.equals("3"))
								{
									input.put("gubun", "W" );
									input.put("lvlnum", "50");
									input.put("cltbk", cltbk);
									input.put("cltact", cltact);
									input.put("cltnum", cltnum);
									input.put("procamt", procamt);
									DataSet ksps2000_50 = manager.findKsps2000(input);
									
									
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
									try
									{
				
										/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																					   /*
																						* �2�0�9�7�3�1�8�6		1
																						* �0�9�9�0�8�5�3�1�8�6		4
																						* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																						* �0�9�9�0�8�5�1�8�7�1		7
																						* �1�5�6�7�0�1�2�1�8�8		6
																						* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																						* �2�0�9�7�1�8�6�5		2
																						* APL�1�8�6�5		3 
																						* �5�8�2�0�1�5�7�5 1		A
																						* �5�8�2�0�1�5�7�5 2 	B
																						* �5�8�2�0�1�5�7�5 3		C 
																						* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
										spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
										spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
										spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_50.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
									}
			
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
									
									
									
									message = "�3�1�6�8�4�9�0�5 �3�1�2�5�3�0�9�1�9�9. �3�1�3�4�2�7�7�9�6�3 �9�9�2�7 �6�2�3�7�6�9�1�7�3�9.";

									////WEB DB�3�3�3�2(�3�1�6�8-HOST�4�9�0�5 �3�1�2�5 50)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "50");
									input1.put("err_msg", message1);
									DataSet rtnsave14 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "3");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave15 = returns.findRtnsave1(input2);

									////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
									message = "�3�1�6�8�4�9�0�5 �3�1�2�5�3�0�9�1�9�9. �3�1�3�4�2�7�7�9�6�3 �9�9�2�7 �6�2�3�7�6�9�1�7�3�9.";
									msg = message;
											url = urlname;
											request.setAttribute("message", message1);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}
								else if(errrtn.equals("1") || errrtn.equals("2"))
								{
									input.put("gubun", "W" );
									input.put("lvlnum", "99");
									input.put("cltbk", cltbk);
									input.put("cltact", cltact);
									input.put("cltnum", cltnum);
									input.put("procamt", procamt);
									DataSet ksps2000_80 = manager.findKsps2000(input);
									
									
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
									try
									{
				
										/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																					   /*
																						* �2�0�9�7�3�1�8�6		1
																						* �0�9�9�0�8�5�3�1�8�6		4
																						* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																						* �0�9�9�0�8�5�1�8�7�1		7
																						* �1�5�6�7�0�1�2�1�8�8		6
																						* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																						* �2�0�9�7�1�8�6�5		2
																						* APL�1�8�6�5		3 
																						* �5�8�2�0�1�5�7�5 1		A
																						* �5�8�2�0�1�5�7�5 2 	B
																						* �5�8�2�0�1�5�7�5 3		C 
																						* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
										spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
										spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
										spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
									}
			
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
									
									
									
									
									message = "�3�1�6�8�4�9�0�5 �3�7,�6�3 �2�3�0�7�3�0�9�1�9�9. �7�1�0�5�3�1 �6�2�3�7 �6�9�3�9�6�6�9�1�9�9.";
									////WEB DB�3�3�3�2(�8�5�5�3 �2�7�0�1 -99)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "99");
									input1.put("err_msg", message1);
									DataSet rtnsave16 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "2");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave17 = returns.findRtnsave1(input2);

									////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
									message = "�3�1�6�8�4�9�0�5 �3�7,�6�3 �2�3�0�7�3�0�9�1�9�9. �7�1�0�5�3�1 �6�2�3�7 �6�9�3�9�6�6�9�1�9�9.";
									msg = message;
											url = urlname;
											request.setAttribute("message", message1);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}
								else if(errrtn.equals("4"))
								{
									input.put("gubun", "W" );
									input.put("lvlnum", "61");
									input.put("cltbk", cltbk);
									input.put("cltact", cltact);
									input.put("cltnum", cltnum);
									input.put("procamt", procamt);
									DataSet ksps2000_80 = manager.findKsps2000(input);
									
									
									
									
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
									try
									{
				
										/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																					   /*
																						* �2�0�9�7�3�1�8�6		1
																						* �0�9�9�0�8�5�3�1�8�6		4
																						* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																						* �0�9�9�0�8�5�1�8�7�1		7
																						* �1�5�6�7�0�1�2�1�8�8		6
																						* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																						* �2�0�9�7�1�8�6�5		2
																						* APL�1�8�6�5		3 
																						* �5�8�2�0�1�5�7�5 1		A
																						* �5�8�2�0�1�5�7�5 2 	B
																						* �5�8�2�0�1�5�7�5 3		C 
																						* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
										spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
										spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
										spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
									}
			
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
									
									
									
									
									
									
									
									
									message = "�6�7�9�0�3�9�4�0�3�5 �3�1�6�8�4�9�0�5 �2�5�5�9�3�0�9�1�9�9. �3�5�7�9�6�2�3�7�0�6 �3�9�2�5�6�8�6�9�1�7�3�9.";

									////WEB DB�3�3�3�2(�3�1�6�8�4�9�0�5�7�1�7�7 �2�5�5�9-61)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "61");
									input1.put("err_msg", message1);
									DataSet rtnsave18 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "1");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave19 = returns.findRtnsave1(input2);

									////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1

									msg = message;
											url = urlname;
											request.setAttribute("message", message1);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}
								else if(errrtn.equals("5"))
								{
									input.put("gubun", "W" );
									input.put("lvlnum", "70");
									input.put("cltbk", cltbk);
									input.put("cltact", cltact);
									input.put("cltnum", cltnum);
									input.put("procamt", procamt);
									DataSet ksps2000_70 = manager.findKsps2000(input);
									
									
									
									
									
									
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
									try
									{
				
										/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																					   /*
																						* �2�0�9�7�3�1�8�6		1
																						* �0�9�9�0�8�5�3�1�8�6		4
																						* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																						* �0�9�9�0�8�5�1�8�7�1		7
																						* �1�5�6�7�0�1�2�1�8�8		6
																						* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																						* �2�0�9�7�1�8�6�5		2
																						* APL�1�8�6�5		3 
																						* �5�8�2�0�1�5�7�5 1		A
																						* �5�8�2�0�1�5�7�5 2 	B
																						* �5�8�2�0�1�5�7�5 3		C 
																						* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																						*/
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
										spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
										spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
										spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_70.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
									}
			
									////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
									
									
									
									
									message = "HOST �4�9�0�5 �2�5�5�9�3�0�9�1�9�9. �7�1�0�5�3�1�2�3�7�5 �0�1�3�5�6�9�1�7�3�9.";

									////WEB DB�3�3�3�2(�3�1�6�8�1�0�7�0+HOST�2�5�5�9)
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "70");
									input1.put("err_msg", message1);
									DataSet rtnsave20 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "2");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave21 = returns.findRtnsave1(input2);

									////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1

									msg = message;
											url = urlname;
											request.setAttribute("message", message1);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}


							}////KSPS2000�2�3�1�9 (�3�1�6�8�3�7�0�1�2�2�2�1:40)�7�1�7�7 �4�7�5�9
						
						}////KSPS2000�2�3�1�9 22�0�9 �3�3�3�2�6�7�9�5 �0�5�5�9�7�3�3�3 0�3�3�3�1�3�5 �7�4�3�7
					
					}////�2�0�7�1�9�7�4�9�8�5�2�2�3�3 1000�0�7�3�9�1�5�9�9 �3�4�3�5�7�4�3�7
				
				}////�3�3�0�3 �2�2�3�7�9�1 �7�1�7�7�7�5 �3�3�8�9 �7�4�3�7
			
			}////RTN�3�3 0�7�7 6�3�7�7�4�3�7
			else if(errrtn.equals("5") || errrtn.equals("1"))
			{
				if(errrtn.equals("5"))
					message = "�8�5�3�0�2�1�9�7�2�5 �4�9�0�5�3�6�3�7 �7�1�3�3 �3�9�3�9�6�6�9�1�9�9. �6�2�3�7�6�3 �7�1�3�1�3�9�4�0�6�9�1�7�3�9. ";
				else if(errrtn.equals("1"))
					message =  "�8�5�5�3�2�7�0�1�7�5 �0�9�1�6�6�9�2�1�2�8�9�1�9�9. �2�7�2�1�5�9 �7�3�0�9�3�1�2�3�7�5 �0�1�3�5�6�9�1�7�3�9.";
				input1.put("policy_apln_no", policy_apln_no);
				input1.put("proc_emp_no", proc_emp_no);
				input1.put("proc_status", "1");
				input1.put("err_msg", message);
				DataSet rtnsave30 = returns.findRtnsave(input1);

				input2.put("policy_apln_no", policy_apln_no);
				input2.put("proc_status", "1");
				input2.put("err_msg", message);
				input2.put("recon_id", proc_emp_no);
				DataSet rtnsave31 = returns.findRtnsave1(input2);
				msg = message;
						url = urlname;
						request.setAttribute("message", msg);
						request.setAttribute("toURL", url);
						return mapping.findForward("alert");
			}
		}
		else if(process.equals("K"))////�3�1�2�5�7�1�3�7 �7�4�3�7 �4�9�0�5
		{
			input8.put("policy_apln_no", policy_apln_no);
			DataSet sendall = manager.findSend(input8);
			sendingnum = sendall.getText("sending_num");////�3�7�2�2�0�7�6�3
			date = sendall.getText("date");////�3�7�2�2�3�1�3�1

			//// [05-B-353] 2005-08-22 �3�3�3�1�6�8. �3�7�2�1�0�2 �2�7�0�1 �2�1�3�4
			input7.put("musera", "INTUSER");
			input7.put("snddate", date);
			input7.put("sndseq", sendingnum);

			anyframe.log.Logger.debug.println("�3�1�2�5�3�1�9�5 KSPS0450�3�1�9�5 INPUT�7�3�9�1�3�11111111====>"+input7);

			DataSet ksps0450 = manager.findIsaogong(input7);////KSPS0450�2�5�6�8

			rtn0450 = ksps0450.getText("rtn");
			message = ksps0450.getText("errmsg");
			if(rtn0450.equals("1") || rtn0450.equals("3"))
			{
				////message = "�5�5�0�9�8�9�9�9�2�5�6�8�3�6 �2�3�0�7�0�6 �3�1�2�5�7�1�3�0�9�1�9�9. �7�1�0�5�3�1�2�3�7�5 �0�1�3�5�6�9�1�7�3�9.";
				msg = message;
						url = urlname;
						request.setAttribute("message", msg);
						request.setAttribute("toURL", url);
						return mapping.findForward("alert");
			}
			else if(rtn0450.equals("4"))
			{
				input.put("gubun", "W" );
				input.put("lvlnum", "60");
				input.put("cltbk", cltbk);
				input.put("cltact", cltact);
				input.put("cltnum", cltnum);
				input.put("procamt", procamt);

				DataSet ksps2000_61 = manager.findKsps2000(input);
				
				
				
				
				
				////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
				try
				{
				
					/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																   /*
																	* �2�0�9�7�3�1�8�6		1
																	* �0�9�9�0�8�5�3�1�8�6		4
																	* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																	* �0�9�9�0�8�5�1�8�7�1		7
																	* �1�5�6�7�0�1�2�1�8�8		6
																	* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																	* �2�0�9�7�1�8�6�5		2
																	* APL�1�8�6�5		3 
																	* �5�8�2�0�1�5�7�5 1		A
																	* �5�8�2�0�1�5�7�5 2 	B
																	* �5�8�2�0�1�5�7�5 3		C 
																	* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																	*/
																
																
					DataSet spinputp  = new DataSet();
				
					spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
					spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
					spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
					spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
					spinputp.put("sp_in_put",input.toString()); ////sp_in_put
					spinputp.put("sp_out_put",ksps2000_61.toString()); ////sp_out_put
				
					returns.findSpLogsave(spinputp);
						
				}catch(Exception e)
				{
			
					System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
				}
			
				////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
				
				
				
				
				
				
				
				
				
				

				errrtn = "";
				errrtn = ksps2000_61.getText("rtn",0);
				message = ksps2000_61.getText("errmsg");
				if(errrtn.equals("0"))
				{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "60");
					input1.put("err_msg", message);
					DataSet rtnsavek0 = returns.findRtnsave(input1);  ////process �5�3�3�3�1�3 �3�3�3�2

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "2");
					input2.put("err_msg", message);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek1 = returns.findRtnsave1(input2); ////payment �5�3�3�3�1�3 �3�3�3�2
				}////WEB DB�3�3�3�2(�3�1�6�8�4�9�0�5�7�1�7�7 �2�5�5�9-61
			}////�3�1�6�8�2�5�5�9�2�3 �7�1�6�3�7�1
			else if(rtn0450.equals("0"))
			{
				////�2�1�8�5�2�3�1�9 �1�5�5�5 �2�2�3�7�3�5 �0�8�2�3�3�5�9�5 �1�9�7�4�3�4�3�7 M0181SP1�3�5 �2�5�6�8�6�3�9�9.
				input3.put("deptcd", "INT");
				input3.put("init", tproc_emp_no);
				input3.put("opt1", opt1);
				input3.put("opt2", "H");
				input3.put("policy", policy);
				//// [05-B-353] 2005-08-22 �3�3�3�1�6�8. regdate �3�4�1�8�3�4�3�7�0�9 �8�9�2�5�2�7�3�1�2�9�2�3 indate�0�9 �9�7�4�7
				input3.put("regdate", indate);
				input3.put("paydate", to_year);
				input3.put("cash", cash);
				input3.put("prmsusp", "00000000000");
				input3.put("susp", "00000000000");
				input3.put("plpay",cash);
				input3.put("tax", "00000000000");
				input3.put("sndseq", sendingnum);
				input3.put("bnkclt", bnkclt);
				input3.put("bnkcode", bnkcode);
				input3.put("bnkacct", bnkacct);
				input3.put("agency", "   ");

				input4.put("policy_apln_no", policy_apln_no);
				input5.put("proc_emp_no", proc_emp_no);

				anyframe.log.Logger.debug.println("�3�1�2�5�7�1�2�3 �9�7�6�3 M0181SP1  input3==========="+input3);
				DataSet approval5 = Pmanager.getApproval(input3, input4, input5);////�7�1�3�9,policy_apln_no,proc_emp_no


////				sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
						  try
						  {
				
							  /*�2�2�0�7�7�9�1�9�4�9�9�3*/
																			 /*
																			  * �2�0�9�7�3�1�8�6		1
																			  * �0�9�9�0�8�5�3�1�8�6		4
																			  * �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																			  * �0�9�9�0�8�5�1�8�7�1		7
																			  * �1�5�6�7�0�1�2�1�8�8		6
																			  * �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																			  * �2�0�9�7�1�8�6�5		2
																			  * APL�1�8�6�5		3 
																			  * �5�8�2�0�1�5�7�5 1		A
																			  * �5�8�2�0�1�5�7�5 2 	B
																			  * �5�8�2�0�1�5�7�5 3		C 
																			  * �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																			  */
											 					
																
							  DataSet spinputp  = new DataSet();
				
							  spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
							  spinputp.put("sp_nm","M0181SP1"); ////sp�0�2
							  spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
							  spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
							  spinputp.put("sp_in_put",input3.toString()); ////sp_in_put
							  spinputp.put("sp_out_put",approval5.toString()); ////sp_out_put
				
							  returns.findSpLogsave(spinputp);
						
						  }catch(Exception e)
						  {
			
							  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
						  }
			
						  ////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2


				realpay.put("policy_apln_no", policy_apln_no);////�3�7�2�2�0�7�6�3
				////realpay.put("pay_amt", approval5.getText("netpay"));////�2�5�3�1�8�6�8�5
				realpay.put("pay_amt", cash);

				errrtn = approval5.getText("rtn");
				message1 = Util.superTrim(approval5.getText("errmsg1")) + Util.superTrim(approval5.getText("errmsg2")) + Util.superTrim(approval5.getText("errmsg3"));

				if(errrtn.equals("0"))
				{
					DataSet netpay = manager.Realpaysave(realpay);////�2�5�3�1�8�6�8�5�3�3�3�2

					////KSPS2000 �2�5�6�8(�3�1�6�8,HOST�4�9�0�5�1�0�7�0 :80)
					input.put("gubun", "W" );
					input.put("lvlnum", "80");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_801 = manager.findKsps2000(input);
					
					
					
					
					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
					try
					{
				
						/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																	   /*
																		* �2�0�9�7�3�1�8�6		1
																		* �0�9�9�0�8�5�3�1�8�6		4
																		* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																		* �0�9�9�0�8�5�1�8�7�1		7
																		* �1�5�6�7�0�1�2�1�8�8		6
																		* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																		* �2�0�9�7�1�8�6�5		2
																		* APL�1�8�6�5		3 
																		* �5�8�2�0�1�5�7�5 1		A
																		* �5�8�2�0�1�5�7�5 2 	B
																		* �5�8�2�0�1�5�7�5 3		C 
																		* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																		*/
																
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
						spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
						spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
						spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_801.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
					}
			
					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
					

					

					////WEB DB�3�3�3�2(�3�1�6�8-HOST�4�9�0�5�1�0�7�0 80)
					message = "�3�4�1�8�3�4�3�7�0�9 �2�2�3�7�9�7�2�5�2�8�9�1�9�9.";
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "80");
					input1.put("err_msg", message1);
					DataSet rtnsavek4 = returns.findRtnsave(input1);

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "0");
					input2.put("err_msg", message1);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek5 = returns.findRtnsave1(input2);


					////WB_PAYMENT�2�3�1�9 �3�0�2�1�0�7�6�3�0�7 �5�5�7�3�3�7�0�9 �6�7�9�0 �3�1�0�1�0�7 Search
					input11.put("policy_apln_no", policy_apln_no);

					DataSet selPayment = manager.findRecei(input11);

					String payor_nm = selPayment.getText("payor_nm");
					String v_to_mail = selPayment.getText("payor_email");
					String mapping1 = "";
					String apln_dt = selPayment.getText("apln_dt").substring(0,10);
					apln_dt = StringFormater.removeZero(apln_dt.substring(0,4)) +" �8�3 " + StringFormater.removeZero(apln_dt.substring(5,7)) +" �3�3 "+ StringFormater.removeZero(apln_dt.substring(8,10)) +" �3�1";

					to_year = null;
					v_toyear = Util.getTodayToYMD();
					to_year = v_toyear.substring(0,8);
					String pay_dt  = "";
					pay_dt = to_year;
					if(pay_dt.length() == 8)
					{
						pay_dt = StringFormater.removeZero(pay_dt.substring(0,4)) + " �8�3 "+ StringFormater.removeZero(pay_dt.substring(4,6)) +" �3�3 "+ StringFormater.removeZero(pay_dt.substring(6,8)) +" �3�1";
					}
					String apln_amt = "";
					apln_amt = selPayment.getText("apln_amt");
					apln_amt = Util.addComma(apln_amt);
					mapping1 = payor_nm +"|"+ selPayment.getText("srvc_name") +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+ apln_dt+"|"+pay_dt+"|"+apln_amt + "�3�9" +"|"+ selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";

					////�0�3�3�1�1�5�8�9�8�5(�7�9�7�4)
					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber03"));////54
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);////�7�9�7�4�3�5�0�7�0�7�6�3
					input10.put("v_to_name", payor_nm);////�7�9�7�4�0�2
					input10.put("v_to_email",  selPayment.getText("payor_email"));////�7�9�7�4�3�3�0�3�3�1

					input10.put("v_mapping", mapping1);
					input10.put("v_lp_code", selPayment.getText("lp_id"));
					input10.put("v_policy_number", selPayment.getText("policy_no"));
					input10.put("v_channel", "cyber");
					input10.put("v_ilips_client_id", "");

					anyframe.log.Logger.debug.println("�0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3  : "+input10);
					DataSet mailcu = mailsend.sendMail(input10);
					request.setAttribute("mailcu",mailcu);

					////LP�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5

					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);

					input10.put("v_to_email", selPayment.getText("lp_email"));
					mapping1 = "";
					String lpname = "";
					lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
					mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
					input10.put("v_mapping", mapping1);

					anyframe.log.Logger.debug.println("LP�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3  : "+input10);
					input10.put("v_lp_code", selPayment.getText("lp_id"));
					DataSet maillp = mailsend.sendMail(input10);
					request.setAttribute("maillp",maillp);

					/*
					////SM�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5
					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);

					input10.put("v_to_email", selPayment.getText("sm_email"));

					mapping1 = "";
					String sm_name = "";
					////sm_name = selPayment.getText("sm_name");
					sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));

					mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
					input10.put("v_mapping", mapping1);

					anyframe.log.Logger.debug.println("SM�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3  : "+input10);
					input10.put("v_lp_code", selPayment.getText("sm_code"));
					DataSet mailsm = mailsend.sendMail(input10);
					request.setAttribute("mailsm",mailsm);
					*/

					////�7�9�7�4�2�3�7�5 SMS�1�5�8�9�8�5

					String owner_mobile  	= selPayment.getText("payor_phone");////�6�1�9�3�5�9
					String lp_code       	= "";////LP�1�7�0�7
					String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////�8�5�2�2
					String gubun1         	= selPayment.getText("pay_cd");////�1�8�6�5�7�9�1�9
					String sms_code = "";
					String srvc_gubunc = "";
					String owner = "";
					owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));

					srvc_gubunc = selPayment.getText("srvc_cd");
					if(srvc_gubunc.equals("1"))////�2�0�7�1�9�7�4�9�2�1�4�0
					{
						sms_code = "5";
					}
					else if(srvc_gubunc.equals("2"))////�2�0�7�1�9�7�4�9�1�8�6�5
					{
						sms_code = "9";
					}
					else if(srvc_gubunc.equals("3"))////�3�1�9�4�9�7�4�9�8�8�1�5�1�8�6�5
					{
						sms_code = "11";
					}
					else if(srvc_gubunc.equals("4"))////�0�9�9�0�8�5
					{
						sms_code = "6";
					}
					else if(srvc_gubunc.equals("5"))////�6�5�0�5�1�5�6�7�8�5
					{
						sms_code = "25";
					}
					else if(srvc_gubunc.equals("6"))////�1�5�6�7�0�1�2�1�8�8
					{
						sms_code = "8";
					}
					else if(srvc_gubunc.equals("7"))////�0�9�9�0�8�5�1�8�7�1
					{
						sms_code = "7";
					}


////					/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SMS�0�9�2�2

					String indate1 = "";
					indate1 = selPayment.getText("policy_apln_no").substring(0,8);

					smscu.put("v_sms_code",  		sms_code);////SMS �0�3�2�7�3�1 �2�2�0�7�4�9�9�3
					smscu.put("v_success_yn",  	"0");////0-�1�0�7�0,1-�2�5�5�9
					smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
					smscu.put("v_name",  			owner);
					smscu.put("v_owner",  		owner);
					smscu.put("v_owner_mobile",  	owner_mobile);
					smscu.put("v_lp_code",  		lp_code);
					smscu.put("v_amt",  			amt);
					smscu.put("v_gubun",  		gubun1);

					smscu.put("tran_etc1",  		indate1);////�3�0�0�4�8�9�3�9
					smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));////�2�5�3�9 �2�5�0�7
					smscu.put("v_pr",  			"CU");
					
					
					
					
					
					
					DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU�0�7


					////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
					message = "�3�4�1�8�3�4�3�7�0�9 �2�2�3�7�9�7�2�5�2�8�9�1�9�9.";
					msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");
				}
				else
				{
					////KSPS2000 �2�5�6�8(�2�5�5�9 :80)
					input.put("gubun", "W" );
					input.put("lvlnum", "70");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_801 = manager.findKsps2000(input);
					
					
					
					
					
					
					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
					try
					{
				
						/*�2�2�0�7�7�9�1�9�4�9�9�3*/
																	   /*
																		* �2�0�9�7�3�1�8�6		1
																		* �0�9�9�0�8�5�3�1�8�6		4
																		* �6�5�0�5�1�5�6�7�8�5�3�1�8�6	5
																		* �0�9�9�0�8�5�1�8�7�1		7
																		* �1�5�6�7�0�1�2�1�8�8		6
																		* �4�1�7�5�1�5�6�7�0�1�2�1�8�8	8
																		* �2�0�9�7�1�8�6�5		2
																		* APL�1�8�6�5		3 
																		* �5�8�2�0�1�5�7�5 1		A
																		* �5�8�2�0�1�5�7�5 2 	B
																		* �5�8�2�0�1�5�7�5 3		C 
																		* �1�1�0�1�0�7�6�3 �1�3�7�4     I          
																		*/
											 					
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd","1"); ////�4�9�0�5�2�2�0�7�4�9�9�3
						spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
						spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
						spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_801.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
					}
			
					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
					
					
					
					
					
					
					
					message = ksps2000_801.getText("err_msg");

					////WEB DB�3�3�3�2(�2�5�5�9 70)
					message = "�2�5�5�9�6�9�2�1�2�8�9�1�9�9. �7�1�0�5�3�1�2�3�7�5 �0�1�3�5�6�9�1�7�3�9.";
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "70");
					input1.put("err_msg", message1);
					DataSet rtnsavek4 = returns.findRtnsave(input1);

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "2");
					input2.put("err_msg", message1);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek5 = returns.findRtnsave1(input2);

					////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
					message = "�2�5�5�9�6�9�2�1�2�8�9�1�9�9. �7�1�0�5�3�1�2�3�7�5 �0�1�3�5�6�9�1�7�3�9.";
					msg = message;
							url = urlname;
							request.setAttribute("message", message1);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}
			}
		}
		/**************************************
		 * �3�3�3�2�2�7 ksps2000 �7�3�1�6 - E
		 ***************************************/

		saveToken(request);
		return doExecute(mapping, form, request, response);
	}

	/**
	 * CybercenterAction�5�7�9�3�2�1�0�7 �1�8�2�2�6�9�8�9 �5�7�9�3�2�1�9�1�3�3 �7�9�6�1�6�7�2�9�6�7 �0�3�2�7�9�3.
	 */
	protected abstract ActionForward doExecute(ActionMapping mapping, ActionForm form,	HttpServletRequest request,	HttpServletResponse response)throws Exception;
}
