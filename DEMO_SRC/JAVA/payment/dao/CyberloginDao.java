package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class CyberloginDao
{
	////�α�����
	public DataSet findLogin(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/cyberlogin", input);
			anyframe.log.Logger.debug.println("login����  output : "+output);				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

			
}