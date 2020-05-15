package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="returnnewpopForm"
 */
public  class ReturnnewpopForm extends ActionForm
{
	
	private String flag;
	private String chkyn;
	private String c_id;
	private String id;
	private String cate_desc;
	private String return_cause;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		flag           = "";
		chkyn          = "";
		c_id           = "";
		id             = "";
		cate_desc      = "";
		return_cause   = "";

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


	public void setC_id(String c_id)
	{
		this.c_id = c_id;
	}

	public String getC_id()
	{
		return c_id;
	}


	public void setId(String id)
	{
		this.id = id;
	}

	public String getId()
	{
		return id;
	}


	public void setCate_desc(String cate_desc)
	{
		this.cate_desc = cate_desc;
	}

	public String getCate_desc()
	{
		return cate_desc;
	}


	public void setReturn_cause(String return_cause)
	{
		this.return_cause = return_cause;
	}

	public String getReturn_cause()
	{
		return return_cause;
	}

	
}