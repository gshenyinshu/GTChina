package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class DividendlistDao
{
	////배당금 내역
	public DataSet findDividendlist(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("배당금 제지급금 내역 input==========="+input);			
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