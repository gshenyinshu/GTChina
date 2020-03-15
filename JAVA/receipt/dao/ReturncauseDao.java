package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturncauseDao
{
	
	////�1�7�3�9(master) - update
	public DataSet uptReturnmaster(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2 master dao ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_master", input);
			anyframe.log.Logger.debug.println("�0�5�2�2 master dao ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	


	////�1�7�3�9(detail) - update
	public DataSet uptReturndetail(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�0�5�2�2 detail dao ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_detail", input);
			anyframe.log.Logger.debug.println("�0�5�2�2 detail dao ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
						
}