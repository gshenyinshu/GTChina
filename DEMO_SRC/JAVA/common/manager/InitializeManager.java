package gtone.changeminer.common.manager;

import anyframe.Configuration;
import anylogic.spi.management.BLContextFactory;

public  class InitializeManager
{
	public static void initConfig()
	{
		try
		{
			Configuration.getInitial().initialize();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	public static void reloadSchema()
	{
		try
		{
			BLContextFactory.getInstance().initialize();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}

