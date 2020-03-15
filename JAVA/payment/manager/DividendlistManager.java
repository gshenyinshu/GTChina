package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendlistDao;

public  class DividendlistManager
{
	private DividendlistManager()
	{}

	private static DividendlistManager instance = null;

	public static DividendlistManager getInstance()
	{
		if( instance == null )
			instance = new DividendlistManager();

		return instance; 
	}

	public static DividendlistManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �0�9�9�0�8�5�8�9�2�2�3�5display
	public DataSet findDividendlist(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendlistDao dao = getDividendlistDao();
			output = dao.findDividendlist(input);
			
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
			DividendlistDao dao = getDividendlistDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private DividendlistDao getDividendlistDao()
	{
		return new DividendlistDao();
	}
}

