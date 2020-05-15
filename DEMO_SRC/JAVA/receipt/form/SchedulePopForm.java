package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="schedulepopForm"
 */
public  class SchedulePopForm extends ActionForm
{
	
	private String allday;	
	private String work_start_hour;
	private String work_start_minute;
	private String work_end_hour;
	private String work_end_minute;
	private String close_start_hour;
	private String close_start_minute;
	private String close_end_hour;
	private String close_end_minute;
	private String process;
	private String closing;
	private String billing;
	private String sixclose;
	private String aplclose;	

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		allday = "";
		work_start_hour    = "";
		work_start_minute  = "";
		work_end_hour      = "";
		work_end_minute    = "";
		close_start_hour   = "";
		close_start_minute = "";
		close_end_hour     = "";
		close_end_minute   = "";
		process  =  "";		
		closing = "";
		billing  = "";
		sixclose = "";
		aplclose = "";		
	}

	public void setAllday(String allday)
	{
		this.allday = allday;
	}

	public String getAllday()
	{
		return allday;
	}
	public void setWork_start_minute(String work_start_minute)
	{
		this.work_start_minute = work_start_minute;
	}

	public String getWork_start_minute()
	{
		return work_start_minute;
	}


	public void setWork_end_hour(String work_end_hour)
	{
		this.work_end_hour = work_end_hour;
	}

	public String getWork_end_hour()
	{
		return work_end_hour;
	}


	public void setWork_end_minute(String work_end_minute)
	{
		this.work_end_minute = work_end_minute;
	}

	public String getWork_end_minute()
	{
		return work_end_minute;
	}


	public void setClose_start_hour(String close_start_hour)
	{
		this.close_start_hour = close_start_hour;
	}

	public String getClose_start_hour()
	{
		return close_start_hour;
	}


	public void setClose_start_minute(String close_start_minute)
	{
		this.close_start_minute = close_start_minute;
	}

	public String getClose_start_minute()
	{
		return close_start_minute;
	}


	public void setClose_end_hour(String close_end_hour)
	{
		this.close_end_hour = close_end_hour;
	}

	public String getClose_end_hour()
	{
		return close_end_hour;
	}


	public void setClose_end_minute(String close_end_minute)
	{
		this.close_end_minute = close_end_minute;
	}

	public String getClose_end_minute()
	{
		return close_end_minute;
	}
	
	public void setProcess(String process)
	{
		this.process = process;
	}

	public String getProcess()
	{
		return process;
	}

	public void setClosing(String closing)
	{
		this.closing = closing;
	}

	public String getClosing()
	{
		return closing;
	}	
	
	public void setBilling(String billing)
	{
		this.billing = billing;
	}

	public String getBilling()
	{
		return billing;
	}


	public void setSixclose(String sixclose)
	{
		this.sixclose = sixclose;
	}

	public String getSixclose()
	{
		return sixclose;
	}
	
}