package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="returncForm"
 */
public  class ReturncForm extends ActionForm
{
	private String current;
	private String flag;
	private String c_id;
	private String id;
	private String gubun;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		current = "";
		flag = "";
		c_id = "";
		id = "";
		gubun = "";

	}

	public void setCurrent(String current)
	{
		this.current = current;
	}

	public String getCurrent()
	{
		return current;
	}	
	
	public void setFlag(String flag)
	{
		this.flag = flag;
	}

	public String getFlag()
	{
		return flag;
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

	public void setGubun(String gubun)
	{
		this.gubun = gubun;
	}

	public String getGubun()
	{
		return gubun;
	}
			
}