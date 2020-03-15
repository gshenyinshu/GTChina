package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class Returncause1Dao
{
	////카테고리내용 검색
	public DataSet selCatedesc(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("c_id  dao ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/select_cate", input);
			anyframe.log.Logger.debug.println("c_id dao ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

						
}