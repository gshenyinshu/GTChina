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
import gtone.changeminer.receipt.form.ReturncontentForm;
import gtone.changeminer.receipt.manager.ReturncontentManager;

import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/return_content"
 *      name="ReturncontentForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="return_content"
 *      path="/return_content.jsp"
 *
 */
 
public  class ReturncontentAction extends Action
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
			
			ReturncontentForm returncontentForm = (ReturncontentForm)form;
			
			ReturncontentManager manager = ReturncontentManager.getInstance();
			SessionManager sessionManager = new SessionManager(request);
			
			String indate = request.getParameter("indate")	== null ? "" : request.getParameter("indate");	
			String seq_no = request.getParameter("seq_no")	== null ? "" : request.getParameter("seq_no");	
			String srvc_gubun = request.getParameter("srvc_gubun")	== null ? "" : request.getParameter("srvc_gubun");	
			String status_code = request.getParameter("status_code")	== null ? "" : request.getParameter("status_code");	
			request.setAttribute("status_code",status_code);
			String prcode = "1";
			
			if(srvc_gubun.equals("A"))
			{
				input.put("table", "CYBER.DBO.CYBER_TBL_WB_MEMBER b");
			}
			else if( srvc_gubun.equals("B") || srvc_gubun.equals("D") || srvc_gubun.equals("C") )
			{
				input.put("table", "CYBER.DBO.CYBER_TBL_WB_ACCOUNT b");
			}
			else if( srvc_gubun.equals("E") || srvc_gubun.equals("F") )
			{
				input.put("table", "CYBER.DBO.CYBER_TBL_WB_AUTO_REPAYMENT b");
			}
			else if(srvc_gubun.equals("G") || srvc_gubun.equals("I") || srvc_gubun.equals("J") )
			{
				input.put("table", "CYBER.DBO.CYBER_TBL_WB_METHOD b");
			}			
			
			input.put("indate", indate);
			input.put("seq_no", seq_no);			
			input.put("prcode", prcode);
			
			
			DataSet selcontent = manager.Selcontent(input);
			request.setAttribute("selcontent", selcontent);					
			
			return mapping.findForward("return_content");
			
				
			
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}