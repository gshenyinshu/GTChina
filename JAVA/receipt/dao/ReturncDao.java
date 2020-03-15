package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturncDao
{
	
	////반송정보리스트
	public DataSet findReturnc(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/return_manager", input);
			anyframe.log.Logger.debug.println("반송사유관리 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

   public DataSet findReturncCount(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/return_count", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }	
    
	////사용자삭제
	public DataSet delReturnc(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("반송사유삭제 ----  input : "+input);	
			DataSet output = executor.execute("/changeminer/return_del", input);
			anyframe.log.Logger.debug.println("반송사유삭제 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	    						
}