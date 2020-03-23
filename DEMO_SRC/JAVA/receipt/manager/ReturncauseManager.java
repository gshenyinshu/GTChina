package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.ReturncauseDao;

public  class ReturncauseManager
{
	private ReturncauseManager()
	{}

	private static ReturncauseManager instance = null;

	public static ReturncauseManager getInstance()
	{
		if( instance == null )
			instance = new ReturncauseManager();

		return instance; 
	}

	public static ReturncauseManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////사유 저장(master)
	public DataSet uptReturnmaster(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturncauseDao dao = getReturncauseDao();
			output = dao.uptReturnmaster(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////사유 저장(detail)
	public DataSet uptReturndetail(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturncauseDao dao = getReturncauseDao();
			output = dao.uptReturndetail(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

			
	private ReturncauseDao getReturncauseDao()
	{
		return new ReturncauseDao();
	}
}

