package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class DisplayallDao
{
	
	////�0�5�2�2�1�7�3�9display
	public DataSet displayAll(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();	
			anyframe.log.Logger.debug.println("�1�8�5�1�7�3 �1�3�7�4�2�3 �9�7�0�3 �8�9�2�2  input===========>"+input);				
			DataSet output = executor.execute("/changeminer/displayStatus", input);
			anyframe.log.Logger.debug.println("�1�8�5�1�7�3 �1�3�7�4�2�3 �9�7�0�3 �8�9�2�2  output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}    						
}