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
import gtone.changeminer.receipt.form.ReturncForm;
import gtone.changeminer.receipt.manager.ReturncManager;
import gtone.changeminer.receipt.manager.CyberRecManager;
import gtone.changeminer.receipt.manager.PolicychangeManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/return_manager"
 *      name="ReturncForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="return_manager"
 *      path="/return_manager.jsp"
 *
 */
public  class ReturncAction extends Action
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
			
			ReturncForm returncForm = (ReturncForm) form;
			////FormToDataset.copyProperties(input, authForm);			
	             String current = request.getParameter("current") == null ? "1" : request.getParameter("current");
	             String page = String.valueOf(POLICY_LIST_PAGE_SIZE * (Integer.parseInt(current) - 1));	            
	             	             
	             String flag = request.getParameter("flag") == null ? "S" : request.getParameter("flag");
		      String c_id = request.getParameter("c_id") == null ? "" : request.getParameter("c_id");
		      String id    = request.getParameter("id") == null ? "" : request.getParameter("id");
		      String gubun    = request.getParameter("gubun") == null ? "S" : request.getParameter("gubun");
		      anyframe.log.Logger.debug.println("Action flag==========="+flag);
		      
			ReturncManager manager = ReturncManager.getInstance();			
			
			if(flag.equals("D"))
			{
				input1.put("c_id", c_id);
				input1.put("id", id);
				DataSet delval = manager.delReturnc(input1);
				request.setAttribute("delval", delval);					
			}
			
			anyframe.log.Logger.debug.println("플래그의 길이==========="+flag);
			input.put("page", page);
			DataSet returnval = manager.findReturnc(input);
			anyframe.log.Logger.debug.println("리스트의 갯수는"+returnval.getCount("c_id"));
			DataSet totalCount = manager.findReturncCount(inputCount);
			anyframe.log.Logger.debug.println("총갯수==========="+totalCount.getText("count"));
			
			request.setAttribute("returnval", returnval);	
			request.setAttribute("totalCount", totalCount.getText("count"));
              	request.setAttribute("current", current);
              	request.setAttribute("flag", flag);
              	request.setAttribute("c_id", c_id);
              	request.setAttribute("id", id);
			
			return mapping.findForward("return_manager");
	

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}


