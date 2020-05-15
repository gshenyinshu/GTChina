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
import gtone.changeminer.receipt.form.NewcategoryForm;
import gtone.changeminer.receipt.manager.NewcategoryManager;

import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/new_category"
 *      name="NewcategoryForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="new_category"
 *      path="/new_category.jsp"
 *
 */
 
public  class NewcategoryAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ NewcategoryAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet input1  = new DataSet();	
			DataSet input2  = new DataSet();	
			DataSet input3  = new DataSet();	
			
			NewcategoryForm newcategoryForm = (NewcategoryForm)form;
			
			NewcategoryManager manager = NewcategoryManager.getInstance();
			SessionManager sessionManager = new SessionManager(request);
			
			String flag = request.getParameter("flag")	== null ? "" : request.getParameter("flag");	
			String chkyn = request.getParameter("chkyn")	== null ? "" : request.getParameter("chkyn");	
			String category  = request.getParameter("category")	== null ? "" : request.getParameter("category");	
			
			anyframe.log.Logger.debug.println("flag==========="+flag);
			anyframe.log.Logger.debug.println("chkyn==========="+chkyn);
			anyframe.log.Logger.debug.println("category==========="+category);
			
										
			if(flag.equals("I") && chkyn.equals("Y"))
			{
				input.put("cate_desc",category);
				anyframe.log.Logger.debug.println("카테고리 입력할때 사용) input==========="+input);

				DataSet catesave = manager.categorySave(input);
				request.setAttribute("catesave", catesave);					
			}
			
			
			request.setAttribute("flag",flag);			
			request.setAttribute("chkyn",chkyn);
			
			request.setAttribute("category",category);
			
			return mapping.findForward("new_category");
				
			
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}