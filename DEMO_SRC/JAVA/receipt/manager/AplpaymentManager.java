package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AplpaymentDao;

public  class AplpaymentManager
{
	private AplpaymentManager()
	{}

	private static AplpaymentManager instance = null;

	public static AplpaymentManager getInstance()
	{
		if( instance == null )
			instance = new AplpaymentManager();

		return instance; 
	}

	public static AplpaymentManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�ش� ������ ���� ���������� ��ȸ.
	public DataSet findAplpayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AplpaymentDao dao = getAplpaymentDao();
			output = dao.findAplpayment(input);
			
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
			AplpaymentDao dao = getAplpaymentDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private AplpaymentDao getAplpaymentDao()
	{
		return new AplpaymentDao();
	}
}

