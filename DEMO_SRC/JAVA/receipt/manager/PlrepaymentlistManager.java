package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PlrepaymentlistDao;

public  class PlrepaymentlistManager
{
	private PlrepaymentlistManager()
	{}

	private static PlrepaymentlistManager instance = null;

	public static PlrepaymentlistManager getInstance()
	{
		if( instance == null )
			instance = new PlrepaymentlistManager();

		return instance; 
	}

	public static PlrepaymentlistManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�ش� ������ ���� ���������� ��ȸ.
	public DataSet findPlrepaymentlist(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlrepaymentlistDao dao = getPlrepaymentlistDao();
			output = dao.findPlrepaymentlist(input);
			
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
			PlrepaymentlistDao dao = getPlrepaymentlistDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
		
	private PlrepaymentlistDao getPlrepaymentlistDao()
	{
		return new PlrepaymentlistDao();
	}
}

