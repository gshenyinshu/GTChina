package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendofflistDao;

public  class DividendofflistManager
{
	private DividendofflistManager()
	{}

	private static DividendofflistManager instance = null;

	public static DividendofflistManager getInstance()
	{
		if( instance == null )
			instance = new DividendofflistManager();

		return instance; 
	}

	public static DividendofflistManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////해당 증번에 대한 배당금내역을display
	public DataSet findDividendofflist(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendofflistDao dao = getDividendofflistDao();
			output = dao.findDividendofflist(input);
			
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
			DividendofflistDao dao = getDividendofflistDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private DividendofflistDao getDividendofflistDao()
	{
		return new DividendofflistDao();
	}
}

