package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.ReturnplDao;

public  class ReturnplManager
{
	private ReturnplManager()
	{}

	private static ReturnplManager instance = null;

	public static ReturnplManager getInstance()
	{
		if( instance == null )
			instance = new ReturnplManager();

		return instance; 
	}

	public static ReturnplManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////���ǹ�ȣ�� ��Ÿ���� select
	public DataSet findPolicyreturnList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnplDao dao = getReturnplDao();
			anyframe.log.Logger.debug.println("manage���� findPolicyreturnList-----------------: "+input);				
			output = dao.findPolicyreturnList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�Ѱ���
	public DataSet findPolicyreturn(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnplDao dao = getReturnplDao();
			anyframe.log.Logger.debug.println("manage���� findPolicyreturn-----------------: "+input);					
			output = dao.findPolicyreturn(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private ReturnplDao getReturnplDao()
	{
		return new ReturnplDao();
	}
}

