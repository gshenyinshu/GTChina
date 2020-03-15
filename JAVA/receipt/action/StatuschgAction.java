package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.StatuschgForm;
import gtone.changeminer.receipt.manager.StatuschgManager;
import gtone.changeminer.payment.manager.ReturnManager;
import anyframe.util.*;////StringFormater.fillZero(String,int)

////�1�7�1�9
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;
/**
 * @struts.action
 *      path="/status_chg_list"
 *      name="statuschgForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="status_chg_list"
 *      path="/status_chg_list.jsp"
 * 
 */

public  class StatuschgAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ StatuschgAction Start ####################");

            DataSet input = new DataSet();
            DataSet input2 = new DataSet();
            DataSet input3= new DataSet();
            DataSet input4= new DataSet();
            DataSet input5= new DataSet();
            DataSet input6= new DataSet();
            DataSet input7= new DataSet();
            DataSet inputCount = new DataSet();
            
            StatuschgForm statuschgForm = (StatuschgForm)form;

            FormToDataset.copyProperties(input, statuschgForm);
		
	     String searchgubun 	 = request.getParameter("searchgubun")	== null ? "S" : request.getParameter("searchgubun");		
	     String searchgubun1 	 = request.getParameter("searchgubun1")	== null ? "N" : request.getParameter("searchgubun1");		

            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
            String mode = request.getParameter("mode") == null ? "" : request.getParameter("mode");
            String rslt = request.getParameter("rslt") == null ? "" : request.getParameter("rslt");
            
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");
            
            String modeind = request.getParameter("modeind") == null ? "1" : request.getParameter("modeind");////�3�1�8�6/�2�1�8�8
            String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");
            
	     String policy_apln_no = request.getParameter("policy_apln_no") == null ? "" : request.getParameter("policy_apln_no");////�3�0�2�1�0�7�6�3
	     String policy_no = request.getParameter("policy_no") == null ? "" : request.getParameter("policy_no");////�3�0�2�1�0�7�6�3
	     String srvc_cd = request.getParameter("srvc_cd") == null ? "" : request.getParameter("srvc_cd");////�2�2�0�7�7�9�1�9
	     String inout= "";
	     ////2006-09-25:�8�1�1�5�2�2 IN/OUT�3�3 ReturnAction�7�7 �9�7�9�5 �2�1�3�4
	     if(srvc_cd.equals("1") || srvc_cd.equals("4") ||srvc_cd.equals("5") || srvc_cd.equals("7"))
	     {
	     		inout = "OUT";	
	     }
	     else if(srvc_cd.equals("2") || srvc_cd.equals("3") || srvc_cd.equals("6") || srvc_cd.equals("8"))
	     {
	     		inout = "IN";
	     }
	     
	     if(srvc_cd.equals("1")) srvc_cd = "L1";////�2�0�9�7�3�1�8�6
	     if(srvc_cd.equals("2") || srvc_cd.equals("3")) srvc_cd = "P3";////�2�0�9�7,APL�1�8�6�5	     
	     if(srvc_cd.equals("4") || srvc_cd.equals("7")) srvc_cd = "D1";////�0�9�9�0�8�5�3�1�8�6
	     if(srvc_cd.equals("5")) srvc_cd = "E1";////�6�7�2�0�6�5�8�6�8�5
	     if(srvc_cd.equals("6")) srvc_cd = "P2";////�1�5�6�7�0�1�8�8�1�5
	     if(srvc_cd.equals("8")) srvc_cd = "P2";////�4�1�7�5�1�5�6�7�0�1�8�8�1�5
	     String bank_cd = request.getParameter("bank_cd") == null ? "" : request.getParameter("bank_cd");////�3�1�6�8
	     String acct_no = request.getParameter("acct_no") == null ? "" : request.getParameter("acct_no");////�7�1�3�3
	     String payor_ssn = request.getParameter("payor_ssn") == null ? "" : request.getParameter("payor_ssn");////�2�9�8�5�3�5�1�5�0�7
		
		String errrtn = "";////�2�3�0�7�4�9�9�3

		////�1�7�1�9�1�7�3�0�6�9�8�5
		SessionManager sessionManager = new SessionManager(request);
		String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		String emp_no = sessionManager.getString(Constant.SESSION_USERID);
		String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);		
		
	     	String proc_emp_no = emp_no;////�4�9�0�5�3�1�1�7�0�7	
	     	String tproc_emp_no = proc_emp_no.toUpperCase();			
	     	
		String deptcd  		= "INT";
		String init	   		= "     ";		
		String gubun    	= "W";////�4�9�0�5�7�9�1�9(C,W)
		String reqnum  	= "   ";////�3�9�4�0�7�1�2�1
		String fromdt 		=    "        ";
		String policy	 	=    request.getParameter("policy_no")	== null ? "" : request.getParameter("policy_no");////�3�6�7�1�0�7�6�3		
		String procdt   		= "        ";////�2�5�3�1�4�9�0�5�3�1�3�1
		String proctm   	= "      ";////�2�5�3�1�4�9�0�5�2�7�7�9
		
		
		String procgb  		= srvc_cd;
		
		String lvlnum  		= "";////�4�9�0�5�1�8�5�1
		String lvlbef   		= "  ";////�4�9�0�5�3�7�1�8�5�1
		String mbkcd    	= "  ";////�0�7�7�1�3�3 �3�1�6�8�4�9�9�3
		String mbkact   	= "               ";////�0�7�7�1�3�3 �7�1�3�3�0�7�6�3
		String cltbk    		=  request.getParameter("bank_cd")	== null ? "" : request.getParameter("bank_cd");////�3�1�6�8�4�9�9�3
		String cltact   		= request.getParameter("acct_no")	== null ? "" : request.getParameter("acct_no");////�7�9�7�4 �7�1�3�3�0�7�6�3
		String cltnum   	= request.getParameter("payor_ssn")	== null ? "" : request.getParameter("payor_ssn");////�7�9�7�4 �3�5�0�7�0�7�6�3
		String procamt = "0000000000000";
		String procno   	= "      ";////�3�3�4�7�3�7�0�1�0�7�6�3 
		String brltcd   		= "    ";////�3�1�6�8�7�1�7�7	
		String chgstatus     = request.getParameter("rtnflag")	== null ? "" : request.getParameter("rtnflag");////�1�8�5�1�1�3�7�4�4�9�9�3�7�3
		anyframe.log.Logger.debug.println("�4�9�0�5�1�8�5�1�7�3()�3�1?==========="+chgstatus);
  		String message = "";
	       StatuschgManager manager = StatuschgManager.getInstance();
	       ReturnManager returns = ReturnManager.getInstance();////�0�5�2�2
	       
		if(searchgubun1.equals("C"))
		{	
	
			input2.put("deptcd", deptcd);
			input2.put("init", init);
			input2.put("reqnum", reqnum );
			input2.put("fromdt", fromdt );
			input2.put("policy", policy );
			input2.put("procdt", procdt );
			input2.put("proctm", proctm );
			input2.put("inout", inout  );
			input2.put("procgb", procgb );
			input2.put("lvlnum", lvlnum );
			input2.put("lvlbef", lvlbef );
			input2.put("mbkcd", mbkcd  );
			input2.put("mbkact", mbkact );
			input2.put("cltbk", "  ");
			input2.put("cltact", "               " );
			input2.put("cltnum", "             ");
			input2.put("procamt", "0000000000000");
			input2.put("procno", procno );
			input2.put("brltcd", brltcd );			
			
			input2.put("gubun", "W" );
			
			input2.put("cltbk", cltbk);
			input2.put("cltact", cltact);
			input2.put("cltnum", cltnum);
			input2.put("procamt", procamt);

			DataSet ksps2000_91  = new DataSet();
			
			if(chgstatus.equals(""))////�3�0�2�1
			{
				input2.put("lvlnum", "91");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");										
				if(errrtn.equals("0"))
				{
					input2.put("lvlnum", "10");
					ksps2000_91 = manager.findKsps2000(input2);																
					errrtn = "";
					errrtn = ksps2000_91.getText("rtn");										
				}////ksps2000
				
				if(errrtn.equals("0"))
				{
					////�3�3�0�9�3�2�3�1 �4�1�4�2�3�3�3�1�0�7 �2�3�9�3�2�5 �7�0�3�3 wb_process�2�3 �9�3�0�7 �8�7�8�5�8�9 �3�3�3�9�7�5
					////�1�7�3�3�0�3�1�1�5�5�2�3�1�9 �2�3�0�7�1�8�5�1�0�7 �6�2�3�7�6�3�2�3 �7�6�3�1�0�9 �3�0�2�1 �1�8�5�1�0�9 �1�3�7�4�6�9�0�3�7�9 �6�9�9�1
					////�8�9 �3�3�3�7 �1�8�5�1�7�5 �2�3�0�7�2�1�3�3�3�5 �8�5�0�0�3�7�0�9 �8�7�8�5�7�9�1�9
					////�9�9�2�7 �3�0�2�1 �1�8�5�1�0�9 �1�3�7�4�6�9�0�3�7�9 �6�7�9�5�7�6 �7�0�3�3.
					////�1�9�1�0�3�5 �9�1 �6�7�1�3�2�9 �2�1�7�6 �7�0�3�3.
					
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "91");
					input5.put("err_msg", "�2�3�0�7�0�3�2�7�3�1 �6�2�3�7�6�3 �7�6�3�1�4�9�0�5");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);
					////findRtnsave
////					�4�9�0�5�2�2�6�9
////					1.wb_process�2�3  �1�8�5�1�7�3�3�5 �3�0�0�4�6�3�9�9.
					
					input3.put("policy_apln_no", policy_apln_no);
					input3.put("proc_emp_no", proc_emp_no);
					input3.put("proc_status", "10");
					input3.put("err_msg", "");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input3);
					
					DataSet rtnsave0 = returns.findRtnsave(input3);
					message = "�1�8�5�1�1�3�7�4�3�3 �3�0�2�1�0�9 �1�3�7�4�9�7�2�5�2�8�9�1�9�9.";
				}	
			}	
			else if(chgstatus.equals("0"))////�1�0�7�0
			{
				input2.put("lvlnum", "80");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");										
				anyframe.log.Logger.debug.println("�1�0�7�0�3�1�9�5 �0�5�5�9�7�3==========="+errrtn);
				if(errrtn.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "80");
					input5.put("err_msg", "�3�1�6�8�4�9�0�5 �7�1�7�7 �1�0�7�0, HOST�4�9�0�5�7�1�7�7 �1�0�7�0");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);						
					message = "�1�8�5�1�1�3�7�4�3�3 �1�0�7�0�3�7�0�9 �1�3�7�4�9�7�2�5�2�8�9�1�9�9.";
				}	
			}
			else if(chgstatus.equals("2"))////�2�5�5�9
			{
				input2.put("lvlnum", "70");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");																
				
				if(errrtn.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "70");
					input5.put("err_msg", "�3�1�6�8�4�9�0�5 �7�1�7�7 �1�0�7�0, HOST�4�9�0�5�7�1�7�7 �2�5�5�9");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);												
				}	
				message = "�1�8�5�1�1�3�7�4�3�3 �2�5�5�9�0�9 �1�3�7�4�9�7�2�5�2�8�9�1�9�9.";
			} 
			else if(chgstatus.equals("3")) ////�3�1�2�5
			{
				input2.put("lvlnum", "50");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");																
				
				if(errrtn.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "50");
					input5.put("err_msg", "�3�1�6�8�4�9�0�5 �7�1�7�7 �3�1�2�5");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);						
				}	
				message = "�1�8�5�1�1�3�7�4�3�3 �3�1�2�5�3�7�0�9 �1�3�7�4�9�7�2�5�2�8�9�1�9�9.";
			}			
////			�3�9�1�6�7�1 2006.12.06 �1�7�3�3�0�3 �7�9�7�4�1�1�5�5 �6�1�0�5 �2�1�3�4
////			�0�5�2�2 �4�9�0�5�8�9 lvlnum 91�0�9 �2�3�0�7�0�3�2�7�3�1���6�2�3�7�6�3���7�6�3�1�4�9�0�5
			////  91�3�3 �2�3�9�1�9�5 30�3�3 �9�7�2�5�2�9 �6�9�8�9�7�5 �2�3�9�5�3�1....
////			wb_tbl_process�2�3�8�9 �1�8�5�1�7�3�3�5 1�0�9 �4�9�0�5�0�7 �6�7�3�9�9�9. "" �3�0�2�1 , 0�3�1 �1�0�7�0, 1�3�1 �0�5�2�2, 2�8�9 �2�5�5�9, 3�3�1 �3�1�2�5, A�8�9 �4�9�0�5�3�6
			else if(chgstatus.equals("1")) ////�0�5�2�2
			{
				input2.put("lvlnum", "91");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");																
				
				if(errrtn.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "1");   
					input5.put("err_msg", "�0�5�2�2 �1�8�5�1 �1�3�7�4");	//// 30 : �0�5�2�2���3�1�6�8�4�9�0�5�3�7��					
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);
					////findRtnsave
////					�4�9�0�5�2�2�6�9
////					1.wb_process�2�3  �1�8�5�1�7�3�3�5 �3�0�0�4�6�3�9�9.

				}	
				message = "�1�8�5�1�1�3�7�4�3�3 �0�5�2�2�3�7�0�9 �1�3�7�4�9�7�2�5�2�8�9�1�9�9.";
			}
			
			input6.put("policy_apln_no", policy_apln_no);
			DataSet readrslt = returns.findRsltread(input6);	
			String prslt = "";
			String perrmsg = "";
			prslt = readrslt.getText("rslt").trim();////�1�8�5�1�1�3�7�4�3�7 �7�3
			perrmsg = readrslt.getText("err_msg").trim();
			
			////wb_payment �1�8�5�1 �1�3�7�4�3�7�3�5 rslt, err_msg
			input5.put("policy_apln_no", policy_apln_no);
			input5.put("proc_emp_no", proc_emp_no);
			input5.put("proc_status", prslt);
			input5.put("err_msg", perrmsg);						
			anyframe.log.Logger.debug.println("wb_payment �1�8�5�1 �1�3�7�4�3�7�3�5 rslt, err_msg==========="+input5);
			
			DataSet rtnpayment = returns.findchgSave(input5);							
			
			////wb_payment�2�5 �9�4�3�1
			////�2�3�9�3 �8�9�3�0�2�3�1�9 proc_status�3�5 �7�3�3�3 wb_payment�2�5 �7�0�3�7�0�5 �2�9�9�5�7�6 �7�0�3�3
			////    wb_process�2�3�1�9�8�9 ksps2000�2�3�1�9 �1�7�3�0�6�9�8�9 �4�9�0�5�1�8�5�1�7�3�3�3 �9�1�2�5�7�5�8�9�7�6�3�3 �0�5�8�9�7�6 �7�0�3�3
			//// �8�9�0�4�9�9�0�5  proc_status�3�5 �7�3�3�1 30�3�3 �0�5�3�5�7�6 �7�0�3�3
			//// �8�9�0�7�8�1 �4�7�0�5�0�7 �6�9�8�9 �1�5�1�9�3�5 �5�1�2�4�6�7 �1�5�9�1 
			//// rslt�2�5 proc_status�0�7 �3�5�3�7�2�7�2�3 �3�3�3�0�6�9�8�5 �9�5�0�1�2�3
			//// �6�9�2�1�5�7�0�5�1�0�3�7�0�9 proc_status�0�7 �8�7�8�5�0�5�1�9 �3�5�3�7�2�7�2�3 �6�9�3�9�6�3 �4�9�9�3�7�3�9�3 �8�0�2�5�3�3�2�9 �6�9�8�9 �3�3�3�9�7�5
			//// �3�3�8�9�7�6�3�5 �2�1�2�3�9�9...
			
			input7.put("policy_apln_no", policy_apln_no);
			input7.put("proc_emp_no", proc_emp_no);
			input7.put("proc_status", chgstatus);
			input7.put("err_msg", message);						
			anyframe.log.Logger.debug.println("wb_payment �1�8�5�1 �1�3�7�4�3�7�3�5 rslt, err_msg==========="+input7);
			
			DataSet rtnprocess = returns.findchgSave(input7);
			////findchgSave
			////�4�9�0�5 �2�2�6�9
////			1.wb_payment�3�5 �1�8�5�1�0�7 �0�1�8�7�8�9 �2�2�6�9�3�5 �6�3�9�9.
////			2.wb_process�2�3 �4�9�0�5�2�7�3�9�3�5 �1�8�5�1�7�3�3�5 �3�0�0�4�6�3�9�9.
////			�3�3 �9�3�7�5�3�1 �2�2�6�9�3�5 �2�1�6�8�6�9�7�9 �3�3�9�9.
	
			////�2�9�8�5�3�5�6�2�3�7�3�3 �2�5�5�9�3�1�7�4�3�7 WB_PAYMENT�2�3 RSLT�2�3 �3�0�2�1(),�1�0�7�0(1),�2�5�5�9(2),�3�1�2�5(3)
////			"" �3�0�2�1 , 0�3�1 �1�0�7�0, 1�3�1 �0�5�2�2, 2�8�9 �2�5�5�9, 3�3�1 �3�1�2�5, A�8�9 �4�9�0�5�3�6 �3�1�2�3 �9�5�3�7�3�3 �5�5�0�9�7�6 �7�0�3�3...
			input4.put("policy_apln_no", policy_apln_no);				
			input4.put("proc_status", chgstatus);
			input4.put("err_msg", message);
			anyframe.log.Logger.debug.println("wb_payment input4==========="+input4);					
			DataSet rtnsave1 = returns.findRtnsave1(input4);	
			////findRtnsave1
////			�4�9�0�5�2�2�6�9
////			1.wb_payment�3�5 �1�8�5�1�7�3�3�5 �2�1�3�4�6�3�9�9.
			
		}	
		
	     	 
	     	 
	     	     
		if(searchgubun.equals("S"))
		{	
	            String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
	            String page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));
	            
	            String where = "";
	            String where1 = "";
	            
			
			if(fromdate.length() > 0)
			{
				where = where + " and CONVERT(CHAR(8),apln_dt, 112) >='"+fromdate+"'"; 	
				where1 = where1 + " and CONVERT(CHAR(8),apln_dt, 112)  >='"+fromdate+"'";
			}
			
			if(todate.length() >0)
			{
				where = where + " and CONVERT(CHAR(8),apln_dt, 112)  <= '"+ todate+"'";
				where1 = where1 + " and CONVERT(CHAR(8),apln_dt, 112)  <= '"+ todate+"'";
			}

			anyframe.log.Logger.debug.println("Policyview�2�3�1�9 modeind-----------------: "+modeind);				
			anyframe.log.Logger.debug.println("Policyview�2�3�1�9 srvc_ind-----------------: "+srvc_ind);							


			if(modeind.length() > 0)
			{
				where 	= where + " and mode = "+ modeind;
				where1 	= where1 + " and mode = "+ modeind;
			}
			
			if(srvc_ind.length() > 0)
			{
				where = where + " and srvc_cd = " + srvc_ind;
				where1 = where1 + " and srvc_cd = " + srvc_ind;
			}
			
			////rslt�7�5 �7�0�0�0�3�3�0�5 �3�0�2�1�1�8�5�1�3�7�9�9 �8�9 �1�5�1�9�3�3 �8�5�9�6�9�7�2�5 �3�3�3�3...
			////if(rslt.length() > 0)
			////{
				if(!rslt.equals("T"))
				{
					if(rslt.equals("B"))
					{
						where = where + " and rslt = ''";
						where1 = where1 + " and rslt = ''";
					}
					else
					{
						where = where + " and rslt = '"+ rslt+"'";						
						where1 = where1 + " and rslt = '"+ rslt+"'";
					}
				}
			////}
			anyframe.log.Logger.debug.println("search�3�5 �7�3�3�1=============>"+search);			
	
	
			////search(1:�3�6�7�1�0�7�6�3, 2:�7�1�2�0�3�1, 3;�3�5�0�7�0�7�6�3)
			if(search.equals("1"))
			{
				if(key.length() > 0)
				{
					where = where + "  and policy_no like '%"+ key +"%'	";				
					where1 = where1 + "  and policy_no like '%"+ key +"%'	";				
				}	

			}
			else if(search.equals("2"))
			{
				if(key.length() > 0)
				{
					where = where + "  and acct_nm like '%"+ key +"%'	";				
					where1 = where1 + "  and acct_nm like '%"+ key +"%'	";				
				}
			}
			else if(search.equals("3"))
			{
				if(key.length() > 0)
				{
					String keyvalue1 = "";
					keyvalue1 = anyframe.util.StringFormater.replaceStr(key,"-","");
					where = where + "  and payor_ssn like '%"+ keyvalue1 +"%'	";				
					where1 = where1 + "  and payor_ssn like '%"+ keyvalue1 +"%'	";				
				}
			}	
	
	            input.put("page", page);
	            input.put("where", where);            
	            input.put("subwhere", where1);
	            
		     anyframe.log.Logger.debug.println("SQL�2�3�1�9 WHERE�3�5 INPUT�7�3-----------------: "+where);	
		     anyframe.log.Logger.debug.println("SQL�2�3�1�9 WHERE[1]�3�5 INPUT�7�3-----------------: "+where1);	
	
	            inputCount.put("where", where1);
	
	            DataSet statuschg = manager.findStatuschgList(input);
	            DataSet totalCount = manager.findStatuschg(inputCount);
	
	            request.setAttribute("statuschg", statuschg);
	            request.setAttribute("totalCount", totalCount.getText("count"));
	            request.setAttribute("current", current);
		
		}
	
	
 	   			
            request.setAttribute("fromdate", fromdate);
            request.setAttribute("todate",todate);
            request.setAttribute("modeind",modeind);
            request.setAttribute("srvc_ind",srvc_ind);
            request.setAttribute("rslt", rslt);	            
            request.setAttribute("search", search);
            request.setAttribute("key", key);
            request.setAttribute("searchgubun",searchgubun);
            request.setAttribute("searchgubun1",searchgubun1);
            
            request.setAttribute("policy_apln_no",policy_apln_no);
            request.setAttribute("policy_no",policy_no);
            request.setAttribute("srvc_cd",srvc_cd);
            request.setAttribute("bank_cd",bank_cd);
            request.setAttribute("acct_no",acct_no);
            request.setAttribute("payor_ssn",payor_ssn);
            request.setAttribute("chgstatus",chgstatus);
		
            Logger.debug.println("################ StatuschgAction End ####################");

     		return mapping.findForward("status_chg_list");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}
