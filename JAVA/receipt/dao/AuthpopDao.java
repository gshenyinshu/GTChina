package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class AuthpopDao
{
	
	////권한저장
	public DataSet findAuthsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("권한내용 저장 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/auth_add", input);
			anyframe.log.Logger.debug.println("권한내용 저장 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
	
	////권한 - update
	public DataSet Authupt(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("권한 수정 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/auth_upt", input);
			anyframe.log.Logger.debug.println("권한 수정 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	////등록시 중복체크
	public DataSet findAuth_dup(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("등록시 중복체크 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/auth_dup_sel", input);
			anyframe.log.Logger.debug.println("등록시 중복체크 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
		
}