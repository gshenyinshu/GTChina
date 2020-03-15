package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="policyviewForm"
 */
public  class PolicyviewForm extends ActionForm
{
	
	private String fromdate;
	private String todate;
	private String mode;
	private String srvc_cd;
	private String rslt;
	private String search;
	private String key;
	private String searchgubun;
	private String modeind;
	private String srvc_ind;
	private String current;
	private String fromamt;
	private String toamt;


	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{

		fromdate = "";
		todate   = "";
		mode     = "";
		srvc_cd  = "";
		rslt     = "";
		search   = "";
		key      = "";
		searchgubun = "";
		modeind = "";
		srvc_ind = "";
		current = "";
		fromamt = "";
		toamt = "";
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


	public void setMode(String mode)
	{
		this.mode = mode;
	}

	public String getMode()
	{
		return mode;
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
	
	public void setFromamt(String formamt)
	{
		this.fromamt = fromamt;
	}

	public String getFromamt()
	{
		return fromamt;
	}

	public void setToamt(String toamt)
	{
		this.toamt = toamt;
	}

	public String getToamt()
	{
		return toamt;
	}
}
