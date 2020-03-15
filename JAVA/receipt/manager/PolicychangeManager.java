package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.PolicychangeDao;

public  class PolicychangeManager
{
	private PolicychangeManager()
	{}

	private static PolicychangeManager instance = null;

	public static PolicychangeManager getInstance()
	{
		if( instance == null )
			instance = new PolicychangeManager();

		return instance; 
	}

	public static PolicychangeManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	
	////wb_master에서 접수건가져오기
	public DataSet findPolicychangeList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findPolicychangeList(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////wb_DB에서 값 가져오기
	public DataSet findPolicychange_wb(DataSet input,DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findPolicychange_wb(input,input1);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}



	////Host - insert
	public DataSet findPolicychange_host_insert(DataSet input,DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findPolicychange_host_insert(input,input1);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////이체일만 변경
	public DataSet findExistpolicy(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findExistpolicy(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	
	
	////wb_DB - update
	public DataSet findPolicychange_wb_update(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findPolicychange_wb_update(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////메일 전송을 위한 값 조회
	public DataSet findMail_sendmsg(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findMail_sendmsg(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////메일 전송을 위한 값 조회(자동이체신청변경, 해지, 그룹빌링)
	public DataSet findMail_sendaccount(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findMail_sendaccount(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////메일 전송을 위한 값 조회(상환)
	public DataSet findMail_repayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findMail_repayment(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	


	////메일(고객정보변경)  전송을 위한 값 조회
	public DataSet findMail_custmsg(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.findMail_custmsg(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////실제메일 전송을 위한 값 조회
	public DataSet sendMail(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.sendMail(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////메일 전송
	public DataSet sendSimpleMail(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();
			output = dao.sendSimpleMail(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////wb_master update
	public DataSet uptMaster(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();			
			output = dao.uptMaster(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////wb_디테일 update
	public DataSet uptDetail(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicychangeDao dao = getPolicychangeDao();			
			output = dao.uptDetail(input);
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

				
	private PolicychangeDao getPolicychangeDao()
	{
		return new PolicychangeDao();
	}
}

