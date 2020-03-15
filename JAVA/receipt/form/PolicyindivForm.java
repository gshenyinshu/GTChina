package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="policyindivForm"
 */
public  class PolicyindivForm extends ActionForm
{
	
	private String fromdate;
	private String todate;
			
	private String search;
	private String key;
	private String searchgubun;
	private String srvc_ind;
	private String current;
	private String indate;
	private String seq_no;
	private String srvc_gubun;
	private String process_mode;
	private String rtnflag;
	private String status_code;
	
	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{

		fromdate = "";
		todate   = "";
		search   = "";
		key      = "";
		searchgubun = "";
		srvc_ind = "";
		current = "";
		indate = "";
		seq_no = "";
		srvc_gubun = "";
		process_mode = "";
		rtnflag = "";
		status_code = "";
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

	public void setIndate(String indate)
	{
		this.indate = indate;
	}

	public String getIndate()
	{
		return indate;
	}


	public void setSeq_no(String seq_no)
	{
		this.seq_no = seq_no;
	}

	public String getSeq_no()
	{
		return seq_no;
	}

	public void setSrvc_gubun(String srvc_gubun)
	{
		this.srvc_gubun = srvc_gubun;
	}

	public String getSrvc_gubun()
	{
		return srvc_gubun;
	}

	public void setProcess_mode(String process_mode)
	{
		this.process_mode = process_mode;
	}

	public String getProcess_mode()
	{
		return process_mode;
	}

	public void setRtnflag(String rtnflag)
	{
		this.rtnflag = rtnflag;
	}

	public String getRtnflag()
	{
		return rtnflag;
	}

	public void setStatus_code(String status_code)
	{
		this.status_code = status_code;
	}

	public String getStatus_code()
	{
		return status_code;
	}
	
}