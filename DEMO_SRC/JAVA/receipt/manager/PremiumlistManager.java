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
	
	////�ش� ������ ���� ����� ������display
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


	////�ش� ������ ���� ����ؾ�ݹ� �⺻ ������ display
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

