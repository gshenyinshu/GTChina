package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendinfoDao;

public  class DividendinfoManager
{
	private DividendinfoManager()
	{}

	private static DividendinfoManager instance = null;

	public static DividendinfoManager getInstance()
	{
		if( instance == null )
			instance = new DividendinfoManager();

		return instance; 
	}

	public static DividendinfoManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �7�4�7�7�6�7�2�0�8�5�0�6 �8�5�1�9 �3�4�1�5�0�7 display
	public DataSet findDividendinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendinfoDao dao = getDividendinfoDao();
			output = dao.findDividendinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////�6�7�9�0�3�6�0�7�2�3 �9�7�6�3 �8�5�1�9�3�4�1�5�0�7 display
	public DataSet findUserinfo(DataSet input, DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendinfoDao dao = getDividendinfoDao();
			output = dao.findUserinfo(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private DividendinfoDao getDividendinfoDao()
	{
		return new DividendinfoDao();
	}
}

