
package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;
import java.util.*;////StringTokenizer에 사용
import anyframe.util.*;////StringFormater
import anyframe.*;
import anyframe.jsp.*;

import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.manager.CyberSmsManager;
import gtone.changeminer.receipt.form.ReturnForm;
import gtone.changeminer.receipt.manager.ReturnManager;
import gtone.changeminer.receipt.manager.CyberRecManager;

////메일보내기
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.common.utility.Variable;////prumail.xml에서 메일경로

import java.lang.*; 

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;
/**
 * @struts.action
 *      path="/return_tbl"
 *      name="ReturnForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="return_tbl"
 *      path="/return_tbl.jsp"
 *
 */
public  class ReturnAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ ReturnAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();	
			DataSet input4  = new DataSet();	
			DataSet input5  = new DataSet();	
			DataSet input6  = new DataSet();	

			ReturnForm returnForm = (ReturnForm) form;
			////FormToDataset.copyProperties(input, returnForm);			
			
			String id   = request.getParameter("id")	== null ? "" : request.getParameter("id");			
			String policy_apln_no = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");		
			String where = "";
			String id1   = request.getParameter("id1")	== null ? "1" : request.getParameter("id1");	
			String errmsg   = request.getParameter("errmsg")	== null ? "1" : request.getParameter("errmsg");	
			String message   = request.getParameter("message")	== null ? "" : request.getParameter("message");
			String process   = request.getParameter("process")	== null ? "" : request.getParameter("process");	
			
			////세션사용하기
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);			
			
			String proc_emp_no = emp_no;////처리자사번
			String tproc_emp_no = proc_emp_no.toUpperCase();
			
			
			ReturnManager manager = ReturnManager.getInstance();
			CyberRecManager ksps2000 = CyberRecManager.getInstance();////KSPS2000
			PolicychangeManager mailsend = PolicychangeManager.getInstance();////메일
			
			anyframe.log.Logger.debug.println("ID1==========="+id1);					
				
			input.put("where",   where);
			DataSet returnval = manager.findReturn(input);
			request.setAttribute("returnval", returnval);	
			
			////반송일때 KSPS2000에 91(강제종료)			
			input3.put("policy_apln_no", policy_apln_no);
			DataSet resrvc_cd = manager.findSrvc_cd(input3);
			request.setAttribute("resrvc_cd", resrvc_cd);	
			
			String srvc_cd = "";
			String procgb = "";
			String policy = "";
			policy = resrvc_cd.getText("policy");
			srvc_cd = resrvc_cd.getText("srvc_cd");
			anyframe.log.Logger.debug.println("업부구분==========="+srvc_cd);
			
				if(srvc_cd.equals("1") || srvc_cd.equals("4") || srvc_cd.equals("5") || srvc_cd.equals("7"))
				{
					procgb = "OUT";
				}
				else
				{
					procgb = "IN";
				}
				
				if(srvc_cd.equals("1"))
				{
					srvc_cd = "L1";
				}
				else if(srvc_cd.equals("2") || srvc_cd.equals("3"))
				{
					srvc_cd = "P3";
				}
				else if(srvc_cd.equals("4") || srvc_cd.equals("7"))
				{
					srvc_cd = "D1";
				}
				else if(srvc_cd.equals("5"))
				{
					srvc_cd = "E1";
				}
				else if(srvc_cd.equals("6"))
				{
					srvc_cd = "P2";
				}				
				else if(srvc_cd.equals("8"))
				{
					srvc_cd = "P2";
				}				

			anyframe.log.Logger.debug.println("처리구분값=====process======"+process);									
			if(process.equals("S"))
			{
				input4.put("deptcd", "INT");////시스템이름      
				input4.put("init", "     "); ////사원번호        
				input4.put("gubun", "W");////처리구분        
				input4.put("reqnum", "   "); ////요청건수        
				input4.put("fromdt", "        ");////조회시작기준일자
				input4.put("policy", policy);////증권번호        
				input4.put("procdt", "        ");////실제처리일자    
				input4.put("proctm", "      ");////실제처리시간    
				input4.put("inout", procgb);////수납/지급 구분  
				input4.put("procgb", srvc_cd);////이체종류        
				input4.put("lvlnum", "91");////처리상태        
				input4.put("lvlbef", "  ");////처리전상태      
				input4.put("mbkcd", "  ");////모계좌 은행코드 
				input4.put("mbkact" ,"               ");////모계좌 계좌번호 
				input4.put("cltbk", "  "); ////고객 은행코드   
				input4.put("cltact", "               ");////고객 계좌번호   
				input4.put("cltnum", "             ");////고객 주민번호   
				input4.put("procamt", "0000000000000");////이체금액        
				input4.put("procno", "      ");////이체전문번호    
				input4.put("brltcd", "    ");////은행결과        				
				anyframe.log.Logger.debug.println("반송일때 ksps2000에 91번 값 write2==========="+input4);
				DataSet ksps2000_91 = ksps2000.findKsps2000(input4);
				request.setAttribute("ksps2000_91", ksps2000_91);	
				String errrtn = "";				
				anyframe.log.Logger.debug.println("2000에 넣고 리턴값==========="+ksps2000_91.getText("rtn"));
				
				errrtn = ksps2000_91.getText("rtn");
				if(errrtn.equals("0"))										
				{
					input1.put("policy_apln_no", policy_apln_no);
					input1.put("proc_emp_no", proc_emp_no);
					input1.put("proc_status", "1");
					input1.put("err_msg", message);
					anyframe.log.Logger.debug.println("wb_processt의 값들========input==="+input1);
					
					DataSet rtnsave = manager.findRtnsave(input1);
					request.setAttribute("rtnsave", rtnsave);	
					
					input2.put("policy_apln_no", policy_apln_no);				
					input2.put("proc_status", "1");
					input2.put("err_msg", message);	
					anyframe.log.Logger.debug.println("wb_payment=======input2==="+input2);
					DataSet rtnsave1 = manager.findRtnsave1(input2);
					request.setAttribute("rtnsave1", rtnsave1);	
				
					DataSet returnview = manager.findReturnview(input3);
					
					////고객에게 반송사유 문자 보내기
					////2006.12.27 유섭교  0602294 사이버 고객센터 화면 수정 
					String to_year = null;
					String v_toyear = Util.getTodayToYMD();
					to_year = v_toyear.substring(0,8);
					CyberSmsManager manager2 = CyberSmsManager.getInstance();
					DataSet custdate = new DataSet();
					custdate.put("deptcd",    "INT");
					custdate.put("init",      	"CYBER");
					custdate.put("cltno",     	returnview.getText("payor_ssn"));
					custdate.put("schk",	"");
					custdate.put("hchk",	"");  
					custdate.put("htchk",	""); 
					custdate.put("ochk",	"");  
					custdate.put("otchk",	""); 
					custdate.put("mtchk",	"");
					custdate.put("emchk",	"");
					custdate.put("send", 	"");			
					custdate.put("hpost", 	"");
					custdate.put("hadd1", 	"");
					custdate.put("hadd2", 	"");
					custdate.put("htela", 	"");
					custdate.put("htel1", 	"");
					custdate.put("htel2", 	"");
					custdate.put("opost", 	"");
					custdate.put("oadd1", 	"");
					custdate.put("oadd2", 	"");
					custdate.put("oadd3", 	"");
					custdate.put("oadd4", 	"");
					custdate.put("otela", 	"");
					custdate.put("otel1", 	"");
					custdate.put("otel2", 	"");
					custdate.put("mtela", 	"");
					custdate.put("mtel1", 	"");
					custdate.put("mtel2", 	"");
					custdate.put("email", 	"");
					custdate.put("emschk", "");
					custdate.put("emserv", 	"");
					custdate.put("option",	"I");
					custdate.put("sexchk",	"");
					custdate.put("sex",		"");
					custdate.put("namechk", "");
					custdate.put("name",	"");
					DataSet custsms = manager2.findCusttel(custdate);////고객 전화번호
					
					Logger.debug.println( custsms.getText("mtela"));
					Logger.debug.println( custsms.getText("mtel1"));
					Logger.debug.println( custsms.getText("mtel2"));
					String mtel = custsms.getText("mtela")+custsms.getText("mtel1")
									+custsms.getText("mtel2");
					
					Logger.debug.println( "전화번호 : "+mtel);
					DataSet sendSmsInput = new DataSet();
		            sendSmsInput.put("RECEIVER_MOBILE", mtel);
		            sendSmsInput.put("CUS_CALL_BACK",   "15883374");
		            sendSmsInput.put("CUS_MSG",         "[지티원사이버]요청하신 수납처리가 미처리 되었사오니 다시 이용하시기 바랍니다.");
		            sendSmsInput.put("TRAN_ETC1",       to_year);
		            sendSmsInput.put("TRAN_ETC2",       "");
		            sendSmsInput.put("TRAN_ETC3",       "CU");
		            
		            manager2.sendSimpleSms(sendSmsInput);
		            ////고객에게 반송사유 문자 보내기 완료 
					
		            
////		          반송메일 보내기
					request.setAttribute("returnview", returnview);	
					String policy_no = returnview.getText("policy_no");////증번
					
					////고객에게 메일
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber05"));////57
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", returnview.getText("payor_ssn"));
					String owner = "";
					owner = Util.superTrim(ToolString.hanToFull(returnview.getText("payor_nm")));
				
					input6.put("v_to_name", owner);
					input6.put("v_to_email", returnview.getText("payor_email"));				
					
					////고객에게 반송문자 메세지 보내기
					////2006.12.28 유섭교  0602294 사이버 고객센터 화면 수정
					
					
					String mapping1 = "";
					
					String apln_dt = "";
					
					apln_dt = policy_apln_no.substring(0,8);
					anyframe.log.Logger.debug.println("접수일자==========  : "+apln_dt);
					if(apln_dt.length() > 0)
					{
						apln_dt = apln_dt.substring(0,4) + " 년 "+ StringFormater.removeZero(apln_dt.substring(4,6)) +" 월 "+ StringFormater.removeZero(apln_dt.substring(6,8)) +" 일";
					}
					
					to_year = to_year.substring(0,4) +" 년 "+ StringFormater.removeZero(to_year.substring(4,6)) + " 월 " + StringFormater.removeZero(to_year.substring(6,8)) + " 일";
	
					////mapping1 = owner +"|"+returnview.getText("srvc_name") +"|"+returnview.getText("plan_nm") +"|"+returnview.getText("payor_ssn") +"|" + apln_dt + "|"+to_year+"|"+message;
					mapping1 = owner +"|"+returnview.getText("srvc_name") +"|"+returnview.getText("plan_nm") +"|"+returnview.getText("policy_no") +"|" + apln_dt + "|"+to_year+"|"+HtmlUtil.translateNewline(message);
					
					input6.put("v_mapping", mapping1);
					input6.put("v_lp_code", returnview.getText("lp_id"));		
					input6.put("v_policy_number", returnview.getText("policy_no"));		
					input6.put("v_channel", "cyber");
					input6.put("v_ilips_client_id", "");
					anyframe.log.Logger.debug.println("메일 보내기 위한 필드  : "+input6);
					DataSet mailcu = mailsend.sendMail(input6); 
					request.setAttribute("mailcu",mailcu);	
					
					
					
					////LP에게 메일 보내기
					mapping1 = "";
					String lpname = "";
					lpname = Util.superTrim(ToolString.hanToFull(returnview.getText("lpname")));
					mapping1 = lpname +"|"+owner+"|"+returnview.getText("srvc_name") +"|"+returnview.getText("payor_ssn") +"|"+returnview.getText("plan_nm")+"|"+returnview.getText("policy_no")+"|"+apln_dt+"|"+to_year+"|"+HtmlUtil.translateNewline(message);
					input6.put("v_mapping", mapping1);
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber06"));////58
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", returnview.getText("payor_ssn"));
					input6.put("v_to_name", lpname);
					input6.put("v_to_email", returnview.getText("lpemail"));
										
					input6.put("v_lp_code", returnview.getText("lp_id"));		
					anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);				
					
					
				}////정상일때
			}
			
			request.setAttribute("policy_apln_no",policy_apln_no);			
			request.setAttribute("id",id);
			request.setAttribute("id1",id1);
			request.setAttribute("errmsg",errmsg);
			request.setAttribute("message",message);
			request.setAttribute("process",process);
			
			return mapping.findForward("return_tbl");
	

			////Logger.debug.println("################ ReturnAction End ####################");

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
