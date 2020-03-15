package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnnewpopDao
{
	
	////�1�7�3�9�3�3�3�2
	public DataSet findReturnsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�1�7�3�9�8�9�3�0 �3�3�3�2 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_add", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�3�0 �3�3�3�2 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
	
	////�1�7�3�9 - update
	public DataSet Returnupt(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�1�7�3�9 �2�1�3�4dao ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_upt", input);
			anyframe.log.Logger.debug.println("�1�7�3�9 �2�1�3�4dao ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////�0�5�2�2�1�7�3�9 - list
	public DataSet findReturndesc(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�1�7�3�9 �4�9�9�3 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_list", input);
			anyframe.log.Logger.debug.println("�1�7�3�9 �4�9�9�3 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////�0�5�2�2�1�7�3�9 - �7�3�1�7
	public DataSet Selcon(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�7�3�1�7�1�7�3�9 �4�9�9�3 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sel_indiv", input);
			anyframe.log.Logger.debug.println("�7�3�1�7 �4�9�9�3 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
}