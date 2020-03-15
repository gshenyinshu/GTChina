package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PolicyviewDao;

public  class PolicyviewManager
{
	private PolicyviewManager()
	{}

	private static PolicyviewManager instance = null;

	public static PolicyviewManager getInstance()
	{
		if( instance == null )
			instance = new PolicyviewManager();

		return instance; 
	}

	public static PolicyviewManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�3�6�7�1�0�7�6�3�0�6 �8�5�5�3�3�4�1�5 select
	public DataSet findPolicyviewList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyviewDao dao = getPolicyviewDao();
anyframe.log.Logger.debug.println("manage�2�3�1�9 findPolicyviewList-----------------: "+input);				
			output = dao.findPolicyviewList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�4�2�7�2�2�1
	public DataSet findPolicyview(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyviewDao dao = getPolicyviewDao();
			output = dao.findPolicyview(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private PolicyviewDao getPolicyviewDao()
	{
		return new PolicyviewDao();
	}
}

