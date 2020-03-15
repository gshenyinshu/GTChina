package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturncDao
{
	
	////�0�5�2�2�3�4�1�5�0�5�2�1�5�7
	public DataSet findReturnc(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/return_manager", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�1�7�3�9�7�1�0�5 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

   public DataSet findReturncCount(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/return_count", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }	
    
	////�1�7�3�0�3�1�1�8�3�1
	public DataSet delReturnc(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2�1�7�3�9�1�8�3�1 ----  input : "+input);	
			DataSet output = executor.execute("/changeminer/return_del", input);
			anyframe.log.Logger.debug.println("�0�5�2�2�1�7�3�9�1�8�3�1 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	    						
}