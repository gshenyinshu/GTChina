package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class SmsmsgaddDao
{
	
	////SMS저장
	public DataSet findSmssave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS내용 저장 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_add", input);
			anyframe.log.Logger.debug.println("SMS내용 저장 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////lp용 - SMS 조회
	public DataSet displayMsg(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS 수정전 조회 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_uptdisplay", input);
			anyframe.log.Logger.debug.println("SMS 수정전 조회 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
	
	////lp용 - update
	public DataSet findModify(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS 수정 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_lp_upt", input);
			anyframe.log.Logger.debug.println("SMS 수정 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////cu용 - SMS 조회
	public DataSet displayMsg_cu(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS 수정전 조회 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_cu_uptdisplay", input);
			anyframe.log.Logger.debug.println("SMS 수정전 조회 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
	
	////cu용 - update
	public DataSet findModify_cu(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS 수정 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_cu_upt", input);
			anyframe.log.Logger.debug.println("SMS 수정 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}

		
}