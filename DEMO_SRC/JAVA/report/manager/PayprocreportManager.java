package gtone.changeminer.report.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.report.dao.PayprocreportDao;

public  class PayprocreportManager
{
	private PayprocreportManager()
	{}

	private static PayprocreportManager instance = null;

	public static PayprocreportManager getInstance()
	{
		if( instance == null )
			instance = new PayprocreportManager();

		return instance; 
	}

	public static PayprocreportManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////���ǹ�ȣ�� ��Ÿ���� select
	public DataSet findPolicyviewList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PayprocreportDao dao = getPayprocreportDao();
			anyframe.log.Logger.debug.println("manage���� findPolicyviewList-----------------: "+input);				
			output = dao.findPolicyviewList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�Ѱ���
	public DataSet findPolicyview(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PayprocreportDao dao = getPayprocreportDao();
			output = dao.findPolicyview(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////�����ޱ��հ�� ���� (����)
	public DataSet findSumcount(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PayprocreportDao dao = getPayprocreportDao();
			output = dao.findSumcount(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////�����ޱ��հ�� ���� (����)
	public DataSet findSumcount1(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PayprocreportDao dao = getPayprocreportDao();
			output = dao.findSumcount1(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////���� display
	public DataSet findSelBank(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PayprocreportDao dao = getPayprocreportDao();
			output = dao.findSelBank(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private PayprocreportDao getPayprocreportDao()
	{
		return new PayprocreportDao();
	}
}

