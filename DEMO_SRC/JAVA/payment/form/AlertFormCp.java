package gtone.changeminer.payment.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="alertForm"
 */
public  class AlertFormCp extends ActionForm
{
	private String message;
	private String toURL;
	
	private String check_form;
	private String bankerr;


	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void resetCp(ActionMapping mapping, HttpServletRequest request)
	{
		message  	= "";
		toURL       = "";
		check_form  = "";
		bankerr = "";
	}

	public void setMessageCp(String message)
	{
		this.message = message;
	}

	public String getMessageCp()
	{
		return message;
	}

	public void setToURLCp(String toURL)
	{
		this.toURL = toURL;
	}

	public String getToURLCp()
	{
		return toURL;
	}


	public void setCheck_formCp(String check_form)
	{
		this.check_form = check_form;
	}

	public String getCheck_formCp()
	{
		return check_form;
	}	
	
	public void setBankerrCp(String bankerr)
	{
		this.bankerr = bankerr;
	}

	public String getBankerrCp()
	{
		return bankerr;
	}
	
}