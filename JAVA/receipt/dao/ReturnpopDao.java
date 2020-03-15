package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnpopDao
{
	
	////�7�9�7�4�3�4�1�5�1�3�7�4
	public DataSet findClient(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�7�9�7�4�3�4�1�5�1�3�7�4) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_client", input);
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�7�9�7�4�3�4�1�5�1�3�7�4) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	


	////�3�1�9�4�3�3�4�7�7�1�0�7
	public DataSet findAccount(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�3�1�9�4�3�3�4�7�7�1�0�7) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_account", input);
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�3�1�9�4�3�3�4�7�7�1�0�7) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		

	////�2�0�9�7�0�6 APL�3�1�9�4�1�8�6�5
	public DataSet findRepayment(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�2�0�9�7�0�6 APL�3�1�9�4�1�8�6�5) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_repayment", input);
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�2�0�9�7�0�6 APL�3�1�9�4�1�8�6�5) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		
	
	////�8�8�3�5�1�3�7�4
	public DataSet findBillingfre(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�8�8�3�5�1�3�7�4) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�8�8�3�5�1�3�7�4) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		
	
	
	////�1�3�2�2�1�5�6�7�5�7�9�3�1�3�7�4
	public DataSet findFundchg(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�1�3�2�2�1�5�6�7�5�7�9�3�1�3�7�4) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(�1�3�2�2�1�5�6�7�5�7�9�3�1�3�7�4) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		

	////APL�2�1�4�0"
	public DataSet findAplin(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(APL�2�1�4�0) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(APL�2�1�4�0) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////APL�6�7�3�1"
	public DataSet findAplcan(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(APL�6�7�3�1) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("�0�7�9�1�5�5�0�6(APL�6�7�3�1) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}			
}