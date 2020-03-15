package gtone.changeminer.report.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.report.dao.SmslpDao;

import java.*;

public  class SmslpManager_New
{
	private SmslpManager_New()
	{}

	private static SmslpManager_New instance = null;

	public static SmslpManager_New getInstance()
	{
		if( instance == null )
			instance = new SmslpManager_New();

		return instance; 
	}

	public static SmslpManager_New getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////SMS Comment
	public DataSet findSmslp(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SmslpDao dao = getSmslpDao();
			output = dao.findSmslp(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	private SmslpDao getSmslpDao()
	{
		return new SmslpDao(); // instantiation
	}
}

