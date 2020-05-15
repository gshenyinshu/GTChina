package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.ReturnpopDao;

public  class ReturnpopManager
{
	private ReturnpopManager()
	{}

	private static ReturnpopManager instance = null;

	public static ReturnpopManager getInstance()
	{
		if( instance == null )
			instance = new ReturnpopManager();

		return instance; 
	}

	public static ReturnpopManager getInstance(boolean newInstance)
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
			ReturnpopDao dao = getReturnpopDao();
			output = dao.findClient(input);
			
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
			ReturnpopDao dao = getReturnpopDao();
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
			ReturnpopDao dao = getReturnpopDao();
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
			ReturnpopDao dao = getReturnpopDao();
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
			ReturnpopDao dao = getReturnpopDao();
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
			ReturnpopDao dao = getReturnpopDao();
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
			ReturnpopDao dao = getReturnpopDao();
			output = dao.findAplcan(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private ReturnpopDao getReturnpopDao()
	{
		return new ReturnpopDao();
	}
}

