
package gtone.changeminer.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;


import gtone.changeminer.common.utility.*;
import gtone.changeminer.payment.form.DividendsearchForm;
import gtone.changeminer.payment.manager.DividendsearchManager;

import gtone.changeminer.payment.form.RestingsearchForm;
import gtone.changeminer.payment.manager.RestingsearchManager;
import gtone.changeminer.payment.form.PlpaymentForm;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.ReturnManager;
import java.lang.*; 
import java.util.Calendar;

////����
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 ����ڰ���
import gtone.changeminer.common.manager.DeathRegistrationManager;
/**
 * @struts.action
 *      path="/dividend_search" 
 *      name="dividendsearchForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="dividend_search"
 *      path="/dividend_search.jsp"
 * 
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class DividendsearchAction extends CyberpayAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ DividendsearchAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			DataSet input5 = new DataSet();
			DataSet input6  = new DataSet();

			DividendsearchForm dividendsearchForm = (DividendsearchForm) form;
			FormToDataset.copyProperties(input, dividendsearchForm);			
			
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");						
			
			////���糯¥ ��������
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);
			String cnvdate	= to_year;
			
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");
			String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");	
						
			////���ǻ���ϱ�
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);			

			String proc_emp_no = emp_no;////ó���ڻ��	
			
			String tproc_emp_no = proc_emp_no.toUpperCase();			
			
			////������ Ȯ���ϴ� ���μ���			
			String sbkcda	= request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
			String sbknoa  = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
			String pyrna    = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");	

			String init  = proc_emp_no;////�͹̳ξ��̵�
			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");////ó���ɼ�(�ؾ�,ó��(I)				
			opt1 = "S";////����� ��� S(ó��)
			String rcvdate = request.getParameter("rcvdate")	== null ? "" : request.getParameter("rcvdate");////��������	
			String date = request.getParameter("date")	== null ? "" : request.getParameter("date");////��������										
			String bk_clt = request.getParameter("bk_clt")	== null ? "" : request.getParameter("bk_clt");////�����ֹι�ȣ	
			String bk_cod = request.getParameter("bk_cod")	== null ? "" : request.getParameter("bk_cod");////�����ڵ�	
			String bk_acct = request.getParameter("bk_acct")	== null ? "" : request.getParameter("bk_acct");////���¹�ȣ										
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");////��������										
			String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////ó������							

			String sndseq  = request.getParameter("sndseq")	== null ? "" : request.getParameter("sndseq");////���۹�ȣ			
			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "";////�����ָ�	
			String bnkyn	= request.getParameter("bnkyn")	== null ? "" : request.getParameter("bnkyn");	

			RestingsearchManager Rmanager = RestingsearchManager.getInstance();////����
			PlpaymentManager Pmanager = PlpaymentManager.getInstance();////������Ȯ�� ���μ���
			ReturnManager returns = ReturnManager.getInstance();////�ݼ�	
			
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);
			
			input1.put("policy_apln_no", policy_apln_no);
			input1.put("recon_id", proc_emp_no);
			input2.put("proc_emp_no", proc_emp_no);
			
			DividendsearchManager manager = DividendsearchManager.getInstance();			
			DataSet dividendsearch 	= manager.findDividendsearch(input);
			DataSet  payment   = manager.Inpayment(input1, input2);	
					
			////20060530 �躸�� 0601081 ����/��ȿ(��/��)üũ�߰�	
			anyframe.log.Logger.debug.println("������� Action���� �߰��׸�1 policy==========="+policy);										
			DataSet checkopt  = Pmanager.Chkpayment(policy);
			
			////20060530 �躸�� 0601081 workingday�� ����/��ȿ(��/��)üũ�߰�	
			////���� ��¥ ������ workingday ���� �������� 
			////step1. ��¥ ��꿡 �ʿ��� ���� ���� 
			Calendar cal = Calendar.getInstance();                 
			String days = ""; 
			String month = ""; 
			String year = ""; 
			String today = "";
			    
			//// Step2. ��¥ ���� (��-��-�� ��) 
			days = String.valueOf( cal.get(Calendar.DATE) ); 
			month = String.valueOf( cal.get(Calendar.MONTH) + 1 ); 
			year = String.valueOf( cal.get(Calendar.YEAR) );
			             
			//// Step3-1.Days�� ���ڸ��� �ٲ� [�� : 1 -> 01] 
			if( days.length() == 1 )        days = "0" + days;                 
			//// Step3-2.Month�� ���ڸ��� �ٲ� [�� : 1 -> 01]                        
			if( month.length() == 1 ) 	month = "0" + month; 
			
			//// Step4. ��¥ ��ȯ 
			today = year + month + days;
				
			anyframe.log.Logger.debug.println("������� Action���� �߰��׸�2today==========="+today);										
			DataSet  workinginfo = Pmanager.Workinginfo(today);
				
			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input3.put("musera", "INTUSER");
				input3.put("sbkcda", sbkcda);
				input3.put("sbknoa", sbknoa);
				input3.put("amount", "00000000001");
				input3.put("pyrna", pyrna);
				input3.put("procgb", "O");
				DataSet bankconf = Pmanager.confBank(input3, input1);
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);
				
				request.setAttribute("bankconf", bankconf);
				payment   = manager.Inpayment(input1, input2);	
				
				bankerr = bankconf.getText("rtn").trim();////�����ڵ�
				bankerrmsg = bankconf.getText("errmsg").trim();////�����޼���
				payorna = bankconf.getText("payorna").trim();////�����ָ�
				
				if(!bankerr.equals("0"))
				{
					input5.put("policy_apln_no", policy_apln_no);
					input5.put("proc_emp_no", proc_emp_no);
					input5.put("proc_status", "2");
					input5.put("err_msg", bankerrmsg);
					
					DataSet rtnsave = returns.findRtnsave(input5);
					request.setAttribute("rtnsave", rtnsave);	

				}
				
				 /****** �޽��� - S ******/ 
				int success = Integer.parseInt(bankerr);
		    		
		    		switch(success)
		    		{
		        		case(0) :
		            			////message =  "������ Ȯ���� �Ǿ����ϴ�..";
						message = "�����ָ� : " + payorna;
		            			break;
		        		case(1) :
		            			////message = payorna + "������ Ȯ���� �����Ͽ����ϴ�.";
						message = bankerrmsg;
		            			break;
		        		default :
		            			////message = payorna + "������ Ȯ���� �����Ͽ����ϴ�.";
						message = bankerrmsg;
		            			break;
		    		}	
			}				
			
			
			/*  ó���� ��ȸ Host ���� ��翹ġ�� ���� ���� üũ, ���� ��� ó�� ���� �Ұ� */
		
			if(process.equals("Y")||process.equals("R"))
			{
				
				Logger.debug.println("################��翹ġ��####################");		
				
				dividendsearch 	= manager.findDividendsearch(input);

				int amt1 = dividendsearch.getInt("acu_div");
		
				
				if( amt1 > 0 )
				{
					bankerr = "1";
					message = "��翹ġ���� �����ϴ�.";		
					Logger.debug.println("################��翹ġ���� �����ϴ�.####################");		
				}
				
				////	ó���� ��ȸ�� �������̸� �����Ѵ�. 			  
				if(bankerr.equals("-1")){		  
							  
					if(process.equals("Y"))
					{
		
						payment   = manager.Inpayment(input1, input2);		
						Logger.debug.println("################��翹ġ��ó��####################");		
								
					}	
					else if(process.equals("R"))
					{
						DataSet recognize = Pmanager.getRecon(input1);
						request.setAttribute("recognize", recognize);		
						payment   = manager.Inpayment(input1, input2);		
						Logger.debug.println("################��翹ġ�ݰ����û####################");				
					}		
				}	
		
			}
			////20060530 �躸��
			request.setAttribute("checkopt", checkopt);
			request.setAttribute("workinginfo", workinginfo);
			////
			
			request.setAttribute("dividendsearch", dividendsearch);
			request.setAttribute("payment", payment);
			
			request.setAttribute("policy",policy);
 			request.setAttribute("policy_apln_no",policy_apln_no);
 			request.setAttribute("ssn",ssn);			
 			
			request.setAttribute("sbkcda",sbkcda);
 			request.setAttribute("sbknoa",sbknoa);
 			request.setAttribute("pyrna",pyrna);

			request.setAttribute("opt1",opt1);
			request.setAttribute("rcvdate",rcvdate);
			request.setAttribute("date",date);
			request.setAttribute("bk_clt",bk_clt);
			request.setAttribute("bk_cod",bk_cod);
			request.setAttribute("bk_acct",bk_acct);
			request.setAttribute("process",process); 			
			request.setAttribute("indate",indate);

			//// 2008.02.25 ������ �߰� (����ڰ��� ���� ����)
			String deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"P");
			request.setAttribute("deathResult",deathResult);			
			Logger.debug.println("################ DividendsearchAction End ####################");

			if( !bankerr.equals("-1") )
			{
            			String msg = message;
            			String url = "/payment/dividend_search.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
            			request.setAttribute("message", msg);	
            			request.setAttribute("toURL", url);	
            			return mapping.findForward("alert");
			}
		    	else
		    	{
				Logger.debug.println("################ PlpaymentpaidupAction Action End ####################");
				return mapping.findForward("dividend_search");
			}


		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
