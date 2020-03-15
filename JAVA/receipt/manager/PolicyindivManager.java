package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PolicyindivDao;

public  class PolicyindivManager
{
	private PolicyindivManager()
	{}

	private static PolicyindivManager instance = null;

	public static PolicyindivManager getInstance()
	{
		if( instance == null )
			instance = new PolicyindivManager();

		return instance; 
	}

	public static PolicyindivManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�3�6�7�1�0�7�6�3�0�6 �8�5�5�3�3�4�1�5 select
	public DataSet findPolicyindivList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyindivDao dao = getPolicyindivDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findPolicyindivList-----------------: "+input);				
			output = dao.findPolicyindivList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�4�2�7�2�2�1
	public DataSet findPolicyindiv(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyindivDao dao = getPolicyindivDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findPolicyindiv-----------------: "+input);					
			output = dao.findPolicyindiv(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////�2�9�8�5�3�5�2�5�5�9
	public DataSet updateBank(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyindivDao dao = getPolicyindivDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 updateBank-----------------: "+input);					
			output = dao.updateBank(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}		
	
	
	////wb_master�2�3 process_mode�2�3 "B"�0�9 update
	public DataSet master_upt(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyindivDao dao = getPolicyindivDao();
			output = dao.master_upt(input);
			return output;
		}
		catch(Exception e)
		{
			throw (e);	
		}
	}

	
	private PolicyindivDao getPolicyindivDao()
	{
		return new PolicyindivDao();
	}
}

