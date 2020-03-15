package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PlpaymentpaidupDao
{

	public DataSet findPlpaymentpaidup(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/ksps0800", input);
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	public DataSet findPlcynoinfo(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/m0161sp1", input);
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////Inpayment DATA
	public DataSet Inpayment(DataSet input) throws Exception
	{		
		try
		{
			
			String bank_code = "";
			DataSet input1 = new DataSet();
			
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/wb_payment_sel", input);
						
			bank_code = output.getText("bank_cd").trim();
			if(bank_code.trim().equals("") || bank_code.trim() == null ) 										
			{
			}
			else
			{
				input1.put("bank_code", bank_code);
				
				InteractionBean interact1 = new InteractionBean();		
				DataSet output1 = interact1.execute("/changeminer/bank_name", input1);				
				output.put("bank_name", output1.getText("bank_name"));													
			}			
			
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////Bank
	public DataSet confBank(DataSet input1, DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			DataSet output1  = new DataSet();
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/ksps0340", input1);
			String rtn = "";
			rtn = output.getText("rtn");			
			
anyframe.log.Logger.debug.println("  input==========="+input);			
			if(rtn.equals("0"))
			{
				InteractionBean interact1 = new InteractionBean();		
				output1 = interact1.execute("/changeminer/bank_conf", input);
			}			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}			
}