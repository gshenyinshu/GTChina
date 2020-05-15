package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class AplpaymentDao
{

	public DataSet findAplpayment(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/lendingamount", input);
			
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