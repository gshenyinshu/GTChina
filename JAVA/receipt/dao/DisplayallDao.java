package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class DisplayallDao
{
	
	////반송사유display
	public DataSet displayAll(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();	
			anyframe.log.Logger.debug.println("상태값 변경에 따른 내역  input===========>"+input);				
			DataSet output = executor.execute("/changeminer/displayStatus", input);
			anyframe.log.Logger.debug.println("상태값 변경에 따른 내역  output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}    						
}