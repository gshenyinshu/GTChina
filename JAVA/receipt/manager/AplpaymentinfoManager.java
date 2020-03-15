package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AplpaymentinfoDao;

public  class AplpaymentinfoManager
{
	private AplpaymentinfoManager()
	{}

	private static AplpaymentinfoManager instance = null;

	public static AplpaymentinfoManager getInstance()
	{
		if( instance == null )
			instance = new AplpaymentinfoManager();

		return instance; 
	}

	public static AplpaymentinfoManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�6�7�9�0 �3�6�0�7�2�3 �9�7�6�3 �7�4�7�7�6�7�2�0�8�5�0�6 �8�5�1�9 �3�4�1�5�0�7 display
	public DataSet findAplpaymentinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AplpaymentinfoDao dao = getAplpaymentinfoDao();
			output = dao.findAplpaymentinfo(input);
			
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
			AplpaymentinfoDao dao = getAplpaymentinfoDao();
			output = dao.findUserinfo(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private AplpaymentinfoDao getAplpaymentinfoDao()
	{
		return new AplpaymentinfoDao();
	}
}

