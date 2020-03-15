package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class DividendlistDao
{
	////�0�9�9�0�8�5 �8�9�2�2
	public DataSet findDividendlist(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("�0�9�9�0�8�5 �3�1�3�1�8�6�8�5 �8�9�2�2 input==========="+input);			
			DataSet output = executor.execute("/changeminer/m0161sp2", input);
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	public DataSet findPlcynoinfo(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/m0161sp1", input);
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
}