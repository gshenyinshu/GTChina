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
import gtone.changeminer.payment.form.CyberloginForm;
import gtone.changeminer.payment.manager.CyberloginManager;
import gtone.changeminer.common.manager.SessionManager;




////ksps2000
import gtone.changeminer.payment.action.*;
import gtone.changeminer.payment.manager.*;

/**
 * @struts.action
 *      path="/cyber_login"
 *      name="cyberloginForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="cyber_login"
 *      path="/cyber_login.jsp"
 *
 * @struts.action-forward
 *      name="admin_main"
 *      path="/admin_main.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
public  class CyberloginAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ Cyberlogin Start ####################");

			DataSet input  = new DataSet();	
			
			CyberloginForm cyberloginForm = (CyberloginForm) form;
			////FormToDataset.copyProperties(input, plpaymentForm);		
				
			String id   = request.getParameter("id")	== null ? "" : request.getParameter("id");		
			String pw   = request.getParameter("pw")	== null ? "" : request.getParameter("pw");			
			String checkyn = request.getParameter("checkyn")	== null ? "N" : request.getParameter("checkyn");					
			String login = request.getParameter("login")	== null ? "Y" : request.getParameter("login");////�0�9�8�9�3�7�4�7�5�9				
			String emp_no = "";				
			String message = "";
			
			input.put("id", id);
			input.put("pw", pw);

			CyberloginManager manager = CyberloginManager.getInstance();
			SessionManager sessionManager = new SessionManager(request);
			
			
			String rslt = "-1";
			if( login.equals("Y") )
			{				
				if(checkyn.equals("Y"))
				{
					DataSet cyberlogin 	= manager.findLogin(input);			
	 				request.setAttribute("cyberlogin", cyberlogin);
					
					emp_no = cyberlogin.getText("emp_no");
					if(emp_no.length() == 0)
				    {
				    	rslt = "1";
				    }
				    else
				    {
	            		sessionManager.set(Constant.SESSION_USERID, cyberlogin.getText("emp_no"));
	            		sessionManager.set(Constant.SESSION_USERNAME, cyberlogin.getText("emp_nm"));
	            		sessionManager.set(Constant.SESSION_LEVEL, cyberlogin.getText("auth_cd"));
						rslt = "2";
				    }
				}
				else
				{
					rslt = "3";	
				}
			}	
			else
			{	
				sessionManager.invalidate();
				request.setAttribute("login", "N");////�0�9�8�9�3�7�2�1�1�5 �4�7�5�9
				rslt = "3";
			}
			
			if( rslt.equals("1") )
			{
            	message = "�0�9�8�9�3�4�1�5�7�5 �5�5�0�2�9�1�9�9. �6�2�3�7�6�3 �9�9�2�7 �0�9�8�9�6�9�1�7�3�9.";
	           	String msg = message;
	        	String url = "/payment/cyber_login.do";
	        	request.setAttribute("message", msg);	
	        	request.setAttribute("toURL", url);	
	        	return mapping.findForward("alert");
		    }
		    if( rslt.equals("2") )
			{
				return mapping.findForward("admin_main");
			}
		    else
		    {
				return mapping.findForward("cyber_login");
			}
			
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}