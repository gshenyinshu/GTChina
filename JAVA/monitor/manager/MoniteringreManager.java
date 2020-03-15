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

	////증권번호및 기타정보 select
	public DataSet findMonitorList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringreDao dao = getMoniteringreDao();
			anyframe.log.Logger.debug.println("manage에서 findMonitorList-----------------: "+input);				
			output = dao.findMonitorList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////총갯수
	public DataSet findMonitor(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringreDao dao = getMoniteringreDao();
			anyframe.log.Logger.debug.println("manage에서 findMonitor-----------------: "+input);					
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

