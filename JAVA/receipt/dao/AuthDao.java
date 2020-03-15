package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class AuthDao
{
	
	////사용자정보리스트
	public DataSet findAuth(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/auth_manager", input);
			anyframe.log.Logger.debug.println("사용자권한관리 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

   public DataSet findAuthCount(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/auth_count", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }	
    
	////사용자삭제
	public DataSet delAuth(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/auth_del", input);
			anyframe.log.Logger.debug.println("사용자삭제 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	    						
}