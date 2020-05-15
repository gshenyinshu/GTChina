package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PremiumlistDao;

public  class PremiumlistManager
{
	private PremiumlistManager()
	{}

	private static PremiumlistManager instance = null;

	public static PremiumlistManager getInstance()
	{
		if( instance == null )
			instance = new PremiumlistManager();

		return instance; 
	}

	public static PremiumlistManager getInstance(boolean newInstance)
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
			PremiumlistDao dao = getPremiumlistDao();
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
			PremiumlistDao dao = getPremiumlistDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private PremiumlistDao getPremiumlistDao()
	{
		return new PremiumlistDao();
	}
}

