package gtone.changeminer.monitor.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.utility.*;
import gtone.changeminer.monitor.form.MoniteringprPrintForm;
import gtone.changeminer.monitor.manager.MoniteringprSearchManager;

////�1�7�1�9
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

/**
 * @struts.action
 *      path="/monitering_proof_print" 
 *      name="MoniteringprPrintForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="monitering_proof_print"
 *      path="/monitering_proof_print.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class MoniteringprPrintAction extends Action
{
  public ActionForward execute(ActionMapping mapping, 
								  ActionForm form, 
								  HttpServletRequest request, 
								  HttpServletResponse response)
    throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ MoniteringprPrintAction Start ####################");

            DataSet input = new DataSet();
            DataSet inputCount = new DataSet();
            ////DataSet input1 = new DataSet();
            
            
            MoniteringprPrintForm moniteringprForm = (MoniteringprPrintForm)form;
            FormToDataset.copyProperties(input, moniteringprForm);
		
			////�1�7�1�9�1�7�3�0�6�9�8�5
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		
			MoniteringprSearchManager manager = MoniteringprSearchManager.getInstance();
			
			
	     	String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");   
            String useind = request.getParameter("useind") == null ? "" : request.getParameter("useind");////�3�0�9�3
            String modeind = request.getParameter("modeind") == null ? "" : request.getParameter("modeind");////�7�0�0�1/�2�2�0�1
            String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");////�2�2�0�7�1�9�0�1-�3�6�0�2�1�9�3�6�0�1            
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");
			
			
			////�3�5�6�7�2�7
			if(searchgubun.equals("S"))
			{	
	            String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
	            String page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));
	            String where = "";
	            String where1 = "";
	            
	            where = where + "and search_code = 'P'";
	            where1 = where1 + "and search_code = 'P'";
	            
				if(fromdate.length() > 0)
				{
					where = where + " and search_date >='"+fromdate+"'"; 	
					where1 = where1 + " and search_date >='"+fromdate+"'"; 	
				}
				
				if(todate.length() >0)
				{
					where = where + " and search_date  <= '"+ todate+"'";
					where1 = where1 + " and search_date  <= '"+ todate+"'";
				}

				if(srvc_ind.length() >0)
				{
					where = where + " and proof_code  = '"+ srvc_ind+"'";
					where1 = where1 + " and proof_code  = '"+ srvc_ind+"'";
				}

				if(modeind.length() >0)
				{
					where = where + " and koreng  = '"+ modeind+"'";
					where1 = where1 + " and koreng  = '"+ modeind+"'";
				}

				if(useind.length() >0)
				{
					where = where + " and proof_usage  = '"+ useind+"'";
					where1 = where1 + " and proof_usage  = '"+ useind+"'";
				}
		
				if(search.equals("1"))////�3�5�0�7�0�7�6�3
				{
					if(key.length() > 0)
					{
						where = where + "  and ssn like '%"+ key +"%'	";				
						where1 = where1 + "  and ssn like '%"+ key +"%'	";
					}					
				}
				else if(search.equals("2"))////�7�1�2�0�3�1
				{
					if(key.length() > 0)
					{
						where = where + "  and name like '%"+ key +"%'	";				
						where1 = where1 + "  and name like '%"+ key +"%'	";
					}					
				}
				else if(search.equals("3"))////�3�5�6�7�8�3�9�3
				{
					if(key.length() > 0)
					{
						where = where + "  and search_date like '%"+ key +"%'	";				
						where1 = where1 + "  and search_date like '%"+ key +"%'	";
					}					
				}
	
	            input.put("page", page);
	            input.put("where", where);            
	            input.put("subwhere", where1);
		            
				anyframe.log.Logger.debug.println("SQL�2�3�1�9 WHERE�3�5 INPUT�7�3-----------------: "+where);	
				anyframe.log.Logger.debug.println("SQL�2�3�1�9 WHERE[1]�3�5 INPUT�7�3-----------------: "+where1);	
		
	            inputCount.put("where", where1);
	

	            DataSet monitor = manager.findMonitorSearchList(input);
	            DataSet totalCount = manager.findMonitorSearch(inputCount);
	
	            request.setAttribute("monitor", 	monitor);
	            request.setAttribute("totalCount", 	totalCount.getText("count"));
	            request.setAttribute("current", 	current);
			}
		
			Logger.debug.println("MoniteringprPrintAction ---- searchgubun : "+searchgubun);
		
	
            request.setAttribute("fromdate", 	fromdate);
            request.setAttribute("todate",		todate);
            
            request.setAttribute("modeind",		modeind);
            request.setAttribute("useind",		useind);
            request.setAttribute("srvc_ind",	srvc_ind);
            request.setAttribute("search", 		search);
            request.setAttribute("key", 		key);
            request.setAttribute("searchgubun",	searchgubun);
			request.setAttribute("auth_cd",		auth_cd);
			
            Logger.debug.println("################ MoniteringprPrintAction End ####################");
            
            return mapping.findForward("monitering_proof_print");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}