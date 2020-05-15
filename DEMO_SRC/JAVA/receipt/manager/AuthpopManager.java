package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AuthpopDao;

public  class AuthpopManager
{
	private AuthpopManager()
	{}

	private static AuthpopManager instance = null;

	public static AuthpopManager getInstance()
	{
		if( instance == null )
			instance = new AuthpopManager();

		return instance; 
	}

	public static AuthpopManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////auth ����
	public DataSet findAuthsave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AuthpopDao dao = getAuthpopDao();
			output = dao.findAuthsave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////���� ����
	public DataSet Authupt(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AuthpopDao dao = getAuthpopDao();
			output = dao.Authupt(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	
	////��Ͻ� �ߺ�üũ
	public DataSet findAuth_dup(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AuthpopDao dao = getAuthpopDao();
			output = dao.findAuth_dup(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
		
	private AuthpopDao getAuthpopDao()
	{
		return new AuthpopDao();
	}
}

