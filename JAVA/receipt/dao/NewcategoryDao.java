package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class NewcategoryDao
{
	
	////사유저장
	public DataSet categorySave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("카테고리 저장 ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/categoryadd", input);
			anyframe.log.Logger.debug.println("카테고리 저장 ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
					
}