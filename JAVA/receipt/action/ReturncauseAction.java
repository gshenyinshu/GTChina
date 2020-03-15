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
import gtone.changeminer.receipt.form.ReturncauseForm;
import gtone.changeminer.receipt.manager.ReturncauseManager;

import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

import java.lang.*; 
import anyframe.jsp.*;

////SMS
import gtone.changeminer.receipt.manager.CyberSmsManager;

////메일
import gtone.changeminer.receipt.form.PolicyrealForm;
import gtone.changeminer.receipt.manager.PolicychangeManager;
import gtone.changeminer.common.utility.Variable;////prumail.xml에서 메일경로

////고객정보외의 메일을 보내기위한 데이타
import gtone.changeminer.receipt.form.ReturncontentForm;
import gtone.changeminer.receipt.manager.ReturncontentManager;

/**
 * @struts.action
 *      path="/return_cause"
 *      name="ReturncauseForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="return_cause"
 *      path="/return_cause.jsp"
 *
 */
 
public  class ReturncauseAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ ReturncauseAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();
			DataSet input4  = new DataSet();	
			DataSet input6  = new DataSet();	
			DataSet input8  = new DataSet();
			DataSet input11 = new DataSet();
			DataSet mailread = new DataSet();
			DataSet custdate = new DataSet();
			
			ReturncauseForm returncauseForm = (ReturncauseForm)form;
			
			ReturncauseManager manager = ReturncauseManager.getInstance();
			
			ReturncontentManager returncontent = ReturncontentManager.getInstance();
			
			////세션사용하기			
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
            
			 ////SMS
			 CyberSmsManager manager2 = CyberSmsManager.getInstance();			

		      ////메일
		       PolicychangeManager mailsend = PolicychangeManager.getInstance();

			String flag 	= request.getParameter("flag")	== null ? "" : request.getParameter("flag");	
			String chkyn 	= request.getParameter("chkyn")	== null ? "" : request.getParameter("chkyn");	
			String cate_desc = request.getParameter("cate_desc")	== null ? "" : request.getParameter("cate_desc");	
			String indate 	= request.getParameter("indate")	== null ? "" : request.getParameter("indate");				
			String seq_no  = request.getParameter("seq_no")	== null ? "" : request.getParameter("seq_no");	
			String srvc_gubun  = request.getParameter("srvc_gubun")	== null ? "" : request.getParameter("srvc_gubun");							
			String prcode = "1";
			String prdate = Util.getTodayToYMD().substring(0,8);
			String prtime = anyframe.util.DateTime.getFormatString("HHmmss");
			
			anyframe.log.Logger.debug.println("srvc_gubun==========="+srvc_gubun);
			anyframe.log.Logger.debug.println("flag==========="+flag);
			anyframe.log.Logger.debug.println("chkyn==========="+chkyn);
			anyframe.log.Logger.debug.println("cate_desc==========="+cate_desc);
			anyframe.log.Logger.debug.println("indate==========="+indate);
			anyframe.log.Logger.debug.println("seq_no==========="+seq_no);
													
			if(flag.equals("S") && chkyn.equals("Y"))
			{
				////wb_master에 update
				input1.put("indate", indate);
				input1.put("seq_no", seq_no);
				input1.put("status", "3");////반송
				input1.put("prdate", prdate);
				input1.put("prtime", prtime);

				anyframe.log.Logger.debug.println("반송사유 입력할때 사용 마스터  input==========="+input);

				DataSet uptmaster = manager.uptReturnmaster(input1);
				request.setAttribute("uptmaster", uptmaster);					
				
				////계약및 고객정보변경에 반송상태값 저장
				
				if(srvc_gubun.equals("A"))
				{
					input2.put("table", "CYBER.DBO.CYBER_TBL_WB_MEMBER");
				}
				else if( srvc_gubun.equals("B") || srvc_gubun.equals("D"))
				{
					input2.put("table", "CYBER.DBO.CYBER_TBL_WB_ACCOUNT");
				}
				else if( srvc_gubun.equals("E") || srvc_gubun.equals("F") )
				{
					input2.put("table", "CYBER.DBO.CYBER_TBL_WB_AUTO_REPAYMENT");
				}
				else if( srvc_gubun.equals("C") || srvc_gubun.equals("G") || srvc_gubun.equals("I") || srvc_gubun.equals("J") )
				{
					input2.put("table", "CYBER.DBO.CYBER_TBL_WB_METHOD");
				}
				
				
				input2.put("indate", indate);
				input2.put("seq_no", seq_no);
				input2.put("prcode", "1");
				input2.put("rslt", "3");
				input2.put("err_msg", cate_desc);
				input2.put("prdate", prdate);
				input2.put("prtime", prtime);
				input2.put("emp_no", emp_no);
				
				anyframe.log.Logger.debug.println("반송사유 입력할때 사용 디테일 input==========="+input);

				DataSet uptdetail = manager.uptReturndetail(input2);
				request.setAttribute("uptdetail", uptdetail);	
				
				if(srvc_gubun.equals("A"))	
				{
					input8.put("indate", indate);
			 		input8.put("seq_no", seq_no);
			 		input8.put("prcode", "1");
			 		
			 		DataSet mailcust = mailsend.findMail_custmsg(input8); 
					request.setAttribute("mailcust",mailcust);
					
					////고객에게 메일
					
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber19"));////80
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", mailcust.getText("ssn"));
					input6.put("v_to_name", mailcust.getText("owner"));
					input6.put("v_to_email", mailcust.getText("aemail"));
					
					
					
					String owner1 = Util.superTrim(ToolString.hanToFull(mailcust.getText("owner")));
					String jumin = mailcust.getText("ssn").substring(0,6) +"-"+ mailcust.getText("ssn").substring(6);
					String indate1 = "";
					String prdate1 = "";
					indate1 = indate.substring(0,4) +" 년 " + StringFormater.removeZero(indate.substring(4,6)) + " 월 "  + StringFormater.removeZero(indate.substring(6,8)) + " 일";
					prdate1 = prdate.substring(0,4) +" 년 " + StringFormater.removeZero(prdate.substring(4,6)) + " 월 "  + StringFormater.removeZero(prdate.substring(6,8)) + " 일";
					
					
					String mapping2= "";
					mapping2 = owner1 +"|"+ owner1 +"|" + jumin +"|"+ indate1 +"|"+ prdate1 +"|"+HtmlUtil.translateNewline(mailcust.getText("err_msg"));
					
					input6.put("v_mapping", mapping2);
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
							input6.put("v_mail_type_seq", Variable.get("email-id.cyber20"));////81
							input6.put("v_to_email", lpsmtot.getText("lpemail",j));
							
							
							String templp = Util.superTrim(ToolString.hanToFull(lpsmtot.getText("lpname",j)));
							String tempsm = Util.superTrim(ToolString.hanToFull(lpsmtot.getText("sm_name",j)));
							String custssn = "";
							custssn = mailcust.getText("ssn").substring(0,6) + "-"+ mailcust.getText("ssn").substring(6);
							mappingcu1 = "";
							mappingcu1 = templp+"|"+owner1+"|"+ owner1 +"|"+custssn +"|"+ indate1 + "|"+prdate1 +"|"+ HtmlUtil.translateNewline(mailcust.getText("err_msg",j));
							input6.put("v_mapping", mappingcu1);
							input6.put("v_lp_code", lpsmtot.getText("lp_code",j));
							anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);														
							anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 메핑필드  : "+mappingcu1);														
							DataSet maillp = mailsend.sendMail(input6); 
							
							
						}
					
					}
					
				}////고객정보 반송
				else
				{
					if( srvc_gubun.equals("B") || srvc_gubun.equals("D"))
					{
						mailread.put("table", "CYBER.DBO.CYBER_TBL_WB_ACCOUNT b" );
					}
					else if( srvc_gubun.equals("E") || srvc_gubun.equals("F") )
					{
						mailread.put("table", "CYBER.DBO.CYBER_TBL_WB_AUTO_REPAYMENT b");
					}
					else if( srvc_gubun.equals("C") || srvc_gubun.equals("G") || srvc_gubun.equals("I") || srvc_gubun.equals("J") )
					{
						mailread.put("table", "CYBER.DBO.CYBER_TBL_WB_METHOD  b");
					}
					
					mailread.put("indate", indate);
					mailread.put("seq_no", seq_no);
					mailread.put("prcode", "1");
					
					DataSet returncont = returncontent.Selcontent(mailread);
					request.setAttribute("returncont", returncont);	
					
					custdate.put("deptcd",    "INT");
					custdate.put("init",      	"CYBER");
					custdate.put("cltno",     	returncont.getText("ssn"));
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
					DataSet custmail = manager2.findCusttel(custdate);////고객 메일
					
					////고객에게 메일
					String owner2 =  Util.superTrim(ToolString.hanToFull(returncont.getText("owner")));
					String jumin1 = "";
					jumin1 = returncont.getText("ssn").substring(0,6) +"-"+ returncont.getText("ssn").substring(6);
					String plan_nm = "";
					plan_nm = Util.superTrim(ToolString.hanToFull(returncont.getText("plan_nm")));
					String indate1 = "";
					String prdate1 = "";
					indate1 = indate.substring(0,4) +" 년 " + StringFormater.removeZero(indate.substring(4,6)) + " 월 "  + StringFormater.removeZero(indate.substring(6,8)) + " 일";
					prdate1 = prdate.substring(0,4) +" 년 " + StringFormater.removeZero(prdate.substring(4,6)) + " 월 "  + StringFormater.removeZero(prdate.substring(6,8)) + " 일";
					
					String map = "";
					map = owner2 +"|"+returncont.getText("srvc_cd") + "|"+ plan_nm + "|"+ returncont.getText("policy") + "|" + indate1 + "|"+ prdate1 + "|" +HtmlUtil.translateNewline(returncont.getText("err_msg"));
					
					
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber05"));////57
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", returncont.getText("ssn"));
					input6.put("v_to_name", returncont.getText("owner"));
					input6.put("v_to_email", custmail.getText("email"));
					
					input6.put("v_mapping", map);
					input6.put("v_lp_code", "");
					input6.put("v_policy_number",returncont.getText("policy"));
					input6.put("v_channel", "cyber");
					input6.put("v_ilips_client_id", "");
					anyframe.log.Logger.debug.println("고객에게 메일 보내기 위한 필드  : "+input6);
					DataSet mailcustc = mailsend.sendMail(input6); 
					request.setAttribute("mailcustc",mailcustc);		 
					
					////LP에게 메일보내기
					String templp = Util.superTrim(ToolString.hanToFull(returncont.getText("lpname")));
					String tempsm = Util.superTrim(ToolString.hanToFull(returncont.getText("smname")));					
					
					input6.put("v_mail_type", "03");
					input6.put("v_mail_type_seq", Variable.get("email-id.cyber06"));////58
					input6.put("v_channel_code", "00000030");
					input6.put("v_member_id", returncont.getText("ssn"));					
					input6.put("v_to_name", templp);
					input6.put("v_to_email", returncont.getText("lpemail"));
					
					map  = "";
					map = templp + "|"+owner2 +"|"+returncont.getText("srvc_cd") + "|"+ jumin1 + "|"+ plan_nm + "|"+ returncont.getText("policy") + "|" + indate1 + "|"+ prdate1 + "|" +HtmlUtil.translateNewline(returncont.getText("err_msg"));
					input6.put("v_mapping", map);
					input6.put("v_lp_code", returncont.getText("slpcd"));
					input6.put("v_policy_number",returncont.getText("policy"));
					input6.put("v_channel", "cyber");
					input6.put("v_ilips_client_id", "");
					anyframe.log.Logger.debug.println("LP에게 메일 보내기 위한 필드  : "+input6);
					DataSet maillp = mailsend.sendMail(input6); 
					request.setAttribute("maillp",maillp);	

					
					
				}////그외의 반송	
		
			}
			
			request.setAttribute("flag",flag);			
			request.setAttribute("chkyn",chkyn);
			request.setAttribute("cate_desc",cate_desc);
			request.setAttribute("indate",indate);
			request.setAttribute("seq_no",seq_no);
			request.setAttribute("srvc_gubun",srvc_gubun);
			
			
			return mapping.findForward("return_cause");
				
			
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}