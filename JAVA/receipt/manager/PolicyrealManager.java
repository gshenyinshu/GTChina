package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PolicyrealDao;

public  class PolicyrealManager
{
	private PolicyrealManager()
	{}

	private static PolicyrealManager instance = null;

	public static PolicyrealManager getInstance()
	{
		if( instance == null )
			instance = new PolicyrealManager();

		return instance; 
	}

	public static PolicyrealManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�3�6�7�1�0�7�6�3�0�6 �8�5�5�3�3�4�1�5 select
	public DataSet findPolicyrealList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyrealDao dao = getPolicyrealDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findPolicyrealList-----------------: "+input);				
			output = dao.findPolicyrealList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�4�2�7�2�2�1
	public DataSet findPolicyreal(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyrealDao dao = getPolicyrealDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findPolicyreal-----------------: "+input);					
			output = dao.findPolicyreal(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private PolicyrealDao getPolicyrealDao()
	{
		return new PolicyrealDao();
	}
}

