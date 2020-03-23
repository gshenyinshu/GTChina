package gtone.changeminer.payment.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="restingpaidupForm"
 */
public  class RestingpaidupForm extends ActionForm
{
	
	private String deptcd;
	private String init;
	private String policy;
	private String policy_apln_no;		
	private String ssn;	
	
	private String sbkcda;
	private String sbknoa;
	private String pyrna;
	private String opt1;
	private String rcvdate;
	private String date;
	private String bk_clt;
	private String bk_cod;
	private String bk_acct;
	private String process;
	
	private String sndseq;
	private String returnurl;
	private String procgb;
	private String bnkyn;
	
	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		policy  = "";		
		deptcd = "";
		init   = "";		
		policy_apln_no = "";				
		ssn = "";
		
		sbkcda  = "";
		sbknoa  = "";
		pyrna   = "";
		opt1    = "";
		rcvdate = "";
		date    = "";
		bk_clt  = "";
		bk_cod  = "";
		bk_acct = "";
		process = "";
		
		sndseq    = "";
		returnurl = "";	
		procgb    = "";	
		bnkyn = "";
		
	}
	
	public void setDeptcd(String deptcd)
	{
		this.deptcd = deptcd;
	}

	public String getDeptcd()
	{
		return deptcd;
	}


	public void setInit(String init)
	{
		this.init = init;
	}

	public String getInit()
	{
		return init;
	}
	
	public void setPolicy(String policy)
	{
		this.policy = policy;
	}

	public String getPolicy()
	{
		return policy;
	}

	public void setPolicy_apln_no(String policy_apln_no)
	{
		this.policy_apln_no = policy_apln_no;
	}

	public String getPolicy_apln_no()
	{
		return policy_apln_no;
	}	
	
	public void setSsn(String ssn)
	{
		this.ssn = ssn;
	}

	public String getSsn()
	{
		return ssn;
	}

	public void setSbkcda(String sbkcda)
	{
		this.sbkcda = sbkcda;
	}

	public String getSbkcda()
	{
		return sbkcda;
	}


	public void setSbknoa(String sbknoa)
	{
		this.sbknoa = sbknoa;
	}

	public String getSbknoa()
	{
		return sbknoa;
	}


	public void setPyrna(String pyrna)
	{
		this.pyrna = pyrna;
	}

	public String getPyrna()
	{
		return pyrna;
	}


	public void setOpt1(String opt1)
	{
		this.opt1 = opt1;
	}

	public String getOpt1()
	{
		return opt1;
	}


	public void setRcvdate(String rcvdate)
	{
		this.rcvdate = rcvdate;
	}

	public String getRcvdate()
	{
		return rcvdate;
	}


	public void setDate(String date)
	{
		this.date = date;
	}

	public String getDate()
	{
		return date;
	}


	public void setBk_clt(String bk_clt)
	{
		this.bk_clt = bk_clt;
	}

	public String getBk_clt()
	{
		return bk_clt;
	}


	public void setBk_cod(String bk_cod)
	{
		this.bk_cod = bk_cod;
	}

	public String getBk_cod()
	{
		return bk_cod;
	}


	public void setBk_acct(String bk_acct)
	{
		this.bk_acct = bk_acct;
	}

	public String getBk_acct()
	{
		return bk_acct;
	}


	public void setProcess(String process)
	{
		this.process = process;
	}

	public String getProcess()
	{
		return process;
	}

	public void setSndseq(String sndseq)
	{
		this.sndseq = sndseq;
	}

	public String getSndseq()
	{
		return sndseq;
	}
	
	public void setReturnurl(String returnurl)
	{
		this.returnurl = returnurl;
	}

	public String getReturnurl()
	{
		return returnurl;
	}
	
	public void setProcgb(String procgb)
	{
		this.procgb = procgb;
	}

	public String getProcgb()
	{
		return procgb;
	}
	
	public void setBnkyn(String bnkyn)
	{
		this.bnkyn = bnkyn;
	}
	
	public String getBnkyn()
	{
		return bnkyn;
	}				
}