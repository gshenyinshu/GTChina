/**
 * Title       	: InoutManAction.java
 * Description 	: �6�9�5�1�3�3�3�1 �1�7�3�3�0�3 �1�1�5�5 �3�0�4�9�8�5 �1�8�5�1 �1�3�7�4 
 * Company     : gtone
 * @author 	: Kim Bo Young
 * @version 1.0
 */

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
import gtone.changeminer.receipt.form.InoutManForm;
import gtone.changeminer.receipt.manager.InoutManManager;
////�1�7�1�9
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.manager.SessionManager;


import java.lang.*; 
/**
 * @struts.action
 *    path="/inout_manager"
 *    type="gtone.changeminer.receipt.action.InoutManAction"
 *    name="inoutManForm"
 *    scope="request"
 *    unknown="false"
 *    validate="false"
 *
 * @struts.action-forward
 *      name="inout_manager"
 *      path="/inout_manager.jsp"
 *      redirect="false"
 *
 */
public  class InoutManAction extends Action
{
	public ActionForward execute(ActionMapping mapping,	
								 ActionForm form,
								 HttpServletRequest request,
								 HttpServletResponse response)
		throws Exception
	{
		try
		{
			Logger.debug.println("################ InoutManAction Start ####################");

			DataSet input  = new DataSet();	
			DataSet output = new DataSet();
			
			InoutManForm inoutManForm = (InoutManForm) form;
			FormToDataset.copyProperties(input, inoutManForm);
			
			InoutManManager manager = InoutManManager.getInstance();
			
			String save_sts 		= input.getText("save_sts");
			
			if(save_sts.equals("Y")){
				////save inout status 
				manager.changeInoutSts(input);
			}
			
			////get inout status
			output = manager.getInoutSts(input);
			request.setAttribute("inoutinfo", output);
			
    		Logger.debug.println("################ InoutManAction End ####################");
			
			return mapping.findForward("inout_manager");
	

		}
		catch (Exception e)
		{
			throw(e);
		}
	}
}