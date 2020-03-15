package gtone.changeminer.monitor.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="moniteringprPrintForm"
 */
public  class MoniteringprPrintForm extends ActionForm
{
	
	private String fromdate;
	private String todate;
			
	private String search;
	private String key;
	private String searchgubun;
	private String useind;
	private String modeind;
	private String srvc_ind;
	private String current;


	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null; // nothing to do
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{

		fromdate = "";
		todate   = "";
		search   = "";
		key      = "";
		searchgubun = "";
		useind = "";
		modeind = "";
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


	public String getUseind() {
		return useind;
	}

	public void setUseind(String useind) {
		this.useind = useind;
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


	public void setModeind(String modeind)
	{
		this.modeind = modeind;
	}

	public String getModeind()
	{
		return modeind;
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