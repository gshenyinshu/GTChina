package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="policyreissueForm"
 */
public  class PolicyReissueForm extends ActionForm
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

	private String chk_code;
	private String rtn;
	private String auth_cd;
	
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
		
		chk_code = "";
		rtn = "";
		auth_cd = "";

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


	public void setChk_code(String chk_code)
	{
		this.chk_code = chk_code;
	}

	public String getChk_code()
	{
		return chk_code;
	}
	
	public void setRtn(String rtn)
	{
		this.rtn = rtn;
	}

	public String getRtn()
	{
		return rtn;
	}	

	public void setAuth_cd(String auth_cd)
	{
		this.auth_cd = auth_cd;
	}

	public String getAuth_cd()
	{
		return auth_cd;
	}
	
}  