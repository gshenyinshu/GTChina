package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.ReturnnewpopDao;

public  class ReturnnewpopManager
{
	private ReturnnewpopManager()
	{}

	private static ReturnnewpopManager instance = null;

	public static ReturnnewpopManager getInstance()
	{
		if( instance == null )
			instance = new ReturnnewpopManager();

		return instance; 
	}

	public static ReturnnewpopManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////���� ����
	public DataSet findReturnsave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnnewpopDao dao = getReturnnewpopDao();
			output = dao.findReturnsave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////���� ����
	public DataSet Returnupt(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnnewpopDao dao = getReturnnewpopDao();
			output = dao.Returnupt(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�ݼ��ڵ�
	public DataSet findReturndesc(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnnewpopDao dao = getReturnnewpopDao();
			output = dao.findReturndesc(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////�ݼ��ڵ�
	public DataSet Selcon(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnnewpopDao dao = getReturnnewpopDao();
			output = dao.Selcon(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}				
	private ReturnnewpopDao getReturnnewpopDao()
	{
		return new ReturnnewpopDao();
	}
}

