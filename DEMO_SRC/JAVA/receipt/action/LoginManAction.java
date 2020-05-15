/**
 * Title       	: LoginManAction.java
 * Description 	: 홈페이지 사이버 센터 로그인 상태 변경 
 * Company     : gtone
 * @author 	: Kim Bo Young
 * @version 1.0
 */

package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.LoginManForm;
import gtone.changeminer.receipt.manager.LoginManManager;
////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;


import java.lang.*; 
/**
 * @struts.action
 *    path="/login_manager"
 *    type="gtone.changeminer.receipt.action.LoginManAction"
 *    name="loginManForm"
 *    scope="request"
 *    unknown="false"
 *    validate="false"
 *
 * @struts.action-forward
 *      name="login_manager"
 *      path="/login_manager.jsp"
 *      redirect="false"
 *
 */

public  class LoginManAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ LoginManAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet output = new DataSet();
			
			LoginManForm loginManForm = (LoginManForm) form;
			FormToDataset.copyProperties(input, loginManForm);
			
			LoginManManager manager = LoginManManager.getInstance();
			
			String save_sts 		= input.getText("save_sts");
			
			if(save_sts.equals("Y")){
				////save login status 
				manager.changeLoginSts(input);
			}
			
			////get login status
			output = manager.getLoginSts(input);
			request.setAttribute("logininfo", output);
			
    		Logger.debug.println("################ LoginManAction End ####################");
			
			return mapping.findForward("login_manager");
	

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}