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
			anyframe.log.Logger.debug.println("반송내역 display19 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_reason", input);
			anyframe.log.Logger.debug.println("반송내역 display 19----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////반송내역 저장
	public DataSet findRtnsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("반송내역 WB_PROCESS 저장19 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update", input);
			anyframe.log.Logger.debug.println("반송내역 WB_PROCESS 저장19 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////반송내역 저장1
	public DataSet findRtnsave1(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("반송내역 저장 WB_PAYMENT19----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_return_update1", input);
			anyframe.log.Logger.debug.println("반송내역 저장 WB_PAYMENT19----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	////상태변경한 상태값 저장
	public DataSet findchgSave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("상태변경한 값 저장 WB_PROCESS 저장19 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/usp_wb_chg_status", input);
			anyframe.log.Logger.debug.println("상태변경한 값 저장 WB_PROCESS 저장19 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////WB_PAYMENT에서 RSLT, ERR_MSG READ
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
	
	////업무분류코드 검색
	public DataSet findSrvc_cd(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("업무분류코드 검색 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/find_srvcode", input);
			anyframe.log.Logger.debug.println("업무분류코드 검색 ----  output : "+output);				
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}							
}