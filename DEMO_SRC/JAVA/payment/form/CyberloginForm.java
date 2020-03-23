package gtone.changeminer.payment.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="cyberloginForm"
 */
public  class CyberloginForm extends ActionForm
{
	private String id;
	private String pw;
	private String checkyn;
	private String login;////로그인 체크


	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		id      = "";
		pw      = "";
		checkyn = "";
		login   = "";
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getId()
	{
		return id;
	}


	public void setPw(String pw)
	{
		this.pw = pw;
	}

	public String getPw()
	{
		return pw;
	}


	public void setCheckyn(String checkyn)
	{
		this.checkyn = checkyn;
	}

	public String getCheckyn()
	{
		return checkyn;
	}


	public void setLogin(String login)
	{
		this.login = login;
	}

	public String getLogin()
	{
		return login;
	}	
}