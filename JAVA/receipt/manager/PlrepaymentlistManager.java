package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PlrepaymentlistDao;

public  class PlrepaymentlistManager
{
	private PlrepaymentlistManager()
	{}

	private static PlrepaymentlistManager instance = null;

	public static PlrepaymentlistManager getInstance()
	{
		if( instance == null )
			instance = new PlrepaymentlistManager();

		return instance; 
	}

	public static PlrepaymentlistManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �8�5�9�7�4�9�3�9�0�5�8�5 �3�5�6�7.
	public DataSet findPlrepaymentlist(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlrepaymentlistDao dao = getPlrepaymentlistDao();
			output = dao.findPlrepaymentlist(input);
			
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
			PlrepaymentlistDao dao = getPlrepaymentlistDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
		
	private PlrepaymentlistDao getPlrepaymentlistDao()
	{
		return new PlrepaymentlistDao();
	}
}

