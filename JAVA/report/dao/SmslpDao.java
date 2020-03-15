
package gtone.changeminer.report.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public class SmslpDao
{
	//SMS comment
	public DataSet findSmslp(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("LP SMS  input==========="+input);
			
			DataSet output = executor.execute("/changeminer/smslp", input);
			anyframe.log.Logger.debug.println("LP SMS output==========="+output);			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
			
}