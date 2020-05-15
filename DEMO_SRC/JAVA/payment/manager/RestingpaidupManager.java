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
	
	////�ش� ������ ���� �޸麸��� display
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


	////�ش� ������ ���� ����ؾ�ݹ� �⺻ ������ display
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

