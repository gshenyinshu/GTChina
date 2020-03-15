package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.ReturnpopDao;

public  class ReturnpopManager
{
	private ReturnpopManager()
	{}

	private static ReturnpopManager instance = null;

	public static ReturnpopManager getInstance()
	{
		if( instance == null )
			instance = new ReturnpopManager();

		return instance; 
	}

	public static ReturnpopManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////고객정보변경
	public DataSet findClient(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnpopDao dao = getReturnpopDao();
			output = dao.findClient(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////자동이체관련
	public DataSet findAccount(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnpopDao dao = getReturnpopDao();
			output = dao.findAccount(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////약대및 APL자동상환
	public DataSet findRepayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnpopDao dao = getReturnpopDao();
			output = dao.findRepayment(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////납주변경
	public DataSet findBillingfre(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnpopDao dao = getReturnpopDao();
			output = dao.findBillingfre(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////변액보험펀드변경
	public DataSet findFundchg(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnpopDao dao = getReturnpopDao();
			output = dao.findFundchg(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////APL신청"
	public DataSet findAplin(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnpopDao dao = getReturnpopDao();
			output = dao.findAplin(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////APL해지"
	public DataSet findAplcan(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnpopDao dao = getReturnpopDao();
			output = dao.findAplcan(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private ReturnpopDao getReturnpopDao()
	{
		return new ReturnpopDao();
	}
}

