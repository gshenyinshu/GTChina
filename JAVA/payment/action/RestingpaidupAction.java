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
import gtone.changeminer.payment.form.RestingpaidupForm;
import gtone.changeminer.payment.manager.RestingpaidupManager;

import gtone.changeminer.payment.form.RestingsearchForm;
import gtone.changeminer.payment.manager.RestingsearchManager;

import gtone.changeminer.payment.form.PlpaymentForm;
import gtone.changeminer.payment.manager.PlpaymentManager;
import gtone.changeminer.payment.manager.ReturnManager;
import java.lang.*; 

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

//// 2008.03.25 사망자관련
import gtone.changeminer.common.manager.DeathRegistrationManager;

/**
 * @struts.action
 *      path="/resting_paidup"
 *      name="restingpaidupForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="resting_paidup"
 *      path="/resting_paidup.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class RestingpaidupAction extends CyberpayAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ RestingpaidupAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1 = new DataSet();
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			DataSet input5 = new DataSet();
			DataSet input6  = new DataSet();

			RestingpaidupForm restingpaidupForm = (RestingpaidupForm) form;
			FormToDataset.copyProperties(input, restingpaidupForm);
			
			String deptcd  = "INT";
			String init		= "     ";
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");						
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");		
			
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8); 
			String cnvdate	= to_year;
			cnvdate = "        ";

			String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");
			
			////세션사용하기
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);			
			
			String proc_emp_no = emp_no;////처리자사번
			String tproc_emp_no = proc_emp_no.toUpperCase();
			
			////예금주 확인하는 프로세스			
			String sbkcda	= request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
			String sbknoa  = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
			String pyrna    = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");	
			String strAcctSsn    = request.getParameter("strAcctSsn")	== null ? "" : request.getParameter("strAcctSsn");

			init  = proc_emp_no;////터미널아이디
			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");////처리옵션(해약,처리(I)				
			String rcvdate = request.getParameter("rcvdate")	== null ? "" : request.getParameter("rcvdate");////접수일자	
			String date = request.getParameter("date")	== null ? "" : request.getParameter("date");////지급일자										
			String bk_clt = request.getParameter("bk_clt")	== null ? "" : request.getParameter("bk_clt");////예금주민번호	
			String bk_cod = request.getParameter("bk_cod")	== null ? "" : request.getParameter("bk_cod");////은행코드	
			String bk_acct = request.getParameter("bk_acct")	== null ? "" : request.getParameter("bk_acct");////계좌번호										
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");////접수일자										
			String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");////처리구분	
			
			String sndseq  = request.getParameter("sndseq")	== null ? "" : request.getParameter("sndseq");////전송번호			
			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "";////예금주명	
			String bnkyn	= request.getParameter("bnkyn")	== null ? "" : request.getParameter("bnkyn");	
						
			RestingpaidupManager manager = RestingpaidupManager.getInstance();
			PlpaymentManager managerp = PlpaymentManager.getInstance();////예금주확인 프로세스
			RestingsearchManager rmanager = RestingsearchManager.getInstance();////M0191SP1처리 프로세스
			ReturnManager returns = ReturnManager.getInstance();////반송	
															
			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);

			input1.put("deptcd", deptcd);
			input1.put("init", init);
			input1.put("policy", policy);

			input2.put("policy_apln_no", policy_apln_no);
			input2.put("recon_id", proc_emp_no);
			input4.put("proc_emp_no", proc_emp_no);

			DataSet  payment   	= rmanager.Inpayment(input2, input4);
			DataSet plcynoinfo 	= manager.findPlcynoinfo(input);
			DataSet restingpaidup 	= manager.findRestingpaidup(input1);	
						
			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input3.put("musera", "INTUSER");
				input3.put("sbkcda", sbkcda);
				input3.put("sbknoa", sbknoa);
				input3.put("amount", "00000000001");

				System.out.println("입금자 확인 strAcctSsn : [" + strAcctSsn + "] pyrna : [" + pyrna + "]");

				//// 임금자 주민번호가 있을때는 그걸로 한다. 휴면보험금 1만원 이하일때 다른 입금자로 보내주기 위함.
				if("".equals(Utility.nvl(strAcctSsn)) == false) {
					input3.put("pyrna", strAcctSsn);
				}else {
					input3.put("pyrna", pyrna);
				}

				input3.put("procgb", "O");
				System.out.println("입금자 입력 input3 : " + input3);

				DataSet bankconf = managerp.confBank(input3, input2);
				request.setAttribute("bankconf", bankconf);
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);

				payment   	= rmanager.Inpayment(input2, input4);
				
				bankerr = bankconf.getText("rtn").trim();////에러코드
				bankerrmsg = bankconf.getText("errmsg").trim();////에러메세지
				payorna = bankconf.getText("payorna").trim();////예금주명
				
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
				
				 /****** 메시지 - S ******/ 
				int success = Integer.parseInt(bankerr);
		    		
		    		switch(success)
		    		{
		        		case(0) :
		            			////message =  "예금주 확인이 되었습니다..";
						message = "예금주명 : " + payorna;
		            			break;
		        		case(1) :
		            			////message = payorna + "예금주 확인이 실패하였습니다.";
						message = bankerrmsg;
		            			break;
		        		default :
		            			////message = payorna + "예금주 확인이 실패하였습니다.";
						message = bankerrmsg;
		            			break;
		    		}	
			}					
									
			if(process.equals("Y"))
			{
				/*
				input5.put("deptcd", "INT");
				input5.put("init",tproc_emp_no );
				input5.put("policy", policy);
				input5.put("opt1", opt1);
				input5.put("divocc", "");
				input5.put("rcvdate", rcvdate);
				input5.put("date", to_year);
				input5.put("sndseq", "      ");////전문번호(처리번호)
				input5.put("bk_clt", bk_clt);
				input5.put("bk_cod", bk_cod);
				input5.put("bk_acct", bk_acct);
								
				anyframe.log.Logger.debug.println("Action M0191SP1  input3==========="+input5);
				
				DataSet approval = rmanager.getApproval(input5, input2, input4);////결재,policy_apln_no,proc_emp_no
				request.setAttribute("approval", approval);	
				*/
				payment   	= rmanager.Inpayment(input2, input4);			
			} 
			else if(process.equals("R"))
			{
				anyframe.log.Logger.debug.println("휴면보험금 제지급내역에서 접수번호==========="+input2);
				
				DataSet recognize = managerp.getRecon(input2);
				request.setAttribute("recognize", recognize);		
				payment   = rmanager.Inpayment(input2, input4);
			}
			else if(process.equals("L"))
			{
				plcynoinfo 	= manager.findPlcynoinfo(input);
				restingpaidup 	= manager.findRestingpaidup(input1);	
			}									
											
			request.setAttribute("plcynoinfo", plcynoinfo); 
			request.setAttribute("restingpaidup", restingpaidup); 
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

			//// 2008.02.25 김종명 추가 (사망자관련 정보 셋팅)
			String deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"P");
			request.setAttribute("deathResult",deathResult);			
			Logger.debug.println("################ RestingpaidupAction End ####################");

			if( !bankerr.equals("-1") )
			{
            			String msg = message;
            			String url = "/payment/resting_paidup.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
            			request.setAttribute("message", msg);	
            			request.setAttribute("toURL", url);	
            			return mapping.findForward("alert");
			}
		    	else
		    	{
				Logger.debug.println("################ PlpaymentAction Action End ####################");
				return mapping.findForward("resting_paidup");
			}

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
