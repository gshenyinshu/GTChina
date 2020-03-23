/**
 * Title       : login_check
 * Description : 좌측메뉴에서 "logout"눌렀을경우 세션 없앰
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : jung-hun Park
 * First Write : 2005.02.17
 */

package gtone.changeminer.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;

import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.utility.*;
import gtone.changeminer.payment.form.LogincheckForm;
import gtone.changeminer.payment.manager.CyberloginManager;
import gtone.changeminer.common.manager.SessionManager;


////ksps2000
import gtone.changeminer.payment.action.*;
import gtone.changeminer.payment.manager.*;

/**
 * @struts.action
 *      path="/login_check"
 *      name="logincheckForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="login_check"
 *      path="/login_check.jsp"
 *
 */
public  class LogincheckAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ LogincheckAction Start ####################");
			
			DataSet input  = new DataSet();	
			
			LogincheckForm logincheckForm = (LogincheckForm) form;
			////FormToDataset.copyProperties(input, plpaymentForm);	
			
			
			SessionManager sessionManager = new SessionManager(request);
			/*String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			*/
			

			////로그아웃했을경우
			String islogin = "";
			String login   = request.getParameter("login")	== null ? "Y" : request.getParameter("login");		
			anyframe.log.Logger.debug.println("LogincheckAction - 로긴 입력 login==========="+login);									
			if( login.equals("N") )
			{
				sessionManager.invalidate();////세션없앰
				islogin = "N";
			}
			
	        request.setAttribute("islogin", islogin);
	
	        return mapping.findForward("login_check");
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}