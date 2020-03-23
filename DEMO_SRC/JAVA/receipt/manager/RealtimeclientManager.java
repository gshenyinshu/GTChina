
package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.RealtimeclientDao;

public  class RealtimeclientManager
{
	private RealtimeclientManager()
	{}

	private static RealtimeclientManager instance = null;

	public static RealtimeclientManager getInstance()
	{
		if( instance == null )
			instance = new RealtimeclientManager();

		return instance; 
	}

	public static RealtimeclientManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////����������
	public DataSet findClient(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findClient(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	////����öȸ/���Űź�
	public DataSet findPrivate(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findPrivate(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	////�ڵ���ü����
	public DataSet findAccount(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findAccount(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////���� APL�ڵ���ȯ
	public DataSet findRepayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findRepayment(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////���ֺ���
	public DataSet findBillingfre(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findBillingfre(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////���׺����ݵ庯��
	public DataSet findFundchg(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findFundchg(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////APL��û"
	public DataSet findAplin(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findAplin(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////APL����"
	public DataSet findAplcan(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findAplcan(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private RealtimeclientDao getRealtimeclientDao()
	{
		return new RealtimeclientDao();
	}
}

