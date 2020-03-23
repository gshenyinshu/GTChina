package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AddPremiumlistDao;

public  class AddPremiumlistManager
{
	private AddPremiumlistManager()
	{}

	private static AddPremiumlistManager instance = null;

	public static AddPremiumlistManager getInstance()
	{
		if( instance == null )
			instance = new AddPremiumlistManager();

		return instance; 
	}

	public static AddPremiumlistManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////해당 증번에 대한 보험료 내역을display
	public DataSet findPremiumlist(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AddPremiumlistDao dao = getPremiumlistDao();
			output = dao.findPremiumlist(input);
			
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
			AddPremiumlistDao dao = getPremiumlistDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private AddPremiumlistDao getPremiumlistDao()
	{
		return new AddPremiumlistDao();
	}
}

