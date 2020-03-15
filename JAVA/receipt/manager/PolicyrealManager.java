package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PolicyrealDao;

public  class PolicyrealManager
{
	private PolicyrealManager()
	{}

	private static PolicyrealManager instance = null;

	public static PolicyrealManager getInstance()
	{
		if( instance == null )
			instance = new PolicyrealManager();

		return instance; 
	}

	public static PolicyrealManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////증권번호및 기타정보 select
	public DataSet findPolicyrealList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyrealDao dao = getPolicyrealDao();
			anyframe.log.Logger.debug.println("manage에서 findPolicyrealList-----------------: "+input);				
			output = dao.findPolicyrealList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////총갯수
	public DataSet findPolicyreal(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyrealDao dao = getPolicyrealDao();
			anyframe.log.Logger.debug.println("manage에서 findPolicyreal-----------------: "+input);					
			output = dao.findPolicyreal(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private PolicyrealDao getPolicyrealDao()
	{
		return new PolicyrealDao();
	}
}

