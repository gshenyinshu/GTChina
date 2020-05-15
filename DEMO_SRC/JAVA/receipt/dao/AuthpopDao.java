package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class AuthpopDao
{
	
	////��������
	public DataSet findAuthsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("���ѳ��� ���� ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/auth_add", input);
			anyframe.log.Logger.debug.println("���ѳ��� ���� ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
	
	////���� - update
	public DataSet Authupt(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("���� ���� ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/auth_upt", input);
			anyframe.log.Logger.debug.println("���� ���� ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	////��Ͻ� �ߺ�üũ
	public DataSet findAuth_dup(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("��Ͻ� �ߺ�üũ ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/auth_dup_sel", input);
			anyframe.log.Logger.debug.println("��Ͻ� �ߺ�üũ ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
		
}