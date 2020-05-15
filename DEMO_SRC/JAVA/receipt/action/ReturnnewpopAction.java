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
import gtone.changeminer.receipt.form.ReturnnewpopForm;
import gtone.changeminer.receipt.manager.ReturnnewpopManager;

import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;

import java.lang.*; 
/**
 * @struts.action
 *      path="/return_newpop"
 *      name="ReturnnewpopForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="return_newpop"
 *      path="/return_newpop.jsp"
 *
 */
 
public  class ReturnnewpopAction extends Action
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
			
			ReturnnewpopForm returnnewpopForm = (ReturnnewpopForm)form;
			
			ReturnnewpopManager manager = ReturnnewpopManager.getInstance();
			SessionManager sessionManager = new SessionManager(request);
			
			String flag = request.getParameter("flag")	== null ? "" : request.getParameter("flag");	
			String chkyn = request.getParameter("chkyn")	== null ? "" : request.getParameter("chkyn");	
			String cate_desc = request.getParameter("cate_desc")	== null ? "" : request.getParameter("cate_desc");	
			String c_id = request.getParameter("c_id")	== null ? "" : request.getParameter("c_id");	
			String id = request.getParameter("id")	== null ? "" : request.getParameter("id");	
			String return_cause = request.getParameter("return_cause")	== null ? "" : request.getParameter("return_cause");	
			////현재날짜 가져오기
			String chg_pwd_dt = null;
			String v_toyear = Util.getTodayToYMD();
			chg_pwd_dt = v_toyear.substring(0,4) + "-" + v_toyear.substring(4,6) +"-"+ v_toyear.substring(6);;
			
			anyframe.log.Logger.debug.println("flag==========="+flag);
			anyframe.log.Logger.debug.println("chkyn==========="+chkyn);
			anyframe.log.Logger.debug.println("c_id==========="+c_id);
			anyframe.log.Logger.debug.println("return_cause==========="+return_cause);
			anyframe.log.Logger.debug.println("id==========="+id);
			
			DataSet catedesc = manager.findReturndesc(input3);
			request.setAttribute("catedesc", catedesc);					
						
			anyframe.log.Logger.debug.println("catedesc갯수==========="+catedesc.getCount("c_id"));
										
			if(flag.equals("I") && chkyn.equals("Y"))
			{
				input.put("c_id", c_id);
				input.put("return_cause", return_cause);
				anyframe.log.Logger.debug.println("반송사유 입력할때 사용) input==========="+input);

				DataSet returnsave = manager.findReturnsave(input);
				request.setAttribute("returnsave", returnsave);					
			}
			else if(flag.equals("U") && chkyn.equals("Y"))
			{
				
				input1.put("id", id);
				input1.put("c_id", c_id);
				input1.put("return_cause", return_cause);
				
				DataSet returnupt = manager.Returnupt(input1);
				request.setAttribute("returnupt", returnupt);					
			}
			else if(flag.equals("U") && chkyn.equals(""))
			{
				input2.put("id", id);
				input2.put("c_id", c_id);
				DataSet searcon = manager.Selcon(input2);
				request.setAttribute("searcon", searcon);	
			}
			
			request.setAttribute("flag",flag);			
			request.setAttribute("chkyn",chkyn);
			request.setAttribute("c_id",c_id);
			request.setAttribute("id",id);
			request.setAttribute("cate_desc",cate_desc);
			request.setAttribute("return_cause",return_cause);
			
			
			return mapping.findForward("return_newpop");
				
			
		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}