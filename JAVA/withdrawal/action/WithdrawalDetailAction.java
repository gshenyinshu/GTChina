
package gtone.changeminer.withdrawal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;


import gtone.changeminer.common.utility.*;
import gtone.changeminer.withdrawal.form.WithdrawalDetailForm;
import gtone.changeminer.withdrawal.manager.WithdrawalManager;

/**
 * @struts.action
 *      path="/policy_view" 
 *      name="WithdrawalForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="policy_view"
 *      path="/policy_view.jsp"
 *
 */
public class WithdrawalDetailAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
		throws Exception
	{
        
		try
		{
			boolean saveFlag = true;
			String strMessage = "";
			String save = request.getParameter("save") == null ? "N" : request.getParameter("save");
			String save_status = request.getParameter("save_status") == null ? "N" : request.getParameter("save_status");
			if("Y".equals(save)) {
				saveFlag = save(mapping, form, request, response);
				if(saveFlag == false) {
					strMessage = "�3�3�3�2�3�3 �2�5�5�9�6�9�2�1�2�8�9�1�9�9.";
				}else {
					if("Y".equals(save_status)) {
						strMessage = "�4�7�6�7�2�1�4�0 �1�8�5�1 �1�3�7�4�2�3 �1�0�7�0�6�9�2�1�2�8�9�1�9�9.";
					}else {
						strMessage = "�3�3�3�2�3�3 �1�0�7�0�6�9�2�1�2�8�9�1�9�9.";
					}
				}
			}

			Logger.debug.println("################ WithdrawalDetailAction Start ####################");

			DataSet input = new DataSet();

			WithdrawalDetailForm WithdrawalDetailForm = (WithdrawalDetailForm)form;

			FormToDataset.copyProperties(input, WithdrawalDetailForm);

//			String policy_no = request.getParameter("policy_no") == null ? "" : request.getParameter("policy_no");
//			String seq = request.getParameter("seq") == null ? "" : request.getParameter("seq");
			String policy_no = WithdrawalDetailForm.getPolicy_no();
			String seq = WithdrawalDetailForm.getSeq();

			String where = " and policy_no = '" + policy_no + "'"
								+ " and seq = '" + seq + "'";

			input.put("page", "0");
			input.put("where", where);           
			System.out.println(input);
			WithdrawalManager manager = WithdrawalManager.getInstance();

			DataSet withdrawal = manager.findList(input);

			// �3�1�2�1�3�5 �7�1�2�0�9�1 �8�9�3�0�3�5 �7�5�3�9�2�5�1�9 �6�7�9�0 �3�6�0�7�2�3 �6�7�9�0�6�9�8�9 �1�8�1�7 �8�9�2�2�3�5 �7�5�3�9�2�3.
			String deptcd 	= "INT";
			String init		= "     ";
			input = new DataSet();
			input.put("deptcd",    deptcd);
			input.put("init",      init);
			input.put("ssn",       withdrawal.getText("client_ssn"));

			DataSet contractsum = manager.selectContract(input);
			Logger.debug.println("�3�5�0�7�0�7�6�3 " + withdrawal.getText("client_ssn"));
			for(int i=0;i<contractsum.getCount("plcyno");i++) {
				
				if(policy_no.equals(contractsum.getText("plcyno", i))) {
					Logger.debug.println("------------------------------------------------------------------- �4�9�2�3�3�3." + policy_no + ":" + contractsum.getText("plcyno", i));
					request.setAttribute("svclpname", contractsum.getText("svclpname", i));
				}
			}

			request.setAttribute("withdrawal", withdrawal); // �4�7�6�7�2�1�4�0 �8�9�2�2

			request.setAttribute("policy_no", policy_no);
			request.setAttribute("seq",seq);
			request.setAttribute("strMessage",strMessage);

			Logger.debug.println("################ WithdrawalDetailAction End ####################");
			return mapping.findForward("withdrawal_detail");
		}
		catch(Exception e)
		{
			throw e;
		}
	}

	public boolean save(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
		  throws Exception
	  {
        
		  try
		  {
		  	System.out.println("�3�3�3�2�5�5�0�9�1�7�2�1 �2�7�3�2 -------->");
			String policy_no = request.getParameter("policy_no") == null ? "" : request.getParameter("policy_no");
			String seq = request.getParameter("seq") == null ? "" : request.getParameter("seq");
			String status_cd = request.getParameter("status_cd") == null ? "" : request.getParameter("status_cd");
			String memo = request.getParameter("memo") == null ? "" : request.getParameter("memo");

			String save_status = request.getParameter("save_status") == null ? "N" : request.getParameter("save_status");

			DataSet input = new DataSet();
			WithdrawalDetailForm WithdrawalDetailForm = (WithdrawalDetailForm)form;

			FormToDataset.copyProperties(input, WithdrawalDetailForm);

//			input.put("policy_no", policy_no);
//			input.put("seq", seq);
//			input.put("status_cd", status_cd);
//			input.put("memo", memo);
			String where = "";
			
			// �3�3�3�2 �0�2�2�8�3�3 Y�3�3�0�5 �4�9�0�5�3�1�3�1�0�7 �3�8�2�5 �8�0�3�3. �2�9) �3�0�2�1 -> �0�5�2�2, �3�0�2�1 -> �2�9�0�1 �3�1�9�5�0�7�3�9. 
			if("Y".equals(save_status)) {
				where = " , STATUS_CD ='" + WithdrawalDetailForm.getStatus_cd() + "'"
							+ " , CON_DATE   = getDate() "
							+ " , EMP_ID     = '" + WithdrawalDetailForm.getEmp_id() + "'";
			}
			input.put("where", where);
			System.out.println(input);
	WithdrawalManager manager = WithdrawalManager.getInstance();
	manager.save(input);
			return true;
		  }
		  catch(Exception e)
		  {
//				throw e;
		  		return false;
		  }
	  }
}

