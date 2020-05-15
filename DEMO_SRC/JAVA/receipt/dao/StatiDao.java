package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class StatiDao
{
	
	////�������������Ʈ
	public DataSet findStati(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("������ ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/stati_read", input);
			anyframe.log.Logger.debug.println("������ ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
   						
}