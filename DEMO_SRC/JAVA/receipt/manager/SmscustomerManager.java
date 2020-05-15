package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.SmscustomerDao;

public  class SmscustomerManager
{
	private SmscustomerManager()
	{}

	private static SmscustomerManager instance = null;

	public static SmscustomerManager getInstance()
	{
		if( instance == null )
			instance = new SmscustomerManager();

		return instance; 
	}

	public static SmscustomerManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}


	public DataSet findSmscustomerList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SmscustomerDao dao = getSmscustomerDao();
			output = dao.findSmscustomerList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	
	private SmscustomerDao getSmscustomerDao()
	{
		return new SmscustomerDao();
	}
}

