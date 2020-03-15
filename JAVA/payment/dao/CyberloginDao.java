package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class CyberloginDao
{
	////�0�9�8�9�3�4�1�5
	public DataSet findLogin(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/cyberlogin", input);
			anyframe.log.Logger.debug.println("login�3�4�1�5  output : "+output);				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

			
}