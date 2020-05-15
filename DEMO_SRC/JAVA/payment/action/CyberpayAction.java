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


////Comment
import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.utility.*;

import java.util.*;////StringTokenizer
import anyframe.util.StringFormater;

////ksps2000
import gtone.changeminer.payment.form.RestingsearchForm;
import gtone.changeminer.payment.manager.CybercenterManager;
import gtone.changeminer.payment.manager.DividendinfoManager;
import gtone.changeminer.payment.manager.DividendoffsearchManager;
import gtone.changeminer.payment.manager.ReturnManager;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.RestingsearchManager;


////SMS
import gtone.changeminer.payment.manager.CyberSmsManager;

////Comment
import gtone.changeminer.receipt.manager.AuthManager;
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.common.utility.Variable;////prumail.xml

////Comment
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

public abstract class CyberpayAction extends Action
{


	/**
	 * ?Comment
	 * ?Comment
	 * ?Comment
	 */

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)throws Exception
	{

		/**************************************
		 *  ksps2000  - S
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
		DataSet smscu = new DataSet();
		DataSet realpay = new DataSet();
		DataSet inAppv   = new DataSet();
		DataSet	outAppv1 = new DataSet();
		DataSet	outAppv2 = new DataSet();



		String errrtn = "-1";
		String message = "";
		String message1 = "";
		String bankerr = "-1";

		String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");
		String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
		String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");

		////Comment
		SessionManager sessionManager = new SessionManager(request);
		String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		String emp_no = sessionManager.getString(Constant.SESSION_USERID);
		String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

		String proc_emp_no = emp_no;

		String deptcd  		= "INT";
		String init	   		= "     ";
		String gubun    	= "";
		String reqnum  	= "   ";
		String fromdt 		=    request.getParameter("indate")	== null ? "" : request.getParameter("indate");
		String policy	 	=    request.getParameter("policy")	== null ? "" : request.getParameter("policy");
		String procdt   		= "        ";
		String proctm   	= "      ";
		String inout 		= "OUT";
		String procgb	 	=    request.getParameter("procgb")	== null ? "" : request.getParameter("procgb");
		String returnurl  = request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");
		String urlname =  returnurl + "?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy;

		////	urlp = "/payment/pl_payment_search.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy;

		String lvlnum  		= "";
		String lvlbef   		= "  ";
		String mbkcd    	= "  ";
		String mbkact   	= "               ";
		String cltbk    		=  request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");
		String cltact   		= request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");
		String cltnum   	= request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");
		String procamt  	= request.getParameter("cash")	== null ? "" : request.getParameter("cash");
		String procno   	= "      ";
		String brltcd   		= "    ";

		////Comment
		String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");
		String tproc_emp_no = proc_emp_no.toUpperCase();
		String v_toyear = Util.getTodayToYMD();
		String  to_year = v_toyear.substring(0,8);

		init  = proc_emp_no;
		String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");
		String rcvdate = request.getParameter("rcvdate")	== null ? "" : request.getParameter("rcvdate");
		String regdate = request.getParameter("regdate")	== null ? "" : request.getParameter("regdate");
		String date = request.getParameter("date")	== null ? "" : request.getParameter("date");
		String bk_clt = request.getParameter("bk_clt")	== null ? "" : request.getParameter("bk_clt");
		String bk_cod = request.getParameter("bk_cod")	== null ? "" : request.getParameter("bk_cod");
		String bk_acct = request.getParameter("bk_acct")	== null ? "" : request.getParameter("bk_acct");

		String strAcctSsn    = request.getParameter("strAcctSsn")	== null ? "" : request.getParameter("strAcctSsn"); 

		String sending_num = "";
		String msg = "";
		String url  = "";
		String sendingnum = "";
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
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2[" + deptcd + "]");
System.out.println("중간 : [" + input);
		int procamt1 	      = 0;

		CybercenterManager manager = CybercenterManager.getInstance();
		ReturnManager returns = ReturnManager.getInstance();
		PlpaymentManager Pmanager = PlpaymentManager.getInstance();
		RestingsearchManager Rmanager = RestingsearchManager.getInstance();
		PolicychangeManager mailsend = PolicychangeManager.getInstance();
		CyberSmsManager manager2 = CyberSmsManager.getInstance();


		anyframe.log.Logger.debug.println("PROCESS*****************====>"+process);
		String srvc_gubunc = "";
		
		////Comment
		if(process.equals("R")||process.equals("Y")){
		
			anyframe.log.Logger.debug.println("=============== Debug ==================");		

			DataSet nameSet = new DataSet();
			nameSet.put("policy_apln_no", policy_apln_no);
			
			anyframe.log.Logger.debug.println("=============== policy_apln_no:"+policy_apln_no);		
			
			DataSet selPayment = manager.findRecei(nameSet); 
			
			
			
			  /*
			  Comment
			  */
			  
			  srvc_gubunc = selPayment.getText("srvc_cd");  
		
			  anyframe.log.Logger.debug.println("debug ==========="+srvc_gubunc);			
		
														
	
			  /*
			  Comment
			  */
			   if(srvc_gubunc.equals("4"))
			  {

				  
					  DataSet inputp1  = new DataSet();
			
					  String cnvdate	= to_year;
					  cnvdate = "        ";

					  inputp1.put("policy", policy);
					  inputp1.put("cnvdate",   cnvdate);
																									
					  DividendinfoManager manager4 = DividendinfoManager.getInstance();
													
					  DataSet dividendinfo 	= manager4.findDividendinfo(inputp1);
		

					  int amt1 = dividendinfo.getInt("acu_div");
					  int amt2 = dividendinfo.getInt("acc_div");
					  
				
				
					  anyframe.log.Logger.debug.println("debug ==========="+amt1);
					  
					  if( (amt1 + amt2) <= 0 )
					  {

						  message = "message";	
																	
						  msg = message;
						  url = urlname;
						  request.setAttribute("message", msg);
						  request.setAttribute("toURL", url);
						  return mapping.findForward("alert");	
							
					  }

			
			
			  }
	
			  /*
			  Comment
			  */
	
			   if(srvc_gubunc.equals("5"))
			  {
			  	
			  	
					////RestingsearchForm restingsearchForm = (RestingsearchForm) form;
					////FormToDataset.copyProperties(input, restingsearchForm);

					DataSet inputp1  = new DataSet();
					DataSet inputp2  = new DataSet();
			
					String cnvdate	= to_year;
					 cnvdate = "        ";

					////String cltno 		= restingsearchForm.getCltno(); 
				
					////cltno   = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");

					inputp1.put("policy", policy);
					inputp1.put("cnvdate",   cnvdate);
									  
									  
					inputp2.put("deptcd", deptcd);		
					inputp2.put("init", init);
					////inputp2.put("cltno",   cltno);
					inputp2.put("cltno",   ssn);
					System.out.println("deptcd : [" + deptcd + "] init : [" + init + "] ssn : [" + ssn + "]");
					System.out.println(inputp2);					
				anyframe.log.Logger.debug.println("	inputp2.toString()================"+	inputp2.toString());
				
					  RestingsearchManager manager5 = RestingsearchManager.getInstance();
			
					  DataSet plcynoinfo 	= manager5.findPlcynoinfo(inputp1); 
					  DataSet restingsearch 	= manager5.findRestingsearch(inputp2); 
					  System.out.println("	restingsearch.toString()================"+	restingsearch.toString());
				anyframe.log.Logger.debug.println("	restingsearch.toString()================"+	restingsearch.toString());
				
			
					  String policy_no = policy; 

					  int cntno = restingsearch.getCount("plyno"); 


				anyframe.log.Logger.debug.println("debug==========="+policy_no);
				anyframe.log.Logger.debug.println("debug"+cntno);
				System.out.println("debug==========="+policy_no);
				System.out.println("debug"+cntno);				
					  String plyno = "";

					  int rs_count = 0;	
					  for(int k=0;k<cntno;k++)
					  {	

						  plyno = restingsearch.getText("plyno",k).trim();
						  
						anyframe.log.Logger.debug.println("debug==========="+plyno);
						System.out.println("debug===========policy_no : [" + policy_no + "] plyno : ["+plyno + "]");
						
						  if(policy_no.equals(plyno)){

							  rs_count = 1;

						  }

					  }



						
					  if( rs_count == 0 )
					  {

						  message = "message";	
						  msg = message;
						  url = urlname;
						  request.setAttribute("message", msg);
						  request.setAttribute("toURL", url);
						  return mapping.findForward("alert");		
						
					  }
				
			
			
			
			  }

			  /*
			  Comment
			  */
			  if(srvc_gubunc.equals("7"))
			  {

		
				  DataSet inputp1  = new DataSet();
				  String cnvdate = to_year;
				  inputp1.put("policy", policy);
				  inputp1.put("cnvdate",   cnvdate);
					
				  DividendoffsearchManager manager7 = DividendoffsearchManager.getInstance();	
				  DataSet dividendoffsearch 	= manager7.findDividendoffsearch(inputp1);	
			
				  int acu_div = dividendoffsearch.getInt("acu_div");
				  int acc_div = dividendoffsearch.getInt("acc_div");
				  int pl_prin = dividendoffsearch.getInt("pl_prin");
		

				int pl_int  = dividendoffsearch.getInt("pl_int");
				int apl_amt =dividendoffsearch.getInt("apl_amt");
				int ard_apl = dividendoffsearch.getInt("ard_apl");
								
								
								
				anyframe.log.Logger.debug.println("debug ==========="+acu_div);
				anyframe.log.Logger.debug.println("debug ==========="+pl_prin);
				
				  if((acu_div +acc_div) <= 0 ||(pl_prin+pl_int+apl_amt +ard_apl)<= 0 ){
			
					  message = "message";	
					  msg = message;
					  url = urlname;
					  request.setAttribute("message", msg);
					  request.setAttribute("toURL", url);
					  return mapping.findForward("alert");													
			

				  }
		
		
			  }


								
			
			
		}
		
		

		
		
		////Comment
		if(process.equals("R"))
		{
			System.out.println("process ------------------->");
			input.put("gubun", "C");
			input.put("lvlnum", "21");
			System.out.println("debug : ksps2000 input :22222222222222222222[" + deptcd + "]");
			System.out.println("debug : ksps2000 input :" + input);
			DataSet ksps2000_10 = manager.findKsps2000(input); 

			
			
				////sp 
				try
				{
				
					/*Comment*/
																
																
					DataSet spinputp  = new DataSet();
				
					spinputp.put("srvc_cd",srvc_gubunc); 
					spinputp.put("sp_nm","KSPS2000"); 
					spinputp.put("tran_no",emp_no); 
					spinputp.put("tran_nm",emp_nm); 
					spinputp.put("sp_in_put",input.toString()); 
					spinputp.put("sp_out_put",ksps2000_10.toString()); 
				
					returns.findSpLogsave(spinputp); //// /changeminer/process_sp_save  cyber.dbo.cyber_tbl_sp_process_log에 insert 함.
						
				}catch(Exception e)
				{
			
					System.out.println("==========SP_LOG_SAVE:"+e.toString());  
				}
			
				////Comment
			

			errrtn = "";
			errrtn = ksps2000_10.getText("rtn",0);

			anyframe.log.Logger.debug.println("11111====>"+errrtn);

			//// WB_PAYMENT
			DataSet nameSet = new DataSet();
			nameSet.put("policy_apln_no", policy_apln_no);

			DataSet selPayment = manager.findRecei(nameSet);

			if(errrtn.equals("0") || errrtn.equals("6"))
			{
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				////[20070220] 1. webdb 
				//// mode:1
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////S/
				DataSet procamt_input 	= new DataSet();
				procamt_input.put("mode", 		"1"); 
				procamt_input.put("srvc_cd", 	selPayment.getText("srvc_cd")); 
				////procamt_input.put("rslt", 		"0"); 
				procamt_input.put("ssn", 		ssn);
				DataSet procamt_info 	= manager.getProcamtInfo(procamt_input);
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////E/

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				////[20070220] 2. procamt_sum 
				//// = procamt_sum
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				int procamt_sum = 0;
				int cnt = procamt_info.getCount("payor_ssn");
				if(cnt > 0){
					for(int i =0; i<cnt; i++){
						procamt_sum = procamt_sum + Integer.parseInt(procamt_info.getText("apln_amt",i));
					}
				}
////				anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  applymoney  : "+Integer.parseInt(procamt) );
				anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  pay_amt  : "+procamt_sum );
				//// 2007?
				////procamt_sum = procamt_sum + Integer.parseInt(procamt);
				anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  procamt_sum  : "+procamt_sum );

				////procamt1 = 10000001;
////				if(procamt1 >10000000)
				if(procamt_sum > 10000000)
				{
					message =  "message";
					input.put("gubun", "W" );
					input.put("lvlnum", "30");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);

					DataSet ksps2000_30 = manager.findKsps2000(input);
					////request.setAttribute("ksps2000_30", ksps2000_30);
					
					////sp 
					try
					{
				
						/*Comment*/
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd",srvc_gubunc); 
						spinputp.put("sp_nm","KSPS2000"); 
						spinputp.put("tran_no",emp_no); 
						spinputp.put("tran_nm",emp_nm); 
						spinputp.put("sp_in_put",input.toString()); 
						spinputp.put("sp_out_put",ksps2000_30.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp); //// /changeminer/process_sp_save  cyber.dbo.cyber_tbl_sp_process_log에 insert 함.
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  
					}
			
					////sp 

					errrtn = "";
					errrtn = ksps2000_30.getText("rtn",0);

					////WEB 
					if(errrtn.equals("0"))
					{
						input1.put("policy_apln_no", policy_apln_no);
						input1.put("proc_emp_no", proc_emp_no);
						input1.put("proc_status", "30");
						input1.put("err_msg", message);
						DataSet rtnsave = returns.findRtnsave(input1); //// /changeminer/usp_wb_return_update

						input2.put("policy_apln_no", policy_apln_no);
						input2.put("proc_status", "1");
						input2.put("err_msg", message);
						input2.put("recon_id", proc_emp_no);
						DataSet rtnsave1 = returns.findRtnsave1(input2); //// /changeminer/usp_wb_return_update1

					}////WEB 

							msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}////1000
				else
				{
					////int cnt = ksps2000_10.getCount("procamt");
					////KSPS2000
					input.put("gubun", "C");
					input.put("lvlnum", "21");




					DataSet ksps2000_21C = manager.findKsps2000(input);
					
					
					////sp 
					try
					{
				
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd",srvc_gubunc); 
						spinputp.put("sp_nm","KSPS2000"); 
						spinputp.put("tran_no",emp_no); 
						spinputp.put("tran_nm",emp_nm); 
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_21C.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  
					}
			
					////sp 
					String rtn21 = ksps2000_21C.getText("rtn").trim();
					anyframe.log.Logger.debug.println("======222222====>"+rtn21);
					int success = Integer.parseInt(rtn21);

						switch(success)
						{
							case(0) :
									message =  "Comment..";
									break;
							case(5) :
									message = "Comment";
									break;
							case(6) :
									message =  "Comment..";
									break;
							default :
									message =  "Comment..";
									break;
						}
						////KSPS2000
						if(rtn21.equals("0") || rtn21.equals("6"))
						{
						input.put("gubun", "W" );
						input.put("lvlnum", "21");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);

						DataSet ksps2000_21W = manager.findKsps2000(input);
						////request.setAttribute("ksps2000_21W", ksps2000_21W);
						
						////sp 로그를 위한 로직... 시작
						try
						{
				
																
							DataSet spinputp  = new DataSet();
				
							spinputp.put("srvc_cd",srvc_gubunc); 
							spinputp.put("sp_nm","KSPS2000"); 
							spinputp.put("tran_no",emp_no); 
							spinputp.put("tran_nm",emp_nm); 
							spinputp.put("sp_in_put",input.toString()); ////sp_in_put
							spinputp.put("sp_out_put",ksps2000_21W.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  
						}

						errrtn = "";
						errrtn = ksps2000_21W.getText("rtn",0);
						anyframe.log.Logger.debug.println("333333====>"+errrtn);
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
						else if(rtn21.equals("5"))	
						{
								message = "Comment";
							input1.put("policy_apln_no", policy_apln_no);
							input1.put("proc_emp_no", proc_emp_no);
							input1.put("proc_status", "2");
							input1.put("err_msg", message);
							DataSet rtnsave4 = returns.findRtnsave(input1);

							input2.put("policy_apln_no", policy_apln_no);
							input2.put("proc_status", "2");
							input2.put("err_msg", message);
							input2.put("recon_id", proc_emp_no);
							DataSet rtnsave5 = returns.findRtnsave1(input2);
						}
					msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}////KSPS2000
			}

		}////END
		////Comment
		else if(process.equals("Y"))
		{
			System.out.println("process ------------------->");
			//// 2007
			//// Comment
			if (!isTokenValid(request)) {
				url = urlname;
				Logger.debug.println("saveToken ? ");
				request.setAttribute("message", " ");
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			resetToken(request); 

			input.put("gubun", "C");
			input.put("lvlnum", "22");
			System.out.println("ksps2000전 input" + input);
			DataSet ksps2000_10 = manager.findKsps2000(input);
			
			////sp 
			try
			{
				
																
				DataSet spinputp  = new DataSet();
				
				spinputp.put("srvc_cd",srvc_gubunc); 
				spinputp.put("sp_nm","KSPS2000"); 
				spinputp.put("tran_no",emp_no); 
				spinputp.put("tran_nm",emp_nm); 
				spinputp.put("sp_in_put",input.toString()); ////sp_in_put
				spinputp.put("sp_out_put",ksps2000_10.toString()); ////sp_out_put
				
				returns.findSpLogsave(spinputp);
						
			}catch(Exception e)
			{
			
				System.out.println("==========SP_LOG_SAVE:"+e.toString());  
			}

			errrtn = "";
			errrtn = ksps2000_10.getText("rtn",0);
			anyframe.log.Logger.debug.println("4444444====>"+errrtn);
			message = "";

			////2006-09-07
			inAppv.put("policy_apln_no", 	policy_apln_no);
////			inAppv.put("proc_status", 		"80");
////			inAppv.put("proc_status", 		"'21', '22', '40', '80'");

			outAppv1 = manager.findAppvProcessStatus(inAppv);
			outAppv2 = manager.findAppvPaymentStatus(inAppv);

			String appv_cnt 	= outAppv1.getText("appv_cnt");
			String appv_rslt	= outAppv2.getText("rslt");

			System.out.println("errrtn : [" + errrtn + "]");

			if(errrtn.equals("0") || errrtn.equals("6")){ 

				if(!appv_cnt.equals("0")){
					message = " ";
					////msg = message;
					url = urlname;
					request.setAttribute("message", message);
					request.setAttribute("toURL", url);
					return mapping.findForward("alert");

				}else{
					//// 2007
					DataSet newSet = new DataSet();
					newSet.put("policy_apln_no", policy_apln_no);
					newSet.put("proc_emp_no", proc_emp_no);
					newSet.put("proc_status", "22");
					newSet.put("err_msg", message);
					DataSet rtnsave10 = returns.findRtnsave(newSet);

					//// WB_PAYMENT
					DataSet nameSet = new DataSet();
					nameSet.put("policy_apln_no", policy_apln_no);
					
					DataSet selPayment = manager.findRecei(nameSet);

					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					////[20070220] 1. webdb
					////- Comment
					///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////S/
					DataSet procamt_input 	= new DataSet();
					procamt_input.put("mode", 		"1"); 
					procamt_input.put("srvc_cd", 	selPayment.getText("srvc_cd")); 
					////procamt_input.put("rslt", 		"0"); 
					procamt_input.put("ssn", 		ssn);
					DataSet procamt_info 	= manager.getProcamtInfo(procamt_input);
					///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////E/

					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					////[20070220] 2. procamt_sum 
					////- Comment
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					int procamt_sum = 0;
					int cnt = procamt_info.getCount("payor_ssn");

					if(cnt > 0){
						for(int i =0; i<cnt; i++){
							procamt_sum = procamt_sum + Integer.parseInt(procamt_info.getText("apln_amt",i));
						}
					}
////					anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  applymoney  : "+Integer.parseInt(procamt) );
					anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  pay_amt  : "+procamt_sum );
					////procamt_sum = procamt_sum + Integer.parseInt(procamt);
					anyframe.log.Logger.debug.println(" (procamt_info - 조회)----  procamt_sum  : "+procamt_sum );
////					if(procamt1 >10000000)
					if(procamt_sum >10000000)
					{
						message =  "Comment";
						input.put("gubun", "W" );
						input.put("lvlnum", "30");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);

						DataSet ksps2000_30 = manager.findKsps2000(input);
						////request.setAttribute("ksps2000_30", ksps2000_30);


						////sp 
						try
						{
				
																
																
							DataSet spinputp  = new DataSet();
				
							spinputp.put("srvc_cd",srvc_gubunc); 
							spinputp.put("sp_nm","KSPS2000"); 
							spinputp.put("tran_no",emp_no); 
							spinputp.put("tran_nm",emp_nm); 
							spinputp.put("sp_in_put",input.toString()); ////sp_in_put
							spinputp.put("sp_out_put",ksps2000_30.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  
						}
						
						errrtn = "";
						errrtn = ksps2000_30.getText("rtn",0);

						////WEB 
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

						}////WEB 

								msg = message;
								url = urlname;
								request.setAttribute("message", msg);
								request.setAttribute("toURL", url);
								return mapping.findForward("alert");
					}
					else
					{
						////KSPS2000
						input.put("gubun", "W" );
						input.put("lvlnum", "22");
						input.put("cltbk", cltbk);
						input.put("cltact", cltact);
						input.put("cltnum", cltnum);
						input.put("procamt", procamt);

						DataSet ksps2000_22W = manager.findKsps2000(input);
						
						////sp 
						try
						{
				
															
																
							DataSet spinputp  = new DataSet();
				
							spinputp.put("srvc_cd",srvc_gubunc);
							spinputp.put("sp_nm","KSPS2000"); 
							spinputp.put("tran_no",emp_no); 
							spinputp.put("tran_nm",emp_nm); 
							spinputp.put("sp_in_put",input.toString()); 
							spinputp.put("sp_out_put",ksps2000_22W.toString()); ////sp_out_put
				
							returns.findSpLogsave(spinputp);
						
						}catch(Exception e)
						{
			
							System.out.println("==========SP_LOG_SAVE:"+e.toString());  
						}
						
						
						String rtn22 = ksps2000_22W.getText("rtn").trim();

						errrtn = "";
						errrtn = ksps2000_22W.getText("rtn",0);
						if(errrtn.equals("0"))
						{
/*
 *		2007
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

							////2006-12-27 
							////KSPS2000
							input.put("gubun", "W" );
							input.put("lvlnum", "40");
							input.put("cltbk", cltbk);
							input.put("cltact", cltact);
							input.put("cltnum", cltnum);
							input.put("procamt", procamt);

							////KSPS2000
							DataSet ksps2000_40 = manager.findKsps2000(input);
							
							
							
							////sp 
							try
							{
				
																
								DataSet spinputp  = new DataSet();
				
								spinputp.put("srvc_cd",srvc_gubunc); 
								spinputp.put("sp_nm","KSPS2000"); 
								spinputp.put("tran_no",emp_no); 
								spinputp.put("tran_nm",emp_nm); 
								spinputp.put("sp_in_put",input.toString()); 
								spinputp.put("sp_out_put",ksps2000_40.toString()); ////sp_out_put
				
								returns.findSpLogsave(spinputp);
						
							}catch(Exception e)
							{
			
								System.out.println("==========SP_LOG_SAVE:"+e.toString());  
							}
							
							
							errrtn = "";
							errrtn = ksps2000_40.getText("rtn");

							////WEBDB 
							if(errrtn.equals("0")){
								input1.put("policy_apln_no", policy_apln_no);
								input1.put("proc_emp_no", proc_emp_no);
								input1.put("proc_status", "40");
								input1.put("err_msg", message);
								DataSet rtnsave10_40 = returns.findRtnsave(input1);

								////Comment
								input3.put("deptcd", "INT");
								input3.put("init", tproc_emp_no);
								input3.put("policy", policy);
								input3.put("opt1", opt1);
								input3.put("divocc", "9");
								input3.put("rcvdate", rcvdate);
								input3.put("date", to_year);
								input3.put("sndseq", "      ");

								//// Comment
								if(srvc_gubunc.equals("5")) {
									
									if("".equals(Utility.nvl(strAcctSsn)) == false) {
										input3.put("bk_clt", strAcctSsn);
									}else {
										input3.put("bk_clt", bk_clt);
									}
								}else {
									input3.put("bk_clt", bk_clt);
								}

								input3.put("bk_cod", bk_cod);
								input3.put("bk_acct", bk_acct);
								input3.put("acct_ssn", strAcctSsn);

								input4.put("policy_apln_no", policy_apln_no);
								input5.put("proc_emp_no", proc_emp_no);

								
								DataSet approval = Rmanager.getApproval(input3, input4, input5);
								anyframe.log.Logger.debug.println("Action M0191SP1   ");
								sending_num = approval.getText("sndseq");
								input9.put("policy_apln_no", policy_apln_no);
								input9.put("sending_num", sending_num);
								input9.put("pay_dt", Util.getTodayToYMD().substring(0,8));
								DataSet sending = manager.Sendingsave(input9);

								errrtn = approval.getText("rtn");
								message1 = Util.superTrim(approval.getText("errmsg1")) + Util.superTrim(approval.getText("errmsg2")) + Util.superTrim(approval.getText("errmsg3"));

								realpay.put("policy_apln_no", policy_apln_no);
								realpay.put("pay_amt", approval.getText("amount"));

								anyframe.log.Logger.debug.println("======5555555555====>"+errrtn);

								//// 2007.5.15 
								//// Comment
								anyframe.log.Logger.debug.println("코approval.getText(errmsg1)====>"+approval.getText("errmsg1"));
////								Comment
////								approval.put("errmsg1", "DGAAAA? ");
								if(Util.superTrim(approval.getText("errmsg1")).indexOf("AAAA") != -1) {
									System.out.println("########################## CyberpayAction.java AAAA #############################");

									srvc_gubunc = selPayment.getText("srvc_cd");
									String strGubun = "";
									if(srvc_gubunc.equals("1"))
									{
										strGubun = " ";
									}
									else if(srvc_gubunc.equals("2"))
									{
										strGubun = " ";
									}
									else if(srvc_gubunc.equals("3"))
									{
										strGubun = " ";
									}
									else if(srvc_gubunc.equals("4"))
									{
										strGubun = "배당금";
									}
									else if(srvc_gubunc.equals("5"))
									{
										strGubun = " ";
									}
									else if(srvc_gubunc.equals("6"))
									{
										strGubun = " ";
									}
									else if(srvc_gubunc.equals("7"))
									{
										strGubun = " ";
									}

									String payor_nm = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm"))); //// 고객명

									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// SMS 
									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// Comment
									DataSet smsSet = new DataSet();
									smsSet.put("page", "0");
									smsSet.put("where", " and hand_phone_yn = 'Y'");
									smsSet.put("subwhere", "");

									AuthManager managerSms = AuthManager.getInstance();
									DataSet authval = managerSms.findAuth(smsSet);
									//// SMS 발송
									for(int i=0;i<authval.getCount("emp_no");i++) {
										System.out.println("for 문");
										System.out.println("for 문" +  Integer.parseInt(procamt));
										//// ex) Comment
										String strMsg = "[message " + policy + payor_nm + " " + strGubun + Integer.parseInt(procamt) + "원 AAAA발견";

										DataSet sendSmsInput = new DataSet();
										sendSmsInput.put("RECEIVER_MOBILE", authval.getText("hand_phone", i));
										sendSmsInput.put("CUS_CALL_BACK",   "15883374");
										sendSmsInput.put("CUS_MSG",         strMsg);
										sendSmsInput.put("TRAN_ETC1",       to_year);
										sendSmsInput.put("TRAN_ETC2",       "");
										sendSmsInput.put("TRAN_ETC3",       "CU");
										
										sendSmsInput.put("srvc_cd", srvc_gubunc);  
            
										sendSmsInput.put("policy_no", policy); 
										sendSmsInput.put("tran_ssn",authval.getText("emp_no", i)); 
										sendSmsInput.put("tran_nm",authval.getText("emp_nm", i));  



										manager2.sendSimpleSms(sendSmsInput);
									}

									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// Comment
									///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
									//// Comment
									smsSet = new DataSet();
									smsSet.put("page", "0");
									smsSet.put("where", " and email_yn = 'Y'");
									smsSet.put("subwhere", "");
									System.out.println("이메일 발송");
									authval = managerSms.findAuth(smsSet);

									////Comment
									for(int i=0;i<authval.getCount("emp_no");i++) {
										//// ex) Comment
										String strSubject = policy + " " + payor_nm + ", " + strGubun + " " + Integer.parseInt(procamt) + "원 [지티원사이버]승인요청중 AAAA가 발견되었습니다.";
										//// ex)
										////	Comment
										////	Comment: 100500000

										String strContent = strSubject + "|" + "  <br>"
																	+ "  : " + policy + "<br>"
																	+ "  : " + payor_nm + "<br>"
																	+ strGubun + " : " + Integer.parseInt(procamt) + " <br>"
																	+ "  : " + authval.getText("emp_nm", i) + "<br>"
																	+ "  : " + Utility.getToday();

										DataSet emailSet = new DataSet();
										////메일보내기(고객)
										emailSet.put("param1", "05");
										////emailSet.put("param2", "12"); 
										emailSet.put("param2", "01"); 
										emailSet.put("param3", "00000029");
										emailSet.put("to_name", authval.getText("emp_nm", i));
										emailSet.put("to_email_addr", authval.getText("email", i));
										emailSet.put("content", strContent); 

										anyframe.log.Logger.debug.println(" CyberAction Input : "+emailSet);
										DataSet mailcu = mailsend.sendSimpleMail(emailSet);
									}

									////Comment
								}
								System.out.println("Done");
								if(errrtn.equals("0"))
								{
									DataSet netpay = manager.Realpaysave(realpay);

									////KSPS2000
									input.put("gubun", "W" );
									input.put("lvlnum", "80");
									input.put("cltbk", cltbk);
									input.put("cltact", cltact);
									input.put("cltnum", cltnum);
									input.put("procamt", procamt);
									DataSet ksps2000_80 = manager.findKsps2000(input);
									
									
									////sp 
									try
									{
				
														
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd",srvc_gubunc); 
										spinputp.put("sp_nm","KSPS2000"); 
										spinputp.put("tran_no",emp_no); 
										spinputp.put("tran_nm",emp_nm); 
										spinputp.put("sp_in_put",input.toString()); 
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  
									}
									
									
									
									message = "This is a message";
									////WEB DB
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

									////WB_PAYMENTSearch
									input11.put("policy_apln_no", policy_apln_no);

									selPayment = manager.findRecei(input11);

									cltnum = selPayment.getText("payor_ssn");
									cltnum = cltnum.substring(0,6) +"-"+ cltnum.substring(6);

									String payor_nm = "";
									payor_nm = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));

									String v_to_mail = selPayment.getText("payor_email");
									String mapping1 = "";
									String apln_dt = selPayment.getText("apln_dt").substring(0,10);
									apln_dt = StringFormater.removeZero(apln_dt.substring(0,4)) +" The " + StringFormater.removeZero(apln_dt.substring(5,7)) +" 월 "+ StringFormater.removeZero(apln_dt.substring(8,10)) +" 일";

									to_year = null;
									v_toyear = Util.getTodayToYMD();
									to_year = v_toyear.substring(0,8);
									String pay_dt  = "";
									pay_dt = to_year;
									if(pay_dt.length() == 8)
									{
										pay_dt = StringFormater.removeZero(pay_dt.substring(0,4)) + " The "+ StringFormater.removeZero(pay_dt.substring(4,6)) +" 월 "+ StringFormater.removeZero(pay_dt.substring(6,8)) +" 일";
									}

									String apln_amt = "";
									if(selPayment.getText("srvc_cd").equals("4"))
									{
										apln_amt = "AMT: "+Util.addComma(approval.getText("loanamt")) + "Sendig : "+Util.addComma(approval.getText("amount"));
									}
									else if(selPayment.getText("srvc_cd").equals("5"))
									{
										apln_amt =  "AMT : "+Util.addComma(approval.getText("amount"));
									}
									else if(selPayment.getText("srvc_cd").equals("7"))
									{
										apln_amt = "AMT: "+Util.addComma(approval.getText("loanamt"));
									}

									////apln_amt = selPayment.getText("apln_amt");
									////apln_amt = Util.addComma(apln_amt);

									mapping1 = payor_nm +"|"+ selPayment.getText("srvc_name") +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+ apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+ selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";

									////Input
									input10.put("v_mail_type", "03");
									input10.put("v_mail_type_seq", Variable.get("email-id.cyber03"));////54
									input10.put("v_channel_code", "00000030");
									input10.put("v_member_id", cltnum);
									input10.put("v_to_name", payor_nm);
									input10.put("v_to_email",  selPayment.getText("payor_email"));

									input10.put("v_mapping", mapping1);
									input10.put("v_lp_code", selPayment.getText("lp_id"));
									input10.put("v_policy_number", selPayment.getText("policy_no"));
									input10.put("v_channel", "cyber");
									input10.put("v_ilips_client_id", "");

									anyframe.log.Logger.debug.println("Input handling  : "+input10);
									DataSet mailcu = mailsend.sendMail(input10);
									request.setAttribute("mailcu",mailcu);

									////Input handling

									input10.put("v_mail_type", "03");
									input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
									input10.put("v_channel_code", "00000030");
									input10.put("v_member_id", cltnum);

									input10.put("v_to_email", selPayment.getText("lp_email"));
									mapping1 = "";
									String lpname = "";
									lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
									mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
									input10.put("v_mapping", mapping1);

									anyframe.log.Logger.debug.println("Debug  : "+input10);
									input10.put("v_lp_code", selPayment.getText("lp_id"));
									DataSet maillp = mailsend.sendMail(input10);
									request.setAttribute("maillp",maillp);

									/*
									////SMS
									input10.put("v_mail_type", "03");
									input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
									input10.put("v_channel_code", "00000030");
									input10.put("v_member_id", cltnum);

									input10.put("v_to_email", selPayment.getText("sm_email"));

									mapping1 = "";
									String sm_name = "";
									////sm_name = selPayment.getText("sm_name");
									sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));

									mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
									input10.put("v_mapping", mapping1);

									anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input10);
									input10.put("v_lp_code", selPayment.getText("sm_code"));
									DataSet mailsm = mailsend.sendMail(input10);
									request.setAttribute("mailsm",mailsm);
									*/

									////SMS Message

									String owner_mobile  	= selPayment.getText("payor_phone");
									String lp_code       	= "";

									String gubun1         = selPayment.getText("pay_cd");
									String sms_code = "";
									srvc_gubunc = "";
									String owner = "";
									owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));

									srvc_gubunc = selPayment.getText("srvc_cd");

									String amt           	= "";
									if(srvc_gubunc.equals("4"))
									{
										amt  = "AMT:"+Util.addComma(StringFormater.removeZero(selPayment.getText("pay_amt"))) +"COMM";

										if(approval.getText("loanamt").length() == 0 || approval.getText("loanamt").equals("0"))
										{ }
										else
										{
											amt = amt + "AMT:"+ Util.addComma(StringFormater.removeZero(approval.getText("loanamt")));
										}
									}
									else if(srvc_gubunc.equals("7"))
									{
										amt  = Util.addComma(StringFormater.removeZero(approval.getText("loanamt")));
									}
									else
									{
										amt  = Util.addComma(StringFormater.removeZero(selPayment.getText("pay_amt")));
									}

									if(srvc_gubunc.equals("1"))
									{
										sms_code = "5";
									}
									else if(srvc_gubunc.equals("2"))
									{
										sms_code = "9";
									}
									else if(srvc_gubunc.equals("3"))
									{
										sms_code = "11";
									}
									else if(srvc_gubunc.equals("4"))
									{
										sms_code = "39";
									}
									else if(srvc_gubunc.equals("5"))
									{
										sms_code = "21";
									}
									else if(srvc_gubunc.equals("6"))
									{
										sms_code = "8";
									}
									else if(srvc_gubunc.equals("7"))
									{
										sms_code = "7";
									}

									String indate1 = "";
									indate1 = selPayment.getText("policy_apln_no").substring(0,8);

									smscu.put("v_sms_code",  		sms_code);
									smscu.put("v_success_yn",  	"0");
									smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
									smscu.put("v_name",  			owner);
									smscu.put("v_owner",  		owner);
									smscu.put("v_owner_mobile",  	owner_mobile);
									smscu.put("v_lp_code",  		lp_code);
									smscu.put("v_amt",  			amt);
									smscu.put("v_gubun",  		gubun1);

									smscu.put("tran_etc1",  		indate1);
									smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));
									smscu.put("v_pr",  			"CU");
									DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU

									////Message
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
									DataSet ksps2000_80 = manager.findKsps2000(input);
									
									
									////sp 
									try
									{
				
														
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd",srvc_gubunc); 
										spinputp.put("sp_nm","KSPS2000"); 
										spinputp.put("tran_no",emp_no); 
										spinputp.put("tran_nm",emp_nm); 
										spinputp.put("sp_in_put",input.toString()); 
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  
									}
									
									
									
									
									message = "This is a Message";
									////WEB DB
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

									////Message

									msg = message1;
											url = urlname;
											request.setAttribute("message", msg);
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
									
									
									////sp 
									try
									{
				
																
																
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd",srvc_gubunc); 
										spinputp.put("sp_nm","KSPS2000"); 
										spinputp.put("tran_no",emp_no); 
										spinputp.put("tran_nm",emp_nm); 
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  
									}
									
									
									
									

									////WEB DB
									message = "This is a message";
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

									////WEB

									msg = message1;
									url = urlname;
											request.setAttribute("message", msg);
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
									
									

									try
									{
				
															
										DataSet spinputp  = new DataSet();
				
										spinputp.put("srvc_cd",srvc_gubunc); 
										spinputp.put("sp_nm","KSPS2000"); 
										spinputp.put("tran_no",emp_no); 
										spinputp.put("tran_nm",emp_nm); 
										spinputp.put("sp_in_put",input.toString()); ////sp_in_put
										spinputp.put("sp_out_put",ksps2000_80.toString()); ////sp_out_put
				
										returns.findSpLogsave(spinputp);
						
									}catch(Exception e)
									{
			
										System.out.println("==========SP_LOG_SAVE:"+e.toString());  
									}
									
									
									

									////WEB DB
									message = "This is a message";
									input1.put("policy_apln_no", policy_apln_no);
									input1.put("proc_emp_no", proc_emp_no);
									input1.put("proc_status", "61");
									input1.put("err_msg", message1);
									DataSet rtnsave18 = returns.findRtnsave(input1);

									input2.put("policy_apln_no", policy_apln_no);
									input2.put("proc_status", "2");
									input2.put("err_msg", message1);
									input2.put("recon_id", proc_emp_no);
									DataSet rtnsave19 = returns.findRtnsave1(input2);



									msg = message1;
											url = urlname;
											request.setAttribute("message", msg);
											request.setAttribute("toURL", url);
											return mapping.findForward("alert");
								}

							}////KSPS2000
						}////KSPS2000
					}
				}
			}
			else if(errrtn.equals("5") || errrtn.equals("1"))
			{
				if(errrtn.equals("5"))
					message = "This is a message";
				else if(errrtn.equals("1"))
					message =  "This is a message";
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
		else if(process.equals("K"))
		{

			input8.put("policy_apln_no", policy_apln_no);
			DataSet sendall = manager.findSend(input8);
			sendingnum = sendall.getText("sending_num");
			date = sendall.getText("date");


			//// [05-B-353] 2005-08-22 
			input7.put("musera", "INTUSER");
			input7.put("snddate", date);
			input7.put("sndseq", sendingnum);
			anyframe.log.Logger.debug.println("==input==>"+input7);
			System.out.println("==input==>"+input7);
			DataSet ksps0450 = manager.findIsaogong(input7);////KSPS0450
			anyframe.log.Logger.debug.println("KSPS0450값들==output==>"+ksps0450);
			String ksps0450err = "";

			rtn0450 = ksps0450.getText("rtn");
			ksps0450err = ksps0450.getText("errmsg");

			anyframe.log.Logger.debug.println("======66666666====>"+rtn0450);
			if(rtn0450.equals("1") || rtn0450.equals("3"))
			{
				message = "This is a message";
				msg = ksps0450err;
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
				
				////sp
				try
				{
				
																
																
					DataSet spinputp  = new DataSet();
				
					spinputp.put("srvc_cd",srvc_gubunc); 
					spinputp.put("sp_nm","KSPS2000"); 
					spinputp.put("tran_no",emp_no); 
					spinputp.put("tran_nm",emp_nm); 
					spinputp.put("sp_in_put",input.toString()); ////sp_in_put
					spinputp.put("sp_out_put",ksps2000_61.toString()); ////sp_out_put
				
					returns.findSpLogsave(spinputp);
						
				}catch(Exception e)
				{
			
					System.out.println("==========SP_LOG_SAVE:"+e.toString());  
				}
				
				

				errrtn = "";
				errrtn = ksps2000_61.getText("rtn",0);
				anyframe.log.Logger.debug.println("======777777777====>"+errrtn);
				if(errrtn.equals("0"))
				{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "60");
					input1.put("err_msg", ksps0450err);
					DataSet rtnsavek0 = returns.findRtnsave(input1);

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "2");
					input2.put("err_msg", ksps0450err);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek1 = returns.findRtnsave1(input2);
				}////WEB DB
			}
			else if(rtn0450.equals("0"))
			{
			
				input3.put("deptcd", "INT");
				input3.put("init", tproc_emp_no);
				input3.put("policy", policy);
				input3.put("opt1", opt1);
				input3.put("divocc", "8");
				//// [05-B-353] 2005-08-22 rcvdate 
				if(rcvdate == null || rcvdate.equals(""))
					input3.put("rcvdate", indate);
				else
					input3.put("rcvdate", rcvdate);
				input3.put("date", to_year);
				input3.put("sndseq", "      ");

				//// 휴면보험금 일때만
				if(srvc_gubunc.equals("5")) {
					
					if("".equals(Utility.nvl(strAcctSsn)) == false) {
						input3.put("bk_clt", strAcctSsn);
					}else {
						input3.put("bk_clt", bk_clt);
					}
				}else {
					input3.put("bk_clt", bk_clt);
				}
////				input3.put("bk_clt", bk_clt);
				input3.put("bk_cod", bk_cod);
				input3.put("bk_acct", bk_acct);

				input4.put("policy_apln_no", policy_apln_no);
				input5.put("proc_emp_no", proc_emp_no);

				anyframe.log.Logger.debug.println("M0191SP1  input3==========="+input3);
				DataSet approval5 = Rmanager.getApproval(input3, input4, input5);

				String approval5err = "";
				approval5err = Util.superTrim(approval5.getText("errmsg1")) + Util.superTrim(approval5.getText("errmsg2")) + Util.superTrim(approval5.getText("errmsg3"));

				errrtn = approval5.getText("rtn");

				realpay.put("policy_apln_no", policy_apln_no);
				realpay.put("pay_amt", approval5.getText("amount"));

				if(errrtn.equals("0"))
				{
					DataSet netpay = manager.Realpaysave(realpay);

					////KSPS2000 
					input.put("gubun", "W" );
					input.put("lvlnum", "80");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_801 = manager.findKsps2000(input);
					
					
					////
					try
					{
				
																
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd",srvc_gubunc); 
						spinputp.put("sp_nm","KSPS2000"); 
						spinputp.put("tran_no",emp_no); 
						spinputp.put("tran_nm",emp_nm); 
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_801.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  
					}
					
					

					////WEB DB
					message = "This is a message";
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "80");
					input1.put("err_msg", approval5err);
					DataSet rtnsavek4 = returns.findRtnsave(input1);

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "0");
					input2.put("err_msg", approval5err);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek5 = returns.findRtnsave1(input2);

					input11.put("policy_apln_no", policy_apln_no);

					DataSet selPayment = manager.findRecei(input11);

					cltnum = selPayment.getText("payor_ssn");
					cltnum = cltnum.substring(0,6) +"-"+ cltnum.substring(6);
					String payor_nm = "";
					payor_nm = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));

					String v_to_mail = selPayment.getText("payor_email");
					String mapping1 = "";
					String apln_dt = selPayment.getText("apln_dt").substring(0,10);
					apln_dt = StringFormater.removeZero(apln_dt.substring(0,4)) +" 년 " + StringFormater.removeZero(apln_dt.substring(5,7)) +" 월 "+ StringFormater.removeZero(apln_dt.substring(8,10)) +" 일";

					to_year = null;
					v_toyear = Util.getTodayToYMD();
					to_year = v_toyear.substring(0,8);
					String pay_dt  = "";
					pay_dt = to_year;
					if(pay_dt.length() == 8)
					{
						pay_dt = StringFormater.removeZero(pay_dt.substring(0,4)) + " 년 "+ StringFormater.removeZero(pay_dt.substring(4,6)) +" 월 "+ StringFormater.removeZero(pay_dt.substring(6,8)) +" 일";
					}

					String apln_amt = "";
					if(selPayment.getText("srvc_cd").equals("4"))
					{
						apln_amt = "AMT: "+Util.addComma(approval5.getText("loanamt")) +"Send : "+Util.addComma(approval5.getText("amount"));
					}
					else if(selPayment.getText("srvc_cd").equals("5"))
					{
						apln_amt =  "AMT : "+Util.addComma(approval5.getText("amount"));
					}
					else if(selPayment.getText("srvc_cd").equals("7"))
					{
						apln_amt = "AMT: "+Util.addComma(approval5.getText("loanamt"));
					}

					mapping1 = payor_nm +"|"+ selPayment.getText("srvc_name") +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+ apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+ selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";


					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber03"));////54
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);////
					input10.put("v_to_name", payor_nm);////
					input10.put("v_to_email",  selPayment.getText("payor_email"));////

					input10.put("v_mapping", mapping1);
					input10.put("v_lp_code", selPayment.getText("lp_id"));
					input10.put("v_policy_number", selPayment.getText("policy_no"));
					input10.put("v_channel", "cyber");
					input10.put("v_ilips_client_id", "");

					anyframe.log.Logger.debug.println("Debug  : "+input10);
					DataSet mailcu = mailsend.sendMail(input10);
					request.setAttribute("mailcu",mailcu);



					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);

					input10.put("v_to_email", selPayment.getText("lp_email"));

					mapping1 = "";
					String lpname = "";
					lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
					mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
					input10.put("v_mapping", mapping1);

					anyframe.log.Logger.debug.println("Input  : "+input10);
					input10.put("v_lp_code", selPayment.getText("lp_id"));
					DataSet maillp = mailsend.sendMail(input10);
					request.setAttribute("maillp",maillp);

					/*

					input10.put("v_mail_type", "03");
					input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
					input10.put("v_channel_code", "00000030");
					input10.put("v_member_id", cltnum);

					input10.put("v_to_email", selPayment.getText("sm_email"));

					mapping1 = "";
					String sm_name = "";
					////sm_name = selPayment.getText("sm_name");
					sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));

					mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnum +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "원" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
					input10.put("v_mapping", mapping1);

					anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input10);
					input10.put("v_lp_code", selPayment.getText("sm_code"));
					DataSet mailsm = mailsend.sendMail(input10);
					request.setAttribute("mailsm",mailsm);
					*/


					String owner_mobile  	= selPayment.getText("payor_phone");
					String lp_code       	= "";

					String gubun1         = selPayment.getText("pay_cd");
					String sms_code = "";
					srvc_gubunc = "";
					String owner = "";
					owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));

					srvc_gubunc = selPayment.getText("srvc_cd");
					String amt           	= "";

					if(srvc_gubunc.equals("4"))
					{
						amt  = "AMT:"+Util.addComma(StringFormater.removeZero(selPayment.getText("pay_amt"))) +"  "+ "Send:"+ Util.addComma(StringFormater.removeZero(approval5.getText("loanamt")));
					}
					else if(srvc_gubunc.equals("7"))
					{
						amt  = Util.addComma(StringFormater.removeZero(approval5.getText("loanamt")));
					}

					else
					{
						amt = Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));
					}



					if(srvc_gubunc.equals("1"))
					{
						sms_code = "5";
					}
					else if(srvc_gubunc.equals("2"))
					{
						sms_code = "9";
					}
					else if(srvc_gubunc.equals("3"))
					{
						sms_code = "11";
					}
					else if(srvc_gubunc.equals("4"))
					{
						sms_code = "6";
					}
					else if(srvc_gubunc.equals("5"))
					{
						sms_code = "25";
					}
					else if(srvc_gubunc.equals("6"))
					{
						sms_code = "8";
					}
					else if(srvc_gubunc.equals("7"))
					{
						sms_code = "7";
					}

					String indate1 = "";
					indate1 = selPayment.getText("policy_apln_no").substring(0,8);

					smscu.put("v_sms_code",  		sms_code);////SMS 
					smscu.put("v_success_yn",  	"0");////
					smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
					smscu.put("v_name",  			owner);
					smscu.put("v_owner",  		owner);
					smscu.put("v_owner_mobile",  	owner_mobile);
					smscu.put("v_lp_code",  		lp_code);
					smscu.put("v_amt",  			amt);
					smscu.put("v_gubun",  		gubun1);

					smscu.put("tran_etc1",  		indate1);
					smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));
					smscu.put("v_pr",  			"CU");
					DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU


					msg = approval5err;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");
				}
				else
				{
					////KSPS2000 
					input.put("gubun", "W" );
					input.put("lvlnum", "70");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_801 = manager.findKsps2000(input);
					
					
					////sp
					try
					{
				
																
																
						DataSet spinputp  = new DataSet();
				
						spinputp.put("srvc_cd",srvc_gubunc); 
						spinputp.put("sp_nm","KSPS2000"); ////
						spinputp.put("tran_no",emp_no); ////
						spinputp.put("tran_nm",emp_nm); ////
						spinputp.put("sp_in_put",input.toString()); ////sp_in_put
						spinputp.put("sp_out_put",ksps2000_801.toString()); ////sp_out_put
				
						returns.findSpLogsave(spinputp);
						
					}catch(Exception e)
					{
			
						System.out.println("==========SP_LOG_SAVE:"+e.toString());  
					}
					
					

					////WEB DB
					message = "This is a message";
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "70");
					input1.put("err_msg", approval5err);
					DataSet rtnsavek4 = returns.findRtnsave(input1);

					input2.put("policy_apln_no", policy_apln_no);
					input2.put("proc_status", "2");
					input2.put("err_msg", approval5err);
					input2.put("recon_id", proc_emp_no);
					DataSet rtnsavek5 = returns.findRtnsave1(input2);


					msg = message;
							url = urlname;
							request.setAttribute("message", msg);
							request.setAttribute("toURL", url);
							return mapping.findForward("alert");

				}
			}
		}
		/**************************************
		 * ksps2000  - E
		 ***************************************/

		saveToken(request);
		return doExecute(mapping, form, request, response);
	}

	/**
	 * CybercenterAction Execute
	 */
	protected abstract ActionForward doExecute(ActionMapping mapping, ActionForm form,	HttpServletRequest request,	HttpServletResponse response)throws Exception;
}

