package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;
import java.util.*;////StringTokenizer에 사용
import anyframe.util.*;////StringFormater
import anyframe.*;


import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.StatiForm;
import gtone.changeminer.receipt.manager.StatiManager;
import gtone.changeminer.receipt.manager.CyberRecManager;
import gtone.changeminer.receipt.manager.PolicychangeManager;

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;


import java.lang.*; 
/**
 * @struts.action
 *      path="/stati_manager"
 *      name="StatiForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="stati_manager"
 *      path="/stati_manager.jsp"
 *
 */
public  class StatiAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			
			Logger.debug.println("################ StatiAction Start ####################");

			DataSet input  = new DataSet();	
			
			
			StatiForm authForm = (StatiForm) form;
	          
		      
			////세션사용하기
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no1 = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
		    String chkYn = "N";   
		    String where = "";
		      
			StatiManager manager = StatiManager.getInstance();			
			
			if(chkYn.equals("Y"))
			{
				where = where + "";
			}
			
			input.put("where", where);
			
			DataSet statival = manager.findStati(input);
			
			request.setAttribute("statival", statival);	
			
			
			return mapping.findForward("stati_manager");
	

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}