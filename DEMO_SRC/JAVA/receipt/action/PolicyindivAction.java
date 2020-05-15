/**
 * Title        : PolicyindivAction.java
 * Description  : �ڵ���ü��ȸ
 * Copyright    : Copyright (c) 2004
 * Company      : CyberImagination
 * @author      : Son,HoJun
 *				: 2005.10.06. 05-C-139. ������. ���û�� üũ�ϵ��� ����.
 *				: 2007.05.14. 0700941. 	�躸��. �ڵ���ü ���� ���� �޽��� ����
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
import gtone.changeminer.receipt.manager.CyberRecManager;////������Ȯ��

////����
import gtone.changeminer.common.utility.Variable;////prumail.xml���� ���ϰ��

////����
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

////SMS
import gtone.changeminer.receipt.manager.CyberSmsManager;

////�����
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
            DataSet group_div = new DataSet();////�׷���� host����� ������
            DataSet ksps0340 = new DataSet();
            DataSet ksps2200 = new DataSet();
            DataSet bankerr = new DataSet();
            DataSet statuschg = new DataSet();
            DataSet statuschgd = new DataSet();
            DataSet inputCount = new DataSet();
            DataSet masterUpt = new DataSet();
            
            PolicyindivForm policyindivForm = (PolicyindivForm)form;
            
            ////���ǻ���ϱ�
            SessionManager sessionManager = new SessionManager(request);
            String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
            String emp_no = sessionManager.getString(Constant.SESSION_USERID);
            String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
            String tproc_emp_no = emp_no.toUpperCase();
           
			////������Ȯ��
			CyberRecManager bankyn = CyberRecManager.getInstance();		
           
            ////ȣ��Ʈ ó���� ���
		    PolicychangeManager hostin = PolicychangeManager.getInstance();
		    ////����
		    PolicychangeManager mailsend = PolicychangeManager.getInstance();
     
			FormToDataset.copyProperties(input, policyindivForm);
		
		    String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
		    Logger.debug.println(">>>>>>>>>>> searchgubun : " + searchgubun);   				
	
			String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
			String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
			String fromdate2 = request.getParameter("fromdate2") == null ? "" : request.getParameter("fromdate2");
			String todate2 = request.getParameter("todate2") == null ? "" : request.getParameter("todate2");            
			String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");////�����з�            
			String status = request.getParameter("status") == null ? " " : request.getParameter("status");////���°�
			String search = request.getParameter("search") == null ? "" : request.getParameter("search");
			String key = request.getParameter("key") == null ? "" : request.getParameter("key");
		
			String indate = request.getParameter("indate") == null ? "" : request.getParameter("indate");
			String seq_no = request.getParameter("seq_no") == null ? "" : request.getParameter("seq_no");	
			String rtnflag = request.getParameter("rtnflag") == null ? "" : request.getParameter("rtnflag");	
			String srvc_gubun = request.getParameter("srvc_gubun") == null ? "" : request.getParameter("srvc_gubun");	
			Logger.debug.println(">>>>>>>>>>> srvc_gubun : " + srvc_gubun);
			
			String process_mode = request.getParameter("process_mode") == null ? "" : request.getParameter("process_mode");	
			
			////ȭ�� �б⸦ ���� �޴� ��ȣ�� 2007.05.23 �߰�...(�ڵ���üó��, ��� ����ó�� ȭ���� ����ȭ������ �ٲٸ鼭. �߰�)
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
					}else{ ////��ü �˻� �׸񿡼� �ڵ���ü����, �ڵ���ü����, APL��û, APL���� �׷������û
								////����ڵ���ȯ
								////APL�ڵ���ȯ���� �׸� ����...
						
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
	
	
	
				////2007.06.08 �̻��� �߰� �ڵ���üó���� ��ຯ���� ���� ... ���¿� ����.. ������ �ٲ۴�.
				
				////if(srvc_ind.equals("B")||srvc_ind.equals("C")||srvc_ind.equals("I")||srvc_ind.equals("J")){
					
				////	orderby = "order by statusnum asc";
					
				////}else{
					
					orderby = "order by indate desc, intime desc";  ////-->�������� �䱸�� ������� ����....
				////}
				
				
	            input.put("page", page);
	            input.put("where", where);            
	            input.put("subwhere", where1);
				input.put("orderby", orderby);
	            
			    anyframe.log.Logger.debug.println("SQL���� WHERE�� INPUT��-----------------: "+where);	
			    anyframe.log.Logger.debug.println("SQL���� WHERE[1]�� INPUT��-----------------: "+where1);	
	
	            inputCount.put("where", where1);
	
	            DataSet policyindiv = manager.findPolicyindivList(input);
	            DataSet totalCount = manager.findPolicyindiv(inputCount);

				//// 2008.02.25 ������ �߰� (����ڰ��� ���� ����)
				for (int i=0;i<policyindiv.getCount("seq_no");i++) {
					String deathResult = "N";
					if (srvc_ind.equals("B") || srvc_ind.equals("C")) { //// �ڵ���ü
						String policy = policyindiv.getText("policy",i);
						deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"A");
						policyindiv.put("deathResult",deathResult,i);
					} else if (srvc_ind.equals("I") || srvc_ind.equals("J")) { //// ��ຯ��
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
		
		////����ó����
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
			anyframe.log.Logger.debug.println("(�����ڵ�)----  input1  : "+input1 );				
			DataSet policychange_wb = hostin.findPolicychange_wb(input0,input1); 

			/****************************
		 	* host�� insert�ϱ� - S		*
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
				input3.put("option",	" ");////20050126�߰�
				input3.put("sexchk",	"");////20050126�߰�
				input3.put("sex",		"");////20050126�߰�
				input3.put("namechk",	"");////20050126�߰�
				input3.put("name",		"");////20050126�߰�
				
				anyframe.log.Logger.debug.println("PolicychangeAction (�ϰ�ó�� - A)----  input3  : "+input3 );
				
				DataSet policychange_host_A = hostin.findPolicychange_host_insert(input3,input1); 
				
				rtn = policychange_host_A.getText("rtn");
				anyframe.log.Logger.debug.println("������������ �����ڵ�  rtn  : "+rtn);
				errmsg = policychange_host_A.getText("errmsg");
				
				
				////������ ���Ϻ�����- ����
				if(rtn.equals("0"))
				{
					input8.put("indate", indate);
			 		input8.put("seq_no", seq_no);
			 		input8.put("prcode", "1");
			 		
			 		DataSet mailcust = mailsend.findMail_custmsg(input8); 
					request.setAttribute("mailcust",mailcust);
					
					////������ ����
					
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
					emschk = mailcust.getText("email_service_yn");////�ȳ��庯�濩��
					String schk = "";
					schk = mailcust.getText("post_send_yn");////�������������濩��
					String hchk = "";
					hchk = mailcust.getText("home_addr_yn");////�����ּҺ��濩��
					String htchk = "";
					htchk = mailcust.getText("home_phone_yn");////������ȭ���濩��
					String ochk = "";
					ochk = mailcust.getText("office_addr_yn");////ȸ���ּҺ��濩��
					String otchk = "";
					otchk = mailcust.getText("office_phone_yn");////ȸ����ȭ���濩��
					String mtchk  = "";
					mtchk = mailcust.getText("mobile_yn");////�ڵ������濩��
					String emchk = "";
					emchk = mailcust.getText("email_yn");////�̸��Ϻ��濩��
					
					
					String mobile = "";
					anyframe.log.Logger.debug.println("ȸ����ȭ��ȣ  : "+mailcust.getText("aoffice_phone1") + "-"+mailcust.getText("aoffice_phone2")+"-"+mailcust.getText("aoffice_phone3"));
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
					
					////�ȳ��庯�濩��
					if(emschk.equals("Y"))
					{
						map2 =  "<font color=#2B63CA>"+mailcust.getText("aemail_service")+"</font>";
					}
					
					////��������������
					if(schk.equals("Y"))
					{
						map3 =  "<font color=#2B63CA>"+mailcust.getText("apost_send")+"</font>";
					}
										
					////�����ּҺ��濩��
					if(hchk.equals("Y"))
					{
						map4 = "<font color=#2B63CA>"+map4+"</font>";
						map5 = "<font color=#2B63CA>"+map5+"</font>";
						map6 = "<font color=#2B63CA>"+map6+"</font>";
					}
					
					////������ȭ���濩��
					if(htchk.equals("Y"))
					{
						map7 = "<font color=#2B63CA>"+map7+"</font>";
					}
					
					////ȸ���ּҺ��濩��
					if(ochk.equals("Y"))
					{
						map8 = "<font color=#2B63CA>"+map8+"</font>";
						map9 = "<font color=#2B63CA>"+map9+"</font>";
						map10 = "<font color=#2B63CA>"+map10+"</font>";
						map11 = "<font color=#2B63CA>"+map11+"</font>";
						map12 = "<font color=#2B63CA>"+map12+"</font>";
					}
					
					////ȸ����ȭ��ȣ���濩��
					if(otchk.equals("Y"))
					{
						map13 = "<font color=#2B63CA>"+map13+"</font>";
					}
					
					////�ڵ������濩��
					if(mtchk.equals("Y"))
					{
						map14 = "<font color=#2B63CA>"+map14+"</font>";
					}
					
					////�̸��Ϻ��濩��
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
					anyframe.log.Logger.debug.println("������ ���� ������ ���� �ʵ�  : "+input6);
					DataSet mailcustc = mailsend.sendMail(input6); 
					request.setAttribute("mailcustc",mailcustc);		
					
					////LP,SM���� ���Ϻ�����
					input11.put("ssn" , mailcust.getText("ssn"));
					input11.put("ssn" , mailcust.getText("ssn"));
					input11.put("ssn" , mailcust.getText("ssn"));
					
					DataSet lpsmtot = manager2.findLpSmtot(input11);////LP,SM�� �ο�
								
					int count = lpsmtot.getCount("lpcode");
					String mappingcu1 = "";
					String mappingcu2 = "";
					if(count > 0)
					{
						for(int j=0;j<count;j++)
						{
							////LP���� ���Ϻ�����
							input6.put("v_mail_type_seq", Variable.get("email-id.cyber08"));////65
							input6.put("v_to_email", lpsmtot.getText("lpemail",j));
														
							String templp = Util.superTrim(ToolString.hanToFull(lpsmtot.getText("lpname",j)));
							String tempsm = Util.superTrim(ToolString.hanToFull(lpsmtot.getText("sm_name",j)));
							String custssn = "";
							custssn = mailcust.getText("ssn").substring(0,6) + "-"+ mailcust.getText("ssn").substring(6);
							
							////mappingcu1 = templp+"|"+owner1+"|"+custssn+"|"+mailcust.getText("aemail_service")+"|"+mailcust.getText("apost_send")+"|"+mailcust.getText("ahome_post")+"|"+mailcust.getText("ahome_addr1")+"|"+mailcust.getText("ahome_addr2")+"|"+home_phone+"|"+mailcust.getText("aoffice_post")+"|"+mailcust.getText("aoffice_addr1")+"|"+mailcust.getText("aoffice_addr2")+"|"+mailcust.getText("aoffice_addr3")+"|"+mailcust.getText("aoffice_addr4")+"|"+office_phone+"|"+mobile+"|"+mailcust.getText("aemail");////17��
							mappingcu1 = templp+"|"+owner1+"|"+custssn+"|"+map2+"|"+map3+"|"+map4+"|"+map5+"|"+map6+"|"+map7+"|"+map8+"|"+map9+"|"+map10+"|"+map11+"|"+map12+"|"+map13+"|"+map14+"|"+map15;
							////mappingcu1 = templp+"|"+owner1+"|"+custssn+"|"+mapping2;////17��
							mappingcu1 = mappingcu1 + 	"|"+	mailcust1.getText("aemail_service")+"|"+mailcust1.getText("apost_send")+"|"+mailcust1.getText("ahome_post")+"|"+mailcust1.getText("ahome_addr1")+"|"+mailcust1.getText("ahome_addr2")+"|"+home_phone1+"|"+mailcust1.getText("aoffice_post")+"|"+mailcust1.getText("aoffice_addr1")+"|"+mailcust1.getText("aoffice_addr2")+"|"+mailcust1.getText("aoffice_addr3")+"|"+mailcust1.getText("aoffice_addr4")+"|"+office_phone1+"|"+mobile1+"|"+mailcust1.getText("aemail");////31�� 		
							input6.put("v_mapping", mappingcu1);
							input6.put("v_lp_code", lpsmtot.getText("lp_code",j));
							input6.put("v_to_name", templp);

							anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �ʵ�  : "+input6);														
							anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �����ʵ�  : "+mappingcu1);														
							DataSet maillp = mailsend.sendMail(input6); 
						}
					}	
					
					////SMS������
					String policy_no     		= "";////���ǹ�ȣ
					String name          		= Util.superTrim(ToolString.hanToFull(mailcust.getText("owner")));
					String owner         		= Util.superTrim(ToolString.hanToFull(mailcust.getText("owner")));
					String owner_mobile  		= mobile;////�ڵ���
					String lp_code       		= "";////LP���
					String amt           		= "";////�ݾ�
					String gubun         		= "";////��ȯ����
					
					input10.put("v_sms_code",  		"1");////SMS �޽��� �����ڵ�
					input10.put("v_success_yn",  	"0");////0-����,1-����
					input10.put("v_policy_no",  	policy_no);
					input10.put("v_name",  			name);
					input10.put("v_owner",  		owner);
					input10.put("v_owner_mobile",  	owner_mobile);
					input10.put("v_lp_code",  		lp_code);
					input10.put("v_amt",  			amt);
					input10.put("v_gubun",  		gubun);
					
					input10.put("tran_etc1",  		indate);////�Է³�¥
					input10.put("tran_etc2",  		seq_no);////���� ����
					
					input10.put("v_pr",  			"CU");
					DataSet sms_ins_cu = manager2.findClientSms(input10);////CU��
										
				}////RTN(0)
				/**************** ����� : SMS������ - E ****************/
				
				
				////������ ���Ϻ�����- ����
				
				
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
						input4.put("status", "2");////����
						
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
						input4.put("status", "2");////����
						
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
					////�ڵ���ü���¹� ��ü �����	
					if(policychange_wb.getText("account_yn").trim().equals("Y"))	
					{
						////KSPS0340(������Ȯ�� ���μ���			
						ksps0340.put("musera", "INTUSER");
						ksps0340.put("sbkcda", policychange_wb.getText("bank_code"));////�����ڵ�
						ksps0340.put("sbknoa", policychange_wb.getText("account_code"));////�������
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
							
							////2007.05.14. 0700941. 	�躸��. �ڵ���ü ���� ���� �޽��� ���� - S							
							if(rtn.equals("0") && reqyn.equals("Y")){////ó������ ���� ���� ���
								errmsg = "�����Ǿ� ó������ ���� �ֽ��ϴ�. Ȯ���Ͽ� �ֽʽÿ�.";
								rtn  = "1";
								
							}else if(rtn.equals("0") && !reqyn.equals("Y")){////ó������ ���� �������
							   	input3.put("deptcd",    "INT");
								input3.put("init",      tproc_emp_no);
								input3.put("policy", 	policychange_wb.getText("policy_no"));
								input3.put("bankcd", 	policychange_wb.getText("bank_code"));
								input3.put("bankac", 	policychange_wb.getText("account_code"));
								input3.put("pyrna",  	policychange_wb.getText("account_name") );
								input3.put("pyrcd",  	policychange_wb.getText("account_ssn") );
								input3.put("fbsday", 	policychange_wb.getText("fb_day"));
								
////								���̹� �ڵ���ü �ϰ�ó�� ���� ���� 0702188
								anyframe.log.Logger.debug.println(
														" policychange_wb.getText(\"group_yn\").trim() =" 
											+			policychange_wb.getText("group_yn").trim()
								);
								if("N".equals(policychange_wb.getText("group_yn").trim()) ){
									input3.put("group",  	"" );	
								}else{
									input3.put("group",  	policychange_wb.getText("group_yn") );
								}
								
								
								input3.put("snd_seq",  	"      " );////20050126�߰�					
								input3.put("ssncd",  	"          " );////20050823�߰�					
								
								DataSet policychange_host_BD = hostin.findPolicychange_host_insert(input3,input1); ////KSPS0870
								anyframe.log.Logger.debug.println("PolicychangeAction (�ϰ�ó�� - BD)----  output  : "+policychange_host_BD);
								rtn = policychange_host_BD.getText("rtn");
								errmsg = policychange_host_BD.getText("errmsg");
								
							}else{
								anyframe.log.Logger.debug.println("rtn=1�� �� errmsg : "+errmsg);
								rtn  = "1";
							}
							anyframe.log.Logger.debug.println("account_yn=Y �϶� rtn: "+rtn);
							anyframe.log.Logger.debug.println("account_yn=Y �϶� errmsg: "+errmsg);
							////2007.05.14. 0700941. 	�躸��. �ڵ���ü ���� ���� �޽��� ���� - E
							
							/*2007.05.14. 0700941. 	�躸��. �ڵ���ü ���� ���� �޽��� ���� �� -S 
							if(reqyn.equals("N"))////ó������ �������<---------�� �κ��� ����!
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
								input3.put("snd_seq",  	"      " );////20050126�߰�					
								input3.put("ssncd",  	"          " );////20050823�߰�					
								anyframe.log.Logger.debug.println("PolicychangeAction (�ϰ�ó�� - BD)----  input3  : "+input3 );
								
								DataSet policychange_host_BD = hostin.findPolicychange_host_insert(input3,input1); ////KSPS0870
								rtn = policychange_host_BD.getText("rtn");
								errmsg = policychange_host_BD.getText("errmsg");
							}	
							////2005.10.06. 05-C-139. ������. ���û�� ������ �˷��ֵ��� ����.  - S
							else
							{
								errmsg = "�����Ǿ� ó������ ���� �ֽ��ϴ�. Ȯ���Ͽ� �ֽʽÿ�.";
								rtn  = "1";
							}
							////2005.10.06. 05-C-139. ������. ���û�� ������ �˷��ֵ��� ����. -E
							////2007.05.14. 0700941. 	�躸��. �ڵ���ü ���� ���� �޽��� ���� �� -E
							*/
						}
						else
						{
							////errmsg = "������ Ȯ���� �����߽��ϴ�.";
							errmsg = bankconf.getText("errmsg").trim();
							////����������:�ڵ���ü�� �����Ͽ�����  ������Ȯ�� ���н� ���з� ����Ʈ����� ��.
							bankerr.put("indate", indate);
							bankerr.put("seq_no", seq_no);

							bankerr.put("emp_no", emp_no);
							bankerr.put("err_msg", errmsg);
							bankerr.put("indate", indate);
							bankerr.put("seq_no", seq_no);
						
							anyframe.log.Logger.debug.println("�����ֽ��н�  : "+bankerr);
							DataSet bankerrmsg = manager.updateBank(bankerr); ////���࿡��
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
							
							////2007.05.14. 0700941. 	�躸��. �ڵ���ü ���� ���� �޽��� ���� - S
														

							if(rtn.equals("0") && reqyn.equals("Y")){////ó������ ���� ���� ���
								errmsg = "�����Ǿ� ó������ ���� �ֽ��ϴ�. Ȯ���Ͽ� �ֽʽÿ�.";
								rtn  = "1";
								
							}else if(rtn.equals("0") && !reqyn.equals("Y")){////ó������ ���� �������
								////host���� - m0141sp1
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
								
								////������
								group_div.put("gubun", "C");
								DataSet policychange_group0141 = hostin.findPolicychange_host_insert(group0141,group_div); ////M0141SP1
								rtn = policychange_group0141.getText("rtn");
								errmsg = policychange_group0141.getText("errmsg");
								
								if(rtn.equals("0"))////������ SMS
								{
									input9.put("indate", indate);
									input9.put("seq_no", seq_no);
									input9.put("srvc_cd", srvc_gubun);
									
									DataSet mailbilling = mailsend.findMail_sendaccount(input9); 
									request.setAttribute("mailbilling",mailbilling);
									
									String mobile = mailbilling.getText("mtela") +"-"+ mailbilling.getText("mtel1") +"-"+ mailbilling.getText("mtel2");
								
									String owner_mobile  	= mobile;////�ڵ���
									String lp_code       	= "";////LP���
									String amt           	= Util.addComma(StringFormater.removeZero(mailbilling.getText("pay_amt")));////�ݾ�
									String gubun         	= "";////��ȯ����					
									String sms_code = "";
									String owner = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
									
									if(srvc_gubun.equals("B"))
									{
										sms_code = "15";
									}
									
									input10.put("v_sms_code",  		sms_code);////SMS �޽��� �����ڵ�
									input10.put("v_success_yn",  	"0");////0-����,1-����
									input10.put("v_policy_no",  	mailbilling.getText("policy"));
									input10.put("v_name",  			owner);
									input10.put("v_owner",  		owner);
									input10.put("v_owner_mobile",  	owner_mobile);
									input10.put("v_lp_code",  		lp_code);
									input10.put("v_amt",  			amt);
									input10.put("v_gubun",  		gubun);
									
									input10.put("tran_etc1",  		indate);////�Է³�¥
									input10.put("tran_etc2",  		seq_no);////���� ����
									input10.put("v_pr",  			"CU");					
									DataSet sms_ins_cu = manager2.findClientSms(input10);////CU��	
									
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
										map3 = StringFormater.removeZero(indate1.substring(0,4)) +" �� " + StringFormater.removeZero(indate1.substring(4,6)) + " �� "  + StringFormater.removeZero(indate1.substring(6,8)) + " ��";
									}	
									
									map4 = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
									map5 = Util.superTrim(ToolString.hanToFull(mailbilling.getText("owner")));
									map6 = mailbilling.getText("policy");
									map7 = mailbilling.getText("bbank_name") + "  "+mailbilling.getText("baccount_code");
									map8 = mailbilling.getText("bfb_day")+"��";
				
									map9 = mailbilling.getText("bank_name") + "  "+mailbilling.getText("account_code");
									map10 = mailbilling.getText("fb_day")+"��";
									
									////������ ����
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
									anyframe.log.Logger.debug.println("���� ������ ���� �ʵ�  : "+input6);
									DataSet mailcu = mailsend.sendMail(input6); 
									request.setAttribute("mailcu",mailcu);
									
									////LP���� ����						
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
									
									anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �ʵ�  : "+input6);
									DataSet maillp = mailsend.sendMail(input6); 
									request.setAttribute("maillp",maillp);
								}
								
							}else{
								anyframe.log.Logger.debug.println("rtn=1�� �� errmsg : "+errmsg);
								rtn  = "1";
							}
							anyframe.log.Logger.debug.println("account_yn=N �϶� rtn: "+rtn);
							anyframe.log.Logger.debug.println("account_yn=N �϶� errmsg: "+errmsg);	
							////2007.05.14. 0700941. 	�躸��. �ڵ���ü ���� ���� �޽��� ���� - E
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
							input4.put("status", "2");////����
						
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
							input4.put("status", "2");////����
						
							input5.put("rslt", "2");
							input5.put("errmsg", errmsg);
						}
				}
					
					
				}					
				else if(srvc_gubun.equals("D"))
				{////�׷���� ��û
					
					////host���� - ksps1820
					group1820.put("dptcd", 	"INT");
					group1820.put("init", 		tproc_emp_no);
					group1820.put("policy", 	policychange_wb.getText("policy_no"));
					group1820.put("group", 		"G");
					
					////������
					group_div.put("gubun", "D1");
					
					DataSet policychange_group1820 = hostin.findPolicychange_host_insert(group1820,group_div); ////KSPS1820
					String rslt = policychange_group1820.getText("rtn");
					
					if( rslt.equals("0") )
					{
						////host���� - m0141sp1
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
						
						////������
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
						input4.put("status", "2");////����
						
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
						input4.put("status", "2");////����
						
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
				anyframe.log.Logger.debug.println("PolicychangeAction (�ϰ�ó�� - EF)----  input3  : "+input3 );
				
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
						input4.put("status", "2");////����
						
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
						input4.put("status", "2");////����
						
						input5.put("rslt", "2");
						input5.put("errmsg", errmsg);
					}
				}
				
				
				////��(SMS+����), LP,SM(����)-����				
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
					indate1 = StringFormater.removeZero(indate1.substring(0,4)) +" �� " + StringFormater.removeZero(indate1.substring(4,6)) + " �� "  + StringFormater.removeZero(indate1.substring(6,8)) + " ��";
					prdate1 = StringFormater.removeZero(prdate1.substring(0,4)) +" �� " + StringFormater.removeZero(prdate1.substring(4,6)) + " �� "  + StringFormater.removeZero(prdate1.substring(6,8)) + " ��";
					paydate = StringFormater.removeZero(paydate.substring(0,4)) +" �� " + StringFormater.removeZero(paydate.substring(4,6)) + " �� "  + StringFormater.removeZero(paydate.substring(6,8)) + " ��";
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
					anyframe.log.Logger.debug.println("���� ������ ���� �ʵ�  : "+input6);
					DataSet mailcu = mailsend.sendMail(input6); 
					request.setAttribute("mailcu",mailcu);

					////LP���� ����						
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
					
					anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �ʵ�  : "+input6);
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);

					
					////������ SMS������
					
					String mobile = mailbilling.getText("mtela") +"-"+ mailbilling.getText("mtel1") +"-"+ mailbilling.getText("mtel2");
								
					String owner_mobile  	= mobile;////�ڵ���
					String lp_code       	= "";////LP���
					String amt           	= Util.addComma(StringFormater.removeZero(mailbilling.getText("pay_amt")));////�ݾ�
					String gubun         	= "1";////��ȯ����					
					String sms_code = "";
					if(srvc_gubun.equals("E"))
					{
						sms_code = "11";
					}
					else if(srvc_gubun.equals("F"))
					{
						sms_code = "12";
					}
					
					
					input10.put("v_sms_code",  		sms_code);////SMS �޽��� �����ڵ�
					input10.put("v_success_yn",  	"0");////0-����,1-����
					input10.put("v_policy_no",  	mailbilling.getText("policy"));
					input10.put("v_name",  			owner);
					input10.put("v_owner",  		owner);
					input10.put("v_owner_mobile",  	owner_mobile);
					input10.put("v_lp_code",  		lp_code);
					input10.put("v_amt",  			amt);
					input10.put("v_gubun",  		gubun);
					
					input10.put("tran_etc1",  		indate);////�Է³�¥
					input10.put("tran_etc2",  		seq_no);////���� ����
					input10.put("v_pr",  			"CU");					
					DataSet sms_ins_cu = manager2.findClientSms(input10);////CU��						
				}
				
				////��(SMS+����), LP,SM(����)-��
								
			}
			else
			if( srvc_gubun.equals("C") || srvc_gubun.equals("G") || srvc_gubun.equals("I") || srvc_gubun.equals("J") )
			{
				anyframe.log.Logger.debug.println("���� �ڵ尪�� ����===>"+srvc_gubun);
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
				anyframe.log.Logger.debug.println("PolicychangeAction (����ó�� - CGIJ)----  input3  : "+input3 );

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
						input4.put("status", "2");////����
						
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
						input4.put("status", "2");////����
						
						input5.put("rslt", "2");
						input5.put("errmsg", errmsg);
					}
				}				
				
			}
				anyframe.log.Logger.debug.println("PolicychangeAction (�ϰ�ó��)----  rtn  : "+rtn );
			/****************************
		 	* host�� insert�ϱ� - E		*
		 	*****************************/
		 	
			/****************************
		 	* Wb_master�� �׿����� detail update
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
		 	
			////����,APL��û,APL���� ��,LP,SM���� ���Ϻ����� ����
			if(srvc_gubun.equals("G") || srvc_gubun.equals("I") || srvc_gubun.equals("J"))
			{					
				if(rtn.equals("0"))
				{
					input9.put("indate", indate);
					input9.put("seq_no", seq_no);
					input9.put("srvc_cd", srvc_gubun);
					
					DataSet mailbilling = mailsend.findMail_sendmsg(input9); 
					request.setAttribute("mailbilling",mailbilling);
					
					////������ ����
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
					
					indate1 = StringFormater.removeZero(indate1.substring(0,4)) +" �� " + StringFormater.removeZero(indate1.substring(4,6)) + " �� "  + StringFormater.removeZero(indate1.substring(6,8)) + " ��";
					prdate1 = StringFormater.removeZero(prdate1.substring(0,4)) +" �� " + StringFormater.removeZero(prdate1.substring(4,6)) + " �� "  + StringFormater.removeZero(prdate1.substring(6,8)) + " ��";
					String plan_nm = Util.superTrim(ToolString.hanToFull(mailbilling.getText("plan_nm")));
					
					String name1 = "";
					if(srvc_gubun.equals("I") || srvc_gubun.equals("J"))
					{
						name1 = "�ڵ����ⳳ��";	
					} 
					
					String bnf_opt = "";
					
					String nf_opt = "";
					
					if(mailbilling.getText("nf_opt").equals("��û"))
					{
						nf_opt = "�ڵ����ⳳ�ν�û";
						bnf_opt = "�ڵ����ⳳ������";
					}
					else if(mailbilling.getText("nf_opt").equals("�̽�û"))
					{
						nf_opt = "�ڵ����ⳳ������";
						bnf_opt = "�ڵ����ⳳ�ν�û";
					}
					
					
					String tmode = "";
					String tbmode = "";
					tmode = mailbilling.getText("mode");
					tbmode = mailbilling.getText("bmode");
					
					if(tmode.equals("01"))
					{
						tmode = "1������";
					}
					else	if(tmode.equals("03"))
					{
						tmode = "3������";
					}
					else	if(tmode.equals("06"))
					{
						tmode = "6������";
					}
					else if(tmode.equals("12"))
					{
						tmode = "����";
					}

					if(tbmode.equals("01"))
					{
						tbmode = "1������";
					}
					else	if(tbmode.equals("03"))
					{
						tbmode = "3������";
					}
					else	if(tbmode.equals("06"))
					{
						tbmode = "6������";
					}
					else if(tbmode.equals("12"))
					{
						tbmode = "����";
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
					anyframe.log.Logger.debug.println("���� ������ ���� �ʵ�  : "+input6);
					DataSet mailcu = mailsend.sendMail(input6); 
					request.setAttribute("mailcu",mailcu);
					
					////LP���� ����						
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber02"));////53
					anyframe.log.Logger.debug.println("���ֺ��濡�� �ڵ尪��  : "+Variable.get("email-id.cyber02"));
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
					
					anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �ʵ�  : "+input6);
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);

					if(srvc_gubun.equals("I") || srvc_gubun.equals("J"))
					{
						////SM���� ����						
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
						anyframe.log.Logger.debug.println("SM���� ���� ������ ���� �ʵ�  : "+input6);
						DataSet mailsm = mailsend.sendMail(input6); 
						request.setAttribute("mailsm",mailsm);
					}
										
					////������ SMS������										
					String policy_no     		= mailbilling.getText("policy");////���ǹ�ȣ
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

					DataSet custtel = manager2.findCusttel(mobiletel);////�� �ڵ��� ��ȣ
					
					String mobile = custtel.getText("mtela") +"-"+ custtel.getText("mtel1") +"-"+ custtel.getText("mtel2");
								
					String owner_mobile  	= mobile;////�ڵ���
					String lp_code       		= "";////LP���
					String amt           		= "";////�ݾ�
					String gubun         		= "";////��ȯ����

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
								
					input10.put("v_sms_code",  		sms_code);////SMS �޽��� �����ڵ�
					input10.put("v_success_yn",  	"0");////0-����,1-����
					input10.put("v_policy_no",  	policy_no);
					input10.put("v_name",  			name);
					input10.put("v_owner",  		owner);
					input10.put("v_owner_mobile",  	owner_mobile);
					input10.put("v_lp_code",  		lp_code);
					input10.put("v_amt",  			amt);
					input10.put("v_gubun",  		gubun);
					
					input10.put("tran_etc1",  		indate);////�Է³�¥
					input10.put("tran_etc2",  		seq_no);////���� ����
					////APL������ ��쿡�� ��,LP,SM���� SMS������
					if(srvc_gubun.equals("J"))
					{
						input10.put("v_pr",  			"AL");
					}
					else 
					{
						input10.put("v_pr",  			"CU");
					}	
					
					////DataSet sms_ins_cu = manager2.findClientSms(input10);////CU��		
							
					
				}////RTN�� 0�϶�					
			}
			////����,APL��û,APL���� ��,LP,SM���� ���Ϻ����� ��
		 	else if(srvc_gubun.equals("C"))////�ڵ���ü���� - ����
		 	{
		 		if(rtn.equals("0"))
		 		{
		 			input9.put("indate", indate);
					input9.put("seq_no", seq_no);
					input9.put("srvc_cd", srvc_gubun);
					
					DataSet mailbilling = mailsend.findMail_sendaccount(input9); 
					request.setAttribute("mailbilling",mailbilling);
					
					////������ ����
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
					
					indate1 = StringFormater.removeZero(indate1.substring(0,4)) +" �� " + StringFormater.removeZero(indate1.substring(4,6)) + " �� "  + StringFormater.removeZero(indate1.substring(6,8)) + " ��";
					prdate1 = StringFormater.removeZero(prdate1.substring(0,4)) +" �� " + StringFormater.removeZero(prdate1.substring(4,6)) + " �� "  + StringFormater.removeZero(prdate1.substring(6,8)) + " ��";
					String plan_nm = Util.superTrim(ToolString.hanToFull(mailbilling.getText("plan_nm")));
					mapping1 = owner + "|" + owner + "|" +mailbilling.getText("policy") +"|"+ mailbilling.getText("bank_name") +"  "+ mailbilling.getText("account_code");
					
					input6.put("v_mapping", mapping1);
					input6.put("v_lp_code", mailbilling.getText("slpcd"));		
					input6.put("v_policy_number", mailbilling.getText("policy"));		
					input6.put("v_channel", "cyber");
					input6.put("v_ilips_client_id", "");
					anyframe.log.Logger.debug.println("���� ������ ���� �ʵ�  : "+input6);
					DataSet mailcu = mailsend.sendMail(input6); 
					request.setAttribute("mailcu",mailcu);
					
					////LP���� ����						
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
					
					anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �ʵ�  : "+input6);
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);

					if(srvc_gubun.equals("C"))
					{
						////SM���� ����						
						input6.put("v_mail_type", "03");
						input6.put("v_mail_type_seq", Variable.get("email-id.cyber25"));////73  => sm���� �����Ƿ� cyber16�� �ƴ�
						input6.put("v_channel_code", "00000030");
						input6.put("v_member_id", mailbilling.getText("ssn"));
						
						input6.put("v_to_email", mailbilling.getText("sm_email"));
						
						
						mapping1 = "";
						String sm_name = "";
						sm_name = Util.superTrim(ToolString.hanToFull(mailbilling.getText("sm_name")));
						
						mapping1 = sm_name+ "|"+ owner + "|" + jumin + "|" + owner + "|" + mailbilling.getText("policy") +"|"+ mailbilling.getText("bank_name") +"  "+ mailbilling.getText("account_code");
						
						input6.put("v_mapping", mapping1);
						input6.put("v_lp_code", mailbilling.getText("sm_code"));
						anyframe.log.Logger.debug.println("SM���� ���� ������ ���� �ʵ�  : "+input6);
						DataSet mailsm = mailsend.sendMail(input6); 
						request.setAttribute("mailsm",mailsm);
					}	

					////��(LP,SM)���� SMS������										
					String policy_no     		= mailbilling.getText("policy");////���ǹ�ȣ
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

					DataSet custtel = manager2.findCusttel(mobiletel);////�� �ڵ��� ��ȣ
					
					String mobile = custtel.getText("mtela") +"-"+ custtel.getText("mtel1") +"-"+ custtel.getText("mtel2");
								
					String owner_mobile  	= mobile;////�ڵ���
					String lp_code       		= "";////LP���
					lp_code = mailbilling.getText("slpcd");
					String amt           		= "";////�ݾ�
					String gubun         		= "";////��ȯ����

					String sms_code = "";
					if(srvc_gubun.equals("C"))
					{
						sms_code = "16";	
					}	
					
								
					input10.put("v_sms_code",  		sms_code);////SMS �޽��� �����ڵ�
					input10.put("v_success_yn",  		"0");////0-����,1-����
					input10.put("v_policy_no",  		policy_no);
					input10.put("v_name",  			name);
					input10.put("v_owner",  			owner);
					input10.put("v_owner_mobile",  	owner_mobile);
					input10.put("v_lp_code",  		lp_code);
					input10.put("v_amt",  			amt);
					input10.put("v_gubun",  			gubun);
					
					input10.put("tran_etc1",  			indate);////�Է³�¥
					input10.put("tran_etc2",  			seq_no);////���� ����
					////APL������ ��쿡�� ��,LP,SM���� SMS������	
					if(srvc_gubun.equals("C"))
					{
						input10.put("v_pr",  			"AL");
					}
					
					anyframe.log.Logger.debug.println("�ڵ���ü ������ ���� action���� input10 ��  : "+input10 );			            
					try {
						DataSet sms_ins_cu = manager2.findClientSms(input10);////CU��	
					} catch (Exception e) {
						System.out.println("findClientSms : " + e.toString());
						////�ڵ�����ȣ�� ���� ��� Error�� ���� ���� ȭ�� ����Ұ�.  �̷� ��Ȳ �ذ� ���Ͽ� try/catch.
						anyframe.log.Logger.debug.println("SMS�߼۽� ����  : " + e.toString());			            
					}
		 		}
		 	}
		 	////�ڵ���ü���� --��
		 	else if(srvc_gubun.equals("D"))////�׷���� ����
		 	{
		 		anyframe.log.Logger.debug.println("�׷���� ���� �����ϴ� ����------------------------------------- "+rtn);			            
		 		if(rtn.equals("0"))
		 		{
		 			/*
		 			input9.put("indate", indate);
					input9.put("seq_no", seq_no);
					input9.put("srvc_cd", srvc_gubun);
					
					DataSet mailbilling = mailsend.findMail_sendaccount(input9); 
					request.setAttribute("mailbilling",mailbilling);
					
					////������ ����
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
					
					indate1 = indate1.substring(0,4) +" �� " + indate1.substring(4,6) + " �� "  + indate1.substring(6,8) + " ��";
					prdate1 = prdate1.substring(0,4) +" �� " + prdate1.substring(4,6) + " �� "  + prdate1.substring(6,8) + " ��";
					String plan_nm = Util.superTrim(ToolString.hanToFull(mailbilling.getText("plan_nm")));
					String modprem = "";
					String modlate = "";
					modprem = mailbilling.getText("modprem");////�����
					
					modlate = HtmlUtil.formatDouble( Integer.parseInt(modprem) * 0.99);
					
					modprem = Util.addComma(modprem);
					mapping1 = owner + "|" + mailbilling.getText("bank_name") +" "+ mailbilling.getText("account_code") + "|" + mailbilling.getText("account_name")+ "|" + mailbilling.getText("fb_day") +"��"+ "|" + mailbilling.getText("policy") + "|"+ mailbilling.getText("account_name") +"|" + modprem +"��" + "|"+ modlate+"��";
					
					input6.put("v_mapping", mapping1);
					input6.put("v_lp_code", mailbilling.getText("slpcd"));		
					input6.put("v_policy_number", mailbilling.getText("policy"));		
					input6.put("v_channel", "cyber");
					input6.put("v_ilips_client_id", "");
					anyframe.log.Logger.debug.println("���� ������ ���� �ʵ�  : "+input6);
					DataSet mailcu = mailsend.sendMail(input6); 
					request.setAttribute("mailcu",mailcu);
					
					////LP���� ����						
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
					mapping1 = lpname+"|"+owner + "|"+ jumin +"|"+ mailbilling.getText("bank_name") +" "+ mailbilling.getText("account_code") + "|" + mailbilling.getText("account_name") +"|"+ mailbilling.getText("fb_day") +"��"+ "|" + mailbilling.getText("policy") + "|"+ mailbilling.getText("account_name") +"|" + modprem +"��" + "|"+ modlate+"��";
					
					input6.put("v_mapping", mapping1);
					
					anyframe.log.Logger.debug.println("LP���� ���� ������ ���� �ʵ�  : "+input6);
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);

					////SM���� ����						
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber17"));////74
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", mailbilling.getText("ssn"));
					
					input6.put("v_to_email", mailbilling.getText("sm_email"));
					
					mapping1 = "";
					String sm_name = "";
					sm_name = Util.superTrim(ToolString.hanToFull(mailbilling.getText("sm_name")));
					
					mapping1 = sm_name+"|"+owner + "|"+ jumin +"|"+ mailbilling.getText("bank_name") +" "+ mailbilling.getText("account_code") + "|" + mailbilling.getText("account_name") + "|"+mailbilling.getText("fb_day") +"��"+ "|" + mailbilling.getText("policy") + "|"+ mailbilling.getText("account_name") +"|" + modprem +"��" + "|"+ modlate+"��";
					
					input6.put("v_mapping", mapping1);
					input6.put("v_lp_code", mailbilling.getText("sm_code"));
					anyframe.log.Logger.debug.println("SM���� ���� ������ ���� �ʵ�  : "+input6);
					DataSet mailsm = mailsend.sendMail(input6); 
					request.setAttribute("mailsm",mailsm);

					////��(LP,SM)���� SMS������										
					String policy_no     		= mailbilling.getText("policy");////���ǹ�ȣ
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

					DataSet custtel = manager2.findCusttel(mobiletel);////�� �ڵ��� ��ȣ
					
					String mobile = custtel.getText("mtela") +"-"+ custtel.getText("mtel1") +"-"+ custtel.getText("mtel2");
								
					String owner_mobile  	= mobile;////�ڵ���
					String lp_code       		= "";////LP���
					lp_code = mailbilling.getText("slpcd");
					String amt           		= "";////�ݾ�
					String gubun         		= "";////��ȯ����

					String sms_code = "";
					if(srvc_gubun.equals("D"))
					{
						sms_code = "20";	
					}	
					
								
					input10.put("v_sms_code",  		sms_code);////SMS �޽��� �����ڵ�
					input10.put("v_success_yn",  		"0");////0-����,1-����
					input10.put("v_policy_no",  		policy_no);
					input10.put("v_name",  			name);
					input10.put("v_owner",  			owner);
					input10.put("v_owner_mobile",  	owner_mobile);
					input10.put("v_lp_code",  		lp_code);
					input10.put("v_amt",  			amt);
					input10.put("v_gubun",  			gubun);
					
					input10.put("tran_etc1",  			indate);////�Է³�¥
					input10.put("tran_etc2",  			seq_no);////���� ����
					////APL������ ��쿡�� ��,LP,SM���� SMS������
					if(srvc_gubun.equals("D"))
					{
						input10.put("v_pr",  			"AL");
					}
					
					anyframe.log.Logger.debug.println("�׷���� ���� action���� input10 ��  : "+input10 );			            
					DataSet sms_ins_cu = manager2.findClientSms(input10);////CU��	
					*/
		 		}		 		

		 	}
		 	////�׷���� ��
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
		 	
		 	Logger.debug.println("PolicyindivAction -- wb_master�� process_mode - ����");
		 	/*********** wb_master�� process_mode�� "B"�� update : S ************/
		 	masterUpt.put("process_mode", "B");
		 	masterUpt.put("indate",  	indate);
    			masterUpt.put("seq_no",  	seq_no);
    			Logger.debug.println("PolicyindivAction -- wb_master�� process_mode - masterUpt : "+masterUpt);
		 	DataSet master_update = manager.master_upt(masterUpt);
		 	/*********** wb_master�� process_mode�� "B"�� update : E ************/

		 	
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
            anyframe.log.Logger.debug.println("����ó���ÿ� ������----  rtn  : "+rtn);
            anyframe.log.Logger.debug.println("����ó���ÿ� ������----  srvc_ind  : "+srvc_ind );

	  	////������Ʈ�� �޽��� ó�� - S
    		if( searchgubun.equals("H") || searchgubun.equals("B") || searchgubun.equals("C"))
	    	{
			String msg = "";

	        	int success = Integer.parseInt(rtn);
				
	    		switch(success)
	    		{
	        		case(0) :
	            			msg =  "���������� ó���Ǿ����ϴ�.";
							////msg = "�����ָ� : " + payorna;
	            			break;
	            		case(9) :
	            			////msg =  "������Ȯ���� �����Ͽ����ϴ�..";
					msg = errmsg;
	            			break;	
	        		default :
	            			////msg = "ó���� �����Ͽ����ϴ�.";
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
