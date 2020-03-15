package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class DividendsearchDao
{
	////약관대출 기본항목
	public DataSet findDividendsearch(DataSet input) throws Exception
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
	
	////배당금
	public DataSet Inpayment(DataSet input, DataSet input2) throws Exception
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
				output.put("bank_name", "");
			}
			else
			{
				input1.put("bank_code", bank_code);
				
				InteractionBean interact1 = new InteractionBean();		
				DataSet output1 = interact1.execute("/changeminer/bank_name", input1);				
				output.put("bank_name", output1.getText("bank_name"));													
			}			
			
			String proc_emp_no = input2.getText("proc_emp_no");
			if(proc_emp_no.trim().equals("") || proc_emp_no.trim() == null)
			{
				output.put("auth_cd", "");
				output.put("emp_nm", "");
			}
			else
			{			
				InteractionBean interact2 = new InteractionBean();		
				DataSet output2 = interact2.execute("/changeminer/auth_read", input2);				
				output.put("auth_cd", output2.getText("auth_cd"));
				output.put("emp_nm", output2.getText("emp_nm"));
			}			

			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}		
}