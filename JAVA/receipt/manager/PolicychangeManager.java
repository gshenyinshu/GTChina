package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PolicychangeDao;

public  class PolicychangeManager
{
	private PolicychangeManager()
	{}

	private static PolicychangeManager instance = null;

	public static PolicychangeManager getInstance()
	{
		if( instance == null )
			instance = new PolicychangeManager();

		return instance; 
	}

	public static PolicychangeManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	
	////wb_master�2�3�1�9 �3�0�2�1�7�1�7�5�3�9�2�7�8�5
	public DataSet findPolicychangeList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findPolicychangeList(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////wb_DB�2�3�1�9 �7�3 �7�5�3�9�2�7�8�5
	public DataSet findPolicychange_wb(DataSet input,DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findPolicychange_wb(input,input1);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}



	////Host - insert
	public DataSet findPolicychange_host_insert(DataSet input,DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findPolicychange_host_insert(input,input1);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�3�3�4�7�3�1�0�7 �1�3�7�4
	public DataSet findExistpolicy(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findExistpolicy(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	
	
	////wb_DB - update
	public DataSet findPolicychange_wb_update(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findPolicychange_wb_update(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////�0�3�3�1 �3�7�2�2�3�5 �3�1�6�3 �7�3 �3�5�6�7
	public DataSet findMail_sendmsg(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findMail_sendmsg(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////�0�3�3�1 �3�7�2�2�3�5 �3�1�6�3 �7�3 �3�5�6�7(�3�1�9�4�3�3�4�7�2�1�4�0�1�3�7�4, �6�7�3�1, �8�9�0�6�1�9�0�6)
	public DataSet findMail_sendaccount(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findMail_sendaccount(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////�0�3�3�1 �3�7�2�2�3�5 �3�1�6�3 �7�3 �3�5�6�7(�1�8�6�5)
	public DataSet findMail_repayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findMail_repayment(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	


	////�0�3�3�1(�7�9�7�4�3�4�1�5�1�3�7�4)  �3�7�2�2�3�5 �3�1�6�3 �7�3 �3�5�6�7
	public DataSet findMail_custmsg(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findMail_custmsg(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////�2�5�3�1�0�3�3�1 �3�7�2�2�3�5 �3�1�6�3 �7�3 �3�5�6�7
	public DataSet sendMail(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.sendMail(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////�0�3�3�1 �3�7�2�2
	public DataSet sendSimpleMail(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.sendSimpleMail(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////wb_master update
	public DataSet uptMaster(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();			
			output = dao.uptMaster(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////wb_�9�9�5�3�3�1 update
	public DataSet uptDetail(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();			
			output = dao.uptDetail(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

				
	private PolicychangeDao getPolicychangeDao()
	{
		return new PolicychangeDao();
	}
}

