package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;
// Return DAO Class
public  class ReturnDao
{
	
	
	public DataSet findReturn(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 display19 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_reason", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 display 19----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////�0�5�2�2�8�9�2�2 �3�3�3�2
	public DataSet findRtnsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 WB_PROCESS �3�3�3�219 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 WB_PROCESS �3�3�3�219 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////�0�5�2�2�8�9�2�2 �3�3�3�21
	public DataSet findRtnsave1(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 �3�3�3�2 WB_PAYMENT19----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update1", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�8�9�2�2 �3�3�3�2 WB_PAYMENT19----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	////�1�8�5�1�1�3�7�4�6�3 �1�8�5�1�7�3 �3�3�3�2
	public DataSet findchgSave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�1�8�5�1�1�3�7�4�6�3 �7�3 �3�3�3�2 WB_PROCESS �3�3�3�219 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_chg_status", input);
			anyframe.log.Logger.debug.println("�1�8�5�1�1�3�7�4�6�3 �7�3 �3�3�3�2 WB_PROCESS �3�3�3�219 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////WB_PAYMENT�2�3�1�9 RSLT, ERR_MSG READ
	public DataSet findRsltread(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/wb_rslt_read", input);
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////�2�2�0�7�1�9�0�1�4�9�9�3 �7�3�1�6
	public DataSet findSrvc_cd(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�2�2�0�7�1�9�0�1�4�9�9�3 �7�3�1�6 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/find_srvcode", input);
			anyframe.log.Logger.debug.println("�2�2�0�7�1�9�0�1�4�9�9�3 �7�3�1�6 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}							
}