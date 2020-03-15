package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.AddPremiumpaidinfoDao;

public  class AddPremiumpaidinfoManager
{
	private AddPremiumpaidinfoManager()
	{}

	private static AddPremiumpaidinfoManager instance = null;

	public static AddPremiumpaidinfoManager getInstance()
	{
		if( instance == null )
			instance = new AddPremiumpaidinfoManager();

		return instance; 
	}

	public static AddPremiumpaidinfoManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}
	
	////해당 증번에 대한 경과해약금및 기본 정보를 display
	public DataSet findPremiumpaidinfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			AddPremiumpaidinfoDao dao = getPremiumpaidinfoDao();
			output = dao.findPremiumpaidinfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////해당증번에 대한 기본정보를 display
	public DataSet findUserinfo(DataSet input, DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null;
			AddPremiumpaidinfoDao dao = getPremiumpaidinfoDao();
			output = dao.findUserinfo(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	private AddPremiumpaidinfoDao getPremiumpaidinfoDao()
	{
		return new AddPremiumpaidinfoDao();
	}
}

