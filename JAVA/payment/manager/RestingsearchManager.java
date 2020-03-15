package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.RestingsearchDao;

public  class RestingsearchManager
{
	private RestingsearchManager()
	{}

	private static RestingsearchManager instance = null;

	public static RestingsearchManager getInstance()
	{
		if( instance == null )
			instance = new RestingsearchManager();

		return instance; 
	}

	public static RestingsearchManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �6�5�0�5�1�5�6�7�8�5�8�9�2�2�3�5display
	public DataSet findRestingsearch(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RestingsearchDao dao = getRestingsearchDao();
			output = dao.findRestingsearch(input);
			
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
			RestingsearchDao dao = getRestingsearchDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	public DataSet Inpayment(DataSet input, DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			RestingsearchDao dao = getRestingsearchDao();
			output = dao.Inpayment(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	public DataSet getApproval( DataSet input1, DataSet input, DataSet input2) throws Exception
	{
		try
		{
			DataSet output = null;
			RestingsearchDao dao = getRestingsearchDao();
			output = dao.getApproval(input1, input, input2);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}			

	private RestingsearchDao getRestingsearchDao()
	{
		return new RestingsearchDao();
	}
}

