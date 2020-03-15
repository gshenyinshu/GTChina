package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="authpopForm"
 */
public  class AuthpopForm extends ActionForm
{
	
	private String flag;
	private String chkyn;
	private String emp_no;
	private String pwd;
	private String emp_nm;
	private String auth_cd;
	private String team_nm;
	private String old_pwd;



	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		flag    = "";
		chkyn   = "";
		emp_no  = "";
		pwd     = "";
		emp_nm  = "";
		auth_cd = "";
		team_nm = "";
		old_pwd = "";
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


	public void setEmp_no(String emp_no)
	{
		this.emp_no = emp_no;
	}

	public String getEmp_no()
	{
		return emp_no;
	}


	public void setPwd(String pwd)
	{
		this.pwd = pwd;
	}

	public String getPwd()
	{
		return pwd;
	}


	public void setEmp_nm(String emp_nm)
	{
		this.emp_nm = emp_nm;
	}

	public String getEmp_nm()
	{
		return emp_nm;
	}


	public void setAuth_cd(String auth_cd)
	{
		this.auth_cd = auth_cd;
	}

	public String getAuth_cd()
	{
		return auth_cd;
	}


	public void setTeam_nm(String team_nm)
	{
		this.team_nm = team_nm;
	}

	public String getTeam_nm()
	{
		return team_nm;
	}


	public void setOld_pwd(String old_pwd)
	{
		this.old_pwd = old_pwd;
	}

	public String getOld_pwd()
	{
		return old_pwd;
	}
	
}