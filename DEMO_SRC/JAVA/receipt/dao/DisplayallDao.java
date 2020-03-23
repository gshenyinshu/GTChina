package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class DisplayallDao
{
	
	////�ݼۻ���display
	public DataSet displayAll(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();	
			anyframe.log.Logger.debug.println("���°� ���濡 ���� ����  input===========>"+input);				
			DataSet output = executor.execute("/changeminer/displayStatus", input);
			anyframe.log.Logger.debug.println("���°� ���濡 ���� ����  output===========>"+output);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}    						
}