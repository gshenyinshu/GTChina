package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PlrepaymentsearchDao
{
	////�2�0�7�1�9�7�4�9 �8�5�1�9�6�0�0�8
	public DataSet findPlrepaymentsearch(DataSet input) throws Exception
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
	
	////�7�1�2�0�3�1�3�5 �7�5�3�9�2�7�8�5 �3�1�6�3 �8�9�3�0
	public DataSet findIssdate(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/coveragenormal", input);
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	
}