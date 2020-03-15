package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.Returncause1Dao;

public  class Returncause1Manager
{
	private Returncause1Manager()
	{}

	private static Returncause1Manager instance = null;

	public static Returncause1Manager getInstance()
	{
		if( instance == null )
			instance = new Returncause1Manager();

		return instance; 
	}

	public static Returncause1Manager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�4�5�5�3�7�9�0�5�8�9�3�0 �7�3�1�6
	public DataSet selCatedesc(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			Returncause1Dao dao = getReturncause1Dao();
			output = dao.selCatedesc(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
				
	private Returncause1Dao getReturncause1Dao()
	{
		return new Returncause1Dao();
	}
}

