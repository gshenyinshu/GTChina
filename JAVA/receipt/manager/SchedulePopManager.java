package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.SchedulePopDao;

public  class SchedulePopManager
{
	private SchedulePopManager()
	{}

	private static SchedulePopManager instance = null;

	public static SchedulePopManager getInstance()
	{
		if( instance == null )
			instance = new SchedulePopManager();

		return instance; 
	}

	public static SchedulePopManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////워킹데이검색
	public DataSet findWorking(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SchedulePopDao dao = getSchedulePopDao();
			output = dao.findWorking(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////워킹데이수정
	public DataSet findUpdateWorking(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SchedulePopDao dao = getSchedulePopDao();
			output = dao.findUpdateWorking(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	
	private SchedulePopDao getSchedulePopDao()
	{
		return new SchedulePopDao();
	}
}

