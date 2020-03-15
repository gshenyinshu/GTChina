package gtone.changeminer.report.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.report.dao.PayprocreportDao;

public  class PayprocreportManager
{
	private PayprocreportManager()
	{}

	private static PayprocreportManager instance = null;

	public static PayprocreportManager getInstance()
	{
		if( instance == null )
			instance = new PayprocreportManager();

		return instance; 
	}

	public static PayprocreportManager getInstance(boolean newInstance)
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
			PayprocreportDao dao = getPayprocreportDao();
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
			PayprocreportDao dao = getPayprocreportDao();
			output = dao.findPolicyview(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////�2�5�3�1�8�6�8�5�6�6�7�1�0�6 �7�2�2�1 (�3�1�8�6)
	public DataSet findSumcount(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PayprocreportDao dao = getPayprocreportDao();
			output = dao.findSumcount(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////�2�5�3�1�8�6�8�5�6�6�7�1�0�6 �7�2�2�1 (�2�1�8�8)
	public DataSet findSumcount1(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PayprocreportDao dao = getPayprocreportDao();
			output = dao.findSumcount1(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////�3�1�6�8 display
	public DataSet findSelBank(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PayprocreportDao dao = getPayprocreportDao();
			output = dao.findSelBank(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private PayprocreportDao getPayprocreportDao()
	{
		return new PayprocreportDao();
	}
}

