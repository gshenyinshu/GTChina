package gtone.changeminer.report.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="payprocreportForm"
 */
public class PayprocreportForm extends ActionForm
{
	
	private String fromdate;
	private String todate;
	private String srvc_cd;
	private String rslt;
	private String bankcd;
	private String key;
	private String searchgubun;
	private String current;
	private String top;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{

		fromdate    = "";
		todate      = "";
		srvc_cd     = "";
		rslt        = "";
		bankcd      = "";
		key         = "";
		searchgubun = "";
		current     = "";
		top = "";

	}
	
	public void setFromdate(String fromdate)
	{
		this.fromdate = fromdate;
	}

	public String getFromdate()
	{
		return fromdate;
	}


	public void setTodate(String todate)
	{
		this.todate = todate;
	}

	public String getTodate()
	{
		return todate;
	}


	public void setSrvc_cd(String srvc_cd)
	{
		this.srvc_cd = srvc_cd;
	}

	public String getSrvc_cd()
	{
		return srvc_cd;
	}


	public void setRslt(String rslt)
	{
		this.rslt = rslt;
	}

	public String getRslt()
	{
		return rslt;
	}


	public void setBankcd(String bankcd)
	{
		this.bankcd = bankcd;
	}

	public String getBankcd()
	{
		return bankcd;
	}


	public void setKey(String key)
	{
		this.key = key;
	}

	public String getKey()
	{
		return key;
	}


	public void setSearchgubun(String searchgubun)
	{
		this.searchgubun = searchgubun;
	}

	public String getSearchgubun()
	{
		return searchgubun;
	}


	public void setCurrent(String current)
	{
		this.current = current;
	}

	public String getCurrent()
	{
		return current;
	}

	public void setTop(String top)
	{
		this.top = top;
	}

	public String getTop()
	{
		return top;
	}

}