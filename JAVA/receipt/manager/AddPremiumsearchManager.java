package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AddPremiumsearchDao;

public  class AddPremiumsearchManager
{
	private AddPremiumsearchManager()
	{}

	private static AddPremiumsearchManager instance = null;

	public static AddPremiumsearchManager getInstance()
	{
		if( instance == null )
			instance = new AddPremiumsearchManager();

		return instance; 
	}

	public static AddPremiumsearchManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �1�5�6�7�0�1 �8�8�3�0�3�5 �3�5�6�7
	public DataSet findPremiumsearch(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AddPremiumsearchDao dao = getPremiumsearchDao();
			output = dao.findPremiumsearch(input);
			
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
			AddPremiumsearchDao dao = getPremiumsearchDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private AddPremiumsearchDao getPremiumsearchDao()
	{
		return new AddPremiumsearchDao();
	}
}

