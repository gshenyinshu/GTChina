package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class SmsmsgaddDao
{
	
	////SMS����
	public DataSet findSmssave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS���� ���� ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_add", input);
			anyframe.log.Logger.debug.println("SMS���� ���� ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////lp�� - SMS ��ȸ
	public DataSet displayMsg(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS ������ ��ȸ ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_uptdisplay", input);
			anyframe.log.Logger.debug.println("SMS ������ ��ȸ ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
	
	////lp�� - update
	public DataSet findModify(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS ���� ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_lp_upt", input);
			anyframe.log.Logger.debug.println("SMS ���� ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////cu�� - SMS ��ȸ
	public DataSet displayMsg_cu(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS ������ ��ȸ ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_cu_uptdisplay", input);
			anyframe.log.Logger.debug.println("SMS ������ ��ȸ ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
	
	////cu�� - update
	public DataSet findModify_cu(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("SMS ���� ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sms_cu_upt", input);
			anyframe.log.Logger.debug.println("SMS ���� ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}

		
}