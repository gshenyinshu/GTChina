package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="returncause1Form"
 */
public  class Returncause1Form extends ActionForm
{
	
	private String flag;
	private String chkyn;	
	private String indate;
	private String seq_no;
	private String srvc_gubun;
	private String c_id;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		flag       = "";
		chkyn      = "";		
		indate     = "";
		seq_no     = "";
		srvc_gubun = "";
		c_id = "";	
	}

	public void setFlag(String flag)
	{
		this.flag = flag;
	}

	public String getFlag()
	{
		return flag;
	}


	public void setChkyn(String chkyn)
	{
		this.chkyn = chkyn;
	}

	public String getChkyn()
	{
		return chkyn;
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

	public void setC_id(String c_id)
	{
		this.c_id = c_id;
	}

	public String getC_id()
	{
		return c_id;
	}

}