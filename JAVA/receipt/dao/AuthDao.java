package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class AuthDao
{
	
	////�1�7�3�0�3�1�3�4�1�5�0�5�2�1�5�7
	public DataSet findAuth(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/auth_manager", input);
			anyframe.log.Logger.debug.println("�1�7�3�0�3�1�7�1�6�3�7�1�0�5 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

   public DataSet findAuthCount(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/auth_count", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }	
    
	////�1�7�3�0�3�1�1�8�3�1
	public DataSet delAuth(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/auth_del", input);
			anyframe.log.Logger.debug.println("�1�7�3�0�3�1�1�8�3�1 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	    						
}