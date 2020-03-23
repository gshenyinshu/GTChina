package gtone.changeminer.payment.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="returnplForm"
 */
public  class ReturnplForm extends ActionForm
{
	
	private String fromdate;
	private String todate;
	private String fromdate2;
	private String todate2;
			
	private String search;
	private String key;
	private String searchgubun;
	private String srvc_ind;
	private String current;


	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{

		fromdate = "";
		todate   = "";
		fromdate2 = "";
		todate2 = "";
		search   = "";
		key      = "";
		searchgubun = "";		
		srvc_ind = "";
		current = "";
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


	public void setFromdate2(String fromdate2)
	{
		this.fromdate2 = fromdate2;
	}

	public String getFromdate2()
	{
		return fromdate2;
	}


	public void setTodate2(String todate2)
	{
		this.todate2 = todate2;
	}

	public String getTodate2()
	{
		return todate2;
	}


	public void setSearch(String search)
	{
		this.search = search;
	}

	public String getSearch()
	{
		return search;
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

	public void setSrvc_ind(String srvc_ind)
	{
		this.srvc_ind = srvc_ind;
	}

	public String getSrvc_ind()
	{
		return srvc_ind;
	}


	public void setCurrent(String current)
	{
		this.current = current;
	}

	public String getCurrent()
	{
		return current;
	}

	
}