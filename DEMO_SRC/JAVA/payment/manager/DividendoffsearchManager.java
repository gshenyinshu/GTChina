package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendoffsearchDao;

public  class DividendoffsearchManager
{
	private DividendoffsearchManager()
	{}

	private static DividendoffsearchManager instance = null;

	public static DividendoffsearchManager getInstance()
	{
		if( instance == null )
			instance = new DividendoffsearchManager();

		return instance; 
	}

	public static DividendoffsearchManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	public DataSet findDividendoffsearch(DataSet input) throws Exception
	{
		////System.out.println("	DividendoffsearchManager==================");	
		try
		{
			DataSet output = null;
			DividendoffsearchDao dao = getDividendoffsearchDao();
			output = dao.findDividendoffsearch(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	private DividendoffsearchDao getDividendoffsearchDao()
	{
		return new DividendoffsearchDao();
	}
}

