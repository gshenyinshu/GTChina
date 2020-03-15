/**
 * Title        : PolicyindivAction.java
 * Description  : 자동이체조회
 * Copyright    : Copyright (c) 2004
 * Company      : CyberImagination
 * @author      : Son,HoJun
 *				: 2005.10.06. 05-C-139. 이위혁. 기신청건 체크하도록 수정.
 *				: 2007.05.14. 0700941. 	김보영. 자동이체 변경 관련 메시지 수정
 * @version 1.0
 */

package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;
import anyframe.util.*;////StringFormater.fillZero(String,int)

import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.PolicyindivForm;
import gtone.changeminer.receipt.manager.PolicyindivManager;
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.receipt.manager.CyberRecManager;////예금주확인

////메일
import gtone.changeminer.common.utility.Variable;////prumail.xml에서 메일경로

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

////SMS
import gtone.changeminer.receipt.manager.CyberSmsManager;

////사망자
import gtone.changeminer.common.manager.DeathRegistrationManager;

/**
 * @struts.action
 *      path="/policy_indiv" 
 *      name="policyindivForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="policy_indiv"
 *      path="/policy_indiv.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class PolicyindivAction extends Action 
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ PolicyindivAction Start ####################");

            DataSet input0 = new DataSet();
            DataSet input = new DataSet();
            DataSet input1 = new DataSet();
            DataSet input3 = new DataSet();
            DataSet input4 = new DataSet();
            DataSet input5 = new DataSet();
            DataSet input6 = new DataSet();
            DataSet input8 = new DataSet();
            DataSet input9 = new DataSet();
            DataSet input10 = new DataSet();
            DataSet input11 = new DataSet();
            DataSet mobiletel = new DataSet();
            DataSet group1820 = new DataSet();
            DataSet group0141 = new DataSet();
            DataSet group_div = new DataSet();////그룹빌링 host저장시 구분자
            DataSet ksps0340 = new DataSet();
            DataSet ksps2200 = new DataSet();
            DataSet bankerr = new DataSet();
            DataSet statuschg = new DataSet();
            DataSet statuschgd = new DataSet();
            DataSet inputCount = new DataSet();
            DataSet masterUpt = new DataSet();
            
            PolicyindivForm policyindivForm = (PolicyindivForm)form;
            
            ////세션사용하기
            SessionManager sessionManager = new SessionManager(request);
            String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
            String emp_no = sessionManager.getString(Constant.SESSION_USERID);
            String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
            String tproc_emp_no = emp_no.toUpperCase();
           
			////예금주확인
			CyberRecManager bankyn = CyberRecManager.getInstance();		
           
            ////호스트 처리시 사용
		    PolicychangeManager hostin = PolicychangeManager.getInstance();
		    ////메일
		    PolicychangeManager mailsend = PolicychangeManager.getInstance();
     
			FormToDataset.copyProperties(input, policyindivForm);
		
		    String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
		    Logger.debug.println(">>>>>>>>>>> searchgubun : " + searchgubun);   				
	
			String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
			String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
			String fromdate2 = request.getParameter("fromdate2") == null ? "" : request.getParameter("fromdate2");
			String todate2 = request.getParameter("todate2") == null ? "" : request.getParameter("todate2");            
			String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");////업무분류            
			String status = request.getParameter("status") == null ? " " : request.getParameter("status");////상태값
			String search = request.getParameter("search") == null ? "" : request.getParameter("search");
			String key = request.getParameter("key") == null ? "" : request.getParameter("key");
		
			String indate = request.getParameter("indate") == null ? "" : request.getParameter("indate");
			String seq_no = request.getParameter("seq_no") == null ? "" : request.getParameter("seq_no");	
			String rtnflag = request.getParameter("rtnflag") == null ? "" : request.getParameter("rtnflag");	
			String srvc_gubun = request.getParameter("srvc_gubun") == null ? "" : request.getParameter("srvc_gubun");	
			Logger.debug.println(">>>>>>>>>>> srvc_gubun : " + srvc_gubun);
			
			String process_mode = request.getParameter("process_mode") == null ? "" : request.getParameter("process_mode");	
			
			////화면 분기를 위한 메뉴 번호값 2007.05.23 추가...(자동이체처리, 계약 변경처리 화면을 메인화면으로 바꾸면서. 추가)
			String menu_mode = request.getParameter("menu_mode") == null ? "" : request.getParameter("menu_mode");
			
			
			
			request.setAttribute("menu_mode", menu_mode);
			Logger.debug.println(">>>>>>>>>>> menu_mode : " + menu_mode);   	
			String errmsg = "";
			String payorna = "";
			String current = "";
			String page = "";
			String where = "";
			String where1 = "";
			String orderby = "";
			String rtn = "-1";
			current = request.getParameter("current") == null ? "1" : request.getParameter("current");
			page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));
			String prtime = anyframe.util.DateTime.getFormatString("HHmmss");
			String prdate = Util.getTodayToYMD().substring(0,8);
    	     
		    PolicyindivManager manager = PolicyindivManager.getInstance();
		    CyberSmsManager manager2 = CyberSmsManager.getInstance();
		     
		     
			if(searchgubun.equals("S")){	
	            where = "";
	            where1 = "";
		
				if(fromdate.length() > 0){
					where = where + " and indate >='"+fromdate+"'"; 	
					where1 = where1 + " and indate >='"+fromdate+"'"; 	
				}
				
				if(todate.length() >0){
					where = where + " and indate  <= '"+ todate+"'";
					where1 = where1 + " and indate  <= '"+ todate+"'";
				}

				if(srvc_ind.length() > 0){
					if(!srvc_ind.equals("Z")){
						where = where + " and srvc_cd ='"+srvc_ind+"'"; 	
						where1 = where1 + " and srvc_cd ='"+srvc_ind+"'"; 	
					}else{ ////전체 검색 항목에서 자동이체변경, 자동이체해지, APL신청, APL해지 그룹빌링신청
								////약대자동상환
								////APL자동상환관련 항목 삭제...
						
						where = where +  " and srvc_cd in('A','G')"; 	////" and srvc_cd in('A','D','E','F','G')"; 	
						where1 = where1 + " and srvc_cd in('A','G')"; 	////" and srvc_cd in('A','D','E','F','G')"; 		
						
							
					}
				}
			
				if(!status.equals("T")){
					if(status.equals("R")){
						where = where + " and status = ' '";
						where1 = where1 + " and status = ' '";
					}else{
						if(status.length() > 0 || status.equals(" ")){
							where = where + " and status = '"+status+"'";
							where1 = where1 + " and status = '"+status+"'";
						}
					}	
				}
			
				if(search.equals("1")){
					if(key.length() > 0){
						where = where + "  and policy like '%"+ key +"%'	";				
						where1 = where1 + "  and policy like '%"+ key +"%'	";
					}					
				}else if(search.equals("2")){
					if(key.length() > 0){
						where = where + "  and owner like '%"+ key +"%'	";				
						where1 = where1 + "  and owner like '%"+ key +"%'	";
					}					
				}else if(search.equals("3")){
					if(key.length() > 0){
						String keyvalue1 = "";
						keyvalue1 = anyframe.util.StringFormater.replaceStr(key,"-","");
						where = where + "  and ssn like '%"+ keyvalue1 +"%'	";				
						where1 = where1 + "  and ssn like '%"+ keyvalue1 +"%'	";			
					}
				}
	
	
	
				////2007.06.08 이상은 추가 자동이체처리와 계약변경일 때는 ... 상태에 따라서.. 정렬을 바꾼다.
				
				////if(srvc_ind.equals("B")||srvc_ind.equals("C")||srvc_ind.equals("I")||srvc_ind.equals("J")){
					
				////	orderby = "order by statusnum asc";
					
				////}else{
					
					orderby = "order by indate desc, intime desc";  ////-->김현정씨 요구로 원래대로 소팅....
				////}
				
				
	            input.put("page", page);
	            input.put("where", where);            
	            input.put("subwhere", where1);
				input.put("orderby", orderby);
	            
			    anyframe.log.Logger.debug.println("SQL에서 WHERE의 INPUT값-----------------: "+where);	
			    anyframe.log.Logger.debug.println("SQL에서 WHERE[1]의 INPUT값-----------------: "+where1);	
	
	            inputCount.put("where", where1);
	
	            DataSet policyindiv = manager.findPolicyindivList(input);
	            DataSet totalCount = manager.findPolicyindiv(inputCount);

				//// 2008.02.25 김종명 추가 (사망자관련 정보 셋팅)
				for (int i=0;i<policyindiv.getCount("seq_no");i++) {
					String deathResult = "N";
					if (srvc_ind.equals("B") || srvc_ind.equals("C")) { //// 자동이체
						String policy = policyindiv.getText("policy",i);
						deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"A");
						policyindiv.put("deathResult",deathResult,i);
					} else if (srvc_ind.equals("I") || srvc_ind.equals("J")) { //// 계약변경
						String policy = policyindiv.getText("policy",i);
						deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"C");
						policyindiv.put("deathResult",deathResult,i);
					} else {
						policyindiv.put("deathResult",deathResult,i);
					}
					Logger.debug.println("[################] @#@#@#@#@# - "+ deathResult);
				}

	            request.setAttribute("policyindiv", policyindiv);
	            request.setAttribute("totalCount", totalCount.getText("count"));
	            request.setAttribute("current", current);

		
			}
		
		////개별처리시
	    if(searchgubun.equals("H"))
	    {
   	     	input0.put("indate",	indate);
			input0.put("seq_no",	seq_no);
			
			input4.put("indate", indate);
			input4.put("seq_no", seq_no);
			
			input5.put("indate", indate);
			input5.put("seq_no", seq_no);		
			input5.put("prcode", "1");	
			
			if( srvc_gubun.equals("A") )
			{
				input1.put("gubun", "A");
			}
			else if( srvc_gubun.equals("B") || srvc_gubun.equals("C") || srvc_gubun.equals("D"))
			{
				input1.put("gubun", "BCD");
			}
			else if( srvc_gubun.equals("E") || srvc_gubun.equals("F") )
			{
				input1.put("gubun", "EF");
			}
			else if( srvc_gubun.equals("G") || srvc_gubun.equals("H") || srvc_gubun.equals("I") || srvc_gubun.equals("J") )
			{
				input1.put("gubun", "GHIJ");
			}
			anyframe.log.Logger.debug.println("(구분코드)----  input1  : "+input1 );				
			DataSet policychange_wb = hostin.findPolicychange_wb(input0,input1); 

			/****************************
		 	* host에 insert하기 - S		*
		 	*****************************/
			
    			
    		input1.put("gubun", srvc_gubun);
			if( srvc_gubun.equals("A") )
			{
				input5.put("table", "CYBER.DBO.CYBER_TBL_WB_MEMBER");
				
				input3.put("deptcd",    "INT");
				input3.put("init",      tproc_emp_no);
				input3.put("cltno",     policychange_wb.getText("ssn"));
				input3.put("schk",	    policychange_wb.getText("post_send_yn"));
				input3.put("hchk",	 	policychange_wb.getText("home_addr_yn"));
				input3.put("htchk",	 	policychange_wb.getText("home_phone_yn"));
				input3.put("ochk",	 	policychange_wb.getText("office_addr_yn"));
				input3.put("otchk",	 	policychange_wb.getText("office_phone_yn"));
				input3.put("mtchk",	 	policychange_wb.getText("mobile_yn"));
				input3.put("emchk",	 	policychange_wb.getText("email_yn"));
				input3.put("send", 	 	policychange_wb.getText("post_send"));
				input3.put("hpost", 	policychange_wb.getText("home_post"));
				
				
				String hadd1 = ToolString.hanToFull(Util.doubleTrim(policychange_wb.getText("home_addr1").trim()).trim());
						   hadd1 = StringFormater.fillSpace(hadd1,70);	
				
				String hadd2 = ToolString.hanToFull(Util.doubleTrim(policychange_wb.getText("home_addr2").trim()).trim());
						   hadd2 = StringFormater.fillSpace(hadd2,70);	
				
				input3.put("hadd1", 	hadd1);
				input3.put("hadd2", 	hadd2);
				
				
				input3.put("htela", 	StringFormater.fillSpace(policychange_wb.getText("home_phone1"),4));
				input3.put("htel1", 	StringFormater.fillSpace(policychange_wb.getText("home_phone2"),4));
				input3.put("htel2", 	StringFormater.fillSpace(policychange_wb.getText("home_phone3"),4));
				input3.put("opost", 	policychange_wb.getText("office_post"));
				
				String office_addr1 = ToolString.hanToFull(Util.doubleTrim(policychange_wb.getText("office_addr1").trim()).trim());
						   office_addr1 = StringFormater.fillSpace(office_addr1,70);	
				
				String office_addr2 = ToolString.hanToFull(Util.doubleTrim(policychange_wb.getText("office_addr2").trim()).trim());
						   office_addr2 = StringFormater.fillSpace(office_addr2,70);	
				
				String office_addr3 = ToolString.hanToFull(Util.doubleTrim(policychange_wb.getText("office_addr3").trim()).trim());
						   office_addr3 = StringFormater.fillSpace(office_addr3,30);	
						   
				String office_addr4 = ToolString.hanToFull(Util.doubleTrim(policychange_wb.getText("office_addr4").trim()).trim());
						   office_addr4 = StringFormater.fillSpace(office_addr4,20);							   
				
				
				
				
				input3.put("oadd1", 	office_addr1);
				input3.put("oadd2", 	office_addr2);
				input3.put("oadd3", 	office_addr3);
				input3.put("oadd4", 	office_addr4);
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
				
				DataSet policychange_host_A = hostin.findPolicychange_host_insert(input3,input1); 
				
				rtn = policychange_host_A.getText("rtn");
				anyframe.log.Logger.debug.println("고객정보변경후 에러코드  rtn  : "+rtn);
				errmsg = policychange_host_A.getText("errmsg");
				
				
				////고객에게 메일보내기- 시작
				if(rtn.equals("0"))
				{
					input8.put("indate", indate);
			 		input8.put("seq_no", seq_no);
			 		input8.put("prcode", "1");
			 		
			 		DataSet mailcust = mailsend.findMail_custmsg(input8); 
					request.setAttribute("mailcust",mailcust);
					
					////고객에게 메일
					
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber07"));////64
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", mailcust.getText("ssn"));
					input6.put("v_to_name", Util.superTrim(mailcust.getText("owner").trim()));
					input6.put("v_to_email", mailcust.getText("aemail"));
					
					String mapping2= "";
					String mapping3= "";
					String home_phone = "";
					String office_phone = "";
					
					
					String emschk = "";
					emschk = mailcust.getText("email_service_yn");////안내장변경여부
					String schk = "";
					schk = mailcust.getText("post_send_yn");////우편물수령지변경여부
					String hchk = "";
					hchk = mailcust.getText("home_addr_yn");////자택주소변경여부
					String htchk = "";
					htchk = mailcust.getText("home_phone_yn");////자택전화변경여부
					String ochk = "";
					ochk = mailcust.getText("office_addr_yn");////회사주소변경여부
					String otchk = "";
					otchk = mailcust.getText("office_phone_yn");////회사전화변경여부
					String mtchk  = "";
					mtchk = mailcust.getText("mobile_yn");////핸드폰변경여부
					String emchk = "";
					emchk = mailcust.getText("email_yn");////이메일변경여부
					
					
					String mobile = "";
					anyframe.log.Logger.debug.println("회사전화번호  : "+mailcust.getText("aoffice_phone1") + "-"+mailcust.getText("aoffice_phone2")+"-"+mailcust.getText("aoffice_phone3"));
					home_phone = mailcust.getText("ahome_phone1") +"-"+ mailcust.getText("ahome_phone2") +"-"+ mailcust.getText("ahome_phone3");
					office_phone = mailcust.getText("aoffice_phone1") +"-"+ mailcust.getText("aoffice_phone2") +"-"+ mailcust.getText("aoffice_phone3");
					mobile 	    =	mailcust.getText("amobile1") +"-"+ mailcust.getText("amobile2") +"-"+ mailcust.getText("amobile3");
					String owner1 = Util.superTrim(mailcust.getText("owner"));
					
					String map2 = mailcust.getText("aemail_service");
					String map3 = mailcust.getText("apost_send");
					String map4 = mailcust.getText("ahome_post");
					String map5 = mailcust.getText("ahome_addr1");
					String map6 = mailcust.getText("ahome_addr2");
					String map7 = home_phone;
					String map8 = mailcust.getText("aoffice_post");
					String map9 = mailcust.getText("aoffice_addr1");
					String map10 = mailcust.getText("aoffice_addr2");
					String map11 = mailcust.getText("aoffice_addr3");
					String map12 = mailcust.getText("aoffice_addr4");
					String map13 = office_phone;
					String map14 = mobile;
					String map15 = mailcust.getText("aemail");
					
					////안내장변경여부
					if(emschk.equals("Y"))
					{
						map2 =  "<font color=#2B63CA>"+mailcust.getText("aemail_service")+"</font>";
					}
					
					////우편물수령지선택
					if(schk.equals("Y"))
					{
						map3 =  "<font color=#2B63CA>"+mailcust.getText("apost_send")+"</font>";
					}
										
					////자택주소변경여부
					if(hchk.equals("Y"))
					{
						map4 = "<font color=#2B63CA>"+map4+"</font>";
						map5 = "<font color=#2B63CA>"+map5+"</font>";
						map6 = "<font color=#2B63CA>"+map6+"</font>";
					}
					
					////자택전화변경여부
					if(htchk.equals("Y"))
					{
						map7 = "<font color=#2B63CA>"+map7+"</font>";
					}
					
					////회사주소변경여부
					if(ochk.equals("Y"))
					{
						map8 = "<font color=#2B63CA>"+map8+"</font>";
						map9 = "<font color=#2B63CA>"+map9+"</font>";
						map10 = "<font color=#2B63CA>"+map10+"</font>";
						map11 = "<font color=#2B63CA>"+map11+"</font>";
						map12 = "<font color=#2B63CA>"+map12+"</font>";
					}
					
					////회사전화번호변경여부
					if(otchk.equals("Y"))
					{
						map13 = "<font color=#2B63CA>"+map13+"</font>";
					}
					
					////핸드폰변경여부
					if(mtchk.equals("Y"))
					{
						map14 = "<font color=#2B63CA>"+map14+"</font>";
					}
					
					////이메일변경여부
					if(emchk.equals("Y"))
					{
						map15 = "<font color=#2B63CA>"+map15+"</font>";
					}
					
					
					////mapping2 = owner1+"|"+mailcust.getText("aemail_service")+"|"+mailcust.getText("apost_send")+"|"+mailcust.getText("ahome_post")+"|"+mailcust.getText("ahome_addr1")+"|"+mailcust.getText("ahome_addr2")+"|"+home_phone+"|"+mailcust.getText("aoffice_post")+"|"+mailcust.getText("aoffice_addr1")+"|"+mailcust.getText("aoffice_addr2")+"|"+mailcust.getText("aoffice_addr3")+"|"+mailcust.getText("aoffice_addr4")+"|"+office_phone+"|"+mobile+"|"+mailcust.getText("aemail");
					mapping2 = owner1+"|"+map2+"|"+map3+"|"+map4+"|"+map5+"|"+map6+"|"+map7+"|"+map8+"|"+map9+"|"+map10+"|"+map11+"|"+map12+"|"+map13+"|"+map14+"|"+map15;
					
					input8.put("indate", indate);
			 		input8.put("seq_no", seq_no);
			 		input8.put("prcode", "0");
			 		
			 		DataSet mailcust1 = mailsend.findMail_custmsg(input8); 
					request.setAttribute("mailcust1",mailcust1);				
	
					String home_phone1 = "";
					String office_phone1 = "";
					String mobile1 = "";
					home_phone1 = mailcust1.getText("ahome_phone1") +"-"+ mailcust1.getText("ahome_phone2") +"-"+ mailcust1.getText("ahome_phone3");
					office_phone1 = mailcust1.getText("aoffice_phone1") +"-"+ mailcust1.getText("aoffice_phone2") +"-"+ mailcust1.getText("aoffice_phone3");
					mobile1 	    =	mailcust1.getText("amobile1") +"-"+ mailcust1.getText("amobile2") +"-"+ mailcust1.getText("amobile3");
					
					mapping3 = mapping2 + "|"+ mailcust1.getText("aemail_service")+"|"+mailcust1.getText("apost_send")+"|"+mailcust1.getText("ahome_post")+"|"+mailcust1.getText("ahome_addr1")+"|"+mailcust1.getText("ahome_addr2")+"|"+home_phone1+"|"+mailcust1.getText("aoffice_post")+"|"+mailcust1.getText("aoffice_addr1")+"|"+mailcust1.getText("aoffice_addr2")+"|"+mailcust1.getText("aoffice_addr3")+"|"+mailcust1.getText("aoffice_addr4")+"|"+office_phone1+"|"+mobile1+"|"+mailcust1.getText("aemail"); 		
					input6.put("v_mapping", mapping3);
					input6.put("v_lp_code", "");
					input6.put("v_policy_number","");
					input6.put("v_channel", "cyber");
					input6.put("v_ilips_client_id", "");
					anyframe.log.Logger.debug.println("고객에게 메일 보내기 위한 필드  : "+input6);
					DataSet mailcustc = mailsend.sendMail(input6); 
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
							custssn = mailcust.getText("ssn").substring(0,6) + "-"+ mailcust.getText("ssn").substring(6);
							
							////mappingcu1 = templp+"|"+owner1+"|"+custssn+"|"+mailcust.getText("aemail_service")+"|"+mailcust.getText("apost_send")+"|"+mailcust.getText("ahome_post")+"|"+mailcust.getText("ahome_addr1")+"|"+mailcust.getText("ahome_addr2")+"|"+home_phone+"|"+mailcust.getText("aoffice_post")+"|"+mailcust.getText("aoffice_addr1")+"|"+mailcust.getText("aoffice_addr2")+"|"+mailcust.getText("aoffice_addr3")+"|"+mailcust.getText("aoffice_addr4")+"|"+office_phone+"|"+mobile+"|"+mailcust.getText("aemail");////17개
							mappingcu1 = templp+"|"+owner1+"|"+custssn+"|"+map2+"|"+map3+"|"+map4+"|"+map5+"|"+map6+"|"+map7+"|"+map8+"|"+map9+"|"+map10+"|"+map11+"|"+map12+"|"+map13+"|"+map14+"|"+map15;
							////mappingcu1 = templp+"|"+owner1+"|"+custssn+"|"+mapping2;////17개
							mappingcu1 = mappingcu1 + 	"|"+	mailcust1.getText("aemail_service")+"|"+mailcust1.getText("apost_send")+"|"+mailcust1.getText("ahome_post")+"|"+mailcust1.getText("ahome_addr1")+"|"+mailcust1.getText("ahome_addr2")+"|"+home_phone1+"|"+mailcust1.getText("aoffice_post")+"|"+mailcust1.getText("aoffice_addr1")+"|"+mailcust1.getText("aoffice_addr2")+"|"+mailcust1.getText("aoffice_addr3")+"|"+mailcust1.getText("aoffice_addr4")+"|"+office_phone1+"|"+mobile1+"|"+mailcust1.getText("aemail");////31개 		
							input6.put("v_mapping", mappingcu1);
							input6.put("v_lp_code", lpsmtot.getText("lp_code",j));
							input6.put("v_to_name", templp);

							anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);														
							anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 메핑필드  : "+mappingcu1);														
							DataSet maillp = mailsend.sendMail(input6); 
						}
					}	
					
					////SMS보내기
					String policy_no     		= "";////증권번호
					String name          		= Util.superTrim(ToolString.hanToFull(mailcust.getText("owner")));
					String owner         		= Util.superTrim(ToolString.hanToFull(mailcust.getText("owner")));
					String owner_mobile  		= mobile;////핸드폰
					String lp_code       		= "";////LP사번
					String amt           		= "";////금액
					String gubun         		= "";////상환구분
					
					input10.put("v_sms_code",  		"1");////SMS 메시지 업무코드
					input10.put("v_success_yn",  	"0");////0-성공,1-실패
					input10.put("v_policy_no",  	policy_no);
					input10.put("v_name",  			name);
					input10.put("v_owner",  		owner);
					input10.put("v_owner_mobile",  	owner_mobile);
					input10.put("v_lp_code",  		lp_code);
					input10.put("v_amt",  			amt);
					input10.put("v_gubun",  		gubun);
					
					input10.put("tran_etc1",  		indate);////입력날짜
					input10.put("tran_etc2",  		seq_no);////실질 순번
					
					input10.put("v_pr",  			"CU");
					DataSet sms_ins_cu = manager2.findClientSms(input10);////CU만
										
				}////RTN(0)
				/**************** 저장시 : SMS보내기 - E ****************/
				
				
				////고객에게 메일보내기- 종료
				
				
				if(process_mode.equals("R"))
				{
					if(rtn.equals("0"))
					{
						input4.put("status", "0");
						
						input5.put("rslt", rtn);
						input5.put("errmsg", errmsg);
					}
					else 
					{
						input4.put("status", "2");////실패
						
						input5.put("rslt", "2");
						input5.put("errmsg", errmsg);
					}
				}
				else if(process_mode.equals("B"))
				{
					if(rtn.equals("0"))
					{
						input4.put("status","1");
						
						input5.put("rslt", "1");
						input5.put("errmsg", errmsg);
					}
					else 
					{
						input4.put("status", "2");////실패
						
						input5.put("rslt", "2");
						input5.put("errmsg", errmsg);
					}
				}
			}
			else if( srvc_gubun.equals("B") || srvc_gubun.equals("D"))
			{
				input5.put("table", "CYBER.DBO.CYBER_TBL_WB_ACCOUNT");
				
				if(srvc_gubun.equals("B"))
				{					
					////자동이체계좌및 전체 변경시	
					if(policychange_wb.getText("account_yn").trim().equals("Y"))	
					{
						////KSPS0340(예금주확인 프로세스			
						ksps0340.put("musera", "INTUSER");
						ksps0340.put("sbkcda", policychange_wb.getText("bank_code"));////은행코드
						ksps0340.put("sbknoa", policychange_wb.getText("account_code"));////은행계좌
						ksps0340.put("amount", "00000000001");
						ksps0340.put("pyrna", policychange_wb.getText("account_ssn"));
						ksps0340.put("procgb", "O");
						
						DataSet bankconf = bankyn.confBank(ksps0340);
						request.setAttribute("bankconf", bankconf);

						payorna = bankconf.getText("payorna");
						
						if(bankconf.getText("rtn").equals("0"))
						{	
													
							ksps2200.put("deptcd", "INT");
							ksps2200.put("policy", policychange_wb.getText("policy_no"));
							
							////anyframe.log.Logger.debug.println("KSPS2200 INPUT  : "+ksps2200);
							DataSet ksps2200yn = hostin.findExistpolicy(ksps2200); ////KSPS2200
							anyframe.log.Logger.debug.println("KSPS2200 OUTPUT  : "+ksps2200yn);
							
							String reqyn = ksps2200yn.getText("reqyn").trim();
							rtn = ksps2200yn.getText("rtn").trim();
							errmsg = ksps2200yn.getText("errmsg");				
							
							////2007.05.14. 0700941. 	김보영. 자동이체 변경 관련 메시지 수정 - S							
							if(rtn.equals("0") && reqyn.equals("Y")){////처리중인 건이 있을 경우
								errmsg = "접수되어 처리중인 건이 있습니다. 확인하여 주십시오.";
								rtn  = "1";
								
							}else if(rtn.equals("0") && !reqyn.equals("Y")){////처리중인 건이 없을경우
							   	input3.put("deptcd",    "INT");
								input3.put("init",      tproc_emp_no);
								input3.put("policy", 	policychange_wb.getText("policy_no"));
								input3.put("bankcd", 	policychange_wb.getText("bank_code"));
								input3.put("bankac", 	policychange_wb.getText("account_code"));
								input3.put("pyrna",  	policychange_wb.getText("account_name") );
								input3.put("pyrcd",  	policychange_wb.getText("account_ssn") );
								input3.put("fbsday", 	policychange_wb.getText("fb_day"));
								
////								사이버 자동이체 일괄처리 로직 변경 0702188
								anyframe.log.Logger.debug.println(
														" policychange_wb.getText(\"group_yn\").trim() =" 
											+			policychange_wb.getText("group_yn").trim()
								);
								if("N".equals(policychange_wb.getText("group_yn").trim()) ){
									input3.put("group",  	"" );	
								}else{
									input3.put("group",  	policychange_wb.getText("group_yn") );
								}
								
								
								input3.put("snd_seq",  	"      " );////20050126추가					
								input3.put("ssncd",  	"          " );////20050823추가					
								
								DataSet policychange_host_BD = hostin.findPolicychange_host_insert(input3,input1); ////KSPS0870
								anyframe.log.Logger.debug.println("PolicychangeAction (일괄처리 - BD)----  output  : "+policychange_host_BD);
								rtn = policychange_host_BD.getText("rtn");
								errmsg = policychange_host_BD.getText("errmsg");
								
							}else{
								anyframe.log.Logger.debug.println("rtn=1일 때 errmsg : "+errmsg);
								rtn  = "1";
							}
							anyframe.log.Logger.debug.println("account_yn=Y 일때 rtn: "+rtn);
							anyframe.log.Logger.debug.println("account_yn=Y 일때 errmsg: "+errmsg);
							////2007.05.14. 0700941. 	김보영. 자동이체 변경 관련 메시지 수정 - E
							
							/*2007.05.14. 0700941. 	김보영. 자동이체 변경 관련 메시지 수정 전 -S 
							if(reqyn.equals("N"))////처리건이 없을경우<---------이 부분이 문제!
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
								input3.put("ssncd",  	"          " );////20050823추가					
								anyframe.log.Logger.debug.println("PolicychangeAction (일괄처리 - BD)----  input3  : "+input3 );
								
								DataSet policychange_host_BD = hostin.findPolicychange_host_insert(input3,input1); ////KSPS0870
								rtn = policychange_host_BD.getText("rtn");
								errmsg = policychange_host_BD.getText("errmsg");
							}	
							////2005.10.06. 05-C-139. 이위혁. 기신청건 있을시 알려주도록 수정.  - S
							else
							{
								errmsg = "접수되어 처리중인 건이 있습니다. 확인하여 주십시오.";
								rtn  = "1";
							}
							////2005.10.06. 05-C-139. 이위혁. 기신청건 있을시 알려주도록 수정. -E
							////2007.05.14. 0700941. 	김보영. 자동이체 변경 관련 메시지 수정 전 -E
							*/
						}
						else
						{
							////errmsg = "예금주 확인이 실패했습니다.";
							errmsg = bankconf.getText("errmsg").trim();
							////문석찬과장:자동이체일 변경하였을시  예금주확인 실패시 실패로 떨어트리라고 함.
							bankerr.put("indate", indate);
							bankerr.put("seq_no", seq_no);

							bankerr.put("emp_no", emp_no);
							bankerr.put("err_msg", errmsg);
							bankerr.put("indate", indate);
							bankerr.put("seq_no", seq_no);
						
							anyframe.log.Logger.debug.println("예금주실패시  : "+bankerr);
							DataSet bankerrmsg = manager.updateBank(bankerr); ////은행에러
							request.setAttribute("bankerrmsg", bankerrmsg);   
							rtn = "9";
							
						}	
					}	
					else if(policychange_wb.getText("account_yn").trim().equals("N"))
					{
						
							ksps2200.put("deptcd", "INT");
							ksps2200.put("policy", policychange_wb.getText("policy_no"));
							////anyframe.log.Logger.debug.println("KSPS2200 INPUT  : "+ksps2200);
							DataSet ksps2200yn = hostin.findExistpolicy(ksps2200); ////KSPS2200

							String reqyn = ksps2200yn.getText("reqyn").trim();
							rtn = ksps2200yn.getText("rtn").trim();
							errmsg = ksps2200yn.getText("errmsg");	
							anyframe.log.Logger.debug.println("KSPS2200 OUTPUT  rtn: "+rtn);
							anyframe.log.Logger.debug.println("KSPS2200 OUTPUT  errmsg: "+errmsg);					
							
							////2007.05.14. 0700941. 	김보영. 자동이체 변경 관련 메시지 수정 - S
														

							if(rtn.equals("0") && reqyn.equals("Y")){////처리중인 건이 있을 경우
								errmsg = "접수되어 처리중인 건이 있습니다. 확인하여 주십시오.";
								rtn  = "1";
								
							}else if(rtn.equals("0") && !reqyn.equals("Y")){////처리중인 건이 없을경우
								////host저장 - m0141sp1
								group0141.put("deptcode",  	"INT");
								group0141.put("init",	  	tproc_emp_no);
								group0141.put("opt1",	  	"7");
								group0141.put("opt2",	  	"C");
								group0141.put("policy",	  	policychange_wb.getText("policy_no"));
								group0141.put("effdate",	"        ");
								group0141.put("nfopt",	  	" ");
								group0141.put("diviopt",	"    ");
								group0141.put("method",	  	"D");
								group0141.put("mode",	  	"  ");
								group0141.put("podday",	  	policychange_wb.getText("fb_day"));
								
								////구분자
								group_div.put("gubun", "C");
								DataSet policychange_group0141 = hostin.findPolicychange_host_insert(group0141,group_div); ////M0141SP1
								rtn = policychange_group0141.getText("rtn");
								errmsg = policychange_group0141.getText("errmsg");
								
								if(rtn.equals("0"))////고객에게 SMS
								{
									input9.put("indate", indate);
									input9.put("seq_no", seq_no);
									input9.put("srvc_cd", srvc_gubun);
									
									DataSet mailbilling = mailsend.findMail_sendaccount(input9); 
									request.setAttribute("mailbilling",mailbilling);
									
									String mobile = mailbilling.getText("mtela") +"-"+ mailbilling.getText("mtel1") +"-"+ mailbilling.getText("mtel2");
								
									String owner_mobile  	= mobile;////핸드폰
									String lp_code       	= "";////LP사번
									String amt           	= Util.addComma(StringFormater.removeZero(mailbilling.getText("pay_amt")));////금액
									String gubun         	= "";////상환구분					
									String sms_code = "";
									String owner = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
									
									if(srvc_gubun.equals("B"))
									{
										sms_code = "15";
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
									
									String map1 = "";
									String map2 = "";
									String map3 = "";
									String map4 = "";
									String map5 = "";
									String map6 = "";
									String map7 = "";
									String map8 = "";
									String map9 = "";
									String map10 = "";
									
									map1 = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
									map2 = Util.superTrim(ToolString.hanToFull(mailbilling.getText("plan_nm")));
									String indate1 = mailbilling.getText("indate1");					
									if(indate1.length() >7)
									{
										map3 = StringFormater.removeZero(indate1.substring(0,4)) +" 년 " + StringFormater.removeZero(indate1.substring(4,6)) + " 월 "  + StringFormater.removeZero(indate1.substring(6,8)) + " 일";
									}	
									
									map4 = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
									map5 = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
									map6 = mailbilling.getText("policy");
									map7 = mailbilling.getText("bbank_name") + "  "+mailbilling.getText("baccount_code");
									map8 = mailbilling.getText("bfb_day")+"일";
				
									map9 = mailbilling.getText("bank_name") + "  "+mailbilling.getText("account_code");
									map10 = mailbilling.getText("fb_day")+"일";
									
									////고객에게 메일
									input6.put("v_mail_type", "03");
									input6.put("v_mail_type_seq", Variable.get("email-id.cyber13"));////70
									input6.put("v_channel_code", "00000030");
									input6.put("v_member_id", mailbilling.getText("ssn"));
								
									input6.put("v_to_name", owner);
									input6.put("v_to_email", mailbilling.getText("email"));
									
									String mapping1 = "";
									mapping1 = map1 + "|" + map2 + "|" + map3 + "|" + map4 + "|" + map5 + "|" + map6 + "|" + map7 + "|" + map8 + "|" + map9 + "|" + map10; 
									
									input6.put("v_mapping", mapping1);
									input6.put("v_lp_code", mailbilling.getText("slpcd"));		
									input6.put("v_policy_number", mailbilling.getText("policy"));		
									input6.put("v_channel", "cyber");
									input6.put("v_ilips_client_id", "");
									anyframe.log.Logger.debug.println("메일 보내기 위한 필드  : "+input6);
									DataSet mailcu = mailsend.sendMail(input6); 
									request.setAttribute("mailcu",mailcu);
									
									////LP에게 메일						
									input6.put("v_mail_type", "03");
									input6.put("v_mail_type_seq", Variable.get("email-id.cyber14"));////71
									input6.put("v_channel_code", "00000030");
									input6.put("v_member_id", mailbilling.getText("ssn"));
									
									input6.put("v_to_email", mailbilling.getText("lpemail"));
									
									
									mapping1 = "";
									String lpname = "";
									lpname = Util.superTrim(ToolString.hanToFull(mailbilling.getText("lpname")));
									String jumin = "";
									jumin = mailbilling.getText("ssn").substring(0,6) + "-"+ mailbilling.getText("ssn").substring(6);
									
									mapping1 = lpname +"|"+map1 + "|"+ jumin+"|"+ map2 + "|" + map3 + "|" + map4 + "|" + map5 + "|" + map6 + "|" + map7 + "|" + map8 + "|" + map9 + "|" + map10; 
									input6.put("v_mapping", mapping1);
									
									anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);
									DataSet maillp = mailsend.sendMail(input6); 
									request.setAttribute("maillp",maillp);
								}
								
							}else{
								anyframe.log.Logger.debug.println("rtn=1일 때 errmsg : "+errmsg);
								rtn  = "1";
							}
							anyframe.log.Logger.debug.println("account_yn=N 일때 rtn: "+rtn);
							anyframe.log.Logger.debug.println("account_yn=N 일때 errmsg: "+errmsg);	
							////2007.05.14. 0700941. 	김보영. 자동이체 변경 관련 메시지 수정 - E
					}
					
					if(process_mode.equals("R"))
					{
						if(rtn.equals("0"))
						{
							input4.put("status", "0");
						
							input5.put("rslt", rtn);
							input5.put("errmsg", errmsg);
						}
						else 
						{
							input4.put("status", "2");////실패
						
							input5.put("rslt", "2");
							input5.put("errmsg", errmsg);
						}
					}
					else if(process_mode.equals("B"))
					{
						if(rtn.equals("0"))
						{
							input4.put("status","1");
						
							input5.put("rslt", "1");
							input5.put("errmsg", errmsg);
						}
						else 
						{
							input4.put("status", "2");////실패
						
							input5.put("rslt", "2");
							input5.put("errmsg", errmsg);
						}
				}
					
					
				}					
				else if(srvc_gubun.equals("D"))
				{////그룹빌링 신청
					
					////host저장 - ksps1820
					group1820.put("dptcd", 	"INT");
					group1820.put("init", 		tproc_emp_no);
					group1820.put("policy", 	policychange_wb.getText("policy_no"));
					group1820.put("group", 		"G");
					
					////구분자
					group_div.put("gubun", "D1");
					
					DataSet policychange_group1820 = hostin.findPolicychange_host_insert(group1820,group_div); ////KSPS1820
					String rslt = policychange_group1820.getText("rtn");
					
					if( rslt.equals("0") )
					{
						////host저장 - m0141sp1
						group0141.put("deptcode",  	"INT");
						group0141.put("init",	  	tproc_emp_no);
						group0141.put("opt1",	  	"7");
						group0141.put("opt2",	  	"C");
						group0141.put("policy",	  	policychange_wb.getText("policy_no"));
						group0141.put("effdate",	"        ");
						group0141.put("nfopt",	  	" ");
						group0141.put("diviopt",	"    ");
						group0141.put("method",	  	"D");
						group0141.put("mode",	  	"  ");
						group0141.put("podday",	  	policychange_wb.getText("fb_day"));
						
						////구분자
						group_div.put("gubun", "D2");
						
						DataSet policychange_group0141 = hostin.findPolicychange_host_insert(group0141,group_div); ////M0141SP1
						rtn = policychange_group0141.getText("rtn");
						errmsg = policychange_group0141.getText("errmsg");
						
					}
				}
				
				
				if(process_mode.equals("R"))
				{
					if(rtn.equals("0"))
					{
						input4.put("status", "0");
						
						input5.put("rslt", rtn);
						input5.put("errmsg", errmsg);
					}
					else 
					{
						input4.put("status", "2");////실패
						
						input5.put("rslt", "2");
						input5.put("errmsg", errmsg);
					}
				}
				else if(process_mode.equals("B"))
				{
					if(rtn.equals("0"))
					{
						input4.put("status","1");
						
						input5.put("rslt", "1");
						input5.put("errmsg", errmsg);
					}
					else 
					{
						input4.put("status", "2");////실패
						
						input5.put("rslt", rtn);
						input5.put("errmsg", errmsg);
					}
				}				
			}
			else
			if( srvc_gubun.equals("E") || srvc_gubun.equals("F") )
			{
				input5.put("table", "CYBER.DBO.CYBER_TBL_WB_AUTO_REPAYMENT");
				
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
				
				DataSet policychange_host_E = hostin.findPolicychange_host_insert(input3,input1); 
				rtn = policychange_host_E.getText("rtn");
				errmsg = policychange_host_E.getText("errmsg");
				
				if(process_mode.equals("R"))
				{
					if(rtn.equals("0"))
					{
						input4.put("status", "0");
						
						input5.put("rslt", rtn);
						input5.put("errmsg", errmsg);
					}
					else 
					{
						input4.put("status", "2");////실패
						
						input5.put("rslt", "2");
						input5.put("errmsg", errmsg);
					}
				}
				else if(process_mode.equals("B"))
				{
					if(rtn.equals("0"))
					{
						input4.put("status","1");
						
						input5.put("rslt", "1");
						input5.put("errmsg", errmsg);
					}
					else 
					{
						input4.put("status", "2");////실패
						
						input5.put("rslt", "2");
						input5.put("errmsg", errmsg);
					}
				}
				
				
				////고객(SMS+메일), LP,SM(메일)-시작				
				if(rtn.equals("0"))
				{
					input9.put("indate", indate);
					input9.put("seq_no", seq_no);
					input9.put("srvc_cd", srvc_gubun);
					
					DataSet mailbilling = mailsend.findMail_repayment(input9); 					
					request.setAttribute("mailbilling",mailbilling);
					
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
					DataSet mailcu = mailsend.sendMail(input6); 
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
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);

					
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
				
				////고객(SMS+메일), LP,SM(메일)-끝
								
			}
			else
			if( srvc_gubun.equals("C") || srvc_gubun.equals("G") || srvc_gubun.equals("I") || srvc_gubun.equals("J") )
			{
				anyframe.log.Logger.debug.println("서비스 코드값이 무엇===>"+srvc_gubun);
				String opt1  = " ";
				String mode  = " ";
				String nfopt = " ";
				if( srvc_gubun.equals("C") )
				{
					opt1 = "3";
					input3.put("method",    "E");
				}
				else if( srvc_gubun.equals("G") )
				{
					opt1 = "4";
					mode = policychange_wb.getText("mode");
					input3.put("method",    "D");
				}
				else if( srvc_gubun.equals("H") )
				{
					opt1  = "1";
					nfopt = policychange_wb.getText("nf_opt");
					input3.put("method",    " ");
				}
				else if( srvc_gubun.equals("I") )
				{
					opt1  = "1";
					nfopt = policychange_wb.getText("nf_opt");
					input3.put("method",    " ");
				}					
				else if(srvc_gubun.equals("J"))
				{
					opt1 = "1";
					nfopt = policychange_wb.getText("nf_opt");
					input3.put("method",    " ");
				}
				input5.put("table", "CYBER.DBO.CYBER_TBL_WB_METHOD");
				
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
				anyframe.log.Logger.debug.println("PolicychangeAction (개별처리 - CGIJ)----  input3  : "+input3 );

				DataSet policychange_host_CGIJ = hostin.findPolicychange_host_insert(input3,input1); 
				rtn = policychange_host_CGIJ.getText("rtn");
				
				errmsg = policychange_host_CGIJ.getText("errmsg");
				
				if(process_mode.equals("R"))
				{
					if(rtn.equals("0"))
					{
						input4.put("status", "0");
						
						input5.put("rslt", "0");
						input5.put("errmsg", errmsg);
					}
					else 
					{
						input4.put("status", "2");////실패
						
						input5.put("rslt", "2");
						input5.put("errmsg", errmsg);
					}
				}
				else if(process_mode.equals("B"))
				{
					if(rtn.equals("0"))
					{
						input4.put("status","1");
						
						input5.put("rslt", "1");
						input5.put("errmsg", errmsg);
					}
					else 
					{
						input4.put("status", "2");////실패
						
						input5.put("rslt", "2");
						input5.put("errmsg", errmsg);
					}
				}				
				
			}
				anyframe.log.Logger.debug.println("PolicychangeAction (일괄처리)----  rtn  : "+rtn );
			/****************************
		 	* host에 insert하기 - E		*
		 	*****************************/
		 	
			/****************************
		 	* Wb_master와 그에따른 detail update
		 	*****************************/
		 	input4.put("prdate", prdate);
		 	input4.put("prtime", prtime);
		 	DataSet masterupt = hostin.uptMaster(input4);
			request.setAttribute("masterupt", masterupt);		 	

		 	input5.put("prdate", prdate);
		 	input5.put("prtime", prtime);
		 	input5.put("emp_no", emp_no);		 	
		 	
		 	DataSet detailupt = hostin.uptDetail(input5);
		 	request.setAttribute("detailupt", detailupt);	
		 	
			////납주,APL신청,APL해지 고객,LP,SM에게 메일보내기 시작
			if(srvc_gubun.equals("G") || srvc_gubun.equals("I") || srvc_gubun.equals("J"))
			{					
				if(rtn.equals("0"))
				{
					input9.put("indate", indate);
					input9.put("seq_no", seq_no);
					input9.put("srvc_cd", srvc_gubun);
					
					DataSet mailbilling = mailsend.findMail_sendmsg(input9); 
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
					if(srvc_gubun.equals("I") || srvc_gubun.equals("J"))
					{
						name1 = "자동대출납부";	
					} 
					
					String bnf_opt = "";
					
					String nf_opt = "";
					
					if(mailbilling.getText("nf_opt").equals("신청"))
					{
						nf_opt = "자동대출납부신청";
						bnf_opt = "자동대출납부해지";
					}
					else if(mailbilling.getText("nf_opt").equals("미신청"))
					{
						nf_opt = "자동대출납부해지";
						bnf_opt = "자동대출납부신청";
					}
					
					
					String tmode = "";
					String tbmode = "";
					tmode = mailbilling.getText("mode");
					tbmode = mailbilling.getText("bmode");
					
					if(tmode.equals("01"))
					{
						tmode = "1개월납";
					}
					else	if(tmode.equals("03"))
					{
						tmode = "3개월납";
					}
					else	if(tmode.equals("06"))
					{
						tmode = "6개월납";
					}
					else if(tmode.equals("12"))
					{
						tmode = "연납";
					}

					if(tbmode.equals("01"))
					{
						tbmode = "1개월납";
					}
					else	if(tbmode.equals("03"))
					{
						tbmode = "3개월납";
					}
					else	if(tbmode.equals("06"))
					{
						tbmode = "6개월납";
					}
					else if(tbmode.equals("12"))
					{
						tbmode = "연납";
					}
					
					
					if(srvc_gubun.equals("I") || srvc_gubun.equals("J"))
					{
						mapping1 = owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + plan_nm +"|"+ mailbilling.getText("policy") + "|" + indate1 + "|" + prdate1 + "|" + nf_opt + "|" + bnf_opt;
					} 
					else if(srvc_gubun.equals("G"))
					{
						mapping1 = owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + plan_nm +"|"+ mailbilling.getText("policy") + "|" + indate1 + "|" + prdate1 + "|" + tmode + "|" + tbmode;
					}
						
					input6.put("v_mapping", mapping1);
					input6.put("v_lp_code", mailbilling.getText("slpcd"));		
					input6.put("v_policy_number", mailbilling.getText("policy"));		
					input6.put("v_channel", "cyber");
					input6.put("v_ilips_client_id", "");
					anyframe.log.Logger.debug.println("메일 보내기 위한 필드  : "+input6);
					DataSet mailcu = mailsend.sendMail(input6); 
					request.setAttribute("mailcu",mailcu);
					
					////LP에게 메일						
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber02"));////53
					anyframe.log.Logger.debug.println("납주변경에서 코드값은  : "+Variable.get("email-id.cyber02"));
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", mailbilling.getText("ssn"));
					
					input6.put("v_to_email", mailbilling.getText("lpemail"));
					
					
					mapping1 = "";
					String lpname = "";
					lpname = Util.superTrim(ToolString.hanToFull(mailbilling.getText("lpname")));
					String jumin = "";
					jumin = mailbilling.getText("ssn").substring(0,6) + "-"+ mailbilling.getText("ssn").substring(6);
					
					if(srvc_gubun.equals("I") || srvc_gubun.equals("J"))
					{
						mapping1 = lpname + "|" + owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + jumin + "|"+ plan_nm + "|"+ mailbilling.getText("policy") + "|" + indate1 + "|"+ prdate1 +"|"  + nf_opt + "|" + bnf_opt;
					}
					else if(srvc_gubun.equals("G"))
					{
						mapping1 = lpname + "|" + owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + jumin + "|"+ plan_nm + "|"+ mailbilling.getText("policy") + "|" + indate1 + "|"+ prdate1 +"|"  + tmode + "|" + tbmode;
					}
					input6.put("v_mapping", mapping1);
					
					anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);

					if(srvc_gubun.equals("I") || srvc_gubun.equals("J"))
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
						
						if(srvc_gubun.equals("I") || srvc_gubun.equals("J"))
						{
							mapping1 = sm_name + "|" + owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + jumin + "|"+ plan_nm + "|"+ mailbilling.getText("policy") + "|" + indate1 + "|"+ prdate1 +"|"  + nf_opt + "|" + bnf_opt;
						}
						else if(srvc_gubun.equals("G"))
						{
							mapping1 = sm_name + "|" + owner + "|" + mailbilling.getText("srvc_name").trim() + "|" + jumin + "|"+ plan_nm + "|"+ mailbilling.getText("policy") + "|" + indate1 + "|"+ prdate1 +"|"  + tmode + "|" + tbmode;
						}
						input6.put("v_mapping", mapping1);
						input6.put("v_lp_code", mailbilling.getText("sm_code"));
						anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input6);
						DataSet mailsm = mailsend.sendMail(input6); 
						request.setAttribute("mailsm",mailsm);
					}
										
					////고객에게 SMS보내기										
					String policy_no     		= mailbilling.getText("policy");////증권번호
					String name          		= owner;

					mobiletel.put("deptcd",    "INT");
					mobiletel.put("init",      	"CYBER");
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
					if(srvc_gubun.equals("G"))
					{
						sms_code = "4";	
					}	
					else if(srvc_gubun.equals("I"))	
					{
						sms_code = "2";
					}
					else if(srvc_gubun.equals("J"))
					{
						sms_code = "3";
					}
								
					input10.put("v_sms_code",  		sms_code);////SMS 메시지 업무코드
					input10.put("v_success_yn",  	"0");////0-성공,1-실패
					input10.put("v_policy_no",  	policy_no);
					input10.put("v_name",  			name);
					input10.put("v_owner",  		owner);
					input10.put("v_owner_mobile",  	owner_mobile);
					input10.put("v_lp_code",  		lp_code);
					input10.put("v_amt",  			amt);
					input10.put("v_gubun",  		gubun);
					
					input10.put("tran_etc1",  		indate);////입력날짜
					input10.put("tran_etc2",  		seq_no);////실질 순번
					////APL해지일 경우에만 고객,LP,SM에게 SMS보내기
					if(srvc_gubun.equals("J"))
					{
						input10.put("v_pr",  			"AL");
					}
					else 
					{
						input10.put("v_pr",  			"CU");
					}	
					
					////DataSet sms_ins_cu = manager2.findClientSms(input10);////CU만		
							
					
				}////RTN이 0일때					
			}
			////납주,APL신청,APL해지 고객,LP,SM에게 메일보내기 끝
		 	else if(srvc_gubun.equals("C"))////자동이체해지 - 시작
		 	{
		 		if(rtn.equals("0"))
		 		{
		 			input9.put("indate", indate);
					input9.put("seq_no", seq_no);
					input9.put("srvc_cd", srvc_gubun);
					
					DataSet mailbilling = mailsend.findMail_sendaccount(input9); 
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
					DataSet mailcu = mailsend.sendMail(input6); 
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
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);

					if(srvc_gubun.equals("C"))
					{
						////SM에게 메일						
						input6.put("v_mail_type", "03");
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber25"));////73  => sm에게 보내므로 cyber16이 아님
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
						DataSet mailsm = mailsend.sendMail(input6); 
						request.setAttribute("mailsm",mailsm);
					}	

					////고객(LP,SM)에게 SMS보내기										
					String policy_no     		= mailbilling.getText("policy");////증권번호
					String name          		= owner;

					mobiletel.put("deptcd",    "INT");
					mobiletel.put("init",      	"CYBER");
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
					try {
						DataSet sms_ins_cu = manager2.findClientSms(input10);////CU만	
					} catch (Exception e) {
						System.out.println("findClientSms : " + e.toString());
						////핸드폰번호가 없을 경우 Error로 인해 다음 화면 진행불가.  이런 상황 해결 위하여 try/catch.
						anyframe.log.Logger.debug.println("SMS발송시 오류  : " + e.toString());			            
					}
		 		}
		 	}
		 	////자동이체해지 --끝
		 	else if(srvc_gubun.equals("D"))////그룹빌링 시작
		 	{
		 		anyframe.log.Logger.debug.println("그룹빌링 메일 시작하는 곳임------------------------------------- "+rtn);			            
		 		if(rtn.equals("0"))
		 		{
		 			/*
		 			input9.put("indate", indate);
					input9.put("seq_no", seq_no);
					input9.put("srvc_cd", srvc_gubun);
					
					DataSet mailbilling = mailsend.findMail_sendaccount(input9); 
					request.setAttribute("mailbilling",mailbilling);
					
					////고객에게 메일
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber22"));////83
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", mailbilling.getText("ssn"));
					String owner = "";
					owner = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
				
					input6.put("v_to_name", owner);
					input6.put("v_to_email", mailbilling.getText("email"));
					
					
					String mapping1 = "";
					String indate1 = mailbilling.getText("indate1");
					String prdate1  = mailbilling.getText("prdate");
					
					indate1 = indate1.substring(0,4) +" 년 " + indate1.substring(4,6) + " 월 "  + indate1.substring(6,8) + " 일";
					prdate1 = prdate1.substring(0,4) +" 년 " + prdate1.substring(4,6) + " 월 "  + prdate1.substring(6,8) + " 일";
					String plan_nm = Util.superTrim(ToolString.hanToFull(mailbilling.getText("plan_nm")));
					String modprem = "";
					String modlate = "";
					modprem = mailbilling.getText("modprem");////보험료
					
					modlate = HtmlUtil.formatDouble( Integer.parseInt(modprem) * 0.99);
					
					modprem = Util.addComma(modprem);
					mapping1 = owner + "|" + mailbilling.getText("bank_name") +" "+ mailbilling.getText("account_code") + "|" + mailbilling.getText("account_name")+ "|" + mailbilling.getText("fb_day") +"일"+ "|" + mailbilling.getText("policy") + "|"+ mailbilling.getText("account_name") +"|" + modprem +"원" + "|"+ modlate+"원";
					
					input6.put("v_mapping", mapping1);
					input6.put("v_lp_code", mailbilling.getText("slpcd"));		
					input6.put("v_policy_number", mailbilling.getText("policy"));		
					input6.put("v_channel", "cyber");
					input6.put("v_ilips_client_id", "");
					anyframe.log.Logger.debug.println("메일 보내기 위한 필드  : "+input6);
					DataSet mailcu = mailsend.sendMail(input6); 
					request.setAttribute("mailcu",mailcu);
					
					////LP에게 메일						
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber17"));////74
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", mailbilling.getText("ssn"));
					
					input6.put("v_to_email", mailbilling.getText("lpemail"));
					
					mapping1 = "";
					String lpname = "";
					lpname = Util.superTrim(ToolString.hanToFull(mailbilling.getText("lpname")));
					String jumin = "";
					jumin = mailbilling.getText("ssn").substring(0,6) + "-"+ mailbilling.getText("ssn").substring(6);
					mapping1 = lpname+"|"+owner + "|"+ jumin +"|"+ mailbilling.getText("bank_name") +" "+ mailbilling.getText("account_code") + "|" + mailbilling.getText("account_name") +"|"+ mailbilling.getText("fb_day") +"일"+ "|" + mailbilling.getText("policy") + "|"+ mailbilling.getText("account_name") +"|" + modprem +"원" + "|"+ modlate+"원";
					
					input6.put("v_mapping", mapping1);
					
					anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);

					////SM에게 메일						
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber17"));////74
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", mailbilling.getText("ssn"));
					
					input6.put("v_to_email", mailbilling.getText("sm_email"));
					
					mapping1 = "";
					String sm_name = "";
					sm_name = Util.superTrim(ToolString.hanToFull(mailbilling.getText("sm_name")));
					
					mapping1 = sm_name+"|"+owner + "|"+ jumin +"|"+ mailbilling.getText("bank_name") +" "+ mailbilling.getText("account_code") + "|" + mailbilling.getText("account_name") + "|"+mailbilling.getText("fb_day") +"일"+ "|" + mailbilling.getText("policy") + "|"+ mailbilling.getText("account_name") +"|" + modprem +"원" + "|"+ modlate+"원";
					
					input6.put("v_mapping", mapping1);
					input6.put("v_lp_code", mailbilling.getText("sm_code"));
					anyframe.log.Logger.debug.println("SM에게 메일 보내기 위한 필드  : "+input6);
					DataSet mailsm = mailsend.sendMail(input6); 
					request.setAttribute("mailsm",mailsm);

					////고객(LP,SM)에게 SMS보내기										
					String policy_no     		= mailbilling.getText("policy");////증권번호
					String name          		= owner;

					mobiletel.put("deptcd",    "INT");
					mobiletel.put("init",      	"CYBER");
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
					if(srvc_gubun.equals("D"))
					{
						sms_code = "20";	
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
					if(srvc_gubun.equals("D"))
					{
						input10.put("v_pr",  			"AL");
					}
					
					anyframe.log.Logger.debug.println("그룹빌링 관한 action에서 input10 값  : "+input10 );			            
					DataSet sms_ins_cu = manager2.findClientSms(input10);////CU만	
					*/
		 		}		 		

		 	}
		 	////그룹빌링 끝
	    }
	  
	
	    if(searchgubun.equals("C"))
	    {
    		statuschg.put("indate", indate);
    		statuschg.put("seq_no", seq_no);
    		statuschg.put("status", rtnflag);
    		statuschg.put("prdate", prdate);
    		statuschg.put("prtime", prtime);
    			
    		DataSet masterstatus = hostin.uptMaster(statuschg);
    		request.setAttribute("masterstatus", masterstatus);	
    		
    		if(srvc_gubun.equals("A"))
    		{
    			statuschgd.put("table", "CYBER.DBO.CYBER_TBL_WB_MEMBER");
    		}
    		else if( srvc_gubun.equals("B") || srvc_gubun.equals("D") || srvc_gubun.equals("C"))
    		{
    			statuschgd.put("table", "CYBER.DBO.CYBER_TBL_WB_ACCOUNT");
    		}
    		else if( srvc_gubun.equals("E") || srvc_gubun.equals("F") )
    		{
    			statuschgd.put("table", "CYBER.DBO.CYBER_TBL_WB_AUTO_REPAYMENT");
    		}
    		else if(srvc_gubun.equals("G") || srvc_gubun.equals("I") || srvc_gubun.equals("J") )
    		{
    			statuschgd.put("table", "CYBER.DBO.CYBER_TBL_WB_METHOD");
    		}
    		
    			statuschgd.put("rslt",rtnflag);
    			statuschgd.put("errmsg", "");
		 	statuschgd.put("prdate", prdate);
		 	statuschgd.put("prtime", prtime);
		 	statuschgd.put("emp_no", emp_no);		 	
	    		
	    		statuschgd.put("indate", indate);
	    		statuschgd.put("seq_no", seq_no);
	    		statuschgd.put("prcode", "1");
    		
    			DataSet detailstatus = hostin.uptDetail(statuschgd);
		 	request.setAttribute("detailstatus", detailstatus);	
		 	
		 	Logger.debug.println("PolicyindivAction -- wb_master에 process_mode - 시작");
		 	/*********** wb_master에 process_mode에 "B"로 update : S ************/
		 	masterUpt.put("process_mode", "B");
		 	masterUpt.put("indate",  	indate);
    			masterUpt.put("seq_no",  	seq_no);
    			Logger.debug.println("PolicyindivAction -- wb_master에 process_mode - masterUpt : "+masterUpt);
		 	DataSet master_update = manager.master_upt(masterUpt);
		 	/*********** wb_master에 process_mode에 "B"로 update : E ************/

		 	
		 	rtn = "0";

	    }
	    
	
            request.setAttribute("fromdate", fromdate);
            request.setAttribute("todate",todate);
            
            
            request.setAttribute("srvc_ind",srvc_ind);
            request.setAttribute("status",status);
            request.setAttribute("rtnflag",rtnflag);
            request.setAttribute("search", search);
            request.setAttribute("key", key);            
            request.setAttribute("searchgubun",searchgubun);
		
            Logger.debug.println("################ PolicyindivAction End ####################");
            anyframe.log.Logger.debug.println("개별처리시에 마지막----  rtn  : "+rtn);
            anyframe.log.Logger.debug.println("개별처리시에 마지막----  srvc_ind  : "+srvc_ind );

	  	////업데이트시 메시지 처리 - S
    		if( searchgubun.equals("H") || searchgubun.equals("B") || searchgubun.equals("C"))
	    	{
			String msg = "";

	        	int success = Integer.parseInt(rtn);
				
	    		switch(success)
	    		{
	        		case(0) :
	            			msg =  "성공적으로 처리되었습니다.";
							////msg = "예금주명 : " + payorna;
	            			break;
	            		case(9) :
	            			////msg =  "예금주확인이 실패하였습니다..";
					msg = errmsg;
	            			break;	
	        		default :
	            			////msg = "처리가 실패하였습니다.";
					msg = errmsg;
	            			break;
	    		}				

        		String url = "/receipt/policy_indiv.do?searchgubun=S&current=1&fromdate="+fromdate+"&todate="+todate+"&srvc_ind="+srvc_ind+"&search="+search+"&key="+key+"&status="+status+"&menu_mode="+menu_mode;
        		request.setAttribute("message", msg);	
	        	request.setAttribute("toURL", url);	
	        	return mapping.findForward("alert");
	    	}
	    	else
	    	{
				return mapping.findForward("policy_indiv");
			}            

        }
        catch(Exception e)
        {
	    System.out.println("PolicyindivAction error : " + e.toString());
            throw e;
        }
    }
}
