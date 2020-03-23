package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;
// Return DAO Class
public  class ReturnDao
{
	
	
	public DataSet findReturn(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�ݼ۳��� display19 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_reason", input);
			anyframe.log.Logger.debug.println("�ݼ۳��� display 19----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////�ݼ۳��� ����
	public DataSet findRtnsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�ݼ۳��� WB_PROCESS ����19 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update", input);
			anyframe.log.Logger.debug.println("�ݼ۳��� WB_PROCESS ����19 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////�ݼ۳��� ����1
	public DataSet findRtnsave1(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�ݼ۳��� ���� WB_PAYMENT19----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update1", input);
			anyframe.log.Logger.debug.println("�ݼ۳��� ���� WB_PAYMENT19----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	////���º����� ���°� ����
	public DataSet findchgSave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("���º����� �� ���� WB_PROCESS ����19 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_chg_status", input);
			anyframe.log.Logger.debug.println("���º����� �� ���� WB_PROCESS ����19 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////WB_PAYMENT���� RSLT, ERR_MSG READ
	public DataSet findRsltread(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/wb_rslt_read", input);
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////�����з��ڵ� �˻�
	public DataSet findSrvc_cd(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�����з��ڵ� �˻� ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/find_srvcode", input);
			anyframe.log.Logger.debug.println("�����з��ڵ� �˻� ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}							
}