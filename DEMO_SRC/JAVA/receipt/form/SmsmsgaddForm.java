package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="smsmsgaddForm"
 */
public  class SmsmsgaddForm extends ActionForm
{
	
	private String smsgubun;
	private String call_back;
	private String send_msg;
	private String send_err;
	private String srvc_name;
	private String prname;
	private String cpflag;
	private String seq_no;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		smsgubun      = "";
		call_back 	= "";
		send_msg	= "";
		send_err		= "";
		srvc_name 	= "";
		prname  		= "";
		cpflag 		= "";
		seq_no		= "";
	}

	public void setSmsgubun(String smsgubun)
	{
		this.smsgubun = smsgubun;
	}

	public String getSmsgubun()
	{
		return smsgubun;
	}


	public void setCall_back(String call_back)
	{
		this.call_back = call_back;
	}

	public String getCall_back()
	{
		return call_back;
	}


	public void setSend_msg(String send_msg)
	{
		this.send_msg = send_msg;
	}

	public String getSend_msg()
	{
		return send_msg;
	}


	public void setSend_err(String send_err)
	{
		this.send_err = send_err;
	}

	public String getSend_err()
	{
		return send_err;
	}

	public void setSrvc_name(String srvc_name)
	{
		this.srvc_name = srvc_name;
	}

	public String getSrvc_name()
	{
		return srvc_name;
	}	
	
	public void setPrname(String prname)
	{
		this.prname = prname;
	}

	public String getPrname()
	{
		return prname;
	}

	public void setCpflag(String cpflag)
	{
		this.cpflag = cpflag;
	}

	public String getCpflag()
	{
		return cpflag;
	}

	public void setSeq_no(String seq_no)
	{
		this.seq_no = seq_no;
	}

	public String getSeq_no()
	{
		return seq_no;
	}
			
}