package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AddPremiumsearchDao;

public  class AddPremiumsearchManager
{
	private AddPremiumsearchManager()
	{}

	private static AddPremiumsearchManager instance = null;

	public static AddPremiumsearchManager getInstance()
	{
		if( instance == null )
			instance = new AddPremiumsearchManager();

		return instance; 
	}

	public static AddPremiumsearchManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////해당 증번에 대한 보험료 납입을 조회
	public DataSet findPremiumsearch(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AddPremiumsearchDao dao = getPremiumsearchDao();
			output = dao.findPremiumsearch(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////해당 증번에 대한 경과해약금및 기본 정보를 display
	public DataSet findPlcynoinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AddPremiumsearchDao dao = getPremiumsearchDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private AddPremiumsearchDao getPremiumsearchDao()
	{
		return new AddPremiumsearchDao();
	}
}

