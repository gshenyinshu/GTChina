package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AplpaymentinfoDao;

public  class AplpaymentinfoManager
{
	private AplpaymentinfoManager()
	{}

	private static AplpaymentinfoManager instance = null;

	public static AplpaymentinfoManager getInstance()
	{
		if( instance == null )
			instance = new AplpaymentinfoManager();

		return instance; 
	}

	public static AplpaymentinfoManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////�ش� ������ ���� ����ؾ�ݹ� �⺻ ������ display
	public DataSet findAplpaymentinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AplpaymentinfoDao dao = getAplpaymentinfoDao();
			output = dao.findAplpaymentinfo(input);
			
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
			AplpaymentinfoDao dao = getAplpaymentinfoDao();
			output = dao.findUserinfo(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private AplpaymentinfoDao getAplpaymentinfoDao()
	{
		return new AplpaymentinfoDao();
	}
}

