/**
 * Title       : cyberindex Form
 * Description : cyberindex Form
 * 2006.06.01
 */
package gtone.changeminer.withdrawal.form;

import java.util.Calendar;
import java.text.SimpleDateFormat;

import org.apache.struts.action.ActionForm      ;
import org.apache.struts.action.ActionMapping   ;
import org.apache.struts.action.ActionErrors    ;
import org.apache.struts.action.ActionMessage   ;

import javax.servlet.http.HttpServletRequest    ;

public class WithdrawalDetailForm extends ActionForm{

    private String policy_no = null ;
    private String seq = null ;
    private String status_cd = null;
	private String memo = null;

    private String emp_id = null; // Your comment here!

//	private String confrim_process = null;
	
 	/**
     * form's functions
     * @return  ActionErrors
     */ 

    public void reset(ActionMapping mapping, HttpServletRequest request){ 
		policy_no = null ;
		seq = null;
		status_cd = null;
		memo = null;
	}

	/**
	 * @return
	 */
	public String getMemo() {
		return memo;
	}

	/**
	 * @return
	 */
	public String getPolicy_no() {
		return policy_no;
	}

	/**
	 * @return
	 */
	public String getSeq() {
		return seq;
	}

	/**
	 * @return
	 */
	public String getStatus_cd() {
		return status_cd;
	}

	/**
	 * @param string
	 */
	public void setMemo(String string) {
		memo = string;
	}

	/**
	 * @param string
	 */
	public void setPolicy_no(String string) {
		policy_no = string;
	}

	/**
	 * @param string
	 */
	public void setSeq(String string) {
		seq = string;
	}

	/**
	 * @param string
	 */
	public void setStatus_cd(String string) {
		status_cd = string;
	}

	/**
	 * @return
	 */
	public String getEmp_id() {
		return emp_id;
	}

	/**
	 * @param string
	 */
	public void setEmp_id(String string) {
		emp_id = string;
	}

}