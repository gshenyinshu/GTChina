package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class SchedulePopDao
{
	
	////WORKINGDAY조회
	public DataSet findWorking(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/schedule", input);
			return output;
		}
		////
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////WORKINGDAY수정
	public DataSet findUpdateWorking(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/schedule_upt", input);
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

}