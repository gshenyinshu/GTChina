package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AuthDao;

public  class AuthManager
{
	private AuthManager()
	{}

	private static AuthManager instance = null;

	public static AuthManager getInstance()
	{
		if( instance == null )
			instance = new AuthManager();

		return instance; 
	}

	public static AuthManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////����� ���� ����Ʈ
	public DataSet findAuth(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AuthDao dao = getAuthDao();
			output = dao.findAuth(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////�Ѱ���
	public DataSet findAuthCount(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AuthDao dao = getAuthDao();
			output = dao.findAuthCount(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	


	////����� ����
	public DataSet delAuth(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AuthDao dao = getAuthDao();
			output = dao.delAuth(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
					
	private AuthDao getAuthDao()
	{
		return new AuthDao();
	}
}

