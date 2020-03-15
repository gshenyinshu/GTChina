package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.StatiDao;

public  class StatiManager
{
	private StatiManager()
	{}

	private static StatiManager instance = null;

	public static StatiManager getInstance()
	{
		if( instance == null )
			instance = new StatiManager();

		return instance; 
	}

	public static StatiManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�1�7�3�0�3�1 �3�4�1�5 �0�5�2�1�5�7
	public DataSet findStati(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			StatiDao dao = getStatiDao();
			output = dao.findStati(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


					
	private StatiDao getStatiDao()
	{
		return new StatiDao();
	}
}

