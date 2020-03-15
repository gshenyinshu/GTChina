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

	////�1�7�3�0�3�1 �3�4�1�5 �0�5�2�1�5�7
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

	////�4�2�7�2�2�1
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


	////�1�7�3�0�3�1 �1�8�3�1
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

