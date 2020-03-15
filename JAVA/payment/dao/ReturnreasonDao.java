package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnreasonDao
{
	
	////�7�9�7�4�3�4�1�5�1�3�7�4
	public DataSet findReturnreason(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�0�5�2�1�5�7�2�3�1�9 �5�8�2�2 input==========="+input);			
			DataSet output = executor.execute("/changeminer/return_reason1", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�0�5�2�1�5�7�2�3�1�9 �5�8�2�2 output==========="+output);						
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
}