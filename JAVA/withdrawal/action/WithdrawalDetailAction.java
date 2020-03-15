
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
					strMessage = "저장이 실패하였습니다.";
				}else {
					if("Y".equals(save_status)) {
						strMessage = "철회신청 상태 변경에 성공하였습니다.";
					}else {
						strMessage = "저장이 성공하였습니다.";
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

			// 자신의 계약된 내용을 가져와서 해당 증번에 해당하는 상세 내역을 가져옴.
			String deptcd 	= "INT";
			String init		= "     ";
			input = new DataSet();
			input.put("deptcd",    deptcd);
			input.put("init",      init);
			input.put("ssn",       withdrawal.getText("client_ssn"));

			DataSet contractsum = manager.selectContract(input);
			Logger.debug.println("주민번호 " + withdrawal.getText("client_ssn"));
			for(int i=0;i<contractsum.getCount("plcyno");i++) {
				
				if(policy_no.equals(contractsum.getText("plcyno", i))) {
					Logger.debug.println("------------------------------------------------------------------- 찾았음." + policy_no + ":" + contractsum.getText("plcyno", i));
					request.setAttribute("svclpname", contractsum.getText("svclpname", i));
				}
			}

			request.setAttribute("withdrawal", withdrawal); // 철회신청 내역

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
		  	System.out.println("저장프로세스 시작 -------->");
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
			
			// 저장 방식이 Y이면 처리일자를 집어 넣음. 예) 접수 -> 반송, 접수 -> 완료 일때만임. 
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

