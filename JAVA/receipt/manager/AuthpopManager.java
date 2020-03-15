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

	////auth �3�3�3�2
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


	////�7�1�6�3 �2�1�3�4
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
	
	
	////�9�4�0�0�2�7 �3�6�1�6�4�7�5�9
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

