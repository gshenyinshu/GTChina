package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class NewcategoryDao
{
	
	////�1�7�3�9�3�3�3�2
	public DataSet categorySave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�4�5�5�3�7�9�0�5 �3�3�3�2 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/categoryadd", input);
			anyframe.log.Logger.debug.println("�4�5�5�3�7�9�0�5 �3�3�3�2 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
					
}