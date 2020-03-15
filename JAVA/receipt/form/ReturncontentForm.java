package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="returncontentForm"
 */
public  class ReturncontentForm extends ActionForm
{
	
	private String indate;
	private String seq_no;
	private String srvc_gubun;
	private String status_code;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		indate = "";
		seq_no = "";
		srvc_gubun = "";
		status_code = "";
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

	public void setStatus_code(String status_code)
	{
		this.status_code = status_code;
	}

	public String getStatus_code()
	{
		return status_code;
	}
	
}