package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnnewpopDao
{
	
	////사유저장
	public DataSet findReturnsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("반송사유내용 저장 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_add", input);
			anyframe.log.Logger.debug.println("반송내용 저장 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
	
	////사유 - update
	public DataSet Returnupt(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("사유 수정dao ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_upt", input);
			anyframe.log.Logger.debug.println("사유 수정dao ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////반송사유 - list
	public DataSet findReturndesc(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("사유 코드 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_list", input);
			anyframe.log.Logger.debug.println("사유 코드 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////반송사유 - 개별
	public DataSet Selcon(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("개별사유 코드 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sel_indiv", input);
			anyframe.log.Logger.debug.println("개별 코드 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
}