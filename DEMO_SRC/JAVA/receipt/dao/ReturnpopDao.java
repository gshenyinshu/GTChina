package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnpopDao
{
	
	////고객정보변경
	public DataSet findClient(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("모니터링(고객정보변경) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_client", input);
			anyframe.log.Logger.debug.println("모니터링(고객정보변경) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	


	////자동이체관련
	public DataSet findAccount(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("모니터링(자동이체관련) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_account", input);
			anyframe.log.Logger.debug.println("모니터링(자동이체관련) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		

	////약대및 APL자동상환
	public DataSet findRepayment(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("모니터링(약대및 APL자동상환) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_repayment", input);
			anyframe.log.Logger.debug.println("모니터링(약대및 APL자동상환) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		
	
	////납주변경
	public DataSet findBillingfre(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("모니터링(납주변경) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("모니터링(납주변경) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		
	
	
	////변액보험펀드변경
	public DataSet findFundchg(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("모니터링(변액보험펀드변경) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("모니터링(변액보험펀드변경) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		

	////APL신청"
	public DataSet findAplin(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("모니터링(APL신청) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("모니터링(APL신청) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////APL해지"
	public DataSet findAplcan(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("모니터링(APL해지) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("모니터링(APL해지) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}			
}