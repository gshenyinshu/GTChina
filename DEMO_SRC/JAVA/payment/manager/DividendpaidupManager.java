package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendpaidupDao;

public  class DividendpaidupManager
{
	private DividendpaidupManager()
	{}

	private static DividendpaidupManager instance = null;

	public static DividendpaidupManager getInstance()
	{
		if( instance == null )
			instance = new DividendpaidupManager();

		return instance; 
	}

	public static DividendpaidupManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�ش� ������ ���� ���� ���� display
	public DataSet findDividendpaidup(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendpaidupDao dao = getDividendpaidupDao();
			output = dao.findDividendpaidup(input);
			
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
			DividendpaidupDao dao = getDividendpaidupDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private DividendpaidupDao getDividendpaidupDao()
	{
		return new DividendpaidupDao();
	}
}

