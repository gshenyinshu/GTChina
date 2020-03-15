package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendoffinfoDao;

public  class DividendoffinfoManager
{
	private DividendoffinfoManager()
	{}

	private static DividendoffinfoManager instance = null;

	public static DividendoffinfoManager getInstance()
	{
		if( instance == null )
			instance = new DividendoffinfoManager();

		return instance; 
	}

	public static DividendoffinfoManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �7�4�7�7�6�7�2�0�8�5�0�6 �8�5�1�9 �3�4�1�5�0�7 display
	public DataSet findDividendoffinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendoffinfoDao dao = getDividendoffinfoDao();
			output = dao.findDividendoffinfo(input);
			
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
			DividendoffinfoDao dao = getDividendoffinfoDao();
			output = dao.findUserinfo(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

/*
	////�0�9�9�0�8�5 �1�8�7�1�3�0�2�1�8�9�2�2
	public DataSet Inpayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendoffinfoDao dao = getDividendoffinfoDao();
			output = dao.Inpayment(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
*/	
	
	private DividendoffinfoDao getDividendoffinfoDao()
	{
		return new DividendoffinfoDao();
	}
}

