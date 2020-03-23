/**
 * Title       : cyberindex
 * Description : cyberindex form
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

public class WithdrawalForm extends ActionForm{

    private String fromDate = null ; //form's creation date
    private String toDate = null ; // date
    private String statusCd = null; // status code 
	private String searchType = null;
	private String key = null;
    
	private int current = 1; // others..
   
//	private String confrim_process = null;
	
 	/**
     * form
     * @return  ActionErrors
     */ 

    public void reset(ActionMapping mapping, HttpServletRequest request){ 
        
/*        Calendar calendar 
            = Calendar.getInstance();
        
		fromDate=todayFormat.format(calendar.getTime());
        toDate  = todayFormat.format(calendar.getTime());
*/       
		fromDate = null ; //starting date
		toDate = null ; //ending date
		statusCd = null; //status code
		searchType = null;
		key = null;
	}

	
	/**
	 * @return
	 */
	public String getFromDate() {
		return fromDate;
	}

	/**
	 * @return
	 */
	public String getKey() {
		return key;
	}

	/**
	 * @return
	 */
	public String getSearchType() {
		return searchType;
	}

	/**
	 * @return
	 */
	public String getStatusCd() {
		return statusCd;
	}

	/**
	 * @return
	 */
	public String getToDate() {
		return toDate;
	}

	/**
	 * @param string
	 */
	public void setFromDate(String string) {
		fromDate = string;
	}

	/**
	 * @param string
	 */
	public void setKey(String string) {
		key = string;
	}

	/**
	 * @param string
	 */
	public void setSearchType(String string) {
		searchType = string;
	}

	/**
	 * @param string
	 */
	public void setStatusCd(String string) {
		statusCd = string;
	}

	/**
	 * @param string
	 */
	public void setToDate(String string) {
		toDate = string;
	}

}