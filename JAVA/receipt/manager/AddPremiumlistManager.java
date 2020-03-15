package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AddPremiumlistDao;

public  class AddPremiumlistManager
{
	private AddPremiumlistManager()
	{}

	private static AddPremiumlistManager instance = null;

	public static AddPremiumlistManager getInstance()
	{
		if( instance == null )
			instance = new AddPremiumlistManager();

		return instance; 
	}

	public static AddPremiumlistManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �1�5�6�7�0�1 �8�9�2�2�3�5display
	public DataSet findPremiumlist(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AddPremiumlistDao dao = getPremiumlistDao();
			output = dao.findPremiumlist(input);
			
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
			AddPremiumlistDao dao = getPremiumlistDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private AddPremiumlistDao getPremiumlistDao()
	{
		return new AddPremiumlistDao();
	}
}

