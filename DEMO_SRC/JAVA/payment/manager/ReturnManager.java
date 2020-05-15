package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.ReturnDao;

// Return Manager Class
public  class ReturnManager
{
	private ReturnManager()
	{}

	private static ReturnManager instance = null;

	public static ReturnManager getInstance()
	{
		if( instance == null )
			instance = new ReturnManager();

		return instance; 
	}

	public static ReturnManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	
	public DataSet findReturn(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnDao dao = getReturnDao();
			output = dao.findReturn(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////반송저장
	public DataSet findRtnsave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnDao dao = getReturnDao();
			output = dao.findRtnsave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////반송저장
	public DataSet findRtnsave1(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnDao dao = getReturnDao();
			output = dao.findRtnsave1(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////처리상태 변경
	public DataSet findchgSave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnDao dao = getReturnDao();
			output = dao.findchgSave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////WB_PAYMENT에서 RSLT, ERR_MSG READ
	public DataSet findRsltread(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnDao dao = getReturnDao();
			output = dao.findRsltread(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////업무분류코드
	public DataSet findSrvc_cd(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			ReturnDao dao = getReturnDao();
			output = dao.findSrvc_cd(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
			
	private ReturnDao getReturnDao()
	{
		return new ReturnDao();
	}
}

