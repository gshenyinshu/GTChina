package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.DividendoffinfoDao;

public  class DividendoffinfoManager
{
	private DividendoffinfoManager()
	{}

	private static DividendoffinfoManager instance = null;

	public static DividendoffinfoManager getInstance()
	{
		if( instance == null )
			instance = new DividendoffinfoManager();

		return instance; 
	}

	public static DividendoffinfoManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�ش� ������ ���� ����ؾ�ݹ� �⺻ ������ display
	public DataSet findDividendoffinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendoffinfoDao dao = getDividendoffinfoDao();
			output = dao.findDividendoffinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////�ش������� ���� �⺻������ display
	public DataSet findUserinfo(DataSet input, DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendoffinfoDao dao = getDividendoffinfoDao();
			output = dao.findUserinfo(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

/*
	////���� �����������
	public DataSet Inpayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DividendoffinfoDao dao = getDividendoffinfoDao();
			output = dao.Inpayment(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
*/	
	
	private DividendoffinfoDao getDividendoffinfoDao()
	{
		return new DividendoffinfoDao();
	}
}

