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

	////카테고리내용 검색
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

