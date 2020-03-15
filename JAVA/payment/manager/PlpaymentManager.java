
package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.PlpaymentDao;

//Payment Manager Class
//Payment Manager Class modified

public  class PlpaymentManager
{
	private PlpaymentManager()
	{}

	private static PlpaymentManager instance = null;

	public static PlpaymentManager getInstance()
	{
		if( instance == null )
			instance = new PlpaymentManager();

		return instance; 
	}

	public static PlpaymentManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	public DataSet findPlpayment(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.findPlpayment(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	public DataSet Inpayment(DataSet input, DataSet input1) throws Exception
	{
		try
		{
			DataSet output = null; // initialize dataset object
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.Inpayment(input, input1);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	public DataSet confBank(DataSet input1, DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.confBank(input1, input);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	////Vaild Date
	public DataSet findValidDay(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			//PlpaymentDao dao = getPlpaymentDao();
			PlpaymentDao dao = getPlpaymentDao();				
			output = dao.findValidDay(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}  	
	
	
	public DataSet getApproval( DataSet input1, DataSet input2, DataSet input3) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.getApproval(input1, input2, input3);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}		


	public DataSet getRecon( DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.getRecon(input);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}		

	////20060601 
	public DataSet Chkpayment( String policy) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.Chkpayment(policy);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////20060601 
	public DataSet Workinginfo( String today) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.Workinginfo(today);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	//// 
	public DataSet Working2after( String today) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.Working2after(today);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	//// 
	public DataSet getOhterSystemStatus( DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.getOhterSystemStatus(input);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////20080201 : METHOD=P
	public DataSet ContractDetail(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.ContractDetail(input);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
/*    
	public DataSet Reflash(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PlpaymentDao dao = getPlpaymentDao();
			output = dao.Reflash(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	} 
 */   



		
	private PlpaymentDao getPlpaymentDao()
	{
		if( PlpaymentlistDao.isInit == false ) {
			isInit = true;
		}
		return new PlpaymentDao();
	}
}

