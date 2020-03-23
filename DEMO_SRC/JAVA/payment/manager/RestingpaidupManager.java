package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.RestingpaidupDao;

public  class RestingpaidupManager
{
	private RestingpaidupManager()
	{}

	private static RestingpaidupManager instance = null;

	public static RestingpaidupManager getInstance()
	{
		if( instance == null )
			instance = new RestingpaidupManager();

		return instance; 
	}

	public static RestingpaidupManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////해당 증번에 대한 휴면보험금 display
	public DataSet findRestingpaidup(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RestingpaidupDao dao = getRestingpaidupDao();
			output = dao.findRestingpaidup(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////해당 증번에 대한 경과해약금및 기본 정보를 display
	public DataSet findPlcynoinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RestingpaidupDao dao = getRestingpaidupDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	public DataSet Inpayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RestingpaidupDao dao = getRestingpaidupDao();
			output = dao.Inpayment(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private RestingpaidupDao getRestingpaidupDao()
	{
		return new RestingpaidupDao();
	}
}

