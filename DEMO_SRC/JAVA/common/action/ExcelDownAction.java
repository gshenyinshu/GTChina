/**
 * Title       : 
 * Description : 
 * Copyright   : Copyright (c) 2005
 * Company     : CyberImagination
 * @author     : Kim, BumJin
 * @version 1.0
 */    
package gtone.changeminer.common.action;
  
import org.apache.struts.action.*;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import anyframe.data.DataSet;



/**
 * @struts.action
 *      path="/excel"
 *      parameter="run"
 *      scope="request"
 *      validate="false"
 *
 * @struts.action-forward
 *      name="excel_down"
 *      path="/excel.jsp"
 *      redirect="false"
 *		test
 *
 */
public  class ExcelDownAction extends Action
{
    public ActionForward execute(ActionMapping mapping, ActionForm form, 
	    	HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try
		{
			String excel = request.getParameter("excel") == null ? "" : request.getParameter("excel");

            //////Excel instantiation
            ////// comment add
            excel = gtone.changeminer.common.utility.Utility.delTag(excel, "a");
            //////img src setting
            excel = gtone.changeminer.common.utility.Utility.delTagImg(excel, "img");
			
         //////   excel = gtone.changeminer.common.utility.Utility.selectToText(excel);

            request.setAttribute("excel", excel);

            return mapping.findForward("excel_down") ;
        }
        catch(Exception e)
        {
        	throw (e);
        }
	}

}
