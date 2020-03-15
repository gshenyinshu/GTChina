package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendinfoDao;

public  class DividendinfoManager
{
	private DividendinfoManager()
	{}

	private static DividendinfoManager instance = null;

	public static DividendinfoManager getInstance()
	{
		if( instance == null )
			instance = new DividendinfoManager();

		return instance; 
	}

	public static DividendinfoManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////해당 증번에 대한 경과해약금및 기본 정보를 display
	public DataSet findDividendinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendinfoDao dao = getDividendinfoDao();
			output = dao.findDividendinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////해당증번에 대한 기본정보를 display
	public DataSet findUserinfo(DataSet input, DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendinfoDao dao = getDividendinfoDao();
			output = dao.findUserinfo(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private DividendinfoDao getDividendinfoDao()
	{
		return new DividendinfoDao();
	}
}

