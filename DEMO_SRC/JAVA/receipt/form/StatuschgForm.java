package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="statuschgForm"
 */
public  class StatuschgForm extends ActionForm
{
	
	private String fromdate;
	private String todate;
	private String mode;
	private String srvc_cd;
	private String rslt;
	private String search;
	private String key;
	private String searchgubun;
	private String searchgubun1;
	private String modeind;
	private String srvc_ind;
	private String current;

	private String policy_apln_no;
	private String policy_no;
	private String bank_cd;
	private String acct_no;
	private String payor_ssn;
	private String chgstatus;
	private String rtnflag;

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
		rslt     = "";
		search   = "";
		key      = "";
		searchgubun = "";
		searchgubun1 = "";
		modeind = "";
		srvc_ind = "";
		current = "";

		policy_apln_no = "";
		policy_no      = "";
		srvc_cd        = "";
		bank_cd        = "";
		acct_no        = "";
		payor_ssn      = "";
		chgstatus 	= "";
		rtnflag  = "";
		
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

	public void setSearchgubun1(String searchgubun1)
	{
		this.searchgubun1 = searchgubun1;
	}

	public String getSearchgubun1()
	{
		return searchgubun1;
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

	public void setPolicy_apln_no(String policy_apln_no)
	{
		this.policy_apln_no = policy_apln_no;
	}

	public String getPolicy_apln_no()
	{
		return policy_apln_no;
	}


	public void setPolicy_no(String policy_no)
	{
		this.policy_no = policy_no;
	}

	public String getPolicy_no()
	{
		return policy_no;
	}

	public void setBank_cd(String bank_cd)
	{
		this.bank_cd = bank_cd;
	}

	public String getBank_cd()
	{
		return bank_cd;
	}


	public void setAcct_no(String acct_no)
	{
		this.acct_no = acct_no;
	}

	public String getAcct_no()
	{
		return acct_no;
	}


	public void setPayor_ssn(String payor_ssn)
	{
		this.payor_ssn = payor_ssn;
	}

	public String getPayor_ssn()
	{
		return payor_ssn;
	}

	public void setChgstatus(String chgstatus)
	{
		this.chgstatus = chgstatus;
	}

	public String getChgstatus()
	{
		return chgstatus;
	}

	public void setRtnflag(String rtnflag)
	{
		this.rtnflag = rtnflag;
	}

	public String getRtnflag()
	{
		return rtnflag;
	}

	
}