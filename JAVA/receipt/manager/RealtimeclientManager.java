
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

	////�7�9�7�4�3�4�1�5�1�3�7�4
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
	
	////�9�4�3�5�4�7�6�7/�2�1�2�1�7�7�1�5
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
	
	////�3�1�9�4�3�3�4�7�7�1�0�7
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

	////�2�0�9�7�0�6 APL�3�1�9�4�1�8�6�5
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

	////�8�8�3�5�1�3�7�4
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

	////�1�3�2�2�1�5�6�7�5�7�9�3�1�3�7�4
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


	////APL�2�1�4�0"
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

	////APL�6�7�3�1"
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

