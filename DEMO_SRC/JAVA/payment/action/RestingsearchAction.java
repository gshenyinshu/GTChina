
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
import gtone.changeminer.payment.form.RestingsearchForm;
import gtone.changeminer.payment.manager.RestingsearchManager;

import gtone.changeminer.payment.form.PlpaymentForm;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.ReturnManager;
import java.lang.*; 

////����
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 ����ڰ���
import gtone.changeminer.common.manager.DeathRegistrationManager;
/**
 * @struts.action
 *      path="/resting_search"
 *      name="restingsearchForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="resting_search"
 *      path="/resting_search.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
 
public  class RestingsearchAction extends CyberpayAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ RestingsearchAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();	
			DataSet input4  = new DataSet();	
			DataSet input5  = new DataSet();
			DataSet input6  = new DataSet();

			RestingsearchForm restingsearchForm = (RestingsearchForm) form;
			FormToDataset.copyProperties(input, restingsearchForm);			
			
			RestingsearchManager manager = RestingsearchManager.getInstance();
			PlpaymentManager managerp = PlpaymentManager.getInstance();////������Ȯ�� ���μ���
			ReturnManager returns = ReturnManager.getInstance();////�ݼ�	
			
			String deptcd	  	= "INT";
			String init			= "     ";
			String cltno 		= restingsearchForm.getCltno(); 
			
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");						
			cltno   = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");									
						
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");			
			String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");	
			
			////���ǻ���ϱ�
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);			
			
			String proc_emp_no = emp_no;////ó���ڻ��
			
			String tproc_emp_no = proc_emp_no.toUpperCase();
			
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);
			String recvdat  = "";
			recvdat		= to_year;
			recvdat		= "        ";
			
			////������ Ȯ���ϴ� ���μ���			
			String sbkcda	= request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
			String sbknoa  = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
			String pyrna    = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");	
			String strAcctSsn    = request.getParameter("strAcctSsn")	== null ? "" : request.getParameter("strAcctSsn");

			init  = proc_emp_no;////�͹̳ξ��̵�
			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");////ó���ɼ�(�ؾ�,ó��(I)				
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
			String message1 = "";
			
			input.put("policy", policy);
			input.put("cnvdate",   recvdat);
	
			input1.put("deptcd", deptcd);		
			input1.put("init", init);
			input1.put("cltno",   cltno);

			input2.put("policy_apln_no", policy_apln_no);
			input2.put("recon_id", proc_emp_no);
			input4.put("proc_emp_no", proc_emp_no);

			DataSet plcynoinfo 		= manager.findPlcynoinfo(input);
			anyframe.log.Logger.debug.println("	input1.toString()================"+	input1.toString());
			DataSet restingsearch 	= manager.findRestingsearch(input1);
			anyframe.log.Logger.debug.println("	restingsearch.toString()================"+	restingsearch.toString());
			DataSet  payment   = manager.Inpayment(input2, input4);

			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input3.put("musera", "INTUSER");
				input3.put("sbkcda", sbkcda);
				input3.put("sbknoa", sbknoa);
				input3.put("amount", "00000000001");

				System.out.println("�Ա��� Ȯ�� strAcctSsn : [" + strAcctSsn + "] pyrna : [" + pyrna + "]");

				//// �ӱ��� �ֹι�ȣ�� �������� �װɷ� �Ѵ�. �޸麸��� 1���� �����϶� �ٸ� �Ա��ڷ� �����ֱ� ����.
				if("".equals(Utility.nvl(strAcctSsn)) == false) {
					input3.put("pyrna", strAcctSsn);
				}else {
					input3.put("pyrna", pyrna);
				}
				
				input3.put("procgb", "O");
				System.out.println("�Ա��� �Է� input3 : " + input3);
				DataSet bankconf = managerp.confBank(input3, input2);
				request.setAttribute("bankconf", bankconf);
				bnkyn = bankconf.getText("rtn").trim();

				request.setAttribute("bnkyn", bnkyn);

				payment   = manager.Inpayment(input2, input4);
				
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
					/*
					input6.put("policy_apln_no", policy_apln_no);				
					input6.put("proc_status", "2");
					input6.put("err_msg", bankerrmsg);
					DataSet rtnsave1 = returns.findRtnsave1(input6);
					request.setAttribute("rtnsave1", rtnsave1);					
					*/
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
			

						
			if(process.equals("Y"))
			{
				/*
				input5.put("deptcd", "INT");
				input5.put("init", tproc_emp_no);
				input5.put("policy", policy);
				input5.put("opt1", opt1);
				input5.put("divocc", "");
				input5.put("rcvdate", rcvdate);
				input5.put("date", to_year);
				input5.put("sndseq", "      ");////������ȣ(ó����ȣ)
				input5.put("bk_clt", bk_clt);
				input5.put("bk_cod", bk_cod);
				input5.put("bk_acct", bk_acct);
				input5.put("disbyn", " ");
				input5.put("amount", "00000000000");
				
				input4.put("proc_emp_no", proc_emp_no);
				
				anyframe.log.Logger.debug.println("Action M0191SP1  input3==========="+input5);
				
				DataSet approval = manager.getApproval(input5, input2, input4);////����,policy_apln_no,proc_emp_no
				request.setAttribute("approval", approval);				
				*/

				payment   = manager.Inpayment(input2, input4);
			}			
			else if(process.equals("R"))
			{
				DataSet recognize = managerp.getRecon(input2);
				request.setAttribute("recognize", recognize);		
				payment   = manager.Inpayment(input2, input4);
			}
			else if(process.equals("L"))
			{
				plcynoinfo 	= manager.findPlcynoinfo(input);
				
				
				restingsearch 	= manager.findRestingsearch(input1);	
			}

			
			
											
			request.setAttribute("plcynoinfo", plcynoinfo); 
			request.setAttribute("restingsearch", restingsearch); 
			request.setAttribute("payment", payment);
			
			request.setAttribute("policy",policy);
 			request.setAttribute("policy_apln_no",policy_apln_no);
 			request.setAttribute("ssn",ssn);
 			
			request.setAttribute("sbkcda",sbkcda);
 			request.setAttribute("sbknoa",sbknoa);
 			request.setAttribute("pyrna",pyrna);
			request.setAttribute("strAcctSsn",strAcctSsn);

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
			Logger.debug.println("################ RestingsearchAction End ####################");

			if( !bankerr.equals("-1") )
			{
            			String msg = message;
            			String url = "/payment/resting_search.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
            			request.setAttribute("message", msg);	
            			request.setAttribute("toURL", url);	
            			return mapping.findForward("alert");
			}
		    	else
		    	{
				Logger.debug.println("################ PlpaymentAction Action End ####################");
				return mapping.findForward("resting_search");
			}
			/****** �޽��� - E ******/ 					

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
