package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendlistDao;

public  class DividendlistManager
{
	private DividendlistManager()
	{}

	private static DividendlistManager instance = null;

	public static DividendlistManager getInstance()
	{
		if( instance == null )
			instance = new DividendlistManager();

		return instance; 
	}

	public static DividendlistManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////해당 증번에 대한 배당금내역을display
	public DataSet findDividendlist(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendlistDao dao = getDividendlistDao();
			output = dao.findDividendlist(input);
			
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
			DividendlistDao dao = getDividendlistDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private DividendlistDao getDividendlistDao()
	{
		return new DividendlistDao();
	}
}

