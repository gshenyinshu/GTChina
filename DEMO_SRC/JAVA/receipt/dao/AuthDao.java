package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class AuthDao
{
	
	////�������������Ʈ
	public DataSet findAuth(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/auth_manager", input);
			anyframe.log.Logger.debug.println("����ڱ��Ѱ��� ----  output : "+output);				
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
    
	////����ڻ���
	public DataSet delAuth(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/auth_del", input);
			anyframe.log.Logger.debug.println("����ڻ��� ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	    						
}