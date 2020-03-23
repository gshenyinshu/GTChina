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
import gtone.changeminer.receipt.form.PlrepaymentsearchForm;
import gtone.changeminer.receipt.manager.PlrepaymentsearchManager;

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
 *      path="/pl_repayment_search"
 *      name="plrepaymentsearchForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="pl_repayment_search"
 *      path="/pl_repayment_search.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class PlrepaymentsearchAction extends CyberReturnAction
{
	public ActionForward doExecute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ PlrepaymentsearchAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1 = new DataSet();
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			DataSet input5 = new DataSet();
			DataSet input6 = new DataSet();
			DataSet issdateT = new DataSet();////계약일

			PlrepaymentsearchForm plrepaymentsearchForm = (PlrepaymentsearchForm) form;
			FormToDataset.copyProperties(input, plrepaymentsearchForm);		
									
			String policy   = request.getParameter("policy")	== null ? "" : request.getParameter("policy");	
			String policy_apln_no   = request.getParameter("policy_apln_no")	== null ? "" : request.getParameter("policy_apln_no");////접수번호	
			String ssn    = request.getParameter("ssn")	== null ? "" : request.getParameter("ssn");				
			
			////현재날짜 가져오기
			String to_year = null;
			String v_toyear = Util.getTodayToYMD();
			to_year = v_toyear.substring(0,8);
			String cnvdate	= to_year;

			////세션사용하기
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

			String proc_emp_no = emp_no;////처리자사번		
			String tproc_emp_no = proc_emp_no.toUpperCase();			
			
			String sbkcda	= request.getParameter("sbkcda")	== null ? "" : request.getParameter("sbkcda");	
			String sbknoa  = request.getParameter("sbknoa")	== null ? "" : request.getParameter("sbknoa");	
			String pyrna    = request.getParameter("pyrna")	== null ? "" : request.getParameter("pyrna");				

			String opt1 =  request.getParameter("opt1")	== null ? "" : request.getParameter("opt1");	
			String regdate  = request.getParameter("regdate")	== null ? "" : request.getParameter("regdate");	
			String cash =  request.getParameter("cash")	== null ? "" : request.getParameter("cash");	
			String bnkclt =  request.getParameter("bnkclt")	== null ? "" : request.getParameter("bnkclt");	
			String bnkcode  = request.getParameter("bnkcode")	== null ? "" : request.getParameter("bnkcode");	
			String bnkacct = request.getParameter("bnkacct")	== null ? "" : request.getParameter("bnkacct");	
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");	
			String process  = request.getParameter("process")	== null ? "" : request.getParameter("process");	
			opt1 = "P3";

			String message = "";
			String bankerr = "-1";
			String bankerrmsg  = "";
			String payorna = "";////예금주명
			String returnurl =  request.getParameter("returnurl")	== null ? "" : request.getParameter("returnurl");	
			String bnkyn	= request.getParameter("bnkyn")	== null ? "" : request.getParameter("bnkyn");	

			PlpaymentManager Pmanager = PlpaymentManager.getInstance();////예금주확인 프로세스, WEBDB에서 약관대출 상환 내역 READ, 결재
			PlrepaymentsearchManager manager = PlrepaymentsearchManager.getInstance();	
			ReturnManager returns = ReturnManager.getInstance();////반송			

			input.put("policy", policy);
			input.put("cnvdate",   cnvdate);
			
			input1.put("policy_apln_no", policy_apln_no);
			input2.put("proc_emp_no", proc_emp_no);

			////계약일을 가져오기 위한 sp			
			issdateT.put("deptcd", "INT");////시스템이름
			issdateT.put("init", tproc_emp_no);////부서
			issdateT.put("plyno", policy);////증권번호

			DataSet plrepaymentsearch 	= manager.findPlrepaymentsearch(input);

			anyframe.log.Logger.debug.println("계약일을 가져오기 위한 input parameter==========="+issdateT);

			DataSet issdatesearch 	= manager.findIssdate(issdateT);

			request.setAttribute("issdatesearch", issdatesearch); 
			
			DataSet  payment   = Pmanager.Inpayment(input1, input2);



			if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
			{
				input3.put("musera", "INTUSER");
				input3.put("sbkcda", sbkcda);
				input3.put("sbknoa", sbknoa);
				input3.put("amount", "00000000001");
				input3.put("pyrna", pyrna);
				input3.put("procgb", "I");
				DataSet bankconf = Pmanager.confBank(input3, input1);
				request.setAttribute("bankconf", bankconf);	
				bnkyn = bankconf.getText("rtn").trim();
				request.setAttribute("bnkyn", bnkyn);			
				
				bankerr = bankconf.getText("rtn").trim();////에러코드
				bankerrmsg = bankconf.getText("errmsg").trim();////에러메세지
				payorna = bankconf.getText("payorna").trim();////예금주명								
				
				if(!bankerr.equals("0"))
				{
					input4.put("policy_apln_no", policy_apln_no);
					input4.put("proc_emp_no", proc_emp_no);
					input4.put("proc_status", "60");
					input4.put("err_msg", bankerrmsg);
					
					DataSet rtnsave = returns.findRtnsave(input4);
					request.setAttribute("rtnsave", rtnsave);	
					/*
					input5.put("policy_apln_no", policy_apln_no);				
					input5.put("proc_status", "2");
					input5.put("err_msg", bankerrmsg);
					DataSet rtnsave1 = returns.findRtnsave1(input5);
					request.setAttribute("rtnsave1", rtnsave1);					
					*/
				}
				
				payment   = Pmanager.Inpayment(input1, input2);
				
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
				payment   = Pmanager.Inpayment(input1, input2);		
			}
			else if(process.equals("L"))	
			{
				plrepaymentsearch 	= manager.findPlrepaymentsearch(input);
			}

			request.setAttribute("plrepaymentsearch", plrepaymentsearch);
			request.setAttribute("payment", payment); 
			
			request.setAttribute("policy",policy);
 			request.setAttribute("policy_apln_no",policy_apln_no);
 			request.setAttribute("ssn",ssn);			
				
 			request.setAttribute("sbkcda",sbkcda);
 			request.setAttribute("sbknoa",sbknoa);
 			request.setAttribute("pyrna",pyrna);

 			request.setAttribute("opt1",opt1);
 			request.setAttribute("regdate",regdate);
 			request.setAttribute("cash",cash);
 			request.setAttribute("indate",indate);
 			request.setAttribute("bnkclt",bnkclt);
 			request.setAttribute("bnkcode",bnkcode);
 			request.setAttribute("process",process);				
 			request.setAttribute("returnurl",returnurl);	

			//// 2008.02.25 김종명 추가 (사망자관련 정보 셋팅)
			String deathResult =  DeathRegistrationManager.DeathRegistration2(policy,"R");
			request.setAttribute("deathResult",deathResult);
			
			Logger.debug.println("################ PlrepaymentsearchAction End ####################");


		    if( !bankerr.equals("-1") )
		    {
	           	String msg = message;
	        	String url = "/receipt/pl_repayment_search.do?policy_apln_no="+policy_apln_no+"&ssn="+ssn+"&policy="+policy+"&bnkyn="+bnkyn;
	        	request.setAttribute("message", msg);	
	        	request.setAttribute("toURL", url);	
	        	return mapping.findForward("alert");
		    }
		    else
		    {
			Logger.debug.println("################ PlpaymentAction Action End ####################");
			return mapping.findForward("pl_repayment_search");
		    }

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}
