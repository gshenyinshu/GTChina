package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class AuthpopDao
{
	
	////�7�1�6�3�3�3�3�2
	public DataSet findAuthsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�7�1�6�3�8�9�3�0 �3�3�3�2 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/auth_add", input);
			anyframe.log.Logger.debug.println("�7�1�6�3�8�9�3�0 �3�3�3�2 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
	
	////�7�1�6�3 - update
	public DataSet Authupt(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�7�1�6�3 �2�1�3�4 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/auth_upt", input);
			anyframe.log.Logger.debug.println("�7�1�6�3 �2�1�3�4 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	////�9�4�0�0�2�7 �3�6�1�6�4�7�5�9
	public DataSet findAuth_dup(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�9�4�0�0�2�7 �3�6�1�6�4�7�5�9 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/auth_dup_sel", input);
			anyframe.log.Logger.debug.println("�9�4�0�0�2�7 �3�6�1�6�4�7�5�9 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
		
}