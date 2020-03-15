
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
import gtone.changeminer.receipt.form.PolicyrealForm;
import gtone.changeminer.receipt.manager.PolicyrealManager;

/**
 * @struts.action
 *      path="/policy_realtime" 
 *      name="policyrealForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="policy_realtime"
 *      path="/policy_realtime.jsp"
 *
 */
public  class PolicyrealAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ PolicyrealAction Start ####################");

            DataSet input = new DataSet();
            DataSet inputCount = new DataSet();
            
            PolicyrealForm policyrealForm = (PolicyrealForm)form;

            FormToDataset.copyProperties(input, policyrealForm);
		
	     String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
	     Logger.debug.println(">>>>>>>>>>> searchgubun : " + searchgubun);   				

            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
            String fromdate2 = request.getParameter("fromdate2") == null ? "" : request.getParameter("fromdate2");
            String todate2 = request.getParameter("todate2") == null ? "" : request.getParameter("todate2");            
            String modeind = request.getParameter("modeind") == null ? "1" : request.getParameter("modeind");////1:�3�1�0�5 ,2:�3�6�0�2�1�9, 3:�1�5�6�9�0�1�3�5
            String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");////�2�2�0�7�1�9�0�1            
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");
	     String rslt = request.getParameter("rslt") == null ? "" : request.getParameter("rslt");			
		if(searchgubun.equals("S"))
		{	

	            String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
	            String page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));
	            
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
				where1 = where1 + " and prdate >='"+fromdate2+"'"; 	
			}
			
			if(todate2.length() >0)
			{
				where = where + " and prdate  <= '"+ todate2+"'";
				where1 = where1 + " and prdate  <= '"+ todate2+"'";
			}

			anyframe.log.Logger.debug.println("Policyreal�2�3�1�9 modeind-----------------: "+modeind);				
			anyframe.log.Logger.debug.println("Policyreal�2�3�1�9 srvc_ind-----------------: "+srvc_ind);							
			anyframe.log.Logger.debug.println("Policyreal�2�3�1�9 rslt-----------------: "+rslt);
			
			if(!rslt.equals("A"))
			{
				where = where + " and status  = '"+rslt+"'"; 	
				where1 = where1 + " and status ='"+rslt+"'"; 	
			}	
				
			if(srvc_ind.length() > 0)
			{
				if(!srvc_ind.equals("Z"))
				{
					where = where + " and srvc_cd ='"+srvc_ind+"'"; 	
					where1 = where1 + " and srvc_cd ='"+srvc_ind+"'"; 	
				}else{ ////�3�7�4�7 �7�3�1�6 �6�0�0�8�2�3�1�9 �8�9�0�6�1�9�0�6�2�1�4�0
							////�2�0�9�7�3�1�9�4�1�8�6�5
							////APL�3�1�9�4�1�8�6�5�7�1�0�7 �6�0�0�8 �1�8�3�1...
									
					where = where +  " and srvc_cd in('A','B','C','G','I','J','K','L','M','N')"; 	
					where1 = where1 + " and srvc_cd in('A','B','C','G','I','J','K','L','M','N')"; 	
									
										
				}
			}
	
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
					where = where + "  and owner like '%"+ key +"%'	";				
					where1 = where1 + "  and owner like '%"+ key +"%'	";
				}					
			}
			else if(search.equals("3"))
			{
				if(key.length() > 0)
				{
					String keyvalue1 = "";
					keyvalue1 = anyframe.util.StringFormater.replaceStr(key,"-","");
					where = where + "  and ssn like '%"+ keyvalue1 +"%'	";				
					where1 = where1 + "  and ssn like '%"+ keyvalue1 +"%'	";			
				}
			}
	
	            input.put("page", page);
	            input.put("where", where);            
	            input.put("subwhere", where1);
	            
		     anyframe.log.Logger.debug.println("SQL�2�3�1�9 WHERE�3�5 INPUT�7�3-----------------: "+where);	
		     anyframe.log.Logger.debug.println("SQL�2�3�1�9 WHERE[1]�3�5 INPUT�7�3-----------------: "+where1);	
	
	            inputCount.put("where", where1);
	
	            PolicyrealManager manager = PolicyrealManager.getInstance();
	
	            DataSet policyreal = manager.findPolicyrealList(input);
	            DataSet totalCount = manager.findPolicyreal(inputCount);
	
	            request.setAttribute("policyreal", policyreal);
	            request.setAttribute("totalCount", totalCount.getText("count"));
	            request.setAttribute("current", current);
		
		}
		
            request.setAttribute("fromdate", fromdate);
            request.setAttribute("todate",todate);
            request.setAttribute("fromdate2", fromdate2);
            request.setAttribute("todate2",todate2);
            
            request.setAttribute("modeind",modeind);
            request.setAttribute("srvc_ind",srvc_ind);
            request.setAttribute("rslt",rslt);
            request.setAttribute("search", search);
            request.setAttribute("key", key);
            request.setAttribute("searchgubun",searchgubun);
		
            Logger.debug.println("################ PolicyrealAction End ####################");
            return mapping.findForward("policy_realtime");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}