package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PolicyviewDao;

public  class PolicyviewManager
{
	private PolicyviewManager()
	{}

	private static PolicyviewManager instance = null;

	public static PolicyviewManager getInstance()
	{
		if( instance == null )
			instance = new PolicyviewManager();

		return instance; 
	}

	public static PolicyviewManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////증권번호및 기타정보 select
	public DataSet findPolicyviewList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyviewDao dao = getPolicyviewDao();
anyframe.log.Logger.debug.println("manage에서 findPolicyviewList-----------------: "+input);				
			output = dao.findPolicyviewList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////총갯수
	public DataSet findPolicyview(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyviewDao dao = getPolicyviewDao();
			output = dao.findPolicyview(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private PolicyviewDao getPolicyviewDao()
	{
		return new PolicyviewDao();
	}
}

