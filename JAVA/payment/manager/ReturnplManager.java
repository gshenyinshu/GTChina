package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.ReturnplDao;

public  class ReturnplManager
{
	private ReturnplManager()
	{}

	private static ReturnplManager instance = null;

	public static ReturnplManager getInstance()
	{
		if( instance == null )
			instance = new ReturnplManager();

		return instance; 
	}

	public static ReturnplManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�3�6�7�1�0�7�6�3�0�6 �8�5�5�3�3�4�1�5 select
	public DataSet findPolicyreturnList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnplDao dao = getReturnplDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findPolicyreturnList-----------------: "+input);				
			output = dao.findPolicyreturnList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�4�2�7�2�2�1
	public DataSet findPolicyreturn(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnplDao dao = getReturnplDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findPolicyreturn-----------------: "+input);					
			output = dao.findPolicyreturn(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private ReturnplDao getReturnplDao()
	{
		return new ReturnplDao();
	}
}

