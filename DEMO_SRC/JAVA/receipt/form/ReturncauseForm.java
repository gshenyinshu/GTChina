package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="returncauseForm"
 */
public  class ReturncauseForm extends ActionForm
{
	
	private String flag;
	private String chkyn;
	private String cate_desc;
	private String indate;
	private String seq_no;
	private String srvc_gubun;


	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		flag       = "";
		chkyn      = "";
		cate_desc  = "";
		indate     = "";
		seq_no     = "";
		srvc_gubun = "";

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


	public void setCate_desc(String cate_desc)
	{
		this.cate_desc = cate_desc;
	}

	public String getCate_desc()
	{
		return cate_desc;
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

}