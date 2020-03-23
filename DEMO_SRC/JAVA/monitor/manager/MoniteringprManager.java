package gtone.changeminer.monitor.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.monitor.dao.MoniteringprDao;

public  class MoniteringprManager
{
	private MoniteringprManager()
	{}

	private static MoniteringprManager instance = null;

	public static MoniteringprManager getInstance()
	{
		if( instance == null )
			instance = new MoniteringprManager();

		return instance; 
	}

	public static MoniteringprManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////���ǹ�ȣ�� ��Ÿ���� select
	public DataSet findMonitorList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringprDao dao = getMoniteringprDao();
			anyframe.log.Logger.debug.println("manage���� findMonitorList-----------------: "+input);				
			output = dao.findMonitorList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�Ѱ���
	public DataSet findMonitor(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringprDao dao = getMoniteringprDao();
			anyframe.log.Logger.debug.println("manage���� findMonitor-----------------: "+input);					
			output = dao.findMonitor(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////count
	public DataSet findMonitor_count(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			MoniteringprDao dao = getMoniteringprDao();
			anyframe.log.Logger.debug.println("manage���� findMonitor_count-----------------: "+input);					
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
			MoniteringprDao dao = getMoniteringprDao();
			anyframe.log.Logger.debug.println("manage���� findMonitor_sel-----------------: "+input);					
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
			MoniteringprDao dao = getMoniteringprDao();
			anyframe.log.Logger.debug.println("manage���� findMonitor_upt-----------------: "+input);					
			output = dao.findMonitor_upt(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private MoniteringprDao getMoniteringprDao()
	{
		return new MoniteringprDao();
	}
}

