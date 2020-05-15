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
	
	////�ش� ������ ���� ���ݳ�����display
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


	////�ش� ������ ���� ����ؾ�ݹ� �⺻ ������ display
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

