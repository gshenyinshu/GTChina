package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PlrepaymentsearchDao;

public  class PlrepaymentsearchManager
{
	private PlrepaymentsearchManager()
	{}

	private static PlrepaymentsearchManager instance = null;

	public static PlrepaymentsearchManager getInstance()
	{
		if( instance == null )
			instance = new PlrepaymentsearchManager();

		return instance; 
	}

	public static PlrepaymentsearchManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	public DataSet findPlrepaymentsearch(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlrepaymentsearchDao dao = getPlrepaymentsearchDao();
			output = dao.findPlrepaymentsearch(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�7�1�2�0�3�1�3�5 �7�5�3�9�2�7�8�5 �3�1�6�3 �8�9�3�0
	public DataSet findIssdate(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlrepaymentsearchDao dao = getPlrepaymentsearchDao();
			output = dao.findIssdate(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	
	private PlrepaymentsearchDao getPlrepaymentsearchDao()
	{
		return new PlrepaymentsearchDao();
	}
}

