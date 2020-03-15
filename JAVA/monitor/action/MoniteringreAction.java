	
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
import gtone.changeminer.monitor.form.MoniteringreForm;
import gtone.changeminer.monitor.manager.MoniteringreManager;

/**
 * @struts.action
 *      path="/monitering_resurr" 
 *      name="moniteringreForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="monitering_resurr"
 *      path="/monitering_resurr.jsp"
 *
 */
public  class MoniteringreAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ MoniteringreAction Start ####################");

            DataSet input = new DataSet();
            DataSet inputCount = new DataSet();
            
            MoniteringreForm moniteringreForm = (MoniteringreForm)form;

            FormToDataset.copyProperties(input, moniteringreForm);
		
	     String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
	     Logger.debug.println(">>>>>>>>>>> searchgubun : " + searchgubun);   				

            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
            String fromdate2 = request.getParameter("fromdate2") == null ? "" : request.getParameter("fromdate2");
            String todate2 = request.getParameter("todate2") == null ? "" : request.getParameter("todate2");            
            String modeind = request.getParameter("modeind") == null ? "1" : request.getParameter("modeind");////1:부활문의
            String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");////업무분류            
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");
		
		if(searchgubun.equals("S"))
		{	

	            String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
	            String page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));
	
	            Logger.debug.println(">>>>>>>>>>> current : " + current);            
	            Logger.debug.println(">>>>>>>>>>> fromdate : " + fromdate);            
	            Logger.debug.println(">>>>>>>>>>> todate : " + todate);     
	            Logger.debug.println(">>>>>>>>>>> fromdate2 : " + fromdate2);            
	            Logger.debug.println(">>>>>>>>>>> todate2 : " + todate2);     	            
	            Logger.debug.println(">>>>>>>>>>> modeind : " + modeind);     
	            Logger.debug.println(">>>>>>>>>>> srvc_ind : " + srvc_ind);     	            
	            Logger.debug.println(">>>>>>>>>>> search : " + search);
	            Logger.debug.println(">>>>>>>>>>> key : " + key);
	            
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
				where = where + " and lapsedate >='"+fromdate2+"'"; 	
				where1 = where1 + " and lapsedate>='"+fromdate2+"'"; 	
			}
			
			if(todate2.length() >0)
			{
				where = where + " and lapsedate  <= '"+ todate2+"'";
				where1 = where1 + " and lapsedate  <= '"+ todate2+"'";
			}

			anyframe.log.Logger.debug.println("monitering_resurrl에서 modeind-----------------: "+modeind);				
			anyframe.log.Logger.debug.println("monitering_resurr에서 srvc_ind-----------------: "+srvc_ind);							
			
			
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
	            
		     anyframe.log.Logger.debug.println("SQL에서 WHERE의 INPUT값-----------------: "+where);	
		     anyframe.log.Logger.debug.println("SQL에서 WHERE[1]의 INPUT값-----------------: "+where1);	
	
	            inputCount.put("where", where1);
	
	            MoniteringreManager manager = MoniteringreManager.getInstance();
	
	            DataSet monitor = manager.findMonitorList(input);
	            DataSet totalCount = manager.findMonitor(inputCount);
	
	            request.setAttribute("monitor", monitor);
	            request.setAttribute("totalCount", totalCount.getText("count"));
	            request.setAttribute("current", current);
		
		}
		
            request.setAttribute("fromdate", fromdate);
            request.setAttribute("todate",todate);
            request.setAttribute("fromdate2", fromdate2);
            request.setAttribute("todate2",todate2);
            
            request.setAttribute("modeind",modeind);
            request.setAttribute("srvc_ind",srvc_ind);
            request.setAttribute("search", search);
            request.setAttribute("key", key);
            request.setAttribute("searchgubun",searchgubun);
		
            Logger.debug.println("################ PolicyrealAction End ####################");
            return mapping.findForward("monitering_resurr");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}
