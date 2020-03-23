package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.PlpaymentlistDao;

// Payment List Manager Class
// Payment List Management

public  class PlpaymentlistManager
{
	private PlpaymentlistManager()
	{}

	private static PlpaymentlistManager instance = null;

	public static PlpaymentlistManager getInstance()
	{
		if( instance == null ) // initialization
			instance = new PlpaymentlistManager();

		return instance; 
	}

	public static PlpaymentlistManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	
	public DataSet findPlpaymentlist(DataSet inputdata) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentlistDao dao = getPlpaymentlistDao();
			output = dao.findPlpaymentlist(inputdata);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	public DataSet findPlcynoinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentlistDao dao = getPlpaymentlistDao();
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
			PlpaymentlistDao dao = getPlpaymentlistDao();
			output = dao.Inpayment(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	
	public DataSet confBank(DataSet input1, DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentlistDao dao = getPlpaymentlistDao();
			output = dao.confBank(input1, input);
			
			return output; //returning dataset
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}		
	
	private PlpaymentlistDao getPlpaymentlistDao()
	{
		return new PlpaymentlistDao();
	}
}

