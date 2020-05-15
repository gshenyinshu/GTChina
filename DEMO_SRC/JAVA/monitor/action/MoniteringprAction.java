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
import gtone.changeminer.monitor.form.MoniteringprForm;
import gtone.changeminer.monitor.manager.MoniteringprManager;

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

/**
 * @struts.action
 *      path="/monitering_proof" 
 *      name="moniteringprForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="monitering_proof"
 *      path="/monitering_proof.jsp"
 *
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class MoniteringprAction extends Action
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
            Logger.debug.println("################ MoniteringprAction Start ####################");

            DataSet input = new DataSet();
            DataSet inputCount = new DataSet();
            DataSet input1 = new DataSet();
            
            
            MoniteringprForm moniteringprForm = (MoniteringprForm)form;
            FormToDataset.copyProperties(input, moniteringprForm);
		
			////세션사용하기
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
		
			MoniteringprManager manager = MoniteringprManager.getInstance();
			
			
	     	String searchgubun 	 = request.getParameter("searchgubun")	== null ? "N" : request.getParameter("searchgubun");		
            String fromdate = request.getParameter("fromdate") == null ? "" : request.getParameter("fromdate");
            String todate = request.getParameter("todate") == null ? "" : request.getParameter("todate");
            String fromdate2 = request.getParameter("fromdate2") == null ? "" : request.getParameter("fromdate2");
            String todate2 = request.getParameter("todate2") == null ? "" : request.getParameter("todate2");            
            String modeind = request.getParameter("modeind") == null ? "1" : request.getParameter("modeind");////증명서
            String srvc_ind = request.getParameter("srvc_ind") == null ? "" : request.getParameter("srvc_ind");////업무분류            
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String key = request.getParameter("key") == null ? "" : request.getParameter("key");
			
			
			////일괄처리시
			String rslt = "-1";
			int sucess_cnt = 0;
			
			
			
			////조회시
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
					where1 = where1 + " and prdate>='"+fromdate2+"'"; 	
				}
				
				if(todate2.length() >0)
				{
					where = where + " and prdate  <= '"+ todate2+"'";
					where1 = where1 + " and prdate  <= '"+ todate2+"'";
				}
	
	
				if(search.equals("1"))////주민번호
				{
					if(key.length() > 0)
					{
						where = where + "  and ssn like '%"+ key +"%'	";				
						where1 = where1 + "  and ssn like '%"+ key +"%'	";
					}					
				}
				else if(search.equals("2"))////계약자
				{
					if(key.length() > 0)
					{
						where = where + "  and name like '%"+ key +"%'	";				
						where1 = where1 + "  and name like '%"+ key +"%'	";
					}					
				}
				else if(search.equals("3"))////신청년도
				{
					if(key.length() > 0)
					{
						where = where + "  and inyear like '%"+ key +"%'	";				
						where1 = where1 + "  and inyear like '%"+ key +"%'	";
					}					
				}
	
	            input.put("page", page);
	            input.put("where", where);            
	            input.put("subwhere", where1);
		            
				anyframe.log.Logger.debug.println("SQL에서 WHERE의 INPUT값-----------------: "+where);	
				anyframe.log.Logger.debug.println("SQL에서 WHERE[1]의 INPUT값-----------------: "+where1);	
		
	            inputCount.put("where", where1);
	

	            DataSet monitor = manager.findMonitorList(input);
	            DataSet totalCount = manager.findMonitor(inputCount);
	
	            request.setAttribute("monitor", 	monitor);
	            request.setAttribute("totalCount", 	totalCount.getText("count"));
	            request.setAttribute("current", 	current);
			}
			else if(searchgubun.equals("C"))
			{
				searchgubun = "S";
				rslt = "1";
				
				////1)pms가 "N"인 리스트 가져오기
				DataSet monitor_sel = manager.findMonitor_sel(input);
				int monitor_sel_cnt = monitor_sel.getCount("ssn");
				Logger.debug.println("MoniteringprAction ---- monitor_sel_cnt : "+monitor_sel_cnt);
				for(int i=0; i<monitor_sel_cnt; i++)
				{
					////2)ctidb에 result='Y'인 해당건있는지 체크
					input1.put("indate", 	monitor_sel.getText("indate",i) );
					input1.put("ssn", 		monitor_sel.getText("ssn",i) );
					input1.put("inyear", 	monitor_sel.getText("inyear",i) );
					Logger.debug.println("MoniteringprAction ---- count  => input1 : "+input1);
					DataSet monitor_count = manager.findMonitor_count(input1);
					String monitor_cnt = monitor_count.getText("cnt").trim();
					Logger.debug.println("MoniteringprAction ---- monitor_cnt : "+monitor_cnt);
					
					if( Integer.parseInt(monitor_cnt) > 0 )
					{
						////3)pms의 "N"  => "Y"로 update
						Logger.debug.println("MoniteringprAction ---- update => input1 : "+input1);
						DataSet monitor_upt = manager.findMonitor_upt(input1);
						
						sucess_cnt = sucess_cnt +1;
					}
					
					Logger.debug.println("MoniteringprAction ---- i : "+i);
				}
			}
		
			Logger.debug.println("MoniteringprAction ---- searchgubun : "+searchgubun);
			Logger.debug.println("MoniteringprAction ---- rslt : "+rslt);
		
		
		
            request.setAttribute("fromdate", 	fromdate);
            request.setAttribute("todate",		todate);
            request.setAttribute("fromdate2", 	fromdate2);
            request.setAttribute("todate2",		todate2);
            
            request.setAttribute("modeind",		modeind);
            request.setAttribute("srvc_ind",	srvc_ind);
            request.setAttribute("search", 		search);
            request.setAttribute("key", 		key);
            request.setAttribute("searchgubun",	searchgubun);
			request.setAttribute("auth_cd",		auth_cd);
			
            Logger.debug.println("################ MoniteringprAction End ####################");
            
            
            if( rslt.equals("1") )
            {
	            String url = "/monitor/monitering_proof.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=1&search=1&key=";
	    		String msg = "";
	    		if( sucess_cnt > 0 )
	    		{
	    			msg = Integer.toString(sucess_cnt)+"건이 정상적으로 처리되었습니다.";
	    		}else{
	    			msg = "해당사항이 없습니다.";
	    		}
	    		
	    		request.setAttribute("message", msg);	
	        	request.setAttribute("toURL", url);	
	        	return mapping.findForward("alert");
            }
            else
            {
            	return mapping.findForward("monitering_proof");
            }
        }
        catch(Exception e)
        {
            throw e;
        }
    }
}