package gtone.changeminer.payment.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="plpaymentpaidupForm"
 */
public  class PlpaymentpaidupForm extends ActionForm
{
	
	private String deptcd;
	private String init;
	private String policy;
	private String policy_apln_no;	
	private String ssn;
	
	private String sbkcda;
	private String sbknoa;
	private String parna;			

	private String opt1;
	private String regdate;
	private String cash;
	private String bnkclt;
	private String bnkcode;
	private String bnkacct;
	private String process;
	private String indate;	
	private String returnurl;
	
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
		
		sbkcda = "";
		sbknoa = "";
		parna  = "";		
		
		opt1    = "";
		regdate = "";
		cash    = "";
		bnkclt  = "";
		bnkcode = "";
		bnkacct = "";
		process = "";
		indate = "";		
		returnurl = "";				
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


	public void setParna(String parna)
	{
		this.parna = parna;
	}

	public String getParna()
	{
		return parna;
	}	
	
	public void setOpt1(String opt1)
	{
		this.opt1 = opt1;
	}

	public String getOpt1()
	{
		return opt1;
	}


	public void setRegdate(String regdate)
	{
		this.regdate = regdate;
	}

	public String getRegdate()
	{
		return regdate;
	}


	public void setCash(String cash)
	{
		this.cash = cash;
	}

	public String getCash()
	{
		return cash;
	}


	public void setBnkclt(String bnkclt)
	{
		this.bnkclt = bnkclt;
	}

	public String getBnkclt()
	{
		return bnkclt;
	}


	public void setBnkcode(String bnkcode)
	{
		this.bnkcode = bnkcode;
	}

	public String getBnkcode()
	{
		return bnkcode;
	}

	public void setBnkacct(String bnkacct)
	{
		this.bnkacct = bnkacct;
	}

	public String getBnkacct()
	{
		return bnkacct;
	}

	public void setProcess(String process)
	{
		this.process = process;
	}

	public String getProcess()
	{
		return process;
	}

	public void setIndate(String indate)
	{
		this.indate = indate;
	}

	public String getIndate()
	{
		return indate;
	}		
	
	public void setReturnurl(String returnurl)
	{
		this.returnurl = returnurl;
	}

	public String getReturnurl()
	{
		return returnurl;
	}
	
}