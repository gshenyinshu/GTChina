package gtone.changeminer.monitor.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="alertForm" 
 */
public  class AlertForm extends ActionForm
{
	private String message;
	private String toURL;
	
	private String check_form;
	private String bankerr;


	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null; // nothing to do
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		message  	= "";
		toURL       = "";
		check_form  = "";
		bankerr = "";
	}

	public void setMessage(String message)
	{
		this.message = message;
	}

	public String getMessage()
	{
		return message;
	}

	public void setToURL(String toURL)
	{
		this.toURL = toURL;
            // toURL
	}

	public String getToURL()
	{
		return toURL;
	}


	public void setCheck_form(String check_form)
	{
		this.check_form = check_form;
	}

	public String getCheck_form()
	{
		return check_form;
	}	
	
	public void setBankerr(String bankerr)
	{
		this.bankerr = bankerr;
	}

	public String getBankerr()
	{
		return bankerr;
	}
	
}