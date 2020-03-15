package gtone.changeminer.monitor.manager;

import anyframe.data.DataSet;

import gtone.changeminer.monitor.dao.MoniteringprSearchDao;

public  class MoniteringprSearchManager
{
	private MoniteringprSearchManager()
	{}

	private static MoniteringprSearchManager instance = null;

	public static MoniteringprSearchManager getInstance()
	{
		if( instance == null )
			instance = new MoniteringprSearchManager();

		return instance; 
	}

	public static MoniteringprSearchManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�3�6�7�1�0�7�6�3�0�6 �8�5�5�3�3�4�1�5 select
	public DataSet findMonitorSearchList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringprSearchDao dao = getMoniteringprSearchDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findMonitorSearchList-----------------: "+input);				
			output = dao.findMonitorSearchList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�4�2�7�2�2�1
	public DataSet findMonitorSearch(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringprSearchDao dao = getMoniteringprSearchDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findMonitorSearch-----------------: "+input);					
			output = dao.findMonitorSearch(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////count
	/*
	public DataSet findMonitor_count(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringprSearchDao dao = getMoniteringprDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findMonitor_count-----------------: "+input);					
			output = dao.findMonitor_count(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	////list
	public DataSet findMonitor_sel(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringprSearchDao dao = getMoniteringprDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findMonitor_sel-----------------: "+input);					
			output = dao.findMonitor_sel(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	
	////update
	public DataSet findMonitor_upt(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringprSearchDao dao = getMoniteringprDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findMonitor_upt-----------------: "+input);					
			output = dao.findMonitor_upt(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	*/
	
	private MoniteringprSearchDao getMoniteringprSearchDao()
	{
		return new MoniteringprSearchDao();
	}
}

