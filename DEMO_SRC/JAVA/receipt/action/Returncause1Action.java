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
import gtone.changeminer.receipt.form.Returncause1Form;
import gtone.changeminer.receipt.manager.Returncause1Manager;

import gtone.changeminer.receipt.form.ReturnnewpopForm;
import gtone.changeminer.receipt.manager.ReturnnewpopManager;

import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/return_cause1"
 *      name="Returncause1Form"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="return_cause1"
 *      path="/return_cause1.jsp"
 *
 */
 
public  class Returncause1Action extends Action
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
			DataSet input3  = new DataSet();	
			DataSet input4  = new DataSet();
			
			ReturnnewpopManager catedesc = ReturnnewpopManager.getInstance();
			
			Returncause1Form returncause1Form = (Returncause1Form)form;
			
			Returncause1Manager manager = Returncause1Manager.getInstance();
			SessionManager sessionManager = new SessionManager(request);
			
			String flag 	= request.getParameter("flag")	== null ? "" : request.getParameter("flag");	
			String chkyn 	= request.getParameter("chkyn")	== null ? "" : request.getParameter("chkyn");	
						
			String indate 	= request.getParameter("indate")	== null ? "" : request.getParameter("indate");				
			String seq_no  = request.getParameter("seq_no")	== null ? "" : request.getParameter("seq_no");	
			String srvc_gubun  = request.getParameter("srvc_gubun")	== null ? "" : request.getParameter("srvc_gubun");							
			String c_id  = request.getParameter("c_id")	== null ? "" : request.getParameter("c_id");							
			
			input4.put("c_id", c_id);
			
			anyframe.log.Logger.debug.println("srvc_gubun==========="+srvc_gubun);
			anyframe.log.Logger.debug.println(" return_cause1 flag==========="+flag);
			anyframe.log.Logger.debug.println("return_cause1 chkyn==========="+chkyn);
			anyframe.log.Logger.debug.println("return_cause1 indate==========="+indate);
			anyframe.log.Logger.debug.println("return_cause1 seq_no==========="+seq_no);
			anyframe.log.Logger.debug.println("return_cause1 c_id==========="+c_id);

			
			if(flag.equals("S") || flag.equals("P"))
			{
				DataSet selcate = catedesc.findReturndesc(input);
				request.setAttribute("selcate", selcate);					
				
			}	
			
			if(flag.equals("P"))
			{
				DataSet catedescp = manager.selCatedesc(input4);
				request.setAttribute("catedescp", catedescp);													
			}

			request.setAttribute("flag",flag);			
			request.setAttribute("chkyn",chkyn);
			request.setAttribute("indate",indate);
			request.setAttribute("seq_no",seq_no);
			request.setAttribute("srvc_gubun",srvc_gubun);
			request.setAttribute("c_id",c_id);
			
			
			return mapping.findForward("return_cause1");
				
			
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}