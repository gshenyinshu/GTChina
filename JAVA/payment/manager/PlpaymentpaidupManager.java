package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.PlpaymentpaidupDao;

public  class PlpaymentpaidupManager
{
	private PlpaymentpaidupManager()
	{}

	private static PlpaymentpaidupManager instance = null;

	public static PlpaymentpaidupManager getInstance()
	{
		if( instance == null )
			instance = new PlpaymentpaidupManager();

		return instance; 
	}

	public static PlpaymentpaidupManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////Find payment
	public DataSet findPlpaymentpaidup(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentpaidupDao dao = getPlpaymentpaidupDao();
			output = dao.findPlpaymentpaidup(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////Find Policy
	public DataSet findPlcynoinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentpaidupDao dao = getPlpaymentpaidupDao();
			output = dao.findPlcynoinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	public DataSet Inpayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentpaidupDao dao = getPlpaymentpaidupDao();
			output = dao.Inpayment(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	////Bank Dataset
	public DataSet confBank(DataSet input1, DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentpaidupDao dao = getPlpaymentpaidupDao();
			output = dao.confBank(input1, input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}		
	
	private PlpaymentpaidupDao getPlpaymentpaidupDao()
	{
		return new PlpaymentpaidupDao();
	}
}

