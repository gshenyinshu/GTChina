
package gtone.changeminer.withdrawal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;


import gtone.changeminer.common.utility.*;
import gtone.changeminer.withdrawal.form.WithdrawalForm;
import gtone.changeminer.withdrawal.manager.WithdrawalManager;

/**
 * @struts.action
 *      path="/policy_view" 
 *      name="WithdrawalForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="policy_view"
 *      path="/policy_view.jsp"
 *
 */
public class WithdrawalAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
		throws Exception
	{
		int POLICY_LIST_PAGE_SIZE = 20;
        
		try
		{
			Logger.debug.println("################ WithdrawalAction Start ####################");

			DataSet input = new DataSet();
			DataSet inputCount = new DataSet();
            
			WithdrawalForm WithdrawalForm = (WithdrawalForm)form;

			FormToDataset.copyProperties(input, WithdrawalForm);

			String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
			String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
			String statuscd = request.getParameter("statuscd") == null ? "" : request.getParameter("statuscd");
			String searchtype = request.getParameter("searchtype") == null ? "" : request.getParameter("searchtype");
			String key = request.getParameter("key") == null ? "" : request.getParameter("key");

			String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
			String page = String.valueOf(20 * (Integer.parseInt(current) - 1));
            
			String where = "";
			String where1 = "";

			if(fromdate.length() > 0)
			{
				where = where + " and CONVERT(CHAR(8),apl_date, 112) >='"+fromdate+"'"; 	
				where1 = where1 + " and CONVERT(CHAR(8),apl_date, 112)  >='"+fromdate+"'";
			}
			
			if(todate.length() >0)
			{
				where = where + " and CONVERT(CHAR(8),apl_date, 112)  <= '"+ todate+"'";
				where1 = where1 + " and CONVERT(CHAR(8),apl_date, 112)  <= '"+ todate+"'";
			}

			if(statuscd.length() >0
			&& !statuscd.equals("A"))
			{
				where = where + " and status_cd = '"+ statuscd+"'";
				where1 = where1 + " and status_cd = '"+ statuscd+"'";
			}
			
			if (searchtype.equals("1"))	//증권번호
			{
				where = where + " and policy_no like '%" +  key + "%'";
				where1 = where1 + " and policy_no like '%" +  key + "%'";
			}
			else if (searchtype.equals("2"))	//계약자
			{
				where = where + " and client_name like '%" +  key + "%'";
				where1 = where1 + " and client_name like '%" +  key + "%'";
			}
			else if (searchtype.equals("3"))	//주민번호
			{
				where = where + " and client_ssn like '%" +  key + "%'";
				where1 = where1 + " and client_ssn like '%" +  key + "%'";
			}
			
			Logger.debug.println("status_code --->" + statuscd);
			Logger.debug.println("where --->" + where);

			input.put("page", page);
			input.put("where", where);            
//			input.put("subwhere", where1);

//			inputCount.put("where", where1);

			WithdrawalManager manager = WithdrawalManager.getInstance();


			DataSet withdrawal = manager.findList(input);
			DataSet totalCount = manager.findListCount(input);
//			DataSet policyview = manager.findPolicyviewList(input);
//			DataSet totalCount = manager.findPolicyview(inputCount);
//			DataSet sumCount = manager.findSumcount(inputCount);
			
			request.setAttribute("withdrawal", withdrawal);
			request.setAttribute("totalCount", totalCount.getText("count"));
			request.setAttribute("current", current);
		
			request.setAttribute("fromdate", fromdate);
			request.setAttribute("todate",todate);
			request.setAttribute("statuscd",statuscd);
			request.setAttribute("searchtype",searchtype);
			request.setAttribute("key", key);
			request.setAttribute("form"     , WithdrawalForm                      ) ;
			Logger.debug.println("################ WithdrawalAction End ####################");
			return mapping.findForward("withdrawal");
		}
		catch(Exception e)
		{
			throw e;
		}
	}
}
