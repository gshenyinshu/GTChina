package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.DisplayallDao;

public  class DisplayallManager
{
	private DisplayallManager()
	{}

	private static DisplayallManager instance = null;

	public static DisplayallManager getInstance()
	{
		if( instance == null )
			instance = new DisplayallManager();

		return instance; 
	}

	public static DisplayallManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}


	////반송사유 display
	public DataSet displayAll(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			DisplayallDao dao = getDisplayallDao();
				
			output = dao.displayAll(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

			
	private DisplayallDao getDisplayallDao()
	{
		return new DisplayallDao();
	}
}

