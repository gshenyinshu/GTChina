/**
 * Title       	: InoutManForm.java
 * Description 	: 홈페이지 사이버 센터 입출금 상태 변경 
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
 * @struts:form name="InoutManForm"
 */
public  class InoutManForm extends ActionForm
{
	private String pl_sts;
	private String div_sts;
	private String rest_sts;
	private String divoff_sts;
	private String prem_sts;
	private String addprem_sts;
	private String plrepay_sts;
	private String apl_sts;
	
	private String pl_close_msg;
	private String div_close_msg;
	private String rest_close_msg;
	private String divoff_close_msg;
	private String prem_close_msg;
	private String addprem_close_msg;
	private String plrepay_close_msg;
	private String apl_close_msg;

	private String save_sts;
	private String emp_no;
	
	public ActionErrors validate(ActionMapping mapping,
	                             HttpServletRequest request)
	{
		return null;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		pl_sts 			= "N";
		div_sts 		= "N";;
		rest_sts 		= "N";
		divoff_sts 		= "N";
		prem_sts 		= "N";
		addprem_sts 	= "N";
		plrepay_sts 	= "N";
		apl_sts 		= "N";

		pl_close_msg 		= "현재 시스템 점검으로 인해 약관대출 신청이 당분간 불가합니다. 이용에 불편을 드려 죄송합니다.";
		div_close_msg 		= "현재 시스템 점검으로 인해 배당금 신청이 당분간 불가합니다. 이용에 불편을 드려 죄송합니다.";
		rest_close_msg 		= "현재 시스템 점검으로 인해 휴면보험금 신청이 당분간 불가합니다. 이용에 불편을 드려 죄송합니다.";
		divoff_close_msg 	= "현재 시스템 점검으로 인해 배당금상계 신청이 당분간 불가합니다. 이용에 불편을 드려 죄송합니다.";
		prem_close_msg 		= "현재 시스템 점검으로 인해 보험료수납 신청이 당분간 불가합니다. 이용에 불편을 드려 죄송합니다.";
		addprem_close_msg 	= "현재 시스템 점검으로 인해 추가보험료수납 신청이 당분간 불가합니다. 이용에 불편을 드려 죄송합니다.";
		plrepay_close_msg 	= "현재 시스템 점검으로 인해 약관대출상환 신청이 당분간 불가합니다. 이용에 불편을 드려 죄송합니다.";
		apl_close_msg 		= "현재 시스템 점검으로 인해 APL상환 신청이 당분간 불가합니다. 이용에 불편을 드려 죄송합니다.";
		
		save_sts		= "N";
		emp_no			= "cyber";
	}

	/**
	 * @return Returns the addprem_close_msg.
	 */
	public String getAddprem_close_msg() {
		return addprem_close_msg;
	}

	/**
	 * @param addprem_close_msg The addprem_close_msg to set.
	 */
	public void setAddprem_close_msg(String addprem_close_msg) {
		this.addprem_close_msg = addprem_close_msg;
	}

	/**
	 * @return Returns the addprem_sts.
	 */
	public String getAddprem_sts() {
		return addprem_sts;
	}

	/**
	 * @param addprem_sts The addprem_sts to set.
	 */
	public void setAddprem_sts(String addprem_sts) {
		this.addprem_sts = addprem_sts;
	}

	/**
	 * @return Returns the apl_close_msg.
	 */
	public String getApl_close_msg() {
		return apl_close_msg;
	}

	/**
	 * @param apl_close_msg The apl_close_msg to set.
	 */
	public void setApl_close_msg(String apl_close_msg) {
		this.apl_close_msg = apl_close_msg;
	}

	/**
	 * @return Returns the apl_sts.
	 */
	public String getApl_sts() {
		return apl_sts;
	}

	/**
	 * @param apl_sts The apl_sts to set.
	 */
	public void setApl_sts(String apl_sts) {
		this.apl_sts = apl_sts;
	}

	/**
	 * @return Returns the div_close_msg.
	 */
	public String getDiv_close_msg() {
		return div_close_msg;
	}

	/**
	 * @param div_close_msg The div_close_msg to set.
	 */
	public void setDiv_close_msg(String div_close_msg) {
		this.div_close_msg = div_close_msg;
	}

	/**
	 * @return Returns the div_sts.
	 */
	public String getDiv_sts() {
		return div_sts;
	}

	/**
	 * @param div_sts The div_sts to set.
	 */
	public void setDiv_sts(String div_sts) {
		this.div_sts = div_sts;
	}

	/**
	 * @return Returns the divoff_close_msg.
	 */
	public String getDivoff_close_msg() {
		return divoff_close_msg;
	}

	/**
	 * @param divoff_close_msg The divoff_close_msg to set.
	 */
	public void setDivoff_close_msg(String divoff_close_msg) {
		this.divoff_close_msg = divoff_close_msg;
	}

	/**
	 * @return Returns the divoff_sts.
	 */
	public String getDivoff_sts() {
		return divoff_sts;
	}

	/**
	 * @param divoff_sts The divoff_sts to set.
	 */
	public void setDivoff_sts(String divoff_sts) {
		this.divoff_sts = divoff_sts;
	}

	/**
	 * @return Returns the pl_close_msg.
	 */
	public String getPl_close_msg() {
		return pl_close_msg;
	}

	/**
	 * @param pl_close_msg The pl_close_msg to set.
	 */
	public void setPl_close_msg(String pl_close_msg) {
		this.pl_close_msg = pl_close_msg;
	}

	/**
	 * @return Returns the pl_sts.
	 */
	public String getPl_sts() {
		return pl_sts;
	}

	/**
	 * @param pl_sts The pl_sts to set.
	 */
	public void setPl_sts(String pl_sts) {
		this.pl_sts = pl_sts;
	}

	/**
	 * @return Returns the plrepay_close_msg.
	 */
	public String getPlrepay_close_msg() {
		return plrepay_close_msg;
	}

	/**
	 * @param plrepay_close_msg The plrepay_close_msg to set.
	 */
	public void setPlrepay_close_msg(String plrepay_close_msg) {
		this.plrepay_close_msg = plrepay_close_msg;
	}

	/**
	 * @return Returns the plrepay_sts.
	 */
	public String getPlrepay_sts() {
		return plrepay_sts;
	}

	/**
	 * @param plrepay_sts The plrepay_sts to set.
	 */
	public void setPlrepay_sts(String plrepay_sts) {
		this.plrepay_sts = plrepay_sts;
	}

	/**
	 * @return Returns the prem_close_msg.
	 */
	public String getPrem_close_msg() {
		return prem_close_msg;
	}

	/**
	 * @param prem_close_msg The prem_close_msg to set.
	 */
	public void setPrem_close_msg(String prem_close_msg) {
		this.prem_close_msg = prem_close_msg;
	}

	/**
	 * @return Returns the prem_sts.
	 */
	public String getPrem_sts() {
		return prem_sts;
	}

	/**
	 * @param prem_sts The prem_sts to set.
	 */
	public void setPrem_sts(String prem_sts) {
		this.prem_sts = prem_sts;
	}

	/**
	 * @return Returns the rest_close_msg.
	 */
	public String getRest_close_msg() {
		return rest_close_msg;
	}

	/**
	 * @param rest_close_msg The rest_close_msg to set.
	 */
	public void setRest_close_msg(String rest_close_msg) {
		this.rest_close_msg = rest_close_msg;
	}

	/**
	 * @return Returns the rest_sts.
	 */
	public String getRest_sts() {
		return rest_sts;
	}

	/**
	 * @param rest_sts The rest_sts to set.
	 */
	public void setRest_sts(String rest_sts) {
		this.rest_sts = rest_sts;
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