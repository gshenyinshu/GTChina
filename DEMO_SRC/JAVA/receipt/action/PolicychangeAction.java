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

////import gtone.changeminer.receipt.action.*;
import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.PolicyrealForm;

////메일보내기
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.common.utility.Variable;////prumail.xml에서 메일경로

////SMS
import gtone.changeminer.receipt.manager.CyberSmsManager;

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

/**
 * @struts.action
 *      path="/policy_change" 
 *      name="policyrealForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="policy_realtime"
 *      path="/policy_realtime.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class PolicychangeAction extends Action
{
  public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)        
    throws Exception
    {
        try
        {
            Logger.debug.println("################ PolicychangeAction Start ####################");

            DataSet input = new DataSet();
            DataSet input0 = new DataSet();
            DataSet input1 = new DataSet();
            DataSet input2 = new DataSet();
            DataSet input3 = new DataSet();
            DataSet input4 = new DataSet();
            DataSet input5 = new DataSet();
            DataSet input6 = new DataSet();
            DataSet input7 = new DataSet();
            DataSet input8 = new DataSet();
            DataSet input9 = new DataSet();
            DataSet input10 = new DataSet();
            DataSet input11 = new DataSet();
            DataSet mobiletel = new DataSet();
            
            PolicyrealForm policyrealForm = (PolicyrealForm)form;
            ////FormToDataset.copyProperties(input, policyrealForm);
		
		 	PolicychangeManager manager = PolicychangeManager.getInstance();
		 
		     ////세션사용하기
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
			String tproc_emp_no = emp_no.toUpperCase();
            
			
			////SMS
			CyberSmsManager manager2 = CyberSmsManager.getInstance();
		 
	       	DataSet policychangelist = manager.findPolicychangeList(input);           
			
			int cnt = policychangelist.getCount("indate");
			
			for(int i=0; i<cnt; i++)
			{
				String indate  = policychangelist.getText("indate",i);
				String seq_no  = policychangelist.getText("seq_no",i); 
				input0.put("indate",	indate);
				input0.put("seq_no",	seq_no);

				
				////web_db에서 해당 데이터 가져오기
				String srvc_cd = policychangelist.getText("srvc_cd",i); 
				String srvc_gubun = srvc_cd;
				if( srvc_cd.equals("A") )
				{
					input1.put("gubun", "A");
				}
				else if( srvc_cd.equals("B") || srvc_cd.equals("C") || srvc_cd.equals("D"))
				{
					input1.put("gubun", "BCD");
				}
				else if( srvc_cd.equals("E") || srvc_cd.equals("F") )
				{
					input1.put("gubun", "EF");
				}
				else if( srvc_cd.equals("G") || srvc_cd.equals("H") || srvc_cd.equals("I") || srvc_cd.equals("J") )
				{
					input1.put("gubun", "GHIJ");
				}
				anyframe.log.Logger.debug.println("PolicychangeAction (구분코드)----  input1  : "+input1 );				
				DataSet policychange_wb = manager.findPolicychange_wb(input0,input1); 
				
				
				
				
			/****************************
		 	* host에 insert하기 - S		*
		 	*****************************/
			String rtn = "-1";
			String prtime = anyframe.util.DateTime.getFormatString("HHmmss");
    			String prdate = Util.getTodayToYMD().substring(0,8);
    			input1.put("gubun", srvc_cd);
				if( srvc_cd.equals("A") )
				{
					input3.put("deptcd",    "INT");
					input3.put("init",      tproc_emp_no);
					input3.put("cltno",     policychange_wb.getText("ssn"));
					input3.put("schk",	    policychange_wb.getText("post_send_yn"));
					input3.put("hchk",	    policychange_wb.getText("home_addr_yn"));
					input3.put("htchk",	    policychange_wb.getText("home_phone_yn"));
					input3.put("ochk",	    policychange_wb.getText("office_addr_yn"));
					input3.put("otchk",	    policychange_wb.getText("office_phone_yn"));
					input3.put("mtchk",	    policychange_wb.getText("mobile_yn"));
					input3.put("emchk",	    policychange_wb.getText("email_yn"));
					input3.put("send", 	    policychange_wb.getText("post_send"));
					input3.put("hpost", 	policychange_wb.getText("home_post"));
					input3.put("hadd1", 	policychange_wb.getText("home_addr1"));
					input3.put("hadd2", 	policychange_wb.getText("home_addr2"));
					input3.put("htela", 	StringFormater.fillSpace(policychange_wb.getText("home_phone1"),4));
					input3.put("htel1", 	StringFormater.fillSpace(policychange_wb.getText("home_phone2"),4));
					input3.put("htel2", 	StringFormater.fillSpace(policychange_wb.getText("home_phone3"),4));
					input3.put("opost", 	policychange_wb.getText("office_post"));
					input3.put("oadd1", 	policychange_wb.getText("office_addr1"));
					input3.put("oadd2", 	policychange_wb.getText("office_addr2"));
					input3.put("oadd3", 	policychange_wb.getText("office_addr3"));
					input3.put("oadd4", 	policychange_wb.getText("office_addr4"));
					input3.put("otela", 	StringFormater.fillSpace(policychange_wb.getText("office_phone1"),4));
					input3.put("otel1", 	StringFormater.fillSpace(policychange_wb.getText("office_phone2"),4));
					input3.put("otel2", 	StringFormater.fillSpace(policychange_wb.getText("office_phone3"),4));
					input3.put("mtela", 	StringFormater.fillSpace(policychange_wb.getText("mobile1"),4));
					input3.put("mtel1", 	StringFormater.fillSpace(policychange_wb.getText("mobile2"),4));
					input3.put("mtel2", 	StringFormater.fillSpace(policychange_wb.getText("mobile3"),4));
					input3.put("email", 	policychange_wb.getText("email"));
					input3.put("emschk", 	policychange_wb.getText("email_service_yn"));
					input3.put("emserv", 	policychange_wb.getText("email_service"));
					input3.put("option",	" ");////20050126추가
					input3.put("sexchk",	"");////20050126추가
					input3.put("sex",		"");////20050126추가
					input3.put("namechk",	"");////20050126추가
					input3.put("name",		"");////20050126추가
					
					anyframe.log.Logger.debug.println("PolicychangeAction (일괄처리 - A)----  input3  : "+input3 );
					
					DataSet policychange_host_A = manager.findPolicychange_host_insert(input3,input1); 
					rtn = policychange_host_A.getText("rtn");
				}
				else if( srvc_cd.equals("B") || srvc_cd.equals("D"))
				{
				    	input3.put("deptcd",    "INT");
					input3.put("init",      tproc_emp_no);
					input3.put("policy", 	policychange_wb.getText("policy_no"));
					input3.put("bankcd", 	policychange_wb.getText("bank_code"));
					input3.put("bankac", 	policychange_wb.getText("account_code"));
					input3.put("pyrna",  	policychange_wb.getText("account_name") );
					input3.put("pyrcd",  	policychange_wb.getText("account_ssn") );
					input3.put("fbsday", 	policychange_wb.getText("fb_day"));
					input3.put("group",  	policychange_wb.getText("group_yn") );
					input3.put("snd_seq",  	"      " );////20050126추가
					input3.put("ssncd",  	"          " );////20050126추가
					
					anyframe.log.Logger.debug.println("PolicychangeAction (일괄처리 - BD)----  input3  : "+input3 );
					
					DataSet policychange_host_BD = manager.findPolicychange_host_insert(input3,input1); 
					rtn = policychange_host_BD.getText("rtn");
				}
				else if( srvc_cd.equals("E") || srvc_cd.equals("F") )////약대자동상환, APL자동상환
				{
					input3.put("dept",    	"INT");
					input3.put("init",      tproc_emp_no);
					input3.put("policy", 	policychange_wb.getText("policy_no"));
					input3.put("option1", 	policychange_wb.getText("option1"));
					input3.put("option2", 	policychange_wb.getText("option2"));
					input3.put("amount", 	policychange_wb.getText("pay_amt"));
					input3.put("paydat", 	"10");
					input3.put("recdat", 	prdate);
					input3.put("strdat", 	policychange_wb.getText("pay_date"));
					anyframe.log.Logger.debug.println("PolicychangeAction (일괄처리 - EF)----  input3  : "+input3 );
					
					DataSet policychange_host_E = manager.findPolicychange_host_insert(input3,input1); 
					rtn = policychange_host_E.getText("rtn");
					
					
					////고객(SMS+메일), LP,SM(메일)-시작
					////약대자동상환, APL자동상환
					if(rtn.equals("0"))
					{
						input5.put("indate", indate);
						input5.put("seq_no", seq_no);
						input5.put("srvc_cd", srvc_gubun);
						
						DataSet mailbilling = manager.findMail_repayment(input5); 					
						request.setAttribute("mailbilling",mailbilling);
						
						////고객에게 메일
						input6.put("v_mail_type", "03");
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber11"));////68
						input6.put("v_channel_code", "00000030");
						String jumin = "";
						jumin = mailbilling.getText("ssn").substring(0,6) + "-"+ mailbilling.getText("ssn").substring(6);
						input6.put("v_member_id", jumin);
						
						String owner = "";
						owner = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
						
						input6.put("v_to_name", owner);
						input6.put("v_to_email", mailbilling.getText("email"));
						
						String mapping1 = "";
						String indate1 = mailbilling.getText("indate1");
						String prdate1  = mailbilling.getText("prdate");
						String paydate = mailbilling.getText("pay_date");
						indate1 = StringFormater.removeZero(indate1.substring(0,4)) +" 년 " + StringFormater.removeZero(indate1.substring(4,6)) + " 월 "  + StringFormater.removeZero(indate1.substring(6,8)) + " 일";
						prdate1 = StringFormater.removeZero(prdate1.substring(0,4)) +" 년 " + StringFormater.removeZero(prdate1.substring(4,6)) + " 월 "  + StringFormater.removeZero(prdate1.substring(6,8)) + " 일";
						paydate = StringFormater.removeZero(paydate.substring(0,4)) +" 년 " + StringFormater.removeZero(paydate.substring(4,6)) + " 월 "  + StringFormater.removeZero(paydate.substring(6,8)) + " 일";
						String plan_nm = Util.superTrim(ToolString.hanToFull(mailbilling.getText("plan_nm")));
						
						if(srvc_gubun.equals("E") || srvc_gubun.equals("F"))
						{
							mapping1 = owner + "|" + mailbilling.getText("srvc_cd")+"|"+plan_nm+"|"+mailbilling.getText("policy")+"|"+indate1+"|"+Util.addComma(StringFormater.removeZero(mailbilling.getText("pay_amt"))) +"|"+paydate;
						}
						input6.put("v_mapping", mapping1);
						input6.put("v_lp_code", mailbilling.getText("slpcd"));		
						input6.put("v_policy_number", mailbilling.getText("policy"));		
						input6.put("v_channel", "cyber");
						input6.put("v_ilips_client_id", "");
						anyframe.log.Logger.debug.println("메일 보내기 위한 필드  : "+input6);
						DataSet mailcu = manager.sendMail(input6); 
						request.setAttribute("mailcu",mailcu);
	
						////LP에게 메일						
						input6.put("v_mail_type", "03");
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber12"));////69
						input6.put("v_channel_code", "00000030");					
						input6.put("v_member_id", jumin);
						
						input6.put("v_to_email", mailbilling.getText("lpemail"));
						
						mapping1 = "";
						String lpname = "";
						lpname = Util.superTrim(ToolString.hanToFull(mailbilling.getText("lpname")));
						
						jumin = mailbilling.getText("ssn").substring(0,6) + "-"+ mailbilling.getText("ssn").substring(6);
						
						if(srvc_gubun.equals("E") || srvc_gubun.equals("F"))
						{
							mapping1 = lpname + "|"+owner + "|" + mailbilling.getText("srvc_cd")+"|"+jumin+"|"+plan_nm+"|"+mailbilling.getText("policy")+"|"+indate1+"|"+Util.addComma(StringFormater.removeZero(mailbilling.getText("pay_amt"))) +"|"+paydate;
						}
						
						input6.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);
						DataSet maillp = manager.sendMail(input6); 
						request.setAttribute("maillp",maillp);
							
						////SM에게 메일						
						/*
						input6.put("v_mail_type", "03");
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber12"));////69
						input6.put("v_channel_code", "00000030");
						input6.put("v_member_id", jumin);
						
						input6.put("v_to_email", mailbilling.getText("sm_email"));
						
						mapping1 = "";
						String sm_name = "";
						sm_name = Util.superTrim(ToolString.hanToFull(mailbilling.getText("sm_name")));
						
						if(srvc_gubun.equals("E") || srvc_gubun.equals("F"))
						{
							mapping1 = sm_name + "|"+owner + "|" + mailbilling.getText("srvc_cd")+"|"+jumin+"|"+plan_nm+"|"+mailbilling.getText("policy")+"|"+indate1+"|"+Util.addComma(StringFormater.removeZero(mailbilling.getText("pay_amt"))) +"|"+paydate;
						}
						
						input6.put("v_mapping", mapping1);
						input6.put("v_lp_code", mailbilling.getText("sm_code"));
						anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input6);
						DataSet mailsm = manager.sendMail(input6); 
						request.setAttribute("mailsm",mailsm);
						*/
						
						////고객에게 SMS보내기
						
						String mobile = mailbilling.getText("mtela") +"-"+ mailbilling.getText("mtel1") +"-"+ mailbilling.getText("mtel2");
									
						String owner_mobile  	= mobile;////핸드폰
						String lp_code       	= "";////LP사번
						String amt           	= Util.addComma(StringFormater.removeZero(mailbilling.getText("pay_amt")));////금액
						String gubun         	= "1";////상환구분					
						String sms_code = "";
						if(srvc_gubun.equals("E"))
						{
							sms_code = "11";
						}
						else if(srvc_gubun.equals("F"))
						{
							sms_code = "12";
						}
						
						
						input10.put("v_sms_code",  		sms_code);////SMS 메시지 업무코드
						input10.put("v_success_yn",  	"0");////0-성공,1-실패
						input10.put("v_policy_no",  	mailbilling.getText("policy"));
						input10.put("v_name",  			owner);
						input10.put("v_owner",  		owner);
						input10.put("v_owner_mobile",  	owner_mobile);
						input10.put("v_lp_code",  		lp_code);
						input10.put("v_amt",  			amt);
						input10.put("v_gubun",  		gubun);						
						input10.put("tran_etc1",  		indate);////입력날짜
						input10.put("tran_etc2",  		seq_no);////실질 순번
						input10.put("v_pr",  			"CU");					
						DataSet sms_ins_cu = manager2.findClientSms(input10);////CU만						
					}
					
					////고객(SMS+메일), LP,SM(메일)-시작					

				}
				else if( srvc_cd.equals("C") || srvc_cd.equals("G") || srvc_cd.equals("I") || srvc_cd.equals("J") )
				{
					
					
					anyframe.log.Logger.debug.println("서비스 코드값이 무엇===>"+srvc_cd);
					String opt1  = " ";
					String mode  = " ";
					String nfopt = " ";
					if( srvc_cd.equals("C") )
					{
						opt1 = "3";
						input3.put("method",    "E");
					}
					else if( srvc_cd.equals("G") )
					{
						opt1 = "4";
						mode = policychange_wb.getText("mode");
						input3.put("method",    "D");
					}
					else if( srvc_cd.equals("H") )
					{
						opt1  = "1";
						nfopt = policychange_wb.getText("nf_opt");
						input3.put("method",    " ");
					}
					else if( srvc_cd.equals("I") )
					{
						opt1  = "1";
						nfopt = policychange_wb.getText("nf_opt");
						input3.put("method",    " ");
					}					
					else if(srvc_cd.equals("J"))
					{
						opt1 = "1";
						nfopt = policychange_wb.getText("nf_opt");
						input3.put("method",    " ");
					}
					
					input3.put("deptcode",  "INT");
					input3.put("init",      tproc_emp_no);
					input3.put("opt1",    	opt1);
					input3.put("opt2",    	"C");
					input3.put("effdate",   prdate);
					input3.put("policy",    policychange_wb.getText("policy_no"));
					input3.put("nfopt",    	nfopt);
					input3.put("diviopt",   "    ");					
					input3.put("mode",    	mode);
					input3.put("podday",    "  ");
					anyframe.log.Logger.debug.println("PolicychangeAction (일괄처리 - CGIJ)----  input3  : "+input3 );

					DataSet policychange_host_CGIJ = manager.findPolicychange_host_insert(input3,input1); 
					rtn = policychange_host_CGIJ.getText("rtn");
					
				}
				anyframe.log.Logger.debug.println("PolicychangeAction (일괄처리)----  rtn  : "+rtn );
			/****************************
		 	* host에 insert하기 - E		*
		 	*****************************/

			/****************************
		 	* wb_db에 update하기 - S		*
		 	*****************************/
				if( rtn.equals("0") )
				{
					input4.put("status", 	"1");
				}
				else
				{
					input4.put("status", 	"2");
				}
				input4.put("prdate", 	prdate);
				input4.put("prtime", 	prtime);
				input4.put("indate",	indate);
				input4.put("seq_no",	seq_no);
				DataSet policychange_wb_update = manager.findPolicychange_wb_update(input4);
			/****************************
		 	* wb_db에 update하기 - E		*
		 	*****************************/
		 	////고객정보변경(고객,LP-SM)
		 	
		 	if(srvc_cd.equals("A") && rtn.equals("0"))
		 	{
		 		////일괄처리시 고객에게 메일보내기
		 		input8.put("indate", indate);
		 		input8.put("seq_no", seq_no);
		 		input8.put("prcode", "1");
		 		
		 		DataSet mailcust = manager.findMail_custmsg(input8); 
				request.setAttribute("mailcust",mailcust);
				
				////고객에게 메일
				
				input6.put("v_mail_type", "03");
				input6.put("v_mail_type_seq", Variable.get("email-id.cyber07"));////64
				input6.put("v_channel_code", "00000030");
				input6.put("v_member_id", mailcust.getText("ssn"));
				input6.put("v_to_name", mailcust.getText("owner"));
				input6.put("v_to_email", mailcust.getText("aemail"));
				
				String mapping2= "";
				String home_phone = "";
				String office_phone = "";
				String mobile = "";
				anyframe.log.Logger.debug.println("회사전화번호  : "+mailcust.getText("aoffice_phone1") + "-"+mailcust.getText("aoffice_phone2")+"-"+mailcust.getText("aoffice_phone3"));
				home_phone = mailcust.getText("ahome_phone1") +"-"+ mailcust.getText("ahome_phone2") +"-"+ mailcust.getText("ahome_phone3");
				office_phone = mailcust.getText("aoffice_phone1") +"-"+ mailcust.getText("aoffice_phone2") +"-"+ mailcust.getText("aoffice_phone3");
				mobile 	    =	mailcust.getText("amobile1") +"-"+ mailcust.getText("amobile2") +"-"+ mailcust.getText("amobile3");
				String owner1 = Util.superTrim(ToolString.hanToFull(mailcust.getText("owner")));
				mapping2 = owner1+"|"+mailcust.getText("aemail_service")+"|"+mailcust.getText("apost_send")+"|"+mailcust.getText("ahome_post")+"|"+mailcust.getText("ahome_addr1")+"|"+mailcust.getText("ahome_addr2")+"|"+home_phone+"|"+mailcust.getText("aoffice_post")+"|"+mailcust.getText("aoffice_addr1")+"|"+mailcust.getText("aoffice_addr2")+"|"+mailcust.getText("aoffice_addr3")+"|"+mailcust.getText("aoffice_addr4")+"|"+office_phone+"|"+mobile+"|"+mailcust.getText("aemail");
				
				input8.put("indate", indate);
		 		input8.put("seq_no", seq_no);
		 		input8.put("prcode", "0");
		 		
		 		DataSet mailcust1 = manager.findMail_custmsg(input8); 
				request.setAttribute("mailcust1",mailcust1);				

				String home_phone1 = "";
				String office_phone1 = "";
				String mobile1 = "";
				home_phone1 = mailcust1.getText("ahome_phone1") +"-"+ mailcust1.getText("ahome_phone2") +"-"+ mailcust1.getText("ahome_phone3");
				office_phone1 = mailcust1.getText("aoffice_phone1") +"-"+ mailcust1.getText("aoffice_phone2") +"-"+ mailcust1.getText("aoffice_phone3");
				mobile1 	    =	mailcust1.getText("amobile1") +"-"+ mailcust1.getText("amobile2") +"-"+ mailcust1.getText("amobile3");
				
				mapping2 = mapping2 + 	"|"+	mailcust1.getText("aemail_service")+"|"+mailcust1.getText("apost_send")+"|"+mailcust1.getText("ahome_post")+"|"+mailcust1.getText("ahome_addr1")+"|"+mailcust1.getText("ahome_addr2")+"|"+home_phone1+"|"+mailcust1.getText("aoffice_post")+"|"+mailcust1.getText("aoffice_addr1")+"|"+mailcust1.getText("aoffice_addr2")+"|"+mailcust1.getText("aoffice_addr3")+"|"+mailcust1.getText("aoffice_addr4")+"|"+office_phone1+"|"+mobile1+"|"+mailcust1.getText("aemail"); 		
				input6.put("v_mapping", mapping2);
				input6.put("v_lp_code", "");
				input6.put("v_policy_number","");
				input6.put("v_channel", "cyber");
				input6.put("v_ilips_client_id", "");
				anyframe.log.Logger.debug.println("고객에게 메일 보내기 위한 필드  : "+input6);
				DataSet mailcustc = manager.sendMail(input6); 
				request.setAttribute("mailcustc",mailcustc);


				////LP,SM에게 메일보내기
				input11.put("ssn" , mailcust.getText("ssn"));
				input11.put("ssn" , mailcust.getText("ssn"));
				input11.put("ssn" , mailcust.getText("ssn"));
				
				DataSet lpsmtot = manager2.findLpSmtot(input11);////LP,SM총 인원
							
				int count = lpsmtot.getCount("lpcode");
				String mappingcu1 = "";
				String mappingcu2 = "";
				if(count > 0)
				{
					for(int j=0;j<count;j++)
					{
						////LP에게 메일보내기
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber08"));////65
						input6.put("v_to_email", lpsmtot.getText("lpemail",j));
						
						String templp = Util.superTrim(ToolString.hanToFull(lpsmtot.getText("lpname",j)));
						String tempsm = Util.superTrim(ToolString.hanToFull(lpsmtot.getText("sm_name",j)));
						String custssn = "";
						custssn = mailcust.getText("ssn").substring(0,7) + "-"+ mailcust.getText("ssn").substring(7);
						
						mappingcu1 = templp+"|"+owner1+"|"+custssn+"|"+mailcust.getText("aemail_service")+"|"+mailcust.getText("apost_send")+"|"+mailcust.getText("ahome_post")+"|"+mailcust.getText("ahome_addr1")+"|"+mailcust.getText("ahome_addr2")+"|"+home_phone+"|"+mailcust.getText("aoffice_post")+"|"+mailcust.getText("aoffice_addr1")+"|"+mailcust.getText("aoffice_addr2")+"|"+mailcust.getText("aoffice_addr3")+"|"+mailcust.getText("aoffice_addr4")+"|"+office_phone+"|"+mobile+"|"+mailcust.getText("aemail");////17개
						mappingcu1 = mappingcu1 + 	"|"+	mailcust1.getText("aemail_service")+"|"+mailcust1.getText("apost_send")+"|"+mailcust1.getText("ahome_post")+"|"+mailcust1.getText("ahome_addr1")+"|"+mailcust1.getText("ahome_addr2")+"|"+home_phone1+"|"+mailcust1.getText("aoffice_post")+"|"+mailcust1.getText("aoffice_addr1")+"|"+mailcust1.getText("aoffice_addr2")+"|"+mailcust1.getText("aoffice_addr3")+"|"+mailcust1.getText("aoffice_addr4")+"|"+office_phone1+"|"+mobile1+"|"+mailcust1.getText("aemail");////31개 		
						input6.put("v_mapping", mappingcu1);
						input6.put("v_lp_code", lpsmtot.getText("lp_code",j));
						anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);														
						anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 메핑필드  : "+mappingcu1);														
						DataSet maillp = manager.sendMail(input6); 
						
						
					}
				}
					
					
					////SMS보내기
										
					String policy_no     		= "";////증권번호
					String name          		= Util.superTrim(ToolString.hanToFull(mailcust.getText("owner")));
					String owner         		= Util.superTrim(ToolString.hanToFull(mailcust.getText("owner")));
					String owner_mobile  	= mobile;////핸드폰
					String lp_code       		= "";////LP사번
					String amt           		= "";////금액
					String gubun         		= "";////상환구분
					
					input10.put("v_sms_code",  		"1");////SMS 메시지 업무코드
					input10.put("v_success_yn",  		"0");////0-성공,1-실패
					input10.put("v_policy_no",  		policy_no);
					input10.put("v_name",  			name);
					input10.put("v_owner",  			owner);
					input10.put("v_owner_mobile",  	owner_mobile);
					input10.put("v_lp_code",  		lp_code);
					input10.put("v_amt",  			amt);
					input10.put("v_gubun",  			gubun);
					
					input10.put("tran_etc1",  			indate);////입력날짜
					input10.put("tran_etc2",  			seq_no);////실질 순번
					
					input10.put("v_pr",  			"CU");
					DataSet sms_ins_cu = manager2.findClientSms(input10);////CU만					
		 		
		 	}
		 	
		 	
		 		if(srvc_cd.equals("G") || srvc_cd.equals("I") || srvc_cd.equals("J"))
		 		{
					if(rtn.equals("0"))
					{
						input5.put("indate", indate);
						input5.put("seq_no", seq_no);
						input5.put("srvc_cd", srvc_cd);
						
						DataSet mailbilling = manager.findMail_sendmsg(input5); 
						request.setAttribute("mailbilling",mailbilling);
						
						////고객에게 메일
						input6.put("v_mail_type", "03");
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber01"));////51
						input6.put("v_channel_code", "00000030");
						input6.put("v_member_id", mailbilling.getText("ssn"));
						String owner = "";
						owner = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
					
						input6.put("v_to_name", owner);
						input6.put("v_to_email", mailbilling.getText("email"));
						
						
						String mapping1 = "";
						String indate1 = mailbilling.getText("indate1");
						String prdate1  = mailbilling.getText("prdate");
						
						indate1 = StringFormater.removeZero(indate1.substring(0,4)) +" 년 " + StringFormater.removeZero(indate1.substring(4,6)) + " 월 "  + StringFormater.removeZero(indate1.substring(6,8)) + " 일";
						prdate1 = StringFormater.removeZero(prdate1.substring(0,4)) +" 년 " + StringFormater.removeZero(prdate1.substring(4,6)) + " 월 "  + StringFormater.removeZero(prdate1.substring(6,8)) + " 일";
						String plan_nm = Util.superTrim(ToolString.hanToFull(mailbilling.getText("plan_nm")));

						String name1 = "";
						if(srvc_cd.equals("I") || srvc_cd.equals("J"))
						{
							name1 = "자동대출납부";	
						}

						String bnf_opt = "";
						if(mailbilling.getText("nf_opt").equals("신청"))
						{
							bnf_opt = "미신청";
						}
						else if(mailbilling.getText("nf_opt").equals("미신청"))
						{
							bnf_opt = "신청";
						}
						bnf_opt = name1 + bnf_opt;
						
						if(srvc_cd.equals("I") || srvc_cd.equals("J"))
						{
							mapping1 = owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + plan_nm +"|"+ mailbilling.getText("policy") + "|" + indate1 + "|" + prdate1 + "|" + mailbilling.getText("nf_opt") + "|" + bnf_opt;
						} 
						else if(srvc_cd.equals("G"))
						{
							mapping1 = owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + plan_nm +"|"+ mailbilling.getText("policy") + "|" + indate1 + "|" + prdate1 + "|" + mailbilling.getText("mode") + "|" + mailbilling.getText("bmode");
						}
							
						input6.put("v_mapping", mapping1);
						input6.put("v_lp_code", mailbilling.getText("slpcd"));		
						input6.put("v_policy_number", mailbilling.getText("policy"));		
						input6.put("v_channel", "cyber");
						input6.put("v_ilips_client_id", "");
						anyframe.log.Logger.debug.println("메일 보내기 위한 필드  : "+input6);
						DataSet mailcu = manager.sendMail(input6); 
						request.setAttribute("mailcu",mailcu);
						
						////LP에게 메일						
						input6.put("v_mail_type", "03");
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber02"));////53
						input6.put("v_channel_code", "00000030");
						input6.put("v_member_id", mailbilling.getText("ssn"));
						
						input6.put("v_to_email", mailbilling.getText("lpemail"));

						
						mapping1 = "";
						String lpname = "";
						lpname = Util.superTrim(ToolString.hanToFull(mailbilling.getText("lpname")));
						
						if(srvc_cd.equals("I") || srvc_cd.equals("J"))
						{
							mapping1 = lpname + "|" + owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + mailbilling.getText("ssn") + "|"+ plan_nm + "|"+ mailbilling.getText("policy") + "|" + indate1 + "|"+ prdate1 +"|"  + mailbilling.getText("nf_opt") + "|" + bnf_opt;
						}
						else if(srvc_cd.equals("G"))
						{
							mapping1 = lpname + "|" + owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + mailbilling.getText("ssn") + "|"+ plan_nm + "|"+ mailbilling.getText("policy") + "|" + indate1 + "|"+ prdate1 +"|"  + mailbilling.getText("mode") + "|" + mailbilling.getText("bmode");
						}
						input6.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);
						DataSet maillp = manager.sendMail(input6); 
						request.setAttribute("maillp",maillp);

						if(srvc_cd.equals("I") || srvc_cd.equals("J"))
						{
							////SM에게 메일						
							input6.put("v_mail_type", "03");
							input6.put("v_mail_type_seq", Variable.get("email-id.cyber23"));////53
							input6.put("v_channel_code", "00000030");
							input6.put("v_member_id", mailbilling.getText("ssn"));
							
							input6.put("v_to_email", mailbilling.getText("sm_email"));
							
							
							mapping1 = "";
							String sm_name = "";
							sm_name = Util.superTrim(ToolString.hanToFull(mailbilling.getText("sm_name")));
							
							if(srvc_cd.equals("I") || srvc_cd.equals("J"))
							{
								mapping1 = sm_name + "|" + owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + mailbilling.getText("ssn") + "|"+ plan_nm + "|"+ mailbilling.getText("policy") + "|" + indate1 + "|"+ prdate1 +"|"  + mailbilling.getText("nf_opt") + "|" + bnf_opt;
							}
							else if(srvc_cd.equals("G"))
							{
								mapping1 = sm_name + "|" + owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + mailbilling.getText("ssn") + "|"+ plan_nm + "|"+ mailbilling.getText("policy") + "|" + indate1 + "|"+ prdate1 +"|"  + mailbilling.getText("mode") + "|" + mailbilling.getText("bmode");
							}
							input6.put("v_mapping", mapping1);
							input6.put("v_lp_code", mailbilling.getText("sm_code"));
							anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input6);
							DataSet mailsm = manager.sendMail(input6); 
							request.setAttribute("mailsm",mailsm);
						}
						////고객에게 SMS보내기										
						String policy_no     		= mailbilling.getText("policy");////증권번호
						String name          		= owner;
	
						mobiletel.put("deptcd",    "INT");
						mobiletel.put("init",      	tproc_emp_no);
						mobiletel.put("cltno",     	mailbilling.getText("ssn"));
						mobiletel.put("schk",	"");
						mobiletel.put("hchk",	"");  
						mobiletel.put("htchk",	""); 
						mobiletel.put("ochk",	"");  
						mobiletel.put("otchk",	""); 
						mobiletel.put("mtchk",	"");
						mobiletel.put("emchk",	"");
						mobiletel.put("send", 	"");			
						mobiletel.put("hpost", 	"");
						mobiletel.put("hadd1", 	"");
						mobiletel.put("hadd2", 	"");
						mobiletel.put("htela", 	"");
						mobiletel.put("htel1", 	"");
						mobiletel.put("htel2", 	"");
						mobiletel.put("opost", 	"");
						mobiletel.put("oadd1", 	"");
						mobiletel.put("oadd2", 	"");
						mobiletel.put("oadd3", 	"");
						mobiletel.put("oadd4", 	"");
						mobiletel.put("otela", 	"");
						mobiletel.put("otel1", 	"");
						mobiletel.put("otel2", 	"");
						mobiletel.put("mtela", 	"");
						mobiletel.put("mtel1", 	"");
						mobiletel.put("mtel2", 	"");
						mobiletel.put("email", 	"");
						mobiletel.put("emschk", "");
						mobiletel.put("emserv", 	"");
						mobiletel.put("option",	"I");
						mobiletel.put("sexchk",	"");
						mobiletel.put("sex",		"");
						mobiletel.put("namechk", "");
						mobiletel.put("name",	"");
	
						DataSet custtel = manager2.findCusttel(mobiletel);////고객 핸드폰 번호
						
						String mobile = custtel.getText("mtela") +"-"+ custtel.getText("mtel1") +"-"+ custtel.getText("mtel2");
									
						String owner_mobile  	= mobile;////핸드폰
						String lp_code       		= "";////LP사번
						String amt           		= "";////금액
						String gubun         		= "";////상환구분
	
						String sms_code = "";
						if(srvc_cd.equals("G"))
						{
							sms_code = "4";	
						}	
						else if(srvc_cd.equals("I"))	
						{
							sms_code = "2";
						}
						else if(srvc_cd.equals("J"))
						{
							sms_code = "3";
						}
									
						input10.put("v_sms_code",  		sms_code);////SMS 메시지 업무코드
						input10.put("v_success_yn",  		"0");////0-성공,1-실패
						input10.put("v_policy_no",  		policy_no);
						input10.put("v_name",  			name);
						input10.put("v_owner",  			owner);
						input10.put("v_owner_mobile",  	owner_mobile);
						input10.put("v_lp_code",  		lp_code);
						input10.put("v_amt",  			amt);
						input10.put("v_gubun",  			gubun);
						
						input10.put("tran_etc1",  			indate);////입력날짜
						input10.put("tran_etc2",  			seq_no);////실질 순번
						////APL해지일 경우에만 고객,LP,SM에게 SMS보내기
						if(srvc_cd.equals("J"))
						{
							input10.put("v_pr",  			"AL");
						}
						else 
						{
							input10.put("v_pr",  			"CU");
						}	
						
						DataSet sms_ins_cu = manager2.findClientSms(input10);////CU만	

					}
				}////납입주기 변경일때	
				
				////자동이체해지(시작)
				if(srvc_cd.equals("C"))
				{
					if(rtn.equals("0"))
		 			{
			 			input5.put("indate", indate);
						input5.put("seq_no", seq_no);
						input5.put("srvc_cd", srvc_gubun);
						
						DataSet mailbilling = manager.findMail_sendaccount(input5); 
						request.setAttribute("mailbilling",mailbilling);
						
						////고객에게 메일
						input6.put("v_mail_type", "03");
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber21"));////82
						input6.put("v_channel_code", "00000030");
						input6.put("v_member_id", mailbilling.getText("ssn"));
						String owner = "";
						owner = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
					
						input6.put("v_to_name", owner);
						input6.put("v_to_email", mailbilling.getText("email"));
						
						
						String mapping1 = "";
						String indate1 = mailbilling.getText("indate1");
						String prdate1  = mailbilling.getText("prdate");
						
						indate1 = StringFormater.removeZero(indate1.substring(0,4)) +" 년 " + StringFormater.removeZero(indate1.substring(4,6)) + " 월 "  + StringFormater.removeZero(indate1.substring(6,8)) + " 일";
						prdate1 = StringFormater.removeZero(prdate1.substring(0,4)) +" 년 " + StringFormater.removeZero(prdate1.substring(4,6)) + " 월 "  + StringFormater.removeZero(prdate1.substring(6,8)) + " 일";
						String plan_nm = Util.superTrim(ToolString.hanToFull(mailbilling.getText("plan_nm")));
						mapping1 = owner + "|" + owner + "|" +mailbilling.getText("policy") +"|"+ mailbilling.getText("bank_name") +"  "+ mailbilling.getText("account_code");
						
						input6.put("v_mapping", mapping1);
						input6.put("v_lp_code", mailbilling.getText("slpcd"));		
						input6.put("v_policy_number", mailbilling.getText("policy"));		
						input6.put("v_channel", "cyber");
						input6.put("v_ilips_client_id", "");
						anyframe.log.Logger.debug.println("메일 보내기 위한 필드  : "+input6);
						DataSet mailcu = manager.sendMail(input6); 
						request.setAttribute("mailcu",mailcu);
						
						////LP에게 메일						
						input6.put("v_mail_type", "03");
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber16"));////73
						input6.put("v_channel_code", "00000030");
						input6.put("v_member_id", mailbilling.getText("ssn"));
						
						input6.put("v_to_email", mailbilling.getText("lpemail"));
						
						
						mapping1 = "";
						String lpname = "";
						lpname = Util.superTrim(ToolString.hanToFull(mailbilling.getText("lpname")));
						String jumin = "";
						jumin = mailbilling.getText("ssn").substring(0,6) + "-"+ mailbilling.getText("ssn").substring(6);
						
						mapping1 = lpname+ "|"+ owner + "|" + jumin + "|" + owner + "|" + mailbilling.getText("policy") +"|"+ mailbilling.getText("bank_name") +"  "+ mailbilling.getText("account_code");
						input6.put("v_mapping", mapping1);
						
						anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);
						DataSet maillp = manager.sendMail(input6); 
						request.setAttribute("maillp",maillp);
	
						////SM에게 메일						
						
						if(srvc_cd.equals("C"))
						{
							input6.put("v_mail_type", "03");
							input6.put("v_mail_type_seq", Variable.get("email-id.cyber25"));////73
							input6.put("v_channel_code", "00000030");
							input6.put("v_member_id", mailbilling.getText("ssn"));
							
							input6.put("v_to_email", mailbilling.getText("sm_email"));
							
							
							mapping1 = "";
							String sm_name = "";
							sm_name = Util.superTrim(ToolString.hanToFull(mailbilling.getText("sm_name")));
							
							mapping1 = sm_name+ "|"+ owner + "|" + jumin + "|" + owner + "|" + mailbilling.getText("policy") +"|"+ mailbilling.getText("bank_name") +"  "+ mailbilling.getText("account_code");
							
							input6.put("v_mapping", mapping1);
							input6.put("v_lp_code", mailbilling.getText("sm_code"));
							anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input6);
							DataSet mailsm = manager.sendMail(input6); 
							request.setAttribute("mailsm",mailsm);
						}	
	
						////고객(LP,SM)에게 SMS보내기										
						String policy_no     		= mailbilling.getText("policy");////증권번호
						String name          		= owner;
	
						mobiletel.put("deptcd",    "INT");
						mobiletel.put("init",      	tproc_emp_no);
						mobiletel.put("cltno",     	mailbilling.getText("ssn"));
						mobiletel.put("schk",	"");
						mobiletel.put("hchk",	"");  
						mobiletel.put("htchk",	""); 
						mobiletel.put("ochk",	"");  
						mobiletel.put("otchk",	""); 
						mobiletel.put("mtchk",	"");
						mobiletel.put("emchk",	"");
						mobiletel.put("send", 	"");			
						mobiletel.put("hpost", 	"");
						mobiletel.put("hadd1", 	"");
						mobiletel.put("hadd2", 	"");
						mobiletel.put("htela", 	"");
						mobiletel.put("htel1", 	"");
						mobiletel.put("htel2", 	"");
						mobiletel.put("opost", 	"");
						mobiletel.put("oadd1", 	"");
						mobiletel.put("oadd2", 	"");
						mobiletel.put("oadd3", 	"");
						mobiletel.put("oadd4", 	"");
						mobiletel.put("otela", 	"");
						mobiletel.put("otel1", 	"");
						mobiletel.put("otel2", 	"");
						mobiletel.put("mtela", 	"");
						mobiletel.put("mtel1", 	"");
						mobiletel.put("mtel2", 	"");
						mobiletel.put("email", 	"");
						mobiletel.put("emschk", "");
						mobiletel.put("emserv", 	"");
						mobiletel.put("option",	"I");
						mobiletel.put("sexchk",	"");
						mobiletel.put("sex",		"");
						mobiletel.put("namechk", "");
						mobiletel.put("name",	"");
	
						DataSet custtel = manager2.findCusttel(mobiletel);////고객 핸드폰 번호
						
						String mobile = custtel.getText("mtela") +"-"+ custtel.getText("mtel1") +"-"+ custtel.getText("mtel2");
									
						String owner_mobile  	= mobile;////핸드폰
						String lp_code       		= "";////LP사번
						lp_code = mailbilling.getText("slpcd");
						String amt           		= "";////금액
						String gubun         		= "";////상환구분
	
						String sms_code = "";
						if(srvc_gubun.equals("C"))
						{
							sms_code = "16";	
						}	
						
									
						input10.put("v_sms_code",  		sms_code);////SMS 메시지 업무코드
						input10.put("v_success_yn",  		"0");////0-성공,1-실패
						input10.put("v_policy_no",  		policy_no);
						input10.put("v_name",  			name);
						input10.put("v_owner",  			owner);
						input10.put("v_owner_mobile",  	owner_mobile);
						input10.put("v_lp_code",  		lp_code);
						input10.put("v_amt",  			amt);
						input10.put("v_gubun",  			gubun);
						
						input10.put("tran_etc1",  			indate);////입력날짜
						input10.put("tran_etc2",  			seq_no);////실질 순번
						////APL해지일 경우에만 고객,LP,SM에게 SMS보내기
						if(srvc_gubun.equals("C"))
						{
							input10.put("v_pr",  			"AL");
						}
						
						anyframe.log.Logger.debug.println("자동이체 해지에 관한 action에서 input10 값  : "+input10 );			            
						DataSet sms_ins_cu = manager2.findClientSms(input10);////CU만	
		 			}						
					
				}				
				////자동이체해지(끝)
				
			}////end -for
			
            Logger.debug.println("################ PolicychangeAction End ####################");
            
            
			String url = "/receipt/policy_realtime.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=Z&&search=1&key=";
    		String msg = "일괄처리가 정상적으로 처리되었습니다.";
    		request.setAttribute("message", msg);	
        	request.setAttribute("toURL", url);	
        	return mapping.findForward("alert");
            ////return mapping.findForward("policy_realtime");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}
