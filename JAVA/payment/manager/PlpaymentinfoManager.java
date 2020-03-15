package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.PlpaymentinfoDao;

public  class PlpaymentinfoManager
{
	private PlpaymentinfoManager()
	{}

	private static PlpaymentinfoManager instance = null;

	public static PlpaymentinfoManager getInstance()
	{
		if( instance == null )
			instance = new PlpaymentinfoManager();

		return instance; 
	}

	public static PlpaymentinfoManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////Payment Info Display
	public DataSet findPlpaymentinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentinfoDao dao = getPlpaymentinfoDao();
			output = dao.findPlpaymentinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////Find User Info
	public DataSet findUserinfo(DataSet input, DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentinfoDao dao = getPlpaymentinfoDao();
			output = dao.findUserinfo(input, input1);
			
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
			PlpaymentinfoDao dao = getPlpaymentinfoDao();
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
			PlpaymentinfoDao dao = getPlpaymentinfoDao();
			output = dao.confBank(input1, input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}		

	private PlpaymentinfoDao getPlpaymentinfoDao()
	{
		return new PlpaymentinfoDao();
	}
}

