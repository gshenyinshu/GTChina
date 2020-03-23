package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.ReturncontentDao;

public  class ReturncontentManager
{
	private ReturncontentManager()
	{}

	private static ReturncontentManager instance = null;

	public static ReturncontentManager getInstance()
	{
		if( instance == null )
			instance = new ReturncontentManager();

		return instance; 
	}

	public static ReturncontentManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////사유 저장
	public DataSet Selcontent(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturncontentDao dao = getReturncontentDao();
			output = dao.Selcontent(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

			
	private ReturncontentDao getReturncontentDao()
	{
		return new ReturncontentDao();
	}
}

