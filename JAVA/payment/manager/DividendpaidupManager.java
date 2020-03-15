package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendpaidupDao;

public  class DividendpaidupManager
{
	private DividendpaidupManager()
	{}

	private static DividendpaidupManager instance = null;

	public static DividendpaidupManager getInstance()
	{
		if( instance == null )
			instance = new DividendpaidupManager();

		return instance; 
	}

	public static DividendpaidupManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �0�9�9�0�8�5 �8�9�2�2 display
	public DataSet findDividendpaidup(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendpaidupDao dao = getDividendpaidupDao();
			output = dao.findDividendpaidup(input);
			
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
			DividendpaidupDao dao = getDividendpaidupDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private DividendpaidupDao getDividendpaidupDao()
	{
		return new DividendpaidupDao();
	}
}

