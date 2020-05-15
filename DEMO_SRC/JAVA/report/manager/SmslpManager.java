package gtone.changeminer.report.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.report.dao.SmslpDao;

public  class SmslpManager
{
	private SmslpManager()
	{}

	private static SmslpManager instance = null;

	public static SmslpManager getInstance()
	{
		if( instance == null )
			instance = new SmslpManager();

		return instance; 
	}

	public static SmslpManager getInstance(boolean newInstance)
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

