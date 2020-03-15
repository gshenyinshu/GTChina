
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
import gtone.changeminer.receipt.form.SchedulePopForm;
import gtone.changeminer.receipt.manager.SchedulePopManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/schedulepop"
 *      name="schedulepopForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="schedulepop"
 *      path="/schedulepop.jsp"
 *
  */
public  class SchedulePopAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ SchedulePopAction Start ####################");

			DataSet input  = new DataSet();				
			DataSet input1  = new DataSet();	

			SchedulePopForm schedulepopForm = (SchedulePopForm) form;
			////FormToDataset.copyProperties(input, schedulepopForm);			
			
			String allday   = request.getParameter("allday")	== null ? "" : request.getParameter("allday");	
					
			String work_start_hour = request.getParameter("work_start_hour")	== null ? "" : request.getParameter("work_start_hour");			
			String work_start_minute = request.getParameter("work_start_minute")	== null ? "" : request.getParameter("work_start_minute");			
			String work_end_hour = request.getParameter("work_end_hour")	== null ? "" : request.getParameter("work_end_hour");			
			String work_end_minute = request.getParameter("work_end_minute")	== null ? "" : request.getParameter("work_end_minute");			

			String work_start_hour2 = request.getParameter("work_start_hour2")	== null ? "" : request.getParameter("work_start_hour2");			
			String work_start_minute2 = request.getParameter("work_start_minute2")	== null ? "" : request.getParameter("work_start_minute2");			
			String work_end_hour2 = request.getParameter("work_end_hour2")	== null ? "" : request.getParameter("work_end_hour2");			
			String work_end_minute2 = request.getParameter("work_end_minute2")	== null ? "" : request.getParameter("work_end_minute2");			
			
			String close_start_hour = request.getParameter("close_start_hour")	== null ? "" : request.getParameter("close_start_hour");			
			String close_start_minute = request.getParameter("close_start_minute")	== null ? "" : request.getParameter("close_start_minute");			
			String close_end_hour = request.getParameter("close_end_hour")	== null ? "" : request.getParameter("close_end_hour");			
			String close_end_minute = request.getParameter("close_end_minute")	== null ? "" : request.getParameter("close_end_minute");						
			String process = request.getParameter("process")	== null ? "" : request.getParameter("process");						
			String closing = request.getParameter("closing")	== null ? "N" : request.getParameter("closing");////유예건 보험료 접수불가일
			String billing = request.getParameter("billing")	== null ? "N" : request.getParameter("billing");////billing진행중인날
			String sixclose = request.getParameter("sixclose")	== null ? "N" : request.getParameter("sixclose");////유예건 보험료 6시까지 접수가능일
			String aplclose = request.getParameter("aplclose")	== null ? "N" : request.getParameter("aplclose");////유예건 APL 접수불가일	

			String work_gubun = request.getParameter("work_gubun")	== null ? "0" : request.getParameter("work_gubun");////휴일구분
			String delay_auto_close = request.getParameter("delay_auto_close")	== null ? "N" : request.getParameter("delay_auto_close");////유예건자동이체불가일
			String pl_repay_day = request.getParameter("pl_repay_day")	== null ? "N" : request.getParameter("pl_repay_day");////대출자동상환일
			
			String delay_pay_close = request.getParameter("delay_pay_close") == null ? "N" : request.getParameter("delay_pay_close");////유예건(감/연)제지급수령불가일
			
			String work_gubun_check_val = request.getParameter("work_gubun_check_val") == null ? "" : request.getParameter("work_gubun_check_val");////영업일의 휴일 구분 상태 변경 여부
			
			String work_start = work_start_hour + work_start_minute;
			String work_end  = work_end_hour + work_end_minute;
			String work_start2 = work_start_hour2 + work_start_minute2;
			String work_end2  = work_end_hour2 + work_end_minute2;
			String close_start = close_start_hour + close_start_minute;
			String close_end = close_end_hour + close_end_minute;	
						
			input.put("allday",   allday);
			SchedulePopManager manager = SchedulePopManager.getInstance();
			
			input1.put("allday", allday);			
			input1.put("work_start", work_start);
			input1.put("work_end", work_end);
			input1.put("work_start2", work_start2);
			input1.put("work_end2", work_end2);
			////input1.put("close_start", close_start);
			////input1.put("close_end", close_end);
			input1.put("closing", closing);
			input1.put("billing", billing);
			input1.put("sixclose", sixclose);
			input1.put("aplclose", aplclose);
			input1.put("delay_auto_close", delay_auto_close);
			input1.put("pl_repay_day", pl_repay_day);
			input1.put("work_gubun", work_gubun);
			input1.put("delay_pay_close", delay_pay_close);
			input1.put("work_gubun_check_val", work_gubun_check_val);
			
			if(process.equals("Y")) 
			{			
				anyframe.log.Logger.debug.println("WORKINGDAY 수정==>"+input1);	
				DataSet uptworkingday 	= manager.findUpdateWorking(input1);							
				request.setAttribute("uptworkingday", uptworkingday); 
			}
			else
			{
				anyframe.log.Logger.debug.println("WORKINGDAY 입력==>"+input);	
				DataSet workingday 	= manager.findWorking(input);							
				request.setAttribute("workingday", workingday); 
			}
			request.setAttribute("allday", allday); 
			
			request.setAttribute("work_start_hour", work_start_hour); 
			request.setAttribute("work_start_minute", work_start_minute); 
			request.setAttribute("work_end_hour", work_end_hour); 
			request.setAttribute("work_end_minute", work_end_minute); 

			request.setAttribute("work_start_hour2", work_start_hour2); 
			request.setAttribute("work_start_minute2", work_start_minute2); 
			request.setAttribute("work_end_hour2", work_end_hour2); 
			request.setAttribute("work_end_minute2", work_end_minute2); 
			
			request.setAttribute("close_start_hour", close_start_hour); 
			request.setAttribute("close_start_minute", close_start_minute); 
			request.setAttribute("close_end_hour", close_end_hour); 
			request.setAttribute("close_end_minute", close_end_minute); 
			request.setAttribute("closing", closing); 
			request.setAttribute("billing", billing); 
			request.setAttribute("sixclose", sixclose); 
			request.setAttribute("aplclose", aplclose); 
			request.setAttribute("work_gubun", work_gubun);
			request.setAttribute("delay_auto_close", delay_auto_close); 
			request.setAttribute("pl_repay_day", pl_repay_day); 
			request.setAttribute("delay_pay_close", delay_pay_close); 
			
			
			return mapping.findForward("schedulepop");

		////Logger.debug.println("################ SchedulePopAction End ####################");

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}

