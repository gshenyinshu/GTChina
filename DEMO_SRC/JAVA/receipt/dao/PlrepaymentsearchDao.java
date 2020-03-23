package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PlrepaymentsearchDao
{
	////약관대출 기본항목
	public DataSet findPlrepaymentsearch(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/m0161sp1", input);
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////계약일을 가져오기 위한 내용
	public DataSet findIssdate(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/coveragenormal", input);
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	
}