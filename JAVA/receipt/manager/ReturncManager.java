package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.ReturncDao;

public  class ReturncManager
{
	private ReturncManager()
	{}

	private static ReturncManager instance = null;

	public static ReturncManager getInstance()
	{
		if( instance == null )
			instance = new ReturncManager();

		return instance; 
	}

	public static ReturncManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�0�5�2�2 �3�4�1�5 �0�5�2�1�5�7
	public DataSet findReturnc(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturncDao dao = getReturncDao();
			output = dao.findReturnc(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////�4�2�7�2�2�1
	public DataSet findReturncCount(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturncDao dao = getReturncDao();
			output = dao.findReturncCount(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	


	////�1�7�3�0�3�1 �1�8�3�1
	public DataSet delReturnc(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturncDao dao = getReturncDao();
			output = dao.delReturnc(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
					
	private ReturncDao getReturncDao()
	{
		return new ReturncDao();
	}
}
