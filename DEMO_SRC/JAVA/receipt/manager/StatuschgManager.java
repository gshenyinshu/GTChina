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

	////���ǹ�ȣ�� ��Ÿ���� select
	public DataSet findStatuschgList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			StatuschgDao dao = getStatuschgDao();
			anyframe.log.Logger.debug.println("manage���� findStatuschgList-----------------: "+input);				
			output = dao.findStatuschgList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�Ѱ���
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

