package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class RestingpaidupDao
{
	////�2�0�7�1�9�7�4�9 �8�9�2�2
	public DataSet findRestingpaidup(DataSet input) throws Exception
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

	////�6�5�0�5�1�5�6�7�8�5 �2�1�4�0
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
}