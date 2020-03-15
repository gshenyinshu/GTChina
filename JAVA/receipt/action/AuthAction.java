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
import gtone.changeminer.receipt.form.AuthForm;
import gtone.changeminer.receipt.manager.AuthManager;
import gtone.changeminer.receipt.manager.CyberRecManager;
import gtone.changeminer.receipt.manager.PolicychangeManager;

////세션
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;


import java.lang.*; 
/**
 * @struts.action
 *      path="/auth_manager"
 *      name="AuthForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="auth_manager"
 *      path="/auth_manager.jsp"
 *
 */
public  class AuthAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			int POLICY_LIST_PAGE_SIZE = 20;
			Logger.debug.println("################ AuthAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet inputCount = new DataSet();
			DataSet input1  = new DataSet();	
			
			AuthForm authForm = (AuthForm) form;
			////FormToDataset.copyProperties(input, authForm);			
	             String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
	             String page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));	            
	             String flag = request.getParameter("flag") == null ? "" : request.getParameter("flag");
		      String emp_no = request.getParameter("emp_no") == null ? "" : request.getParameter("emp_no");
		      
		      
			      ////세션사용하기
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no1 = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
		       
		       String where = "";
		       String where1 = "";
		      
		      
		      anyframe.log.Logger.debug.println("Action flag==========="+flag);
		      anyframe.log.Logger.debug.println("Action emp_no==========="+emp_no);
		      
			AuthManager manager = AuthManager.getInstance();			
			
			if(flag.equals("D"))
			{
				input1.put("emp_no", emp_no);
				DataSet delval = manager.delAuth(input1);
				request.setAttribute("delval", delval);	
			}
			
			anyframe.log.Logger.debug.println("플래그의 길이==========="+flag.length());
			
			if(emp_no1.length() > 0)
			{
				if(!auth_cd.equals("40"))
				{
					where = where + " and emp_no ='"+emp_no1+"'"; 	
					where1 = where1 + " and emp_no ='"+emp_no1+"'";
				}	
			}
			
			
			input.put("page", page);
			input.put("where", where);
			input.put("subwhere", where);
			
			DataSet authval = manager.findAuth(input);
			
			
			inputCount.put("where", where);
			
			DataSet totalCount = manager.findAuthCount(inputCount);
			anyframe.log.Logger.debug.println("총갯수==========="+totalCount.getText("count"));
			request.setAttribute("authval", authval);	
			request.setAttribute("totalCount", totalCount.getText("count"));
              	request.setAttribute("current", current);
			
			
			
			return mapping.findForward("auth_manager");
	

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}