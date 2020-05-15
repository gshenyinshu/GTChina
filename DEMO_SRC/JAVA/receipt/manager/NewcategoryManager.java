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

	////ī�װ� �Է�
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

