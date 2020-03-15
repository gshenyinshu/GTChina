////// 2006.05.30

package gtone.changeminer.common.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gtone.changeminer.common.form.CyberIndexForm;
import gtone.changeminer.common.manager.CyberIndexManager;
import gtone.changeminer.common.utility.Utility;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import anyframe.data.DataSet;
import anyframe.log.Logger;

public  class CyberIndexAction extends DispatchAction {

	public ActionForward list(ActionMapping mapping, ActionForm form, 
				HttpServletRequest request, HttpServletResponse response)
		throws Exception  {
		Logger.debug.println("CyberIndexAction Start ");
		CyberIndexForm		thisForm = (CyberIndexForm)form ;
		String cause = Utility.nvl(request.getParameter("cause"));
		String flag  = Utility.nvl(request.getParameter("flag"));
		String seq  = Utility.nvl(request.getParameter("seq"));
		String createdate = Utility.nvl(request.getParameter("createdate"));
		
		DataSet input = new DataSet();
		
		if (thisForm.getTermDiv().equals("2")){
			//////Getting index number
			//////Getting index value
			String toYear = thisForm.getToDate().substring(0,4);
			String toMonth = thisForm.getToDate().substring(4);
			String fromYear = thisForm.getFromDate().substring(0,4);
			String fromMonth = thisForm.getFromDate().substring(4);
			String start_date="";
			String end_date="";
			
			String result = "";
			int tempy = Integer.parseInt(toYear);
			int temp = Integer.parseInt(toMonth);
			Logger.debug.print("toYear"+tempy);
			Logger.debug.print("toMonth"+temp);
			
			start_date = fromYear+fromMonth +"01";
			if (temp==1 || temp==3 || temp==5 || temp==7 ||
					temp==9 || temp==10 || temp==12 ){
				end_date = toYear+toMonth + "31";
			}else if (temp==4 || temp==6 || temp==8 || temp==11){
				end_date = toYear+toMonth + "30";
			}else if (temp==2){
				if ((tempy % 400 == 0) || ((tempy % 100 != 0) && (tempy % 4 == 0))) 
					end_date = toYear+toMonth + "29";
				else
					end_date = toYear+toMonth + "28";
			}
					
			input.put( "start_date"   , start_date);
			input.put( "end_date", end_date    );    
		}else if (thisForm.getTermDiv().equals("4")){
//////			string operations
			String toYear1 = thisForm.getQuatertoDate().substring(0,4);
			String toMonth1 = thisForm.getQuatertoDate().substring(4,6);
			String result1 = "";
			
			//////result = toYear + ( Integer.parseInt(toMonth) + 1 ) + "";
//////			result1 = thisForm.getQuatertoDate();
			Logger.debug.println("toMonth1:"+toMonth1);
			if (toMonth1.equals("01") || toMonth1.equals("03") || toMonth1.equals("05") || toMonth1.equals("07") ||
					toMonth1.equals("09") || toMonth1.equals("10") || toMonth1.equals("12") ){
				result1 = thisForm.getQuatertoDate() + "31";
			}else if (toMonth1.equals("04") || toMonth1.equals("06") || toMonth1.equals("08") || toMonth1.equals("11")){
				result1 = thisForm.getQuatertoDate() + "30";
			}else if (toMonth1.equals("02")){
				if ((Integer.parseInt(toYear1) % 400 == 0) 
						|| ((Integer.parseInt(toYear1) % 100 != 0) 
							&& (Integer.parseInt(toYear1) % 4 == 0))) 
					result1 = thisForm.getQuatertoDate() + "29";
				else
					result1 = thisForm.getQuatertoDate() + "28";
			}

			input.put( "start_date", thisForm.getQuaterfromDate()+"01");
			input.put( "end_date", result1    );
			
			Logger.debug.println("thisForm.getQuaterfromDate():"+thisForm.getQuaterfromDate());
			Logger.debug.println("result1:"+result1);
			
			
		}else if (thisForm.getTermDiv().equals("3")){
//////			making input stream
			input.put("start_date" , thisForm.getYear());
			input.put("end_date",(Integer.parseInt(thisForm.getYear())+1)+"");
		}else{
			input.put("start_date" , thisForm.getFromDate());
			input.put("end_date",thisForm.getToDate());
		}
		
		
		Logger.debug.println("input : "+input);
		
		CyberIndexManager manager = CyberIndexManager.getInstance();
//////		comment:
		DataSet pub_stat  = manager.findPubStat(input);
//////		comment:
		DataSet list1  = manager.findList(input);
//////		comment:
		DataSet list2  = manager.findListAdd(input);
		
		for(int i=0; i < list1.getCount("item"); i++){
			if ("comment:".equals( list1.getText("item",i) )){
				list1.put("order","1",i);
			}else if ("APL신청".equals( list1.getText("item",i) )){
				list1.put("order","2",i);
			}else if ("APL해지".equals( list1.getText("item",i) )){
				list1.put("order","3",i);
			}else if ("자동이체변경".equals( list1.getText("item",i))){
				list1.put("order","4",i);
			}else if ("자동이체해지".equals( list1.getText("item",i))){
				list1.put("order","5",i);
			}else if ("약대지급".equals( list1.getText("item",i) )){
				list1.put("order","6",i);
			}else if ("배당금지급".equals( list1.getText("item",i) )){
				list1.put("order","7",i);
			}else if ("배당금상계지급".equals( list1.getText("item",i) )){
				list1.put("order","8",i);
			}else if ("휴면보험금지급".equals( list1.getText("item",i) )){
				list1.put("order","9",i);
			}else if ("보험료수납".equals( list1.getText("item",i) )){
				list1.put("order","10",i);
			}else if ("약대상환".equals( list1.getText("item",i) )){
				list1.put("order","11",i);
			}else if ("APL상환".equals( list1.getText("item",i) )){
				list1.put("order","12",i);
			}
		}
		
		//////comment:
		if (!"".equals(cause)){
			
			
			if (!"U".equals(flag)){
				seq = "0";
			}
			
			DataSet input1 = new DataSet();
			input1.put("flag",flag);
			input1.put("seq",seq);
			input1.put("cause",cause);
			input1.put("createdate",createdate);
			
			manager.causeAdd(input1);
			Logger.debug.println("특이사항 저장 : "+input1);
		}
		
		
		request.setAttribute("pub_stat", pub_stat);
		request.setAttribute("list1",       list1);
		request.setAttribute("list2" ,      list2);
		request.setAttribute("form"  , thisForm ) ;
		
		Logger.debug.println(" output1 : "+list1);
		Logger.debug.println(" output2 : "+list2);
		Logger.debug.println(" output3 : "+pub_stat);
		
		Logger.debug.println("CyberIndexAction End ");
		
		return mapping.findForward("list");
	}

	public ActionForward excel(ActionMapping mapping, ActionForm form, 
				HttpServletRequest request, HttpServletResponse response)
		throws Exception  {
		
		return mapping.findForward("excel");
	}
	
	public ActionForward cause(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
	throws Exception  {
		CyberIndexManager manager = CyberIndexManager.getInstance();
		String search = Utility.nvl(request.getParameter("search"));
		String searchStr = Utility.nvl(request.getParameter("searchStr"));
		String sdate = Utility.nvl(request.getParameter("sdate"));
		String edate = Utility.nvl(request.getParameter("edate"));
		int pageNumber = Utility.nvlToNumber(request.getParameter("pageNumber"), 1);
		String v_top = "" + (10 * (pageNumber - 1));
		
		DataSet input = new DataSet();
		input.put("search",search);
		input.put("searchStr",searchStr);
		input.put("sdate",sdate);
		input.put("edate",edate);
		input.put("v_top",v_top);
		Logger.debug.println("cause : "+input);
		DataSet list = manager.findCause(input);

		input.put("v_mode","count");
		String  total = manager.findCauseTotal(input);
		
		Logger.debug.println("cause list : "+list);
		request.setAttribute("list",list);
		request.setAttribute("total",total);
		
		DataSet returnForm = new DataSet();
		returnForm.put("search",search);
		returnForm.put("searchStr",searchStr);
		returnForm.put("sdate",sdate);
		returnForm.put("edate",edate);
		Logger.debug.println("returnForm : "+returnForm);
		request.setAttribute("returnForm",returnForm);
		
		return mapping.findForward("popup");

	}
	/*
	public ActionForward manager(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
	throws Exception  {
		CyberIndexManager manager = CyberIndexManager.getInstance();
		DataSet list = manager.findStandardList();
		request.setAttribute("list",list);
		return mapping.findForward("manager");
	}

	
	public ActionForward manager_update(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
	throws Exception  {
		CyberIndexManager manager = CyberIndexManager.getInstance();
		manager.findStandardUpdate();
		
		return mapping.findForward("manager_update");
	}*/

}

