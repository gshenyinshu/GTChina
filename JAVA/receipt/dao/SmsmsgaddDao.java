package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class SmsmsgaddDao
{
	
	////SMS�3�3�3�2
	public DataSet findSmssave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS�8�9�3�0 �3�3�3�2 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_add", input);
			anyframe.log.Logger.debug.println("SMS�8�9�3�0 �3�3�3�2 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////lp�3�0 - SMS �3�5�6�7
	public DataSet displayMsg(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS �2�1�3�4�3�7 �3�5�6�7 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_uptdisplay", input);
			anyframe.log.Logger.debug.println("SMS �2�1�3�4�3�7 �3�5�6�7 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
	
	////lp�3�0 - update
	public DataSet findModify(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS �2�1�3�4 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_lp_upt", input);
			anyframe.log.Logger.debug.println("SMS �2�1�3�4 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////cu�3�0 - SMS �3�5�6�7
	public DataSet displayMsg_cu(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS �2�1�3�4�3�7 �3�5�6�7 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_cu_uptdisplay", input);
			anyframe.log.Logger.debug.println("SMS �2�1�3�4�3�7 �3�5�6�7 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
	
	////cu�3�0 - update
	public DataSet findModify_cu(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS �2�1�3�4 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_cu_upt", input);
			anyframe.log.Logger.debug.println("SMS �2�1�3�4 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}

		
}