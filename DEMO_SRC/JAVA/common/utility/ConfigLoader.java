package gtone.changeminer.common.utility;

import java.util.*;

import anyframe.*;

public  class ConfigLoader 
{
	private static Config    config = null;

	static
	{  
		try
		{
			initialize();
		}
		catch ( Exception e )
		{ 
			e.printStackTrace();
		}
	}

	private static void initialize() throws Exception
	{
		try
		{
			if ( config == null )
			{
				config = Configuration.lookup("/config");
				System.out.println("config : " + config);
			}

			////// return config;
		}
		catch( Exception e )
		{
			e.printStackTrace();
			//////throw(e);
		}
	}

	public static String getConfig(String attribute) throws Exception
	{
		if (config == null)
		{
			initialize();
		}
		System.out.println("config.file : " + System.getProperty("config.file"));
		System.out.println("user.dir : " + System.getProperty("user.dir"));
		System.out.println("getConfigFilePath() : " + Configuration.getConfigFilePath());
		System.out.println("(getConfig) config : " + config);
		System.out.println("config.getString("+attribute+")");
		System.out.println("config.getString("+attribute+") : " + config.getString(attribute));
		return config.getString(attribute);
	}
}