package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.ReturnreasonDao;

public  class ReturnreasonManager
{
	private ReturnreasonManager()
	{}

	private static ReturnreasonManager instance = null;

	public static ReturnreasonManager getInstance()
	{
		if( instance == null )
			instance = new ReturnreasonManager();

		return instance; 
	}

	public static ReturnreasonManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////반송사유
	public DataSet findReturnreason(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnreasonDao dao = getReturnreasonDao();
			output = dao.findReturnreason(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private ReturnreasonDao getReturnreasonDao()
	{
		return new ReturnreasonDao();
	}
}

