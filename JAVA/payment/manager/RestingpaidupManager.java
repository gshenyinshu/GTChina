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
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �6�5�0�5�1�5�6�7�8�5 display
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


	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �7�4�7�7�6�7�2�0�8�5�0�6 �8�5�1�9 �3�4�1�5�0�7 display
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

