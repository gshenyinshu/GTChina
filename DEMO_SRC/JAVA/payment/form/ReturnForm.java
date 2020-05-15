package gtone.changeminer.payment.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="returnForm"
 */
public  class ReturnForm extends ActionForm
{
	
	private String id;
	private String name;
	private String message;
	private String policy_apln_no;
	private String id1;
	private String errmsg;
	private String process;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		id      = "";
		name    = "";
		message = "";
		policy_apln_no = "";
		id1      = "";
		errmsg = "";
		process = "";

	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getId()
	{
		return id;
	}


	public void setName(String name)
	{
		this.name = name;
	}

	public String getName()
	{
		return name;
	}


	public void setMessage(String message)
	{
		this.message = message;
	}

	public String getMessage()
	{
		return message;
	}
	
	public void setPolicy_apln_no(String policy_apln_no)
	{
		this.policy_apln_no = policy_apln_no;
	}

	public String getPolicy_apln_no()
	{
		return policy_apln_no;
	}
	
	public void setId1(String id1)
	{
		this.id1 = id1;
	}

	public String getId1()
	{
		return id1;
	}	
	
	public void setErrmsg(String errmsg)
	{
		this.errmsg = errmsg;
	}

	public String getErrmsg()
	{
		return errmsg;
	}

	public void setProcess(String process)
	{
		this.process = process;
	}

	public String getProcess()
	{
		return process;
	}
			
}