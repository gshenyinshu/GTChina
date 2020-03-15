package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;
import java.util.*;////Vector�2�3 �1�7�3�0

import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.PolicyReissueForm;
import gtone.changeminer.receipt.manager.PolicyReissueManager;

////�1�7�1�9
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
            DataSet input1 = new DataSet();////�3�1�7�5�4�9�0�5
			DataSet input2 = new DataSet();////�0�9�2�2,�0�5�2�2-update�6�9�8�5�3�1�6�7
			DataSet input3 = new DataSet();////�3�6�2�7�4�9�0�5-�3�0�2�1�0�9 update�6�9�8�5�3�1�6�7
			DataSet input4 = new DataSet();////msbd�3�3�3�2
            DataSet inputCount = new DataSet();
            
            PolicyReissueForm policyreissueForm = (PolicyReissueForm)form;
            FormToDataset.copyProperties(input, policyreissueForm);
			
	     	PolicyReissueManager manager = PolicyReissueManager.getInstance();
			
			////�1�7�1�9�1�7�3�0�6�9�8�5
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

			String proc_emp_no = emp_no;////�4�9�0�5�3�1�1�7�0�7			
			
	     	String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
            String fromdate2 = request.getParameter("fromdate2") == null ? "" : request.getParameter("fromdate2");
            String todate2 = request.getParameter("todate2") == null ? "" : request.getParameter("todate2");            
            String srvc_ind = request.getParameter("srvc_ind") == null ? "all" : request.getParameter("srvc_ind");////�2�2�0�7�1�9�0�1            
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");
            String chk_code  = request.getParameter("chk_code") == null ? "" : request.getParameter("chk_code");
            String rtn  = request.getParameter("rtn") == null ? "0" : request.getParameter("rtn");
			
			
			
			/****************************************************************/
			////�3�5�6�7 - S
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

			
			////�3�6�7�1�0�7�6�3 �0�6 �7�3�1�6�7�3
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
			
			
			////�1�8�5�1				
			if( !srvc_ind.equals("all") )
			{
				where = where + " and rtn ='"+srvc_ind+"'"; 	
				where1 = where1 + " and rtn ='"+srvc_ind+"'"; 	
			}
			
			////�1�5�6�7�3�6�7�1�3�9�0�9�6�8
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
			////�3�5�6�7 - E
			/****************************************************************/
			
			
			
			
			/****************************************************************/
			////�1�8�5�1�2�2�9�9�3�3�5�7 - S
			if( searchgubun.equals("U") )
			{
				Vector v_chkcode = new Vector();		
		        int ct  = 0;
		        String policy ="";////�3�6�0�7
		        String indate ="";////�3�0�2�1�3�1�3�1
		        String subcode ="";////�1�7�3�0�0�2�0�0
		        String param_value ="";////�3�6�0�7+�3�0�2�1�3�1�3�1

		        
	        	StringTokenizer stk = new StringTokenizer(chk_code, "/");
	        	while (stk.hasMoreTokens()) {
	        		v_chkcode.addElement(stk.nextToken());				
	        		ct++;
	        	}
				anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �4�7�5�9�7�3) :  ct -----------------: "+ct);					    			        	
	        	
	        	
	        	////web-DB�0�9 �3�3�3�2
				for (int i=0; i<ct; i++)
				{
				    param_value = (String)v_chkcode.elementAt(i);
					anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �1�3�7�4�2�7(for�0�1) :  param_value-----------------: "+param_value);					    
					
					if(	param_value.length() >0 ) 
					{
						policy = param_value.substring(0,10);
						indate = param_value.substring(10,18);		
						subcode = param_value.substring(18);

						if( subcode.equals("�3�1�5�2") )
						{
							subcode = "H";
						}
						else
						{
							subcode = "O";
						}
						
						input2.put("rtn",     rtn);////�1�8�5�1�7�3(0:�3�6�2�7�4�9�0�5, 1:�3�0�2�1, 2:�0�9�2�2, 3:�0�5�2�2)
						input2.put("indate",  indate);////�3�0�2�1�3�1�3�1
				    	input2.put("policy",  policy);////�3�6�0�7
				    	input2.put("code",    "3");////�1�5�6�7�3�6�7�1�3�9�0�9�6�8
				    	input2.put("prdate",  Util.getTodayToYMD().substring(0,8));////�4�9�0�5�3�1�3�1
				    	input2.put("prtime",  anyframe.util.DateTime.getFormatString("HHmmss"));////�4�9�0�5�2�7�7�9
				    	input2.put("subcode", subcode);////�1�5�6�7�3�6�7�1�3�9�0�9�6�8
				    	input2.put("prname",  proc_emp_no );////�4�9�0�5�3�1�1�7�0�7
						DataSet policyReissue_up = manager.findPolicyReissue_up(input2);
					}		    
				}////end-for
			}
			////�1�8�5�1�2�2�9�9�3�3�5�7 - E
			/****************************************************************/


			
			
			/****************************************************************/
			////�3�1�7�5�4�9�0�5 - S
			String rslt = "-1";
			////int rslt_cnt = 0;////�1�0�7�0�4�7�5�9
			if( searchgubun.equals("C") )
			{
				rtn = "-4";////alert �1�7�3�4
				
				////list�7�5�3�9�2�7�8�5
				DataSet change_list = manager.findChange_list(input);
	        	int cnt = change_list.getCount("indate");
				for (int i=0; i<cnt; i++)
				{
				    String indate = change_list.getText("indate",i);
				    String policy = change_list.getText("policy",i);
				    String subcode = change_list.getText("subcode",i);

					////1)HOST�3�3�3�2
					input1.put("deptcd",    "INT");
					input1.put("init",      "CYBER");
					input1.put("policy",    policy);	
					DataSet host_save = manager.findSave_host(input1);////ksps1300(�3�6�7�1�0�7�6�3�1�7)
					rslt = host_save.getText("rtn");
					if( rslt.equals("0"))
					{
						rslt = "0";
					}
					else
					{
						rslt = "1";
					}
					
					
					////2)web-DB�0�9 �3�3�3�2
					if(rslt.equals("0"))
					{
						
						////msbd�2�3 �3�3�3�2
						////�6�8�2�8�3�5 �0�1�8�5�2�9 �6�5..
						if( i == (cnt - 1)){
							try 
							{
								input4.put("job_name",     policy);
								DataSet msdb_save= manager.findSave_msdb(input4);
								anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - msbd�2�3 �3�3�3�2 : "+cnt);					    
							}
							catch (Exception e) 
							{
								rtn = "-5";////alert �1�7�3�4
							}
						}
						
						////2006.03.24 �3�9�1�6�7�1 cyberadmin �8�5�8�6�7�3�1�3 PSR
						if(rtn.equals("-5")){
							continue;
						}else{
						////web-DB�2�3 update
						input3.put("rtn",     "1");////�1�8�5�1�7�3(0:�3�0�2�1, 1:�3�6�2�7�4�9�0�5, 2:�0�9�2�2, 3:�0�5�2�2)
						input3.put("indate",  indate);////�3�0�2�1�3�1�3�1
				    	input3.put("policy",  policy);////�3�6�0�7
				    	input3.put("code",    "3");////�1�5�6�7�3�6�7�1�3�9�0�9�6�8
				    	input3.put("subcode", subcode);////�1�5�6�7�3�6�7�1�3�9�0�9�6�8
////				    	2006.06.07 �3�9�1�6�7�1 cyberindex �5�8�7�1 �3�6�7�1�3�9�0�9�6�8�2�3�1�9 �4�9�0�5�3�1�3�9�7�5 �1�9�3�9 �3�3�2�5�1�9
				    	////�5�8�7�1�0�7 �3�1�6�7 �1�5�0�6�7�5 �3�4�3�0�6�9�8�5�0�9 �6�5.. 
				    	input3.put("prdate",  Util.getTodayToYMD().substring(0,8));////�4�9�0�5�3�1�3�1
				    	input3.put("prtime",  anyframe.util.DateTime.getFormatString("HHmmss"));////�4�9�0�5�2�7�7�9
				    	input3.put("prname",  proc_emp_no );////�4�9�0�5�3�1�1�7�0�7
				    	
				    	anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �1�3�7�4�2�7(action) :  input3-----------------: "+input3);					    
						DataSet policyReissue_up1 = manager.findPolicyReissue_up1(input3);
						}
					}
					////rslt_cnt++;
				}////end-for
			}
			////�3�1�7�5�4�9�0�5 - E
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
        	
        	
        	////�2�2�9�9�3�3�5�7�2�7 �0�3�2�7�3�1 �4�9�0�5 - S
    		if( searchgubun.equals("U") || searchgubun.equals("C") )
	    	{
				String msg = "";
	        	int success = Integer.parseInt(rtn);

	    		switch(success)
	    		{
	        		case(2) :
	            			msg =  "�0�9�2�2�4�9�0�5�7�5 �1�0�7�0�3�4�3�7�0�9 �4�9�0�5�9�7�2�5�2�8�9�1�9�9.";
	            			break;
	        		case(3) :
	            			msg =  "�0�5�2�2�4�9�0�5�7�5 �1�0�7�0�3�4�3�7�0�9 �4�9�0�5�9�7�2�5�2�8�9�1�9�9.";
	            			break;
	            	case(-4) :
	            			msg =  "�3�1�7�5�4�9�0�5�7�5 �1�0�7�0�3�4�3�7�0�9 �4�9�0�5�9�7�2�5�2�8�9�1�9�9.";
	            			break;
	            	case(-5) :
	            			msg =  "�3�1�1�5�7�1�0�7 �1�0�7�0�6�9�2�1�2�8�9�1�9�9. �3�1�7�5�4�9�0�5�0�7 �3�9�2�5�6�8 �6�9�1�7�3�9.";
	            			break;
	        		default :
	            			msg = "�2�7�0�1�3�0�9�1�9�9. �6�2�3�7�6�9�2�7�7�9 �9�9�2�7 �4�9�0�5 �6�9�2�7�8�5 �0�1�9�2�9�1�9�9.";
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
			////�2�2�9�9�3�3�5�7�2�7 �0�3�2�7�3�1 �4�9�0�5 - E
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
}
