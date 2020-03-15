package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;
import java.util.*;////Vector에 사용

import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.PolicyReissueForm;
import gtone.changeminer.receipt.manager.PolicyReissueManager;

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

/**
 * @struts.action
 *      path="/policy_reissue" 
 *      name="policyreissueForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="policy_reissue"
 *      path="/policy_reissue.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
 
 
public  class PolicyReissueAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 16;
        
        try
        {
            Logger.debug.println("################ PolicyReissueAction Start ####################");

            DataSet input = new DataSet();
            DataSet input1 = new DataSet();////일괄처리
			DataSet input2 = new DataSet();////발송,반송-update하기위해
			DataSet input3 = new DataSet();////즉시처리-접수로 update하기위해
			DataSet input4 = new DataSet();////msbd저장
            DataSet inputCount = new DataSet();
            
            PolicyReissueForm policyreissueForm = (PolicyReissueForm)form;
            FormToDataset.copyProperties(input, policyreissueForm);
			
	     	PolicyReissueManager manager = PolicyReissueManager.getInstance();
			
			////세션사용하기
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

			String proc_emp_no = emp_no;////처리자사번			
			
	     	String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
            String fromdate2 = request.getParameter("fromdate2") == null ? "" : request.getParameter("fromdate2");
            String todate2 = request.getParameter("todate2") == null ? "" : request.getParameter("todate2");            
            String srvc_ind = request.getParameter("srvc_ind") == null ? "all" : request.getParameter("srvc_ind");////업무분류            
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");
            String chk_code  = request.getParameter("chk_code") == null ? "" : request.getParameter("chk_code");
            String rtn  = request.getParameter("rtn") == null ? "0" : request.getParameter("rtn");
			
			
			
			/****************************************************************/
			////조회 - S
			String current = "";
            current = request.getParameter("current") == null ? "1" : request.getParameter("current");
            String page = "";
            page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));
            String where = "";
            String where1 = "";
			
			if(fromdate.length() > 0)
			{
				where = where + " and indate >='"+fromdate+"'"; 	
				where1 = where1 + " and indate >='"+fromdate+"'"; 	
			}
			
			if(todate.length() >0)
			{
				where = where + " and indate  <= '"+ todate+"'";
				where1 = where1 + " and indate  <= '"+ todate+"'";
			}

			if(fromdate2.length() > 0)
			{
				where = where + " and prdate >='"+fromdate2+"'"; 	
				where1 = where1 + " and prdate>='"+fromdate2+"'"; 	
			}
			
			if(todate2.length() >0)
			{
				where = where + " and prdate  <= '"+ todate2+"'";
				where1 = where1 + " and prdate  <= '"+ todate2+"'";
			}

			
			////증권번호 및 검색값
			if(search.equals("1"))
			{
				if(key.length() > 0)
				{
					where = where + "  and policy like '%"+ key +"%'	";				
					where1 = where1 + "  and policy like '%"+ key +"%'	";
				}					
			}
			else if(search.equals("2"))
			{
				if(key.length() > 0)
				{
					where = where + "  and name like '%"+ key +"%'	";				
					where1 = where1 + "  and name like '%"+ key +"%'	";
				}					
			}
			else if(search.equals("3"))
			{
				if(key.length() > 0)
				{
					where = where + "  and label_yn like '%"+ key +"%'	";				
					where1 = where1 + "  and label_yn like '%"+ key +"%'	";
				}					
			}
			
			
			////상태				
			if( !srvc_ind.equals("all") )
			{
				where = where + " and rtn ='"+srvc_ind+"'"; 	
				where1 = where1 + " and rtn ='"+srvc_ind+"'"; 	
			}
			
			////보험증권재발행
			where = where + " and code ='3'"; 	
			where1 = where1 + " and code ='3'"; 	

			
            input.put("page", page);
            input.put("where", where);            
            input.put("subwhere", where1);
            DataSet policyReissue_list = manager.findPolicyReissueList(input);

            inputCount.put("where", where1);
            DataSet totalCount = manager.findPolicyReissueCount(inputCount);

            request.setAttribute("policyReissue_list", policyReissue_list);
            request.setAttribute("totalCount", totalCount.getText("count"));
            request.setAttribute("current", current);
			////조회 - E
			/****************************************************************/
			
			
			
			
			/****************************************************************/
			////상태업데이트 - S
			if( searchgubun.equals("U") )
			{
				Vector v_chkcode = new Vector();		
		        int ct  = 0;
		        String policy ="";////증번
		        String indate ="";////접수일자
		        String subcode ="";////사용방법
		        String param_value ="";////증번+접수일자

		        
	        	StringTokenizer stk = new StringTokenizer(chk_code, "/");
	        	while (stk.hasMoreTokens()) {
	        		v_chkcode.addElement(stk.nextToken());				
	        		ct++;
	        	}
				anyframe.log.Logger.debug.println("보험증권재발행 - 체크값) :  ct -----------------: "+ct);					    			        	
	        	
	        	
	        	////web-DB로 저장
				for (int i=0; i<ct; i++)
				{
				    param_value = (String)v_chkcode.elementAt(i);
					anyframe.log.Logger.debug.println("보험증권재발행 - 변경시(for문) :  param_value-----------------: "+param_value);					    
					
					if(	param_value.length() >0 ) 
					{
						policy = param_value.substring(0,10);
						indate = param_value.substring(10,18);		
						subcode = param_value.substring(18);

						if( subcode.equals("자택") )
						{
							subcode = "H";
						}
						else
						{
							subcode = "O";
						}
						
						input2.put("rtn",     rtn);////상태값(0:즉시처리, 1:접수, 2:발송, 3:반송)
						input2.put("indate",  indate);////접수일자
				    	input2.put("policy",  policy);////증번
				    	input2.put("code",    "3");////보험증권재발행
				    	input2.put("prdate",  Util.getTodayToYMD().substring(0,8));////처리일자
				    	input2.put("prtime",  anyframe.util.DateTime.getFormatString("HHmmss"));////처리시간
				    	input2.put("subcode", subcode);////보험증권재발행
				    	input2.put("prname",  proc_emp_no );////처리자사번
						DataSet policyReissue_up = manager.findPolicyReissue_up(input2);
					}		    
				}////end-for
			}
			////상태업데이트 - E
			/****************************************************************/


			
			
			/****************************************************************/
			////일괄처리 - S
			String rslt = "-1";
			////int rslt_cnt = 0;////성공체크
			if( searchgubun.equals("C") )
			{
				rtn = "-4";////alert 설정
				
				////list가져오기
				DataSet change_list = manager.findChange_list(input);
	        	int cnt = change_list.getCount("indate");
				for (int i=0; i<cnt; i++)
				{
				    String indate = change_list.getText("indate",i);
				    String policy = change_list.getText("policy",i);
				    String subcode = change_list.getText("subcode",i);

					////1)HOST저장
					input1.put("deptcd",    "INT");
					input1.put("init",      "CYBER");
					input1.put("policy",    policy);	
					DataSet host_save = manager.findSave_host(input1);////ksps1300(증권번호별)
					rslt = host_save.getText("rtn");
					if( rslt.equals("0"))
					{
						rslt = "0";
					}
					else
					{
						rslt = "1";
					}
					
					
					////2)web-DB로 저장
					if(rslt.equals("0"))
					{
						
						////msbd에 저장
						////형식을 바꿔야 함..
						if( i == (cnt - 1)){
							try 
							{
								input4.put("job_name",     policy);
								DataSet msdb_save= manager.findSave_msdb(input4);
								anyframe.log.Logger.debug.println("보험증권재발행 - msbd에 저장 : "+cnt);					    
							}
							catch (Exception e) 
							{
								rtn = "-5";////alert 설정
							}
						}
						
						////2006.03.24 유섭교 cyberadmin 기능개선 PSR
						if(rtn.equals("-5")){
							continue;
						}else{
						////web-DB에 update
						input3.put("rtn",     "1");////상태값(0:접수, 1:즉시처리, 2:발송, 3:반송)
						input3.put("indate",  indate);////접수일자
				    	input3.put("policy",  policy);////증번
				    	input3.put("code",    "3");////보험증권재발행
				    	input3.put("subcode", subcode);////보험증권재발행
////				    	2006.06.07 유섭교 cyberindex 통계 증권재발행에서 처리일짜가 빠져 있어서
				    	////통계를 위해 새롭게 적용하기로 함.. 
				    	input3.put("prdate",  Util.getTodayToYMD().substring(0,8));////처리일자
				    	input3.put("prtime",  anyframe.util.DateTime.getFormatString("HHmmss"));////처리시간
				    	input3.put("prname",  proc_emp_no );////처리자사번
				    	
				    	anyframe.log.Logger.debug.println("보험증권재발행 - 변경시(action) :  input3-----------------: "+input3);					    
						DataSet policyReissue_up1 = manager.findPolicyReissue_up1(input3);
						}
					}
					////rslt_cnt++;
				}////end-for
			}
			////일괄처리 - E
			/****************************************************************/

			
            request.setAttribute("fromdate", 	fromdate);
            request.setAttribute("todate",		todate);
            request.setAttribute("fromdate2", 	fromdate2);
            request.setAttribute("todate2",		todate2);
            
            request.setAttribute("srvc_ind",	srvc_ind);
            request.setAttribute("search", 		search);
            request.setAttribute("key", 		key);
            request.setAttribute("searchgubun",	searchgubun);
            request.setAttribute("chk_code",	chk_code);
            request.setAttribute("auth_cd",	auth_cd);

            Logger.debug.println("################ PolicyReissueAction End ####################");
        	
        	
        	////업데이트시 메시지 처리 - S
    		if( searchgubun.equals("U") || searchgubun.equals("C") )
	    	{
				String msg = "";
	        	int success = Integer.parseInt(rtn);

	    		switch(success)
	    		{
	        		case(2) :
	            			msg =  "발송처리가 성공적으로 처리되었습니다.";
	            			break;
	        		case(3) :
	            			msg =  "반송처리가 성공적으로 처리되었습니다.";
	            			break;
	            	case(-4) :
	            			msg =  "일괄처리가 성공적으로 처리되었습니다.";
	            			break;
	            	case(-5) :
	            			msg =  "일부건만 성공하였습니다. 일괄처리를 재실행 하세요.";
	            			break;
	        		default :
	            			msg = "오류입니다. 확인하시고 다시 처리 하시기 바랍니다.";
	            			break;
	    		}				
	    		
        		String url = "/receipt/policy_reissue.do?searchgubun=S&current=1&chk_code=&fromdate=&todate=&fromdate2=&todate2=&srvc_ind=all&search=1&key=";
        		request.setAttribute("message", msg);	
	        	request.setAttribute("toURL", url);	
	        	return mapping.findForward("alert");
	    	}
	    	else
	    	{
				return mapping.findForward("policy_reissue");
			}
			////업데이트시 메시지 처리 - E
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
}
