package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="authForm"
 */
public  class AuthForm extends ActionForm
{
	private String current;
	private String flag;
	private String emp_no;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		current = "";
		flag = "";
		emp_no = "";
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

	public void setEmp_no(String emp_no)
	{
		this.emp_no = emp_no;
	}

	public String getEmp_no()
	{
		return emp_no;
	}
			
}