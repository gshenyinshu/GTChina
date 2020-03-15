package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.NewcategoryDao;

public  class NewcategoryManager
{
	private NewcategoryManager()
	{}

	private static NewcategoryManager instance = null;

	public static NewcategoryManager getInstance()
	{
		if( instance == null )
			instance = new NewcategoryManager();

		return instance; 
	}

	public static NewcategoryManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�4�5�5�3�7�9�0�5 �3�0�0�4
	public DataSet categorySave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			NewcategoryDao dao = getNewcategoryDao();
			output = dao.categorySave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	private NewcategoryDao getNewcategoryDao()
	{
		return new NewcategoryDao();
	}
}

