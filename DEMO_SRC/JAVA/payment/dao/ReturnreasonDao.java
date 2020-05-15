package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnreasonDao
{
	
	////고객정보변경
	public DataSet findReturnreason(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("반송리스트에서 팝업 input==========="+input);			
			DataSet output = executor.execute("/changeminer/return_reason1", input);
			anyframe.log.Logger.debug.println("반송리스트에서 팝업 output==========="+output);						
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
}