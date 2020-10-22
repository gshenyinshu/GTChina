package gtone.changeminer.payment.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="dividendoffsearchForm"
 */
public  class DividendoffsearchForm extends ActionForm
{
	private String policy;
	private String cnvdate;
	private String policy_apln_no;	
	private String ssn;	

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
	
	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		policy  = "";
		cnvdate = "";
		policy_apln_no = "";		
		ssn  = "";

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
	}

	public void setPolicy(String policy)
	{
		this.policy = policy;
	}

	public String getPolicy()
	{
		return policy;
	}


	public void setCnvdate(String cnvdate)
	{
		this.cnvdate = cnvdate;
	}

	public String getCnvdate()
	{
		return cnvdate;
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
}