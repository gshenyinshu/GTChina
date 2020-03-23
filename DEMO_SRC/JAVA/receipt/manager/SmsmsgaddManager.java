package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.SmsmsgaddDao;

public  class SmsmsgaddManager
{
	private SmsmsgaddManager()
	{}

	private static SmsmsgaddManager instance = null;

	public static SmsmsgaddManager getInstance()
	{
		if( instance == null )
			instance = new SmsmsgaddManager();

		return instance; 
	}

	public static SmsmsgaddManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////SMS ����
	public DataSet findSmssave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SmsmsgaddDao dao = getSmsmsgaddDao();
			output = dao.findSmssave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////SMS update �� ��ȸ
	public DataSet displayMsg(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SmsmsgaddDao dao = getSmsmsgaddDao();
			output = dao.displayMsg(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////lp�� update
	public DataSet findModify(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SmsmsgaddDao dao = getSmsmsgaddDao();
			output = dao.findModify(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////cu�� SMS update �� ��ȸ
	public DataSet displayMsg_cu(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SmsmsgaddDao dao = getSmsmsgaddDao();
			output = dao.displayMsg_cu(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////cu�� update
	public DataSet findModify_cu(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			SmsmsgaddDao dao = getSmsmsgaddDao();
			output = dao.findModify_cu(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


				
	private SmsmsgaddDao getSmsmsgaddDao()
	{
		return new SmsmsgaddDao();
	}
}

