
package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.RealtimeclientDao;

public  class RealtimeclientManager
{
	private RealtimeclientManager()
	{}

	private static RealtimeclientManager instance = null;

	public static RealtimeclientManager getInstance()
	{
		if( instance == null )
			instance = new RealtimeclientManager();

		return instance; 
	}

	public static RealtimeclientManager getInstance(boolean newInstance)
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
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findClient(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	////동의철회/수신거부
	public DataSet findPrivate(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findPrivate(input);
			
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
			RealtimeclientDao dao = getRealtimeclientDao();
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
			RealtimeclientDao dao = getRealtimeclientDao();
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
			RealtimeclientDao dao = getRealtimeclientDao();
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
			RealtimeclientDao dao = getRealtimeclientDao();
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
			RealtimeclientDao dao = getRealtimeclientDao();
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
			RealtimeclientDao dao = getRealtimeclientDao();
			output = dao.findAplcan(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private RealtimeclientDao getRealtimeclientDao()
	{
		return new RealtimeclientDao();
	}
}

