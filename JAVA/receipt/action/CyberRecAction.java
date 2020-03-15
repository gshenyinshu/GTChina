////package gtone.home.common.action;
package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.*;

////�4�1�7�5�1�7�6�0
import anyframe.data.DataSet;
import anyframe.log.*;
import gtone.changeminer.common.utility.*;

import java.util.*;////StringTokenizer�2�3 �1�7�3�0
import anyframe.util.*;////StringFormater
import anyframe.*;

////ksps2000
import gtone.changeminer.receipt.manager.AuthManager;
import gtone.changeminer.receipt.manager.CyberRecManager;
import gtone.changeminer.receipt.manager.PremiumsearchManager;
import gtone.changeminer.payment.manager.ReturnManager;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.CybercenterManager;

////�1�7�1�9
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

////SMS�1�5�8�9�8�5
import gtone.changeminer.payment.manager.CyberSmsManager;

////�0�3�3�1�1�5�8�9�8�5
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.common.utility.Variable;////prumail.xml�2�3�1�9 �0�3�3�1�7�4�0�9



public abstract class CyberRecAction extends Action 
{


	/**
	 * �0�9�8�9�3�7 �9�7�2�5�8�9�3�1�3�5 �2�1�1�5�0�7 �5�5�9�3�6�9�8�9 �0�3�2�7�9�3.
	 * �0�9�8�9�3�7�9�7�3�1 �2�9�3�1 �1�8�5�1�3�1 �7�4�3�7 �0�9�8�9�3�7 �5�1�3�3�3�1�0�9 �3�3�9�4.
	 * �0�9�8�9�3�7�9�1 �1�8�5�1�3�1 �7�4�3�7 doExecute() �0�3�2�7�9�3 �6�3�4�9. 
	 */

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)throws Exception 
	{

		/**************************************
		 * �3�3�3�2�2�7 ksps2000 �7�3�1�6 - S
	 	 ***************************************/

		DataSet input = new DataSet();
		DataSet input1 = new DataSet();
		DataSet input2 = new DataSet();
		DataSet input3 = new DataSet();
		DataSet input4 = new DataSet();
		DataSet input5 = new DataSet();
		DataSet input6 = new DataSet();
		DataSet input7 = new DataSet();
		DataSet input8 = new DataSet();////KSPS0450
		DataSet input9 = new DataSet();
		DataSet ksps0340 = new DataSet();////�2�9�8�5�3�5�6�2�3�7
		DataSet policyan = new DataSet();		
		
		DataSet input10 = new DataSet();
		DataSet input11 = new DataSet();
		DataSet smscu = new DataSet();
		DataSet realpay = new DataSet();
		
		CybercenterManager manager3 = CybercenterManager.getInstance();	
		CyberRecManager manager = CyberRecManager.getInstance();		
		ReturnManager returns = ReturnManager.getInstance();////�0�5�2�2
		PlpaymentManager Pmanager = PlpaymentManager.getInstance();////M0181SP1�3�5 �2�5�6�8
		PolicychangeManager mailsend = PolicychangeManager.getInstance();////�0�3�3�1
		CyberSmsManager manager2 = CyberSmsManager.getInstance();
		
		String errrtn = "-1";
		String message = "";
		String bankerr = "-1";
		String proc_status = "";
		
		String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////�4�9�0�5�7�9�1�9	
		String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");			
		String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");	
		
              ////�1�7�1�9�1�7�3�0�6�9�8�5
              SessionManager sessionManager = new SessionManager(request);
              String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
              String emp_no = sessionManager.getString(Constant.SESSION_USERID);
	       String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
		
		String proc_emp_no = emp_no;////�4�9�0�5�3�1�1�7�0�7
		
		policyan.put("policy_apln_no", policy_apln_no);
		
		////KSPS2000�2�3 �3�3�3�2�6�7�9�5 �1�7�3�0
		String deptcd  		= "INT";
		String init	   		= "     ";		
		String gubun    	= "";////�4�9�0�5�7�9�1�9(C,W)
		String reqnum  	= "   ";////�3�9�4�0�7�1�2�1
		String fromdt 		=    request.getParameter("indate")	== null ? "" : request.getParameter("indate");////�3�5�6�7�8�5�3�9�3�1�3�1			
		String policy	 	=    request.getParameter("policy")	== null ? "" : request.getParameter("policy");////�3�6�7�1�0�7�6�3		
		String procdt   		= "        ";////�2�5�3�1�4�9�0�5�3�1�3�1
		String proctm   	= "      ";////�2�5�3�1�4�9�0�5�2�7�7�9
		String inout 		= "IN";////�2�1�8�8(IN), �3�1�8�6(OUT)
		String procgb  		= "L1";////�2�0�9�7�3�1�8�6
		String lvlnum  		= "";////�4�9�0�5�1�8�5�1
		String lvlbef   		= "  ";////�4�9�0�5�3�7�1�8�5�1
		String mbkcd    	= "  ";////�0�7�7�1�3�3 �3�1�6�8�4�9�9�3
		String mbkact   	= "               ";////�0�7�7�1�3�3 �7�1�3�3�0�7�6�3
		String cltbk    		=  request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");////�3�1�6�8�4�9�9�3
		String cltact   		= request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");////�7�9�7�4 �7�1�3�3�0�7�6�3
		String cltnum   	= request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");////�7�9�7�4 �3�5�0�7�0�7�6�3
		String procamt  	= request.getParameter("cash")	== null ? "" : request.getParameter("cash");////�3�3�4�7�8�5�2�2
			  procamt       = StringFormater.fillZero(StringFormater.replaceStr(procamt,",",""),13);
		String procno   	= "      ";////�3�3�4�7�3�7�0�1�0�7�6�3 
		String brltcd   		= "    ";////�3�1�6�8�7�1�7�7
		
		////alert�4�8�3�5 �9�9�3�7�7�9 �9�9�2�7 �6�7�9�0�5�1�3�3�3�1�0�9 �9�7�9�1�2�3�7�3 url
		String returnurl = request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");	
		String urlname =  returnurl + "?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy;		
		anyframe.log.Logger.debug.println("�0�5�5�9 url�3�5 �7�3===================>"+urlname);					

		////�2�9�8�5�3�5�6�2�3�7 �5�5�0�9�1�7�2�1
		String musera = "INTUSER";
		String sbkcda = request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
		String sbknoa = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
		String amount = request.getParameter("amount")	== null ? "" : request.getParameter("amount");	
		String pyrna = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");	
		
		////�2�2�3�7�2�7 M0181SP1�2�3 �1�7�5�4�6�7�7�3�9�1
		String opt1 =  request.getParameter("opt1")	== null ? "P2" : request.getParameter("opt1");	
		String regdate  = request.getParameter("regdate")	== null ? "" : request.getParameter("regdate");	
		String cash =  request.getParameter("cash")	== null ? "" : request.getParameter("cash");	
			  cash       = StringFormater.fillZero(StringFormater.replaceStr(cash,",",""),11);
			  
		String bnkclt =  request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");	
		String bnkcode  = request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");	
		String bnkacct = request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");	
		String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");					
		String tproc_emp_no = proc_emp_no.toUpperCase();
		String v_toyear = Util.getTodayToYMD();
		String  to_year = v_toyear.substring(0,8);
		
		String sending_num = "";	  
		String msg = "";
		String url  = "";
		String sendingnum = "";
		String date = "";
		String rtn0450 = "";
		String errmsg1  = "";
		String ksps0450err = "";
		
		////�2�2�3�7�2�7 M0181SP1�2�3 �1�7�5�4
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
				
				
				
		////�4�9�0�5�3�7 �3�5�6�7
		
		DataSet inputp1  = new DataSet();
		DataSet inputp2  = new DataSet();
		DataSet inputp3  = new DataSet();	


		anyframe.log.Logger.debug.println("�4�9�0�5 �5�5�0�9�1�7�2�1.... �4�9�9�3 ==========="+process);	

		
		inputp1.put("policy", policy);					
		inputp2.put("policy_apln_no", policy_apln_no);
		inputp3.put("proc_emp_no", proc_emp_no);
		
		
		
		String seladvcnt =  request.getParameter("seladvcnt")	== null ? "0" : request.getParameter("seladvcnt");	
		
		
			if(process.equals("R")||process.equals("Y") ){
				anyframe.log.Logger.debug.println("=============== �4�9�0�5�3�7 �3�5�6�7 �6�9�8�5 ==================");	
			
				
				
				PremiumsearchManager manager1 = PremiumsearchManager.getInstance();

				DataSet premiumsearch 	= manager1.findPremiumsearch(inputp1);	
				DataSet payment   		= Pmanager.Inpayment(inputp2, inputp3);
								
				int realpay1 = premiumsearch.getInt("modp");
				int realpay2 = payment.getInt("apln_amt");				
								
								
								
								
				if(realpay1 != realpay2){
				
					 message = "[�4�9�0�5�3�7�3�5�6�7]�2�5�3�0�8�5�2�2�3�3 �6�1�1�5�6�7�0�1�2�5 �9�9�0�6�9�1�9�9.";
					msg = message;
					url = urlname;
					request.setAttribute("message", msg);
					request.setAttribute("toURL", url);
					return mapping.findForward("alert");	
					
				}	
	

	
						}	
			
							
				
		////�2�2�3�7�3�9�4�0�1�5�1�9-�2�7�3�2 or �2�5�2�7�7�9 �3�3�3�2�6�7�9�5
		if(process.equals("Y"))
		{			
			//// (0701875)2007�8�3 10�3�3 16�3�1 �2�7�1�0�6�7 : �3�6�1�6�3�9�4�0 �0�4�3�3. saveToken �3�3�3�0
			//// �1�5�0�9�7�9�4�3 �6�7�3�5�7�4�3�7�8�1 �9�1�1�3�5�7�0�6�4�9�0�3 �9�3�0�7 �3�9�4�0 �9�7�2�5�3�5�7�4�3�7 �3�6�1�6�2�2�3�7�3�9�4�0�3�5 �0�4�8�9 �1�5�1�9.
			if (!isTokenValid(request)) {
				url = urlname;
				Logger.debug.println("saveToken �1�5�0�9�7�9�4�3 �6�7�3�5�7�4�3�7�8�1 �9�1�1�3�5�7�0�6�4�9�0�3 �9�3�0�7 �3�9�4�0 �9�7�2�5�3�5�7�4�3�7 �0�4�6�5.");
				request.setAttribute("message", "�2�2�3�7�3�9�4�0 �3�5�6�8�3�6�2�3 �9�1 �9�9�0�3 �2�2�3�7�3�9�4�0�3�3 �3�6�1�6�2�1�4�0 �9�7�2�5�3�7�0�7�0�9 �3�5�6�8�9�7�3�1 �2�9�2�8�9�1�9�9.");
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			resetToken(request); //// �1�7�1�9�2�3 �3�3�8�9 �5�7�5�3�7�3�3�5 �4�1�8�5�6�1 �6�3�9�9. �3�6�1�6�3�9�4�0�2�7 �3�1�3�5 if�0�1�2�3 �7�5�0�5�7�5 �6�9�8�5 �3�1�6�5.

			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//// (0701875)�3�3�3�6�3�1�8�6 �0�2�3�1�0�7 �3�1�6�7 �8�5�2�2�3�7�9�1 �7�1�3�3�7�7�8�1 �4�9�0�5�3�6�3�7 �7�1 �7�5�0�7�8�5
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			DataSet inAppv = new DataSet();
			inAppv.put("policy_apln_no", 	policy_apln_no);

			DataSet outAppv1 = manager3.findAppvProcessStatus(inAppv);
			String appv_cnt 	= outAppv1.getText("appv_cnt");////�1�8�5�1�4�9�9�3 �2�9�0�1 22, 40, 80�3�7 �7�1�3�3 0�3�1 �7�4�3�7

			if(!appv_cnt.equals("0")){
				////�4�9�0�5 �0�3�1�7�3�1
				msg = "�8�5�2�2�3�7�9�1 �7�1 �3�3�7�7�8�1 �4�9�0�5�3�6�3�0�9�1�9�9. �6�2�3�7 �6�3 �4�9�0�5�6�7�3�5�1�7�3�9.";
				url = urlname;
				request.setAttribute("message", msg);
				request.setAttribute("toURL", url);
				return mapping.findForward("alert");
			}
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			//// (0701875)2007�8�3 10�3�3 16�3�1 �2�7�1�0�6�7 : �2�2�3�7�3�9�4�0 �2�7�3�2�2�7 22�4�9�9�3�0�7 �8�0�8�9�9�9.
			DataSet newSet = new DataSet();
			newSet.put("policy_apln_no", policy_apln_no);
			newSet.put("proc_emp_no", proc_emp_no);
			newSet.put("proc_status", "22");
			newSet.put("err_msg", message);
			DataSet rtnsaveNew = returns.findRtnsave(newSet);

			input11.put("policy_apln_no", policy_apln_no);
			DataSet selPayment = manager3.findRecei(input11);

			////KSPS0340(�2�9�8�5�3�5�6�2�3�7 �5�5�0�9�1�7�2�1			
			ksps0340.put("musera", "INTUSER");
			ksps0340.put("sbkcda", sbkcda);
			ksps0340.put("sbknoa", sbknoa);
			ksps0340.put("amount", "00000000001");
			ksps0340.put("pyrna", pyrna);
			ksps0340.put("procgb", "I");
			
			DataSet bankconf = manager.confBank(ksps0340);
			request.setAttribute("bankconf", bankconf);
			
			String ksps0340_rtn = bankconf.getText("rtn");
			message = bankconf.getText("errmsg");

				input.put("gubun", "W" );
				input.put("lvlnum", "40");
				input.put("cltbk", cltbk);
				input.put("cltact", cltact);
				input.put("cltnum", cltnum);
				input.put("procamt", procamt);
			
				////KSPS2000�2�5�6�8(�3�1�6�8�3�7�0�1�2�2�2�1:40)	
				DataSet ksps2000_40 = manager.findKsps2000(input);	


			DataSet spinputp_  = new DataSet();
				
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
						
	
				spinputp_.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
				spinputp_.put("sp_nm","KSPS2000"); ////sp�0�2
				spinputp_.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
				spinputp_.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
				spinputp_.put("sp_in_put",input.toString()); ////sp_in_put
				spinputp_.put("sp_out_put",ksps2000_40.toString()); ////sp_out_put
	
			  returns.findSpLogsave(spinputp_);
	
			}catch(Exception e)
			{
	
			  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
			}
	
			////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
													
				errrtn = "";
				errrtn = ksps2000_40.getText("rtn");				
				
				////WEBDB �3�3�3�2(�3�1�6�8�3�7�0�1�2�2�2�1:40)
				if(errrtn.equals("0"))
				{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "40");
					input1.put("err_msg", message);						
					DataSet rtnsave2 = returns.findRtnsave(input1);					
				}
				
				////�3�9�6�5�3�1�3�1�0�7 �7�5�3�9�2�3(�6�1�3�9�3�1�3�3 �3�3�4�9�3�3�2�2�2�2�3�1�3�7�3�7�3�1 �6�3�3�7�3�1... �5�5�9�3�6�9�2�1 �3�1�3�1�0�7 �7�5�3�9�2�3)
				DataSet inputval = new DataSet();
				DataSet findValidDay = Pmanager.findValidDay(inputval);
													
				String validday = findValidDay.getText("validday"); //// �3�9�6�5�3�1�3�1 
													
				anyframe.log.Logger.debug.println("�3�9�6�5�3�1�3�1 ====  :"+validday);	
							
				////M0181SP1�2�3 �9�1�2�5�7�3 PARAMETER
				input3.put("deptcd", "INT");
				input3.put("init", tproc_emp_no);
				input3.put("opt1", opt1);
				input3.put("opt2", "U");
				input3.put("policy", policy);
				input3.put("regdate", indate);
				input3.put("paydate", validday);
				input3.put("cash", cash);
				input3.put("prmsusp", "00000000000");
				input3.put("susp", "00000000000");
				input3.put("plpay", "00000000000");
				input3.put("tax", "00000000000");
				input3.put("sndseq", "      ");
				input3.put("bnkclt", bnkclt);
				input3.put("bnkcode", bnkcode);
				input3.put("bnkacct", bnkacct);						
				input3.put("agency", "   ");						
				
				input4.put("policy_apln_no", policy_apln_no);
				input5.put("proc_emp_no", proc_emp_no);

				
				anyframe.log.Logger.debug.println("Action M0181SP1  input3==========="+input3);
				DataSet approval = Pmanager.getApproval(input3, input4, input5);////�7�1�3�9,policy_apln_no,proc_emp_no
				
				////			sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
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
				
				 spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
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
				
				errmsg1 = Util.superTrim(approval.getText("errmsg1")) + Util.superTrim(approval.getText("errmsg2")) + Util.superTrim(approval.getText("errmsg3"));

			//// (0701875)2007.10.16 �2�7�1�0�6�7
			//// �2�3�0�7 �0�3�1�7�3�1�3�6 AAAA�7�5 �5�5�6�5�9�1 �0�1�3�1�7�5 �3�3�3�5�7�4�3�7 SMS �0�9�2�2.
			anyframe.log.Logger.debug.println("�0�5�5�9 �4�9approval.getText(errmsg1)====>"+approval.getText("errmsg1"));
////			AAAA�5�3�2�1�5�7
////			approval.put("errmsg1", "DGAAAA�3�3�3�4�9�1�9�9.");
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
				else if(srvc_gubunc.equals("8"))////�4�1�7�5�1�5�6�7�0�1�2�1�8�8
				{
					strGubun = "�4�1�7�5�1�5�6�7�0�1�2�1�8�8";
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
	
					//// ex) �1�7�3�3�0�3 �3�3�3�6�2�1�8�8 �6�2�3�7�3�9�0�4 100500000 �6�4�8�3�9�4, �2�0�7�1�9�7�4�9 (or�6�7�2�0, �6�5�0�5) 00000�3�9 [�3�1�5�3�3�9�1�7�3�3�0�3]�2�2�3�7�3�9�4�0�3�6 AAAA�7�5 �0�9�7�7�9�7�2�5�2�8�9�1�9�9.");" +
					String strMsg = "[�3�1�5�3�3�9�1�7�3�3�0�3]�3�3�3�6�2�1�8�8�6�2�3�7" + policy + payor_nm + " " + strGubun + Integer.parseInt(procamt) + "�3�9 AAAA�0�9�7�7";
	
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
					//// ex) �1�7�3�3�0�3 �3�3�3�6�2�1�8�8 �6�2�3�7�3�9�0�4 100500000 �6�4�8�3�9�4, �2�0�7�1�9�7�4�9 (or�6�7�2�0, �6�5�0�5) 00000�3�9 [�3�1�5�3�3�9�1�7�3�3�0�3]�2�2�3�7�3�9�4�0�3�6 AAAA�7�5 �0�9�7�7�9�7�2�5�2�8�9�1�9�9.");" +
					String strSubject = policy + " " + payor_nm + ", " + strGubun + " " + Integer.parseInt(procamt) + "�3�9 [�3�1�5�3�3�9�1�7�3�3�0�3]�2�2�3�7�3�9�4�0�3�6 AAAA�7�5 �0�9�7�7�9�7�2�5�2�8�9�1�9�9.";
					//// ex)
					////	�1�7�3�3�0�3 �3�3�3�6�2�1�8�8 �7�5�8�6�1�0 �3�3�3�7�9�1 �6�2�3�7 �0�1�9�2�9�1�9�9.
					////	�3�6�0�7 : 100500000
					////	�7�1�2�0�3�1�0�2 : �6�4�8�3�9�4
					////	�2�0�7�1�9�7�4�9 (or �6�7�2�0, �6�5�0�5) 00000�3�9
					////	�4�9�0�5�3�1 : OOO
					////	�4�9�0�5�2�7�7�9 OO:OO:OO
	
					String strContent = strSubject + "|" + "�1�7�3�3�0�3 �3�3�3�6�2�1�8�8 �7�5�8�6�1�0 �3�3�3�7�9�1 �6�2�3�7 �0�1�9�2�9�1�9�9. <br>"
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

				////M0181SP1�3�5 �9�1�7�9�8�5 �9�9�3�3�2�3 output�3�7�0�9 �3�7�2�2�0�7�6�3�0�7 �0�8�3�3
				sending_num = approval.getText("sndseq");////�3�7�2�2�0�7�6�3
				input6.put("policy_apln_no", policy_apln_no);
				input6.put("sending_num", sending_num);
				input6.put("pay_dt", Util.getTodayToYMD().substring(0,8));
				////�3�7�2�2�0�7�6�3�0�7 WB_PAYMENT�2�3 Sending_num(�3�7�2�2�0�7�6�3)�2�3 SAVE
				DataSet sending = manager.Sendingsave(input6);////�3�7�2�2�0�7�6�3 �3�3�3�2
				
				realpay.put("policy_apln_no", policy_apln_no);
				////realpay.put("pay_amt", approval.getText("netpay"));////�2�5�3�1�8�6�8�5
				realpay.put("pay_amt", cash);////�2�5�3�1�8�6�8�5
				
				errrtn = approval.getText("rtn");
								
				if(errrtn.equals("0"))////KSPS2000�2�5�6�8(�3�1�6�8,HOST:80 �4�9�0�5�1�0�7�0)
				{
					DataSet netpay = manager3.Realpaysave(realpay);////�2�5�3�1�8�6�8�5�3�3�3�2
					
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
	
					  spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
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
					
					////WEB DB�3�3�3�2(�3�1�6�8-HOST�4�9�0�5�1�0�7�0 80)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "80");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave3 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "0");
					input2.put("err_msg", errmsg1);
					DataSet rtnsave4 = returns.findRtnsave1(input2);
					
					
						////WB_PAYMENT�2�3�1�9 �3�0�2�1�0�7�6�3�0�7 �5�5�7�3�3�7�0�9 �6�7�9�0 �3�1�0�1�0�7 Search
						String cltnumt = "";
						cltnumt = cltnum.substring(0,6)+"-"+cltnum.substring(6);
						
						String payor_nm = Util.superTrim(selPayment.getText("payor_nm"));
						String v_to_mail = selPayment.getText("payor_email");
						String mapping1 = "";
						String apln_dt = selPayment.getText("apln_dt").substring(0,10);							
						apln_dt = apln_dt.substring(0,4) +" �8�3 " + apln_dt.substring(5,7) +" �3�3 "+ apln_dt.substring(8,10) +" �3�1";
						
						to_year = null;
						v_toyear = Util.getTodayToYMD();
						to_year = v_toyear.substring(0,8);
						String pay_dt  = "";
						pay_dt = to_year;
						if(pay_dt.length() == 8)
						{
							pay_dt = pay_dt.substring(0,4) + " �8�3 "+ pay_dt.substring(4,6) +" �3�3 "+ pay_dt.substring(6,8) +" �3�1";
						}							
						String apln_amt = "";
						////apln_amt = selPayment.getText("pay_amt");
						apln_amt = selPayment.getText("apln_amt");
						
						////apln_amt = approval.getText("netpay");////�2�5�3�1�8�6�8�5
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
										
						if(selPayment.getText("srvc_cd").equals("6"))
						{
							////LP�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5					
							input10.put("v_mail_type", "03");
							input10.put("v_mail_type_seq", Variable.get("email-id.cyber10"));////67
							input10.put("v_channel_code", "00000030");
							input10.put("v_member_id", cltnum);
							
							input10.put("v_to_email", selPayment.getText("lp_email"));
							
							mapping1 = "";
							String lpname = "";							
							lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
							mapping1 = lpname +"|"+payor_nm+"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+ selPayment.getText("acct_nm") + "|"+selPayment.getText("payor_ssn") +"|" + selPayment.getText("lstpdat").substring(0,4) + "�8�3 " + selPayment.getText("lstpdat").substring(4) + "�3�3" ;
							input10.put("v_mapping", mapping1);
							
							anyframe.log.Logger.debug.println("LP�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3  : "+input10);
							input10.put("v_lp_code", selPayment.getText("lp_id"));		
							DataSet maillp = mailsend.sendMail(input10); 
							request.setAttribute("maillp",maillp);	
							
							/*
							////SM�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5					
							input10.put("v_mail_type", "03");
							input10.put("v_mail_type_seq", Variable.get("email-id.cyber10"));////67
							input10.put("v_channel_code", "00000030");
							input10.put("v_member_id", cltnum);
							
							input10.put("v_to_email", selPayment.getText("sm_email"));
							
							mapping1 = "";
							String sm_name = "";							
							sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));
							mapping1 = sm_name +"|"+payor_nm+"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+ selPayment.getText("acct_nm") + "|"+selPayment.getText("payor_ssn") +"|" + selPayment.getText("lstpdat").substring(0,4) + "�8�3 " + selPayment.getText("lstpdat").substring(4) + "�3�3" ;
							input10.put("v_mapping", mapping1);
							
							anyframe.log.Logger.debug.println("SM�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3  : "+input10);
							input10.put("v_lp_code", selPayment.getText("sm_code"));		
							DataSet mailsm = mailsend.sendMail(input10); 
							request.setAttribute("mailsm",mailsm);								
							*/
						}
						else
						{								
							////LP�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5					
							input10.put("v_mail_type", "03");
							input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
							input10.put("v_channel_code", "00000030");
							input10.put("v_member_id", cltnum);
							
							input10.put("v_to_email", selPayment.getText("lp_email"));
							
							mapping1 = "";
							String lpname = "";							
							lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
							mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
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
							
							mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
							input10.put("v_mapping", mapping1);
							
							anyframe.log.Logger.debug.println("SM�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3  : "+input10);
							input10.put("v_lp_code", selPayment.getText("sm_code"));		
							DataSet mailsm = mailsend.sendMail(input10); 
							request.setAttribute("mailsm",mailsm);								
							*/
						}
						
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
					msg = errmsg1;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");														
				}
				else if(errrtn.equals("3"))////KSPS2000�2�5�6�8-�3�1�6�8�4�9�0�5�3�1�2�5:50
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
	
					  spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
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
					
					////WEB DB�3�3�3�2(�3�1�6�8-HOST�4�9�0�5 �3�1�2�5 50)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "50");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave5 = returns.findRtnsave(input1);
					
					////WB_PAYMENT�2�3 3(�3�1�2�5) SAVE
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "3");
					input2.put("err_msg", errmsg1);
					DataSet rtnsave6 = returns.findRtnsave1(input2);
					
					////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
					message = "�3�1�6�8 �4�9�0�5 �3�1�2�5�3�0�9�1�9�9. �3�1�3�4�2�7�7�9�6�3 �9�9�2�7 �6�2�3�7�6�9�1�7�3�9.";
					msg = message;
	            			url = urlname;
	            			request.setAttribute("message", errmsg1);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");																										
				}
				else if(errrtn.equals("1") || errrtn.equals("2"))////FILE OPEN ERROR, DATA VALID CHECK�2�7�0�1, �3�1�6�8�4�9�0�5 �6�3 CAPSIL�2�7�0�1				
				{
					////KSPS2000�2�5�6�8 (�8�5�5�3�2�7�0�1 :99) �3�1�6�8�4�9�0�5 �3�7,�6�3 �2�3�0�7�0�9�1�6 �7�1�0�5�3�1 �6�2�3�7�6�9�3�9	
					input.put("gubun", "W" );
					input.put("lvlnum", "99");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_99 = manager.findKsps2000(input);	
					
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
	
					  spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
					  spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
					  spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
					  spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
					  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
					  spinputp.put("sp_out_put",ksps2000_99.toString()); ////sp_out_put
	
					  returns.findSpLogsave(spinputp);
	
					}catch(Exception e)
					{
	
					  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
					}
	
					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
					
					////WB_PROCESS�2�3 �3�3�3�2(�8�5�5�3 �2�7�0�1 -99)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "99");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave7 = returns.findRtnsave(input1);
					
					////WB_PROCESS�2�3 �3�3�3�2(�8�5�5�3 �2�7�0�1 -99)
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "2");
					input2.put("err_msg", errmsg1);
					DataSet rtnsave8 = returns.findRtnsave1(input2);
					
					////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
					message = "�3�1�6�8�4�9�0�5 �3�7,�6�3 �2�3�0�7�3�0�9�1�9�9. �7�1�0�5�3�1 �6�2�3�7 �6�9�3�9�6�6�9�1�9�9.";
					msg = errmsg1;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");																																		
				}
				else if(errrtn.equals("4"))////�3�1�6�8�2�5�5�9
				{
					
					////KSPS2000�2�5�6�8(�3�1�6�8�4�9�0�5�7�1�7�7 �2�5�5�9 & �3�9�3�0�2�1�7�5�8�6 61), WB_PAYMENT�2�3�1�9�8�9 �0�5�2�2�3�7�0�9 �4�9�0�5
					input.put("gubun", "W" );
					input.put("lvlnum", "61");
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
	
					  spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
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
					
					////WEB DB�3�3�3�2(�3�1�6�8�4�9�0�5�7�1�7�7 �2�5�5�9-61)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "61");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave9 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "2");
					input2.put("err_msg", errmsg1);
					DataSet rtnsave10 = returns.findRtnsave1(input2);
					
					////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
					message = "�6�7�9�0�3�9�4�0�3�5 �3�1�6�8�4�9�0�5 �2�5�5�9�3�0�9�1�9�9. �3�5�7�9�6�2�3�7�0�6 �3�9�2�5�6�8�6�9�1�7�3�9.";
					msg = errmsg1;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");																																									
				}
				else if(errrtn.equals("5"))////HOST�4�9�0�5�2�5�5�9 (DISB, PPAY,MODP)
				{
					input.put("gubun", "W" );
					input.put("lvlnum", "70");
					input.put("cltbk", cltbk);
					input.put("cltact", cltact);
					input.put("cltnum", cltnum);
					input.put("procamt", procamt);
					DataSet ksps2000_70w = manager.findKsps2000(input);	
					
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
	
					  spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
					  spinputp.put("sp_nm","KSPS2000"); ////sp�0�2
					  spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
					  spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
					  spinputp.put("sp_in_put",input.toString()); ////sp_in_put
					  spinputp.put("sp_out_put",ksps2000_70w.toString()); ////sp_out_put
	
					  returns.findSpLogsave(spinputp);
	
					}catch(Exception e)
					{
	
					  System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
					}
	
					////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2
					
					////WEB DB�3�3�3�2(�3�1�6�8�1�0�7�0+HOST�2�5�5�9)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "70");
					input1.put("err_msg", errmsg1);						
					DataSet rtnsave11 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "3");////�3�1�2�5�3�7�0�9 �4�9�0�5
					input2.put("err_msg", errmsg1);
					DataSet rtnsave12 = returns.findRtnsave1(input2);
					
					////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
					message = "HOST �4�9�0�5 �2�5�5�9�3�0�9�1�9�9. �7�1�0�5�3�1�2�3�7�5 �0�1�3�5�6�9�1�7�3�9.";
					msg = errmsg1;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");																																											
					
				}
			
		}////�2�2�3�7�3�9�4�0 or �2�5�2�7�7�9�3�3�3�2�6�7�9�5 �8�2	
		else if(process.equals("R"))////�3�1�2�5�7�1�3�7�7�4�3�7 �3�1�9�4 PGM�4�9�0�5�2�5 �3�0�2�1�3�1�9�5 �2�2�3�7�4�9�0�5
		{
			DataSet wbprostatus = manager.findProcstatus(policyan);
			proc_status = "";
			proc_status = wbprostatus.getText("proc_status");
						
			////KSPS0450�3�5 �4�9�0�5�6�9�8�5 �3�1�6�3 �4�9�0�5�0�9�5�7			
			DataSet sendall = manager.findSend(policyan);	
			sendingnum = sendall.getText("sending_num");////�3�7�2�2�0�7�6�3
			date = sendall.getText("date");////�3�7�2�2�3�1�3�1
			
			input7.put("musera", "INTUSER");
			input7.put("snddate", date);
			input7.put("sndseq", sendingnum);
			DataSet ksps0450 = manager.findIsaogong(input7);////KSPS0450�2�5�6�8
						
			rtn0450 = ksps0450.getText("rtn");
			ksps0450err = ksps0450.getText("errmsg");////�2�3�0�7�0�3�1�7�3�1
			
			if(rtn0450.equals("1") || rtn0450.equals("3"))
			{
				message = "�5�5�0�9�8�9�9�9�2�5�6�8�3�6 �2�3�0�7�0�6 �3�1�2�5�7�1�3�0�9�1�9�9. �7�1�0�5�3�1�2�3�7�5 �0�1�3�5�6�9�1�7�3�9.";
				msg = ksps0450err;
	    			url = urlname;
	    			request.setAttribute("message", msg);	
	    			request.setAttribute("toURL", url);	
	    			return mapping.findForward("alert");
			}
			else if(rtn0450.equals("4"))////�3�1�6�8�2�5�5�9�3�7 �7�4�3�7
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
	
				  spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
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
				errrtn = ksps2000_61.getText("rtn");				
				if(errrtn.equals("0"))
				{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "60");
					input1.put("err_msg", ksps0450err);						
					DataSet rtnsavek13 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "2");
					input2.put("err_msg", ksps0450err);
					DataSet rtnsavek14 = returns.findRtnsave1(input2);	
					
					
					////KSPS0450D�3�5 �2�5�6�8�6�3 �2�3�0�7�4�9�9�3(4) �3�1�6�8�2�5�5�9-�7�9�7�4�2�3�7�5 �3�1�6�8�4�9�0�5 �2�5�5�9 SMS�3�7�2�2, �3�1�6�8�3�5�7�9 �6�2�3�7�9�4 �3�9�4�0				
					////�7�9�7�4�2�3�7�5 SMS�1�5�8�9�8�5
					
					/*
					String cltnumt = "";
					cltnumt = cltnum.substring(0,6)+"-"+cltnum.substring(6);
					input11.put("policy_apln_no", policy_apln_no);
					
					DataSet selPayment = manager3.findRecei(input11);
					
					String payor_nm = selPayment.getText("payor_nm");
					String v_to_mail = selPayment.getText("payor_email");
					String mapping1 = "";
					String apln_dt = selPayment.getText("apln_dt").substring(0,10);							
					apln_dt = apln_dt.substring(0,4) +" �8�3 " + apln_dt.substring(5,7) +" �3�3 "+ apln_dt.substring(8,10) +" �3�1";
					
					to_year = null;
					v_toyear = Util.getTodayToYMD();
					to_year = v_toyear.substring(0,8);
					String pay_dt  = "";
					pay_dt = to_year;
					if(pay_dt.length() == 8)
					{
						pay_dt = pay_dt.substring(0,4) + " �8�3 "+ pay_dt.substring(4,6) +" �3�3 "+ pay_dt.substring(6,8) +" �3�1";
					}							
					String apln_amt = "";
					apln_amt = selPayment.getText("apln_amt");
					apln_amt = Util.addComma(apln_amt);
								
					String owner_mobile  	= selPayment.getText("payor_phone");////�6�1�9�3�5�9
					String lp_code       	= "";////LP�1�7�0�7
					String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////�8�5�2�2
					String gubun1         = selPayment.getText("pay_cd");////�1�8�6�5�7�9�1�9					
					String sms_code = "";
					String srvc_gubunc = "";
					String owner = "";
					owner = Util.superTrim(ToolString.hanToFull(selPayment.getText("payor_nm")));
					
					srvc_gubunc = selPayment.getText("srvc_cd");
					sms_code = "8";
					String indate1 = "";
					indate1 = selPayment.getText("policy_apln_no").substring(0,8);
					
					smscu.put("v_sms_code",  		sms_code);////SMS �0�3�2�7�3�1 �2�2�0�7�4�9�9�3
					smscu.put("v_success_yn",  	"1");////0-�1�0�7�0,1-�2�5�5�9
					smscu.put("v_policy_no",  	selPayment.getText("policy_no"));
					smscu.put("v_name",  			owner);
					smscu.put("v_owner",  		owner);
					smscu.put("v_owner_mobile",  	owner_mobile);
					smscu.put("v_lp_code",  		lp_code);
					smscu.put("v_amt",  			amt);
					smscu.put("v_gubun",  		gubun1);
					
					smscu.put("tran_etc1",  		indate1);////�3�0�0�4�8�9�3�9
					smscu.put("tran_etc2",  		selPayment.getText("policy_apln_no"));////�2�5�3�9 �2�5�0�7
					smscu.put("v_pr",  			"AD");					
					DataSet sms_ins_cu = manager2.findClientSms(smscu);////CU�0�7	
					*/
									
				}////WEB DB�3�3�3�2(�3�1�6�8�4�9�0�5�7�1�7�7 �2�5�5�9-61									
			}
			else if(rtn0450.equals("0"))////KSPS0450�2�5�6�8�6�3 �0�5�5�9�7�3�3�3 0�3�7�7�4�3�7(�3�1�6�8�3�4�1�8�4�9�0�5)
			{
				
				////�3�9�6�5�3�1�3�1�0�7 �7�5�3�9�2�3(�6�1�3�9�3�1�3�3 �3�3�4�9�3�3�2�2�2�2�3�1�3�7�3�7�3�1 �6�3�3�7�3�1... �5�5�9�3�6�9�2�1 �3�1�3�1�0�7 �7�5�3�9�2�3)
				DataSet inputval = new DataSet();
				DataSet findValidDay = Pmanager.findValidDay(inputval);
												
				String validday = findValidDay.getText("validday"); //// �3�9�6�5�3�1�3�1 
												
				anyframe.log.Logger.debug.println("�3�9�6�5�3�1�3�1 ====  :"+validday);	
				
				input3.put("deptcd", "INT");
				input3.put("init", tproc_emp_no);
				input3.put("opt1", opt1);
				input3.put("opt2", "H");
				input3.put("policy", policy);
				input3.put("regdate", indate);
				input3.put("paydate", validday);
				input3.put("cash", cash);
				input3.put("prmsusp", "00000000000");
				input3.put("susp", "00000000000");
				input3.put("plpay", "00000000000");
				input3.put("tax", "00000000000");
				input3.put("sndseq", "      ");
				input3.put("bnkclt", bnkclt);
				input3.put("bnkcode", bnkcode);
				input3.put("bnkacct", bnkacct);						
				input3.put("agency", "   ");						
									
				input5.put("proc_emp_no", proc_emp_no);
				
				anyframe.log.Logger.debug.println("�3�1�2�5�3�7�7�4�3�7 M0181SP1  input3==========="+input3);
				DataSet approval3 = Pmanager.getApproval(input3, policyan, input5);////�7�1�3�9,policy_apln_no,proc_emp_no
				
				
				////			sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �2�7�3�2
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
				
				 spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
				 spinputp.put("sp_nm","M0181SP1"); ////sp�0�2
				 spinputp.put("tran_no",emp_no); ////�4�9�0�5�3�9�4�0�3�1 �0�7�6�3				
				 spinputp.put("tran_nm",emp_nm); ////�4�9�0�5�3�9�4�0�3�1 �8�1�3�9
				 spinputp.put("sp_in_put",input3.toString()); ////sp_in_put
				 spinputp.put("sp_out_put",approval3.toString()); ////sp_out_put
				
				 returns.findSpLogsave(spinputp);
				
				}catch(Exception e)
				{
				
				 System.out.println("==========SP_LOG_SAVE:"+e.toString());  ////sp�0�9�8�9�0�7 �8�0�9�9�7�5 �2�3�0�7�7�5 �0�9�1�6�2�7�2�3�8�9 �9�9�0�3�4�9�0�5�0�7 �3�1�6�7... �0�9�8�9�0�7 �4�0�8�9�9�9. 
				}
				
				////sp �0�9�8�9�0�7 �3�1�6�3 �0�9�3�2... �8�2				
				
				
				////M0181SP1�3�5 �9�1�7�9�8�5 �9�9�3�3�2�3 output�3�7�0�9 �3�7�2�2�0�7�6�3�0�7 �0�8�3�3
				sending_num = approval3.getText("sndseq");////�3�7�2�2�0�7�6�3
				input6.put("policy_apln_no", policy_apln_no);
				input6.put("sending_num", sending_num);
				input6.put("pay_dt", Util.getTodayToYMD().substring(0,8));
				DataSet sending = manager.Sendingsave(input6);////�3�7�2�2�0�7�6�3 �3�3�3�2
				
				realpay.put("policy_apln_no", policy_apln_no);
				realpay.put("pay_amt", approval3.getText("netpay"));////�2�5�3�1�8�6�8�5
				realpay.put("pay_amt", cash);////�2�5�3�1�8�6�8�5
				
				errrtn = approval3.getText("rtn");
				
				if(errrtn.equals("0"))////�3�4�1�8�3�7�0�9 �4�9�0�5�9�1�7�4�3�7
				{
					
					DataSet netpay = manager3.Realpaysave(realpay);////�2�5�3�1�8�6�8�5�3�3�3�2
					
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
	
					  spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
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
					
					////WEB DB�3�3�3�2(�3�1�6�8-HOST�4�9�0�5�1�0�7�0 80)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "80");
					input1.put("err_msg", ksps0450err);						
					DataSet rtnsavek15 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "0");
					input2.put("err_msg", ksps0450err);
					DataSet rtnsavek16 = returns.findRtnsave1(input2);
					
					////WB_PAYMENT�2�3�1�9 �3�0�2�1�0�7�6�3�0�7 �5�5�7�3�3�7�0�9 �6�7�9�0 �3�1�0�1�0�7 Search
					String cltnumt = "";
					cltnumt = cltnum.substring(0,6)+"-"+cltnum.substring(6);
					input11.put("policy_apln_no", policy_apln_no);
					
					DataSet selPayment = manager3.findRecei(input11);
					
					String payor_nm = Util.superTrim(selPayment.getText("payor_nm"));
					String v_to_mail = selPayment.getText("payor_email");
					String mapping1 = "";
					String apln_dt = selPayment.getText("apln_dt").substring(0,10);							
					apln_dt = apln_dt.substring(0,4) +" �8�3 " + apln_dt.substring(5,7) +" �3�3 "+ apln_dt.substring(8,10) +" �3�1";
					
					to_year = null;
					v_toyear = Util.getTodayToYMD();
					to_year = v_toyear.substring(0,8);
					String pay_dt  = "";
					pay_dt = to_year;
					if(pay_dt.length() == 8)
					{
						pay_dt = pay_dt.substring(0,4) + " �8�3 "+ pay_dt.substring(4,6) +" �3�3 "+ pay_dt.substring(6,8) +" �3�1";
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
												
					if(selPayment.getText("srvc_cd").equals("6"))
					{
						apln_amt  = "";
						////apln_amt = Util.addComma(approval3.getText("netpay"));
						apln_amt = Util.addComma(apln_amt = selPayment.getText("apln_amt"));
						
						
						////LP�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5					
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber10"));////67
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
						
						input10.put("v_to_email", selPayment.getText("lp_email"));
						
						mapping1 = "";
						String lpname = "";							
						lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
						mapping1 = lpname +"|"+payor_nm+"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+ selPayment.getText("acct_nm") + "|"+selPayment.getText("payor_ssn") +"|" + selPayment.getText("lstpdat").substring(0,4) + "�8�3 " + selPayment.getText("lstpdat").substring(4) + "�3�3" ;
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("LP�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3  : "+input10);
						input10.put("v_lp_code", selPayment.getText("lp_id"));		
						DataSet maillp = mailsend.sendMail(input10); 
						request.setAttribute("maillp",maillp);	
						/*
						////SM�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5					
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber10"));////67
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
						
						input10.put("v_to_email", selPayment.getText("sm_email"));
						
						mapping1 = "";
						String sm_name = "";							
						sm_name = Util.superTrim(ToolString.hanToFull(selPayment.getText("sm_name")));
						mapping1 = sm_name +"|"+payor_nm+"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+ selPayment.getText("acct_nm") + "|"+selPayment.getText("payor_ssn") +"|" + selPayment.getText("lstpdat").substring(0,4) + "�8�3 " + selPayment.getText("lstpdat").substring(4) + "�3�1" ;
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("SM�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3  : "+input10);
						input10.put("v_lp_code", selPayment.getText("sm_code"));		
						DataSet mailsm = mailsend.sendMail(input10); 
						request.setAttribute("mailsm",mailsm);								
						*/
					}
					else
					{				
						////LP�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5
						input10.put("v_mail_type", "03");
						input10.put("v_mail_type_seq", Variable.get("email-id.cyber04"));////55
						input10.put("v_channel_code", "00000030");
						input10.put("v_member_id", cltnum);
						
						input10.put("v_to_email", selPayment.getText("lp_email"));
						
						mapping1 = "";
						String lpname = "";							
						lpname = Util.superTrim(ToolString.hanToFull(selPayment.getText("lpname")));
						mapping1 = lpname +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
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
						
						mapping1 = sm_name +"|"+payor_nm+"|"+selPayment.getText("srvc_name") +"|"+cltnumt +"|"+selPayment.getText("plan_nm")+"|"+selPayment.getText("policy_no")+"|"+apln_dt+"|"+pay_dt+"|"+apln_amt + "�3�9" +"|"+selPayment.getText("bank_name") +" "+ selPayment.getText("acct_no") +"|"+" ";
						input10.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("SM�2�3�7�5 �0�3�3�1 �1�5�8�9�8�5 �3�1�6�3 �6�9�9�3  : "+input10);
						input10.put("v_lp_code", selPayment.getText("sm_code"));		
						DataSet mailsm = mailsend.sendMail(input10); 
						request.setAttribute("mailsm",mailsm);								
						*/
					}
					
					////�7�9�7�4�2�3�7�5 SMS�1�5�8�9�8�5
								
					String owner_mobile  	= selPayment.getText("payor_phone");////�6�1�9�3�5�9
					String lp_code       	= "";////LP�1�7�0�7
					String amt           	= Util.addComma(StringFormater.removeZero(selPayment.getText("apln_amt")));////�8�5�2�2
					String gubun1        = selPayment.getText("pay_cd");////�1�8�6�5�7�9�1�9					
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
					msg = ksps0450err;
	            			url = urlname;
	            			request.setAttribute("message", msg);	
	            			request.setAttribute("toURL", url);	
	            			return mapping.findForward("alert");																									
				}
				else if(errrtn.equals("1") || errrtn.equals("2") || errrtn.equals("5"))
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
	
					  spinputp.put("srvc_cd","6"); ////�4�9�0�5�2�2�0�7�4�9�9�3
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
					
					////WEB DB�3�3�3�2(�2�5�5�9 70)
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "70");
					input1.put("err_msg", ksps0450err);						
					DataSet rtnsavek17 = returns.findRtnsave(input1);
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "2");
					input2.put("err_msg", ksps0450err);
					DataSet rtnsavek18 = returns.findRtnsave1(input2);
					
					////�4�9�0�5 �1�0�7�0 �0�3�1�7�3�1
					message = "�2�5�5�9�6�9�2�1�2�8�9�1�9�9. �7�1�0�5�3�1�2�3�7�5 �0�1�3�5�6�9�1�7�3�9.";
					msg = ksps0450err;
        			url = urlname;
        			request.setAttribute("message", msg);	
        			request.setAttribute("toURL", url);	
        			return mapping.findForward("alert");																				
				}////M0181SP1�3�5 �2�1�6�8�6�3 �0�5�5�9�4�9�9�3�7�5 1,2,5�3�7�7�4�3�7					
				}////KSPS0450�3�3 0�3�7�7�4�3�7
			
		}////�3�1�2�5�7�1�3�7�7�4�3�7 �3�1�9�4 PGM�4�9�0�5�2�5 �3�0�2�1�3�1�9�5 �2�2�3�7�4�9�0�5
		
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
