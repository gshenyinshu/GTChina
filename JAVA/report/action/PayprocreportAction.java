
package gtone.changeminer.report.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;


import gtone.changeminer.common.utility.*;
import gtone.changeminer.report.form.PayprocreportForm;
import gtone.changeminer.report.manager.PayprocreportManager;

/**
 * @struts.action
 *      path="/pay_proc_report" 
 *      name="payprocreportForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="pay_proc_report"
 *      path="/pay_proc_report.jsp"
 *
 */
public  class PayprocreportAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        ////int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ PayprocreportAction Start ####################");

            DataSet input = new DataSet();
            DataSet inputCount = new DataSet();
            DataSet input1 = new DataSet();
            
            PayprocreportManager manager = PayprocreportManager.getInstance();
            PayprocreportForm payprocreportForm = (PayprocreportForm)form;
            FormToDataset.copyProperties(input, payprocreportForm);
		
	     String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");////조회클릭시		
	     Logger.debug.println(">>>>>>>>>>> searchgubun : " + searchgubun);   				

            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");////처리일자(시작)
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");////처리일자(끝)
            
            String srvc_cd = request.getParameter("srvc_cd") == null ? "" : request.getParameter("srvc_cd");////지급종류
            String rslt = request.getParameter("rslt") == null ? "" : request.getParameter("rslt");////상태
            
            String bankcd = request.getParameter("bankcd") == null ? "" : request.getParameter("bankcd");////은행종류
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");////증권번호
            String mode  = "1";////지급
            String bank_code = "";
            
            String top = request.getParameter("top") == null ? "10" : request.getParameter("top");////count갯수
            int POLICY_LIST_PAGE_SIZE = Integer.parseInt(top);
            
	     ////은행명과 은행코드를 가져오기 위한 루틴	
	     input1.put("bank_code", bank_code);
	     DataSet selBank = manager.findSelBank(input1);
	     request.setAttribute("selBank", selBank);
	
	     if(searchgubun.equals("S"))
		{	   

	            String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
	            String page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));
	            
	            anyframe.log.Logger.debug.println("이 값들은 어떤값인가.  top값-----------------: "+POLICY_LIST_PAGE_SIZE);	
	            anyframe.log.Logger.debug.println("이 값들은 어떤값인가.  current-----------------: "+current);	
	            anyframe.log.Logger.debug.println("이 값들은 어떤값인가.  page-----------------: "+page);	
	            
	            String where = "";   ////CYBER_tbl_WB_PROCESS 처리날짜 조회시
		    	
				String subwhere = " and P1.mode='"+mode+"'"; ////CYBER_TBL_WB_PAYMENT  조건 조회시
		    	
		    ////where = where + " and mode='"+mode+"'"; 	
		    
		     
		    
		     if(fromdate.length() > 0)
			{
				where = where + " and  PRO1.proc_dt >= '"+Utility.getMakeDay("yyyyMMdd","yyyy-MM-dd",fromdate)+" 00:00:00.000'"; 	
			////	where1 = where1 + " and CONVERT(CHAR(8),proc_dt, 112) >='"+fromdate+"'";
			}
			
		     if(todate.length() >0)
			{
				where = where + " and PRO1.proc_dt <= '"+ Utility.getMakeDay("yyyyMMdd","yyyy-MM-dd",todate)+" 23:59:59.999'";
			////	where1 = where1 + " and CONVERT(CHAR(8),proc_dt, 112)  <= '"+ todate+"'";
			}
			
		     if(srvc_cd.length() > 0)
			{
				if(!srvc_cd.equals("T"))
				{
					subwhere = subwhere + " and P1.srvc_cd = " + srvc_cd;  //// 서비스 코드..
				////	where1 = where1 + " and srvc_cd = " + srvc_cd;
				}	
			}
			
		     if(rslt.length() > 0)
			{
				if(!rslt.equals("T"))
				{
					////if(rslt.equals("B"))
					////{
					////	subwhere = subwhere + " and P1.rslt = 'B'";
					////	where1 = where1 + " and rslt = ''";
					////}
					////else
					////{
						subwhere = subwhere + " and P1.rslt = '"+ rslt+"'";						
					////	where1 = where1 + " and rslt = '"+ rslt+"'";
					////}
				}
			}
			
			if(bankcd.length() > 0)
			{
				if(!bankcd.equals("T"))
				{
					subwhere = subwhere + " and P1.bank_cd = '"+ bankcd+"'";						
					////where1 = where1 + " and bank_cd = '"+ bankcd+"'";						
				}
			}
			
			if(key.length() > 0)
			{
				subwhere = subwhere + "  and P1.policy_no like '%"+ key +"%'	";				
				////where1 = where1 + "  and policy_no like '%"+ key +"%'	";			
			}
	 	     input.put("top", top);
	            input.put("page", page);
	            input.put("where", Util.replaceStr(where, "'", "''"));
				
				input.put("subwhere", Util.replaceStr(subwhere, "'", "''"));
	            

		     anyframe.log.Logger.debug.println("SQL에서 WHERE의 INPUT값-----------------: "+where);	
			anyframe.log.Logger.debug.println("SQL에서 WHERE2의 INPUT값-----------------: "+subwhere);
		     	
	
	            inputCount.put("where", where);
				inputCount.put("subwhere", subwhere); 
				

			
	            DataSet policyview = manager.findPolicyviewList(input);
	            DataSet totalCount = manager.findPolicyview(inputCount);
	            DataSet sumCount = manager.findSumcount(inputCount);
	
	            request.setAttribute("policyview", policyview);
	            request.setAttribute("totalCount", totalCount.getText("count"));
	            request.setAttribute("current", current);
	            request.setAttribute("sumCount", sumCount);
		
		}
		
            request.setAttribute("fromdate", fromdate);
            request.setAttribute("todate",todate);
            request.setAttribute("srvc_cd",srvc_cd);
            request.setAttribute("rslt", rslt);	            
            request.setAttribute("key", key);
            request.setAttribute("searchgubun",searchgubun);
            request.setAttribute("top", top);
		
            Logger.debug.println("################ PayprocreportAction End ####################");
            return mapping.findForward("pay_proc_report");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}