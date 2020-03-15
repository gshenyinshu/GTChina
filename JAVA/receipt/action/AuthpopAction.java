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
import gtone.changeminer.receipt.form.AuthpopForm;
import gtone.changeminer.receipt.manager.AuthpopManager;

import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;
import java.lang.*; 
/**
 * @struts.action
 *      path="/auth_pop"
 *      name="AuthpopForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="auth_pop"
 *      path="/auth_pop.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"    
 */
 
public  class AuthpopAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ AuthpopAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();////�9�4�0�0�2�7 �3�6�1�6�4�7�5�9

			AuthpopForm authpopForm = (AuthpopForm)form;
			
			AuthpopManager manager = AuthpopManager.getInstance();
			
			SessionManager sessionManager = new SessionManager(request);
			
			String flag = request.getParameter("flag")	== null ? "" : request.getParameter("flag");	
			String chkyn = request.getParameter("chkyn")	== null ? "" : request.getParameter("chkyn");	
			String emp_no = request.getParameter("emp_no")	== null ? "" : request.getParameter("emp_no");	
			String pwd = request.getParameter("pwd")	== null ? "" : request.getParameter("pwd");	
			String emp_nm = request.getParameter("emp_nm")	== null ? "" : request.getParameter("emp_nm");	
			String auth_cd = request.getParameter("auth_cd")	== null ? "" : request.getParameter("auth_cd");	
			String team_nm = request.getParameter("team_nm")	== null ? "" : request.getParameter("team_nm");	
			String old_pwd = request.getParameter("old_pwd")	== null ? "" : request.getParameter("old_pwd");	
			String hand_phone = request.getParameter("hand_phone")	== null ? "" : request.getParameter("hand_phone");
			String hand_phone_yn = request.getParameter("hand_phone_yn")	== null ? "" : request.getParameter("hand_phone_yn");
			String email = request.getParameter("email")	== null ? "" : request.getParameter("email");
			String email_yn = request.getParameter("email_yn")	== null ? "" : request.getParameter("email_yn");

			////�6�1�3�9�8�9�3�9 �7�5�3�9�2�7�8�5
			String chg_pwd_dt = null;
			String v_toyear = Util.getTodayToYMD();
			chg_pwd_dt = v_toyear.substring(0,4) + "-" + v_toyear.substring(4,6) +"-"+ v_toyear.substring(6);;
			
			
			anyframe.log.Logger.debug.println("flag==========="+flag);
			/*
			anyframe.log.Logger.debug.println("chkyn==========="+chkyn);
			anyframe.log.Logger.debug.println("emp_no==========="+emp_no);
			anyframe.log.Logger.debug.println("pwd==========="+pwd);
			anyframe.log.Logger.debug.println("emp_nm==========="+emp_nm);
			anyframe.log.Logger.debug.println("auth_cd==========="+auth_cd);
			anyframe.log.Logger.debug.println("team_nm==========="+team_nm);
			anyframe.log.Logger.debug.println("old_pwd==========="+old_pwd);
			anyframe.log.Logger.debug.println("chg_pwd_dt==========="+chg_pwd_dt);
			*/
			
			
			if(flag.equals("I"))
			{	
				////�1�7�0�7	
				if(emp_no.length() == 0) 
				{
					emp_no = sessionManager.getString(Constant.SESSION_USERID);
				}
				////�3�3�0�5
				if(emp_nm.length() == 0)
				{
					emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);		
				}
				
				////�7�1�6�3
				if(auth_cd.length() == 0)
				{
					auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
				}
			}
					
			String dup_no = "";
			String rslt = "-1";
			if(flag.equals("I") && chkyn.equals("Y"))
			{
				////�9�4�0�0�2�7 �3�6�1�6�4�7�5�9
				input3.put("emp_no", emp_no);
				DataSet auth_dup = manager.findAuth_dup(input3);
				dup_no = auth_dup.getText("cnt");
				anyframe.log.Logger.debug.println("�7�1�6�3 �3�0�0�4�6�7�9�5 �1�7�3�0(�3�6�1�6�4�7�5�9)  - dup_no==========="+dup_no);
				
				if( dup_no.equals("0") )
				{
					input.put("emp_no", emp_no);
					input.put("pwd", pwd);
					input.put("emp_nm", emp_nm);
					input.put("auth_cd", auth_cd);
					input.put("team_nm", team_nm);
					input.put("old_pwd", old_pwd);
					input.put("chg_pwd_dt", chg_pwd_dt);
					input.put("hand_phone", hand_phone);
					input.put("hand_phone_yn", hand_phone_yn);
					input.put("email", email);
					input.put("email_yn", email_yn);

					anyframe.log.Logger.debug.println("�7�1�6�3 �3�0�0�4�6�7�9�5 �1�7�3�0) input==========="+input);
	
					DataSet authsave = manager.findAuthsave(input);
					rslt = authsave.getText("rslt");
					if( rslt.equals("0") ) rslt = "-3";
					anyframe.log.Logger.debug.println("�7�1�6�3 �3�0�0�4�6�7�9�5 �1�7�3�0) rslt==========="+rslt);
					request.setAttribute("authsave", authsave);					
				}
				else
				{
					rslt = "-2";////�3�6�1�6ID
					anyframe.log.Logger.debug.println("�7�1�6�3 �3�0�0�4�6�7�9�5 �1�7�3�0(�3�6�1�6�4�7�5�9)  - rslt==========="+rslt);
				}
			}
			else if(flag.equals("U") && chkyn.equals("Y"))
			{
				
				input1.put("pwd", pwd);
				input1.put("emp_nm", emp_nm);
				input1.put("auth_cd", auth_cd);
				input1.put("team_nm", team_nm);
				input1.put("old_pwd", old_pwd);
				input1.put("chg_pwd_dt", chg_pwd_dt);
				input1.put("emp_no", emp_no);
				input1.put("hand_phone", hand_phone);
				input1.put("hand_phone_yn", hand_phone_yn);
				input1.put("email", email);
				input1.put("email_yn", email_yn);
				anyframe.log.Logger.debug.println("�7�1�6�3 �2�1�3�4�6�7�9�5 �1�7�3�0) input1==========="+input1);
				
				DataSet authupt = manager.Authupt(input1);
				rslt = authupt.getText("rslt");
				if( rslt.equals("0") ) rslt = "-4";
				anyframe.log.Logger.debug.println("�7�1�6�3 �2�1�3�4�6�7�9�5 �1�7�3�0) rslt==========="+rslt);
				request.setAttribute("authupt", authupt);					
			}

			request.setAttribute("flag",flag);
			request.setAttribute("chkyn",chkyn);
			request.setAttribute("emp_no",emp_no);
			request.setAttribute("pwd",pwd);
			request.setAttribute("emp_nm",emp_nm);
			request.setAttribute("auth_cd",auth_cd);
			request.setAttribute("team_nm",team_nm);
			request.setAttribute("old_pwd",old_pwd);
			request.setAttribute("chg_pwd_dt",chg_pwd_dt);
			request.setAttribute("hand_phone",hand_phone);
			request.setAttribute("hand_phone_yn",hand_phone_yn);
			request.setAttribute("email",email);
			request.setAttribute("email_yn",email_yn);

        	/****** �0�3�2�7�3�1 - S ******/ 
		    int success = 0;
			String message = "";
		    success = Integer.parseInt(rslt);
		    switch(success)
		    {
		        case(-2) :
		            message = "�3�6�1�6�9�1 ID(�1�7�0�7)�3�0�9�1�9�9. ";
		            break;		            
		        case(-3) :
		           message = "�3�4�1�8�3�4�3�7�0�9 �9�4�0�0�9�7�2�5�2�8�9�1�9�9. ";
		            break;
		        case(-4) :
		           message = "�3�4�1�8�3�4�3�7�0�9 �2�1�3�4�9�7�2�5�2�8�9�1�9�9. ";
		            break;
		        default :
		            message = "�2�5�5�9�6�9�2�1�2�8�9�1�9�9. ";
		            break;
		    }
		    anyframe.log.Logger.debug.println("�7�1�6�3 �3�0�0�4�6�7�9�5 �1�7�3�0(�3�6�1�6�4�7�5�9)  - message==========="+message);
		    
		    
			if( !rslt.equals("-1") )
			{
            	String msg = message;
            	String url = "/receipt/auth_pop.do";
            	request.setAttribute("message", msg);	
            	request.setAttribute("toURL", url);	
            	
            	if( flag.equals("I") || flag.equals("U") )////�3�0�0�4,�2�1�3�4�2�7
            	{
            		request.setAttribute("check_form", "Y");
            	}
            	return mapping.findForward("alert");
		    }
		    else
		    {
				return mapping.findForward("auth_pop");
			}
			/****** �0�3�2�7�3�1 - E ******/ 
				
			
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}