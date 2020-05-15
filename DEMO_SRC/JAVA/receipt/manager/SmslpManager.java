package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.SmslpDao;

public  class SmslpManager
{
	private SmslpManager()
	{}

	private static SmslpManager instance = null;

	public static SmslpManager getInstance()
	{
		if( instance == null )
			instance = new SmslpManager();

		return instance; 
	}

	public static SmslpManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////SMS�˻�
	public DataSet findSmslpList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SmslpDao dao = getSmslpDao();
			anyframe.log.Logger.debug.println("manage���� findSmslpList-----------------: "+input);				
			output = dao.findSmslpList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	
	private SmslpDao getSmslpDao()
	{
		return new SmslpDao();
	}
}

