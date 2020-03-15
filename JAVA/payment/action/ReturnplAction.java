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
import gtone.changeminer.payment.form.ReturnplForm;
import gtone.changeminer.payment.manager.ReturnplManager;

/**
 * @struts.action
 *      path="/policy_return" 
 *      name="ReturnplForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="policy_return"
 *      path="/policy_return.jsp"
 *
 */
public  class ReturnplAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ PolicyreturnAction Start ####################");

            DataSet input = new DataSet();
            DataSet inputCount = new DataSet();
            
            ReturnplForm returnplForm = (ReturnplForm)form;

            FormToDataset.copyProperties(input, returnplForm);
		
	     String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
	     Logger.debug.println(">>>>>>>>>>> searchgubun : " + searchgubun);   				

            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
            String fromdate2 = request.getParameter("fromdate2") == null ? "" : request.getParameter("fromdate2");
            String todate2 = request.getParameter("todate2") == null ? "" : request.getParameter("todate2");            
            String modeind = request.getParameter("modeind") == null ? "1" : request.getParameter("modeind");////1:일반 ,2:증명서, 3:부활문의
            String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");////업무분류            
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");
		
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

			if(fromdate2.length() > 0)
			{
				where = where + " and CONVERT(CHAR(8),prdate, 112)  >='"+fromdate2+"'"; 	
				where1 = where1 + "and CONVERT(CHAR(8),prdate, 112) >='"+fromdate2+"'"; 	
			}
			
			if(todate2.length() >0)
			{
				where = where + " and CONVERT(CHAR(8),prdate, 112)  <= '"+ todate+"'";
				where1 = where1 + " and CONVERT(CHAR(8),prdate, 112)  <= '"+ todate+"'";
			}

			anyframe.log.Logger.debug.println("Policyreturn에서 srvc_ind-----------------: "+srvc_ind);							
			
			if(!srvc_ind.equals("0"))
			{
				if(!srvc_ind.equals("Z"))
				{
					where = where + " and srvc_cd ='"+srvc_ind+"'"; 	
					where1 = where1 + " and srvc_cd ='"+srvc_ind+"'"; 	
				}	
			}
			
			
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
					where1 = where1 + "  and acct_nm like '%"+ key +"%'	";								}					
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
	            
		     anyframe.log.Logger.debug.println("SQL에서 WHERE의 INPUT값-----------------: "+where);	
		     anyframe.log.Logger.debug.println("SQL에서 WHERE[1]의 INPUT값-----------------: "+where1);	
	
	            inputCount.put("where", where1);
	
	            ReturnplManager manager = ReturnplManager.getInstance();
	
	            DataSet policyreturn = manager.findPolicyreturnList(input);
	            DataSet totalCount = manager.findPolicyreturn(inputCount);
	
	            request.setAttribute("policyreturn", policyreturn);
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
		
            Logger.debug.println("################ ReturnplAction End ####################");
            return mapping.findForward("policy_return");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}