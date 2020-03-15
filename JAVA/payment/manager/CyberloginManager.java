package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.CyberloginDao;

public  class CyberloginManager
{
	private CyberloginManager()
	{}

	private static CyberloginManager instance = null;

	public static CyberloginManager getInstance()
	{
		if( instance == null )
			instance = new CyberloginManager();

		return instance; 
	}

	public static CyberloginManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	public DataSet findLogin(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberloginDao dao = getCyberloginDao();
			output = dao.findLogin(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

		
	private CyberloginDao getCyberloginDao()
	{
		return new CyberloginDao();
	}
}

