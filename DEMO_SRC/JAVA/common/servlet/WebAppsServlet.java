package gtone.changeminer.common.servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

import anyframe.log.*;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.config.ModuleConfig;
import org.apache.struts.util.RequestUtils;

/**
 * @web.servlet name="action" 
 * 				display-name="Struts Action Servlet"
 * 				load-on-startup="1" 
 * 
 * @web.servlet-init-param 	name="config" 
 * 							value="/WEB-INF/struts-config.xml" 
 * @web.servlet-init-param 	name="config/common"
 * 							value="/WEB-INF/struts-config-common.xml"
 * @web.servlet-init-param 	name="config/close"
 * 							value="/WEB-INF/struts-config-close.xml"
 * @web.servlet-init-param 	name="config/monitor"     
 * 							value="/WEB-INF/struts-config-monitor.xml"
 * @web.servlet-init-param 	name="config/payment"
 * 							value="/WEB-INF/struts-config-payment.xml"
 * @web.servlet-init-param 	name="config/receipt"
 * 							value="/WEB-INF/struts-config-receipt.xml"
 * @web.servlet-init-param 	name="config/report"
 * 							value="/WEB-INF/struts-config-report.xml"
 * @web.servlet-init-param 	name="config/return"
 * 							value="/WEB-INF/struts-config-return.xml"
  *   
 * @web.servlet-init-param 	name="debug" 
 * 							value="0" 
 *   
 * @web.servlet-mapping url-pattern="*.do"
 */
public  class WebAppsServlet extends ActionServlet
{ 
	protected void process(HttpServletRequest request, HttpServletResponse response)
		throws IOException, ServletException 
	{
		try 
		{
			String uri = request.getRequestURI();
			String remoteAddr = request.getRemoteAddr();
   
			Logger.debug.println("************************************************");
			Logger.debug.println(uri);
			Logger.debug.println("Access IP : " + remoteAddr);
			Logger.debug.println("************************************************");

			if (uri.indexOf("reload.do") != -1)
			{
				init();  

				RequestUtils.selectModule(request, getServletContext());
				ModuleConfig config = getModuleConfig(request);
				getRequestProcessor(config).init(this, config);

				RequestDispatcher dispatcher = request.getRequestDispatcher("/reload.jsp");
				dispatcher.forward(request, response);
			}
			else
			{
				super.process(request, response);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
};



