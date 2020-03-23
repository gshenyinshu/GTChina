package gtone.changeminer.receipt.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import anyframe.data.DataSet;
import anyframe.log.*;
import java.util.*;////Vector�� ���
import anyframe.*;
import anyframe.util.*;////StringFormater.fillZero(String,int)
import java.util.List;

import gtone.changeminer.common.action.*;
import gtone.changeminer.common.utility.*;
import gtone.changeminer.receipt.form.PolicyReissueForm;
import gtone.changeminer.receipt.manager.PolicyReissueManager;

////����
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;


/**
 * @struts.action
 *      path="/policy_reissue_pop" 
 *      name="policyreissueForm"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="policy_reissue_pop"
 *      path="/policy_reissue_pop.jsp"
 *
 * @struts.action-forward
 *      name="alert"
 *      path="/alert.jsp"   
 */
 
 
public  class PolicyReissuePopAction extends Action
{
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
    throws Exception
    {
        
        int POLICY_LIST_PAGE_SIZE = 20;
        
        try
        {
            Logger.debug.println("################ PolicyReissuePopAction Start ####################");

            DataSet input = new DataSet();
            DataSet input0 = new DataSet();
            DataSet input1 = new DataSet();////������Ʈ
            DataSet input2 = new DataSet();
            
            PolicyReissueForm policyreissueForm = (PolicyReissueForm)form;
            FormToDataset.copyProperties(input, policyreissueForm);
			
	     	PolicyReissueManager manager = PolicyReissueManager.getInstance();
			
			////���ǻ���ϱ�
			SessionManager sessionManager = new SessionManager(request);
			String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
			String emp_no = sessionManager.getString(Constant.SESSION_USERID);
			String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);

			
			/****************************************************************/
			////��ȸ - S
			List policyReissue_list = manager.findPolicyReissue_pop_list1(input);
			request.setAttribute("policyReissue_list", policyReissue_list);
			////��ȸ - E
			/****************************************************************/
			
			
			
			/****************************************************************/
			////���¾�����Ʈ - S
        	////web-DB�� ����
        	String policy ="";////����
	        String indate ="";////��������
	        String subcode ="";////�����
	        String param_value ="";////����+��������
	        
	        Vector v_chkcode = new Vector();		
	        int ct  = 0;
	        String chk_code_v = input.getText("chk_code");
        	StringTokenizer stk = new StringTokenizer(chk_code_v, "/");
        	while (stk.hasMoreTokens()) {
        		v_chkcode.addElement(stk.nextToken());				
        		ct++;
        	}
			anyframe.log.Logger.debug.println("������������� - üũ�� :  ct -----------------: "+ct);	
			
			for (int j=0; j<ct; j++)
			{
			    param_value = (String)v_chkcode.elementAt(j);
				anyframe.log.Logger.debug.println("������������� - �����(for��) :  param_value-----------------: "+param_value);					    
				
				if(	param_value.length() >0 ) 
				{
					policy = param_value.substring(0,10);
					indate = param_value.substring(10,18);		
					subcode = param_value.substring(18);

					if( subcode.equals("����") )
					{
						subcode = "H";
					}
					else
					{
						subcode = "O";
					}
					
					input1.put("label_yn",  	"Y");
					input1.put("indate",  		indate);////��������
			    	input1.put("policy",  		policy);////����
			    	input1.put("code",    		"3");////�������������
			    	input1.put("subcode", 		subcode);////�������������
			    	anyframe.log.Logger.debug.println("������������� - update :  input1 -----------------: "+input1);					    			        	
			    	
					DataSet policyReissue_label_upt = manager.findPolicyReissue_label_upt(input1);
				}		    
			}////end-for
			////���¾�����Ʈ - E
			/****************************************************************/


            Logger.debug.println("################ PolicyReissuePopAction End ####################");
        	
        	
			return mapping.findForward("policy_reissue_pop");
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
}