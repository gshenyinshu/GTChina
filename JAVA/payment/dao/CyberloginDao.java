package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class CyberloginDao
{
	////로긴정보
	public DataSet findLogin(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/cyberlogin", input);
			anyframe.log.Logger.debug.println("login정보  output : "+output);				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

			
}