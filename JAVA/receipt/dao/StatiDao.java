package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class StatiDao
{
	
	////�1�7�3�0�3�1�3�4�1�5�0�5�2�1�5�7
	public DataSet findStati(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�5�8�7�1�7�1�0�5 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/stati_read", input);
			anyframe.log.Logger.debug.println("�5�8�7�1�7�1�0�5 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
   						
}