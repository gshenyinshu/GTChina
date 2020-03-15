package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.StatuschgDao;

public  class StatuschgManager
{
	private StatuschgManager()
	{}

	private static StatuschgManager instance = null;

	public static StatuschgManager getInstance()
	{
		if( instance == null )
			instance = new StatuschgManager();

		return instance; 
	}

	public static StatuschgManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�3�6�7�1�0�7�6�3�0�6 �8�5�5�3�3�4�1�5 select
	public DataSet findStatuschgList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			StatuschgDao dao = getStatuschgDao();
			anyframe.log.Logger.debug.println("manage�2�3�1�9 findStatuschgList-----------------: "+input);				
			output = dao.findStatuschgList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�4�2�7�2�2�1
	public DataSet findStatuschg(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			StatuschgDao dao = getStatuschgDao();
			output = dao.findStatuschg(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////C-W
	public DataSet findKsps2000(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			StatuschgDao dao = getStatuschgDao();
				
			output = dao.findKsps2000(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	
	private StatuschgDao getStatuschgDao()
	{
		return new StatuschgDao();
	}
}

