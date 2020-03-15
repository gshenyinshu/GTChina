package gtone.changeminer.receipt.dao;

import anyframe.data.*;
import anyframe.db.*;

import gtone.changeminer.common.dao.Executor;

public  class CyberRecDao
{
	/////////C-W
	public DataSet findKsps2000(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();	
			anyframe.log.Logger.debug.println("KSPS2000 input===========>"+input);				
			DataSet output = executor.execute("/changeminer/ksps2000", input);
			anyframe.log.Logger.debug.println("KSPS2000 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}

	////�3�7�2�2�0�7�6�3 �3�3�3�2
	public DataSet Sendingsave(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�3�7�2�2�0�7�6�3 �3�3�3�2 input===========>"+input);
			DataSet output = executor.execute("/changeminer/usp_wb_sending_update", input);
			anyframe.log.Logger.debug.println("�3�7�2�2�0�7�6�3 �3�3�3�2 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}

	////�3�7�2�2�0�7�6�3 �7�3�1�6
	public DataSet findSend(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�3�7�2�2�0�7�6�3 �7�3�1�6 input===========>"+input);
			DataSet output = executor.execute("/changeminer/wb_payment_sending", input);
			anyframe.log.Logger.debug.println("�3�7�2�2�0�7�6�3 �7�3�1�6 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////�3�1�9�4�3�3�4�7�7�3�1�6
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�3�1�9�4�3�3�4�7 �7�3�1�6 input===========>"+input);			
			DataSet output = executor.execute("/changeminer/ksps0450", input);			
			anyframe.log.Logger.debug.println("�3�1�9�4�3�3�4�7 �7�3�1�6 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////�2�9�8�5�3�5�6�2�3�7
	public DataSet confBank(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			DataSet output1  = new DataSet();			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�2�9�8�5�3�5 �6�2�3�7 input===========>"+input);			
			DataSet output = executor.execute("/changeminer/ksps0340", input);
			anyframe.log.Logger.debug.println("�2�9�8�5�3�5 �6�2�3�7 output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////WB_PAYMENT�2�3�1�9 PROC_STATUS�7�3�1�6
	public DataSet findProcstatus(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("WB_PROCESS�2�3�1�9 �1�8�5�1�7�3  input===========>"+input);			
			DataSet output = executor.execute("/changeminer/findProcval", input);
			anyframe.log.Logger.debug.println("WB_PROCESS�2�3�1�9 �1�8�5�1�7�3  output===========>"+output);			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}			
}