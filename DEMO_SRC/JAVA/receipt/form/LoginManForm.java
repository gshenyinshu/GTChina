/**
 * Title       	: LoginManForm.java
 * Description 	: 홈페이지 사이버 센터 로그인 상태 변경 
 * Company     : gtone
 * @author 	: Kim Bo Young
 * @version 1.0
 */

package gtone.changeminer.receipt.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * XDoclet definition:
 * @struts:form name="LoginManForm"
 */
public  class LoginManForm extends ActionForm
{
	private String login_sts;
	private String login_close_msg;
	
	private String save_sts;
	private String emp_no;

	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request){
		login_sts 		= "N";
		login_close_msg = "현재 시스템 점검으로 인해 사이버센터 이용이 당분간 불가합니다. 이용에 불편을 드려 죄송합니다.";
		
		save_sts		= "N";
		emp_no			= "cyber";
	}

	/**
	 * @return Returns the login_close_msg.
	 */
	public String getLogin_close_msg() {
		return login_close_msg;
	}

	/**
	 * @param login_close_msg The login_close_msg to set.
	 */
	public void setLogin_close_msg(String login_close_msg) {
		this.login_close_msg = login_close_msg;
	}

	/**
	 * @return Returns the login_sts.
	 */
	public String getLogin_sts() {
		return login_sts;
	}

	/**
	 * @param login_sts The login_sts to set.
	 */
	public void setLogin_sts(String login_sts) {
		this.login_sts = login_sts;
	}

	/**
	 * @return Returns the save_sts.
	 */
	public String getSave_sts() {
		return save_sts;
	}

	/**
	 * @param save_sts The save_sts to set.
	 */
	public void setSave_sts(String save_sts) {
		this.save_sts = save_sts;
	}

	/**
	 * @return Returns the emp_no.
	 */
	public String getEmp_no() {
		return emp_no;
	}

	/**
	 * @param emp_no The emp_no to set.
	 */
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

}