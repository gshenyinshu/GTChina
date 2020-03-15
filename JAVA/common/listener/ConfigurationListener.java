/**
 * Title       : Configuration Listener
 * Description : context 가 시작될때, anyframe의 설정을 초기화
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author Dong-hyun Sohn
 * @version 1.0
 */

package gtone.changeminer.common.listener;

import java.net.URL;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletContextEvent;

import anyframe.Configuration;
import anylogic.spi.management.BLContextFactory;

import gtone.changeminer.common.utility.VariableLoader;
import gtone.changeminer.common.constant.Constant;

/**
 *	@web.listener
 */
public class ConfigurationListener implements ServletContextListener
{	
	ServletContext context = null;
	/* Application Startup Event */
	public void	contextInitialized(ServletContextEvent contextEvent)
	{
		try
		{
			context = contextEvent.getServletContext();

			setAnyframeConfig();
			initSiteVariable();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	/* Application Shutdown	Event */
	public void	contextDestroyed(ServletContextEvent ce) {}

	void setAnyframeConfig()
	{
		try
		{
			String config_xml      = context.getInitParameter("anyframe-config");
			String real_config_xml = context.getRealPath(config_xml);

			System.out.println("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
			System.out.println("ConfigFile Path : " + real_config_xml);
			System.out.println("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
			Configuration.setConfigFilePath(real_config_xml);

			//	config.xml
		//	Configuration.getInitial().initialize();

			//	io_schema
		//	BLContextFactory.getInstance().initialize();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	
	void initSiteVariable()
	{
		try
		{
			String mylp_xml = context.getInitParameter("pruhome-config");
			String real_mylp_xml = context.getRealPath(mylp_xml);
			Constant.setVariablePath(real_mylp_xml);
			VariableLoader.initialize(real_mylp_xml);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}


