/**
 * Title       	: LoginManForm.java
 * Description 	: �6�9�5�1�3�3�3�1 �1�7�3�3�0�3 �1�1�5�5 �0�9�8�9�3�7 �1�8�5�1 �1�3�7�4 
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
		login_close_msg = "�6�1�3�9 �2�7�2�1�5�9 �3�9�7�3�3�7�0�9 �3�7�6�7 �1�7�3�3�0�3�1�1�5�5 �3�3�3�0�3�3 �9�0�1�9�7�9 �1�3�7�5�6�6�9�1�9�9. �3�3�3�0�2�3 �1�3�5�3�3�5 �9�3�0�3 �3�9�2�2�6�6�9�1�9�9.";
		
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