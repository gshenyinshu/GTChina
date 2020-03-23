package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PlrepaymentinfoDao;

public  class PlrepaymentinfoManager
{
	private PlrepaymentinfoManager()
	{}

	private static PlrepaymentinfoManager instance = null;

	public static PlrepaymentinfoManager getInstance()
	{
		if( instance == null )
			instance = new PlrepaymentinfoManager();

		return instance; 
	}

	public static PlrepaymentinfoManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�ش� ������ ���� ����ؾ�ݹ� �⺻ ������ display
	public DataSet findPlrepaymentinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlrepaymentinfoDao dao = getPlrepaymentinfoDao();
			output = dao.findPlrepaymentinfo(input);
			
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
			PlrepaymentinfoDao dao = getPlrepaymentinfoDao();
			output = dao.findUserinfo(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private PlrepaymentinfoDao getPlrepaymentinfoDao()
	{
		return new PlrepaymentinfoDao();
	}
}

