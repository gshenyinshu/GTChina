package gtone.changeminer.monitor.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.monitor.dao.MoniteringreDao;

public  class MoniteringreManager
{
	private MoniteringreManager()
	{}

	private static MoniteringreManager instance = null;

	public static MoniteringreManager getInstance()
	{
		if( instance == null )
			instance = new MoniteringreManager();

		return instance; 
	}

	public static MoniteringreManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�3�6�7�1�0�7�6�3�0�6 �8�5�5�3�3�4�1�5 select
	public DataSet findMonitorList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringreDao dao = getMoniteringreDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findMonitorList-----------------: "+input);				
			output = dao.findMonitorList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�4�2�7�2�2�1
	public DataSet findMonitor(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringreDao dao = getMoniteringreDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findMonitor-----------------: "+input);					
			output = dao.findMonitor(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private MoniteringreDao getMoniteringreDao()
	{
		return new MoniteringreDao();
	}
}

