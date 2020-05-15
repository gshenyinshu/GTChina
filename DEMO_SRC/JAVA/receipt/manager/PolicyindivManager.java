package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PolicyindivDao;

public  class PolicyindivManager
{
	private PolicyindivManager()
	{}

	private static PolicyindivManager instance = null;

	public static PolicyindivManager getInstance()
	{
		if( instance == null )
			instance = new PolicyindivManager();

		return instance; 
	}

	public static PolicyindivManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////증권번호및 기타정보 select
	public DataSet findPolicyindivList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyindivDao dao = getPolicyindivDao();
			anyframe.log.Logger.debug.println("manage에서 findPolicyindivList-----------------: "+input);				
			output = dao.findPolicyindivList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////총갯수
	public DataSet findPolicyindiv(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyindivDao dao = getPolicyindivDao();
			anyframe.log.Logger.debug.println("manage에서 findPolicyindiv-----------------: "+input);					
			output = dao.findPolicyindiv(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////예금주실패
	public DataSet updateBank(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyindivDao dao = getPolicyindivDao();
			anyframe.log.Logger.debug.println("manage에서 updateBank-----------------: "+input);					
			output = dao.updateBank(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}		
	
	
	////wb_master에 process_mode에 "B"로 update
	public DataSet master_upt(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyindivDao dao = getPolicyindivDao();
			output = dao.master_upt(input);
			return output;
		}
		catch(Exception e)
		{
			throw (e);	
		}
	}

	
	private PolicyindivDao getPolicyindivDao()
	{
		return new PolicyindivDao();
	}
}

