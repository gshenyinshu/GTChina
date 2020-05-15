package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendsearchDao;

public  class DividendsearchManager
{
	private DividendsearchManager()
	{}

	private static DividendsearchManager instance = null;

	public static DividendsearchManager getInstance()
	{
		if( instance == null )
			instance = new DividendsearchManager();

		return instance; 
	}

	public static DividendsearchManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	public DataSet findDividendsearch(DataSet input) throws Exception
	{
		////System.out.println("	DividendsearchManager==================");	
		try
		{
			DataSet output = null;
			DividendsearchDao dao = getDividendsearchDao();
			output = dao.findDividendsearch(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	public DataSet Inpayment(DataSet input, DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendsearchDao dao = getDividendsearchDao();
			output = dao.Inpayment(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private DividendsearchDao getDividendsearchDao()
	{
		return new DividendsearchDao();
	}
}

