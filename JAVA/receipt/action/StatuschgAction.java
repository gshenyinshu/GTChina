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

////세션
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
            
            String modeind = request.getParameter("modeind") == null ? "1" : request.getParameter("modeind");////지급/수납
            String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");
            
	     String policy_apln_no = request.getParameter("policy_apln_no") == null ? "" : request.getParameter("policy_apln_no");////접수번호
	     String policy_no = request.getParameter("policy_no") == null ? "" : request.getParameter("policy_no");////접수번호
	     String srvc_cd = request.getParameter("srvc_cd") == null ? "" : request.getParameter("srvc_cd");////업무구분
	     String inout= "";
	     ////2006-09-25:김보영 IN/OUT이 ReturnAction과 달라 수정
	     if(srvc_cd.equals("1") || srvc_cd.equals("4") ||srvc_cd.equals("5") || srvc_cd.equals("7"))
	     {
	     		inout = "OUT";	
	     }
	     else if(srvc_cd.equals("2") || srvc_cd.equals("3") || srvc_cd.equals("6") || srvc_cd.equals("8"))
	     {
	     		inout = "IN";
	     }
	     
	     if(srvc_cd.equals("1")) srvc_cd = "L1";////약대지급
	     if(srvc_cd.equals("2") || srvc_cd.equals("3")) srvc_cd = "P3";////약대,APL상환	     
	     if(srvc_cd.equals("4") || srvc_cd.equals("7")) srvc_cd = "D1";////배당금지급
	     if(srvc_cd.equals("5")) srvc_cd = "E1";////해약환급금
	     if(srvc_cd.equals("6")) srvc_cd = "P2";////보험료납부
	     if(srvc_cd.equals("8")) srvc_cd = "P2";////추가보험료납부
	     String bank_cd = request.getParameter("bank_cd") == null ? "" : request.getParameter("bank_cd");////은행
	     String acct_no = request.getParameter("acct_no") == null ? "" : request.getParameter("acct_no");////계좌
	     String payor_ssn = request.getParameter("payor_ssn") == null ? "" : request.getParameter("payor_ssn");////예금주부번
		
		String errrtn = "";////에러코드

		////세션사용하기
		SessionManager sessionManager = new SessionManager(request);
		String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		String emp_no = sessionManager.getString(Constant.SESSION_USERID);
		String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);		
		
	     	String proc_emp_no = emp_no;////처리자사번	
	     	String tproc_emp_no = proc_emp_no.toUpperCase();			
	     	
		String deptcd  		= "INT";
		String init	   		= "     ";		
		String gubun    	= "W";////처리구분(C,W)
		String reqnum  	= "   ";////요청건수
		String fromdt 		=    "        ";
		String policy	 	=    request.getParameter("policy_no")	== null ? "" : request.getParameter("policy_no");////증권번호		
		String procdt   		= "        ";////실제처리일자
		String proctm   	= "      ";////실제처리시간
		
		
		String procgb  		= srvc_cd;
		
		String lvlnum  		= "";////처리상태
		String lvlbef   		= "  ";////처리전상태
		String mbkcd    	= "  ";////모계좌 은행코드
		String mbkact   	= "               ";////모계좌 계좌번호
		String cltbk    		=  request.getParameter("bank_cd")	== null ? "" : request.getParameter("bank_cd");////은행코드
		String cltact   		= request.getParameter("acct_no")	== null ? "" : request.getParameter("acct_no");////고객 계좌번호
		String cltnum   	= request.getParameter("payor_ssn")	== null ? "" : request.getParameter("payor_ssn");////고객 주민번호
		String procamt = "0000000000000";
		String procno   	= "      ";////이체전문번호 
		String brltcd   		= "    ";////은행결과	
		String chgstatus     = request.getParameter("rtnflag")	== null ? "" : request.getParameter("rtnflag");////상태변경코드값
		anyframe.log.Logger.debug.println("처리상태값()은?==========="+chgstatus);
  		String message = "";
	       StatuschgManager manager = StatuschgManager.getInstance();
	       ReturnManager returns = ReturnManager.getInstance();////반송
	       
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
			
			if(chgstatus.equals(""))////접수
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
					////이로직은 추측이지만 아래와 같이 wb_process에 두번 남기는 이유가
					////사이버센터에서 에러상태를 확인후에 강제로 접수 상태로 변경하려고 하니
					////그 이전 상태가 에러였음을 기록으로 남기고서
					////다시 접수 상태로 변경하려고 했던것 같음.
					////분석을 더 해봐야 알것 같음.
					
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "91");
					input5.put("err_msg", "에러메시지 확인후 강제처리");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);
					////findRtnsave
////					처리역활
////					1.wb_process에  상태값을 입력한다.
					
					input3.put("policy_apln_no", policy_apln_no);
					input3.put("proc_emp_no", proc_emp_no);
					input3.put("proc_status", "10");
					input3.put("err_msg", "");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input3);
					
					DataSet rtnsave0 = returns.findRtnsave(input3);
					message = "상태변경이 접수로 변경되었습니다.";
				}	
			}	
			else if(chgstatus.equals("0"))////성공
			{
				input2.put("lvlnum", "80");
				ksps2000_91 = manager.findKsps2000(input2);										
				
				errrtn = "";
				errrtn = ksps2000_91.getText("rtn");										
				anyframe.log.Logger.debug.println("성공일때 리턴값==========="+errrtn);
				if(errrtn.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "80");
					input5.put("err_msg", "은행처리 결과 성공, HOST처리결과 성공");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);						
					message = "상태변경이 성공으로 변경되었습니다.";
				}	
			}
			else if(chgstatus.equals("2"))////실패
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
					input5.put("err_msg", "은행처리 결과 성공, HOST처리결과 실패");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);												
				}	
				message = "상태변경이 실패로 변경되었습니다.";
			} 
			else if(chgstatus.equals("3")) ////지연
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
					input5.put("err_msg", "은행처리 결과 지연");						
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);						
				}	
				message = "상태변경이 지연으로 변경되었습니다.";
			}			
////			유섭교 2006.12.06 사이버 고객센터 화면 수정
////			반송 처리는 lvlnum 91로 에러메시지　확인후　강제처리
			////  91이 아니라 30이 되어야 하는게 아닌지....
////			wb_tbl_process에는 상태값을 1로 처리를 해준다. "" 접수 , 0은 성공, 1은 반송, 2는 실패, 3은 지연, A는 처리중
			else if(chgstatus.equals("1")) ////반송
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
					input5.put("err_msg", "반송 상태 변경");	//// 30 : 반송（은행처리전）					
					anyframe.log.Logger.debug.println("wb_process update==========="+input5);
					
					DataSet rtnsave3 = returns.findRtnsave(input5);
					////findRtnsave
////					처리역활
////					1.wb_process에  상태값을 입력한다.

				}	
				message = "상태변경이 반송으로 변경되었습니다.";
			}
			
			input6.put("policy_apln_no", policy_apln_no);
			DataSet readrslt = returns.findRsltread(input6);	
			String prslt = "";
			String perrmsg = "";
			prslt = readrslt.getText("rslt").trim();////상태변경전 값
			perrmsg = readrslt.getText("err_msg").trim();
			
			////wb_payment 상태 변경전의 rslt, err_msg
			input5.put("policy_apln_no", policy_apln_no);
			input5.put("proc_emp_no", proc_emp_no);
			input5.put("proc_status", prslt);
			input5.put("err_msg", perrmsg);						
			anyframe.log.Logger.debug.println("wb_payment 상태 변경전의 rslt, err_msg==========="+input5);
			
			DataSet rtnpayment = returns.findchgSave(input5);							
			
			////wb_payment와 동일
			////아래 내용에서 proc_status의 값이 wb_payment와 같으면 않될것 같음
			////    wb_process에서는 ksps2000에서 사용하는 처리상태값이 들어가는것이 맞는것 같음
			//// 그렇다면  proc_status의 값은 30이 맞을것 같음
			//// 그러나 쿼리를 하는 부분을 파악해 보니 
			//// rslt와 proc_status를 조인시에 이용하기 때문에
			//// 히스토리성으로 proc_status를 남기면서 조인시에 필요한 코드값도 넣어줘야 하는 이유가
			//// 있는것을 알았다...
			
			input7.put("policy_apln_no", policy_apln_no);
			input7.put("proc_emp_no", proc_emp_no);
			input7.put("proc_status", chgstatus);
			input7.put("err_msg", message);						
			anyframe.log.Logger.debug.println("wb_payment 상태 변경전의 rslt, err_msg==========="+input7);
			
			DataSet rtnprocess = returns.findchgSave(input7);
			////findchgSave
			////처리 역활
////			1.wb_payment의 상태를 바꾸는 역활을 한다.
////			2.wb_process에 처리시점의 상태값을 입력한다.
////			이 두가지 역활을 수행하고 있다.
	
			////예금주확인이 실패일경우 WB_PAYMENT에 RSLT에 접수(),성공(1),실패(2),지연(3)
////			"" 접수 , 0은 성공, 1은 반송, 2는 실패, 3은 지연, A는 처리중 위에 라인이 틀린것 같음...
			input4.put("policy_apln_no", policy_apln_no);				
			input4.put("proc_status", chgstatus);
			input4.put("err_msg", message);
			anyframe.log.Logger.debug.println("wb_payment input4==========="+input4);					
			DataSet rtnsave1 = returns.findRtnsave1(input4);	
			////findRtnsave1
////			처리역활
////			1.wb_payment의 상태값을 수정한다.
			
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

			anyframe.log.Logger.debug.println("Policyview에서 modeind-----------------: "+modeind);				
			anyframe.log.Logger.debug.println("Policyview에서 srvc_ind-----------------: "+srvc_ind);							


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
			
			////rslt가 공백이면 접수상태인데 그 부분이 누락되어 있음...
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
			anyframe.log.Logger.debug.println("search의 값은=============>"+search);			
	
	
			////search(1:증권번호, 2:계약자, 3;주민번호)
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
	            
		     anyframe.log.Logger.debug.println("SQL에서 WHERE의 INPUT값-----------------: "+where);	
		     anyframe.log.Logger.debug.println("SQL에서 WHERE[1]의 INPUT값-----------------: "+where1);	
	
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
