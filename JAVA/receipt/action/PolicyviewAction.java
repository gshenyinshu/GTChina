
package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.logger.SystemOutLogger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;


import gtone.changeminer.common.utility.*;
import gtone.changeminer.payment.manager.PlpaymentinfoManager;
import gtone.changeminer.receipt.form.PolicyviewForm;
import gtone.changeminer.receipt.manager.PlrepaymentsearchManager;
import gtone.changeminer.receipt.manager.PolicyviewManager;

/**
 * @struts.action
 *      path="/policy_view" 
 *      name="policyviewForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="policy_view"
 *      path="/policy_view.jsp"
 *
 */
public  class PolicyviewAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
		throws Exception
	{
		int POLICY_LIST_PAGE_SIZE = 20;
        
		try
		{
			Logger.debug.println("################ PolicyviewAction Start ####################");

			DataSet input = new DataSet();
			DataSet inputCount = new DataSet();
            
			PolicyviewForm policyviewForm = (PolicyviewForm)form;

			FormToDataset.copyProperties(input, policyviewForm);
		
		 String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
		 Logger.debug.println(">>>>>>>>>>> searchgubun : " + searchgubun);   				

			String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
			String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
			String fromamt = request.getParameter("fromamt") == null ? "" : request.getParameter("fromamt");
			String toamt = request.getParameter("toamt") == null ? "" : request.getParameter("toamt");
			String mode = request.getParameter("mode") == null ? "" : request.getParameter("mode");
			String rslt = request.getParameter("rslt") == null ? "" : request.getParameter("rslt");
            
			String search = request.getParameter("search") == null ? "" : request.getParameter("search");
			String key = request.getParameter("key") == null ? "" : request.getParameter("key");
            
			String modeind = request.getParameter("modeind") == null ? "1" : request.getParameter("modeind");////�3�1�8�6/�2�1�8�8
			String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");
		
		if(searchgubun.equals("S"))
		{	

				String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
				String page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));
	            
				String where = "";
				String where1 = "";
	
			if(fromdate.length() > 0)
			{
				where = where + " and CONVERT(CHAR(8),apln_dt, 112) >='"+fromdate+"'"; 	
				where1 = where1 + " and CONVERT(CHAR(8),apln_dt, 112)  >='"+fromdate+"'";
			}
			
			if(todate.length() >0)
			{
				where = where + " and CONVERT(CHAR(8),apln_dt, 112)  <= '"+ todate+"'";
				where1 = where1 + " and CONVERT(CHAR(8),apln_dt, 112)  <= '"+ todate+"'";
			}

			if(fromamt.length() > 0)
			{
				where = where + " and apln_amt >"+fromamt; 	
				where1 = where1 + " and apln_amt >"+fromamt;
			}
			
			if(toamt.length() >0)
			{
				where = where + " and apln_amt  <= "+ toamt;
				where1 = where1 + " and apln_amt  <= "+ toamt;
			}

			anyframe.log.Logger.debug.println("Policyview�2�3�1�9 modeind-----------------: "+modeind);				
			anyframe.log.Logger.debug.println("Policyview�2�3�1�9 srvc_ind-----------------: "+srvc_ind);							


			if(modeind.length() > 0)
			{
				where 	= where + " and mode = "+ modeind;
				where1 	= where1 + " and mode = "+ modeind;
			}

			if(srvc_ind.length() > 0)
			{
				where = where + " and srvc_cd = " + srvc_ind;
				where1 = where1 + " and srvc_cd = " + srvc_ind;
			}
			
			if(rslt.length() > 0)
			{
				if(!rslt.equals("T"))
				{
					if(rslt.equals("B"))
					{
						where = where + " and rslt = ''";
						where1 = where1 + " and rslt = ''";
					}
					else
					{
						where = where + " and rslt = '"+ rslt+"'";						
						where1 = where1 + " and rslt = '"+ rslt+"'";
					}
				}
			}
			anyframe.log.Logger.debug.println("search�3�5 �7�3�3�1=============>"+search);
			/*			
			if(search.equals("1"))
			{
				if(key.length() > 0)
				{
					where = where + "  and policy_no like '%"+ key +"%'	";				
					where1 = where1 + "  and policy_no like '%"+ key +"%'	";				
				}	
			}
			else if(search.equals("3"))
			{
				if(key.length() > 0)
				{
					where = where + "  and P3.emp_nm like '%"+ key +"%'	";				
					where1 = where1 + "  and P3.emp_nm like '%"+ key +"%'	";				
				}	
			} 
			else if(search.equals("2"))
			{
				if(key.length() > 0)
				{
					String keyvalue = "";
					keyvalue = anyframe.util.StringFormater.replaceStr(key,"-","");
					keyvalue = anyframe.util.StringFormater.replaceStr(keyvalue,"/","");
					keyvalue = anyframe.util.StringFormater.replaceStr(keyvalue,".","");
					
					where = where + " and CONVERT(CHAR(8),P2.PROC_DT, 112) = '"+ keyvalue+"'";						
					where1 = where1 +  "and CONVERT(CHAR(8),P2.PROC_DT, 112) = '"+ keyvalue+"'";						
				}	
			}
			else if(search.equals("4"))////�3�5�0�7�0�7�6�3
			{
				if(key.length() > 0)
				{
					String keyvalue1 = "";
					keyvalue1 = anyframe.util.StringFormater.replaceStr(key,"-","");
					where = where + "  and payor_ssn like '%"+ keyvalue1 +"%'	";				
					where1 = where1 + "  and payor_ssn like '%"+ keyvalue1 +"%'	";				
					
					
				}
			}			
			*/
			
			////search(1:�3�6�7�1�0�7�6�3, 2:�7�1�2�0�3�1, 3;�3�5�0�7�0�7�6�3)
			if(search.equals("1"))
			{
				if(key.length() > 0)
				{
					where = where + "  and policy_no like '%"+ key +"%'	";				
					where1 = where1 + "  and policy_no like '%"+ key +"%'	";				
				}	

			}
			else if(search.equals("2"))
			{
				if(key.length() > 0)
				{
					where = where + "  and acct_nm like '%"+ key +"%'	";				
					where1 = where1 + "  and acct_nm like '%"+ key +"%'	";				
				}
			}
			else if(search.equals("3"))
			{
				if(key.length() > 0)
				{
					String keyvalue1 = "";
					keyvalue1 = anyframe.util.StringFormater.replaceStr(key,"-","");
					where = where + "  and payor_ssn like '%"+ keyvalue1 +"%'	";				
					where1 = where1 + "  and payor_ssn like '%"+ keyvalue1 +"%'	";				
				}
			}
	
				input.put("page", page);
				input.put("where", where);            
				input.put("subwhere", where1);
	            
			 anyframe.log.Logger.debug.println("SQL�2�3�1�9 WHERE�3�5 INPUT�7�3-----------------: "+where);	
			 anyframe.log.Logger.debug.println("SQL�2�3�1�9 WHERE[1]�3�5 INPUT�7�3-----------------: "+where1);	
	
				inputCount.put("where", where1);
	
				PolicyviewManager manager = PolicyviewManager.getInstance();
	
				DataSet policyview = manager.findPolicyviewList(input);
				DataSet totalCount = manager.findPolicyview(inputCount);
	
				request.setAttribute("policyview", policyview);
				request.setAttribute("totalCount", totalCount.getText("count"));
				request.setAttribute("count1", totalCount.getText("count1"));
				request.setAttribute("count2", totalCount.getText("count2"));
				request.setAttribute("count3", totalCount.getText("count3"));
				request.setAttribute("count4", totalCount.getText("count4"));
				request.setAttribute("td1", totalCount.getText("td1"));
				request.setAttribute("td2", totalCount.getText("td2"));
				request.setAttribute("td3", totalCount.getText("td3"));
				request.setAttribute("td4", totalCount.getText("td4"));
				request.setAttribute("current", current);
	          
			System.out.println(totalCount.toString());  
			System.out.println(totalCount.getText("td1"));

			if("1".equals(srvc_ind) || "".equals(srvc_ind)) {
				////PlpaymentinfoManager manager9 = PlpaymentinfoManager.getInstance();
				PlrepaymentsearchManager manager9 = PlrepaymentsearchManager.getInstance();
				for(int i=0;i<policyview.getCount("policy_no");i++) {
					DataSet sInputSet = new DataSet();

					////�7�1�2�0�3�1�3�5 �7�5�3�9�2�7�8�5 �3�1�6�3 sp			
					sInputSet.put("deptcd", "INT");////�2�7�2�1�5�9�3�3�0�5
					sInputSet.put("init", "     ");////�1�5�1�9
					sInputSet.put("plyno", policyview.getText("policy_no", i));////�3�6�7�1�0�7�6�3
					DataSet issdatesearch 	= manager9.findIssdate(sInputSet);
					policyview.put("plncode", issdatesearch.getText("plncode"), i);

					System.out.println("#################################################");
					System.out.println(sInputSet);
					System.out.println(policyview.getText("plancd", i));
					System.out.println("#################################################");
				}

			

			}
		
		}
		
			request.setAttribute("fromdate", fromdate);
			request.setAttribute("todate",todate);
			request.setAttribute("modeind",modeind);
			request.setAttribute("srvc_ind",srvc_ind);
			request.setAttribute("rslt", rslt);	            
			request.setAttribute("search", search);
			request.setAttribute("key", key);
			request.setAttribute("searchgubun",searchgubun);
			request.setAttribute("fromamt", fromamt);
			request.setAttribute("toamt",toamt);
            
			Logger.debug.println("################ PolicyviewAction End ####################");
			return mapping.findForward("policy_view");
		}
		catch(Exception e)
		{
			throw e;
		}
	}
}