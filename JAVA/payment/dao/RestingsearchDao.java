package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class RestingsearchDao
{
	////�6�5�0�5�1�5�6�7�8�5 �8�9�2�2
	public DataSet findRestingsearch(DataSet input) throws Exception
	{		
		try
		{
			String policy = "";	
			DataSet input1 = new DataSet();
			Executor executor = null;
			executor = Executor.getInstance();	
			DataSet output = executor.execute("/changeminer/ksps3506", input);
			
			int cnt = output.getCount("plyno");
			
			for(int i=0;i<cnt;i++)
			{
				policy = output.getText("plyno",i).trim();
				if(policy.trim().length() == 0)
				{
					output.put("ownid","",i);
					output.put("ownna","",i);
				}
				else
				{
					input1.put("policy", policy);
					
					InteractionBean interact = new InteractionBean();
					DataSet output1 = interact.execute("/changeminer/ksps0300", input1);		
					output.put("ownid", output1.getText("ownid"), i);
					output.put("ownna", output1.getText("ownna"), i);					
				}
				
			}
			
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


	////�7�1�3�9
	public DataSet getApproval(DataSet input1, DataSet input, DataSet input4) throws Exception
	{		
		try
		{
			Executor executor = null;
			DataSet output1  = new DataSet();
			DataSet output2  = new DataSet();
			
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
	
			////m0191sp1 �2�1�3�4�6�3.  Action�5�7�9�3�2�1�2�3�1�9�3�5 �2�5�1�9�0�3�2�5�3�5 �4�9�9�3 �1�3�3�1�4�7�0�9 �3�9�2�7�3�4�3�7�0�9 Dao�2�3�1�9 �2�1�3�4�9�1 �1�3�2�1 �4�1�7�5 -s
			input1.put("disbyn", " ");
			input1.put("amount", "00000000000");
			////m0191sp1 �2�1�3�4�6�3.  Action�5�7�9�3�2�1�2�3�1�9�3�5 �2�5�1�9�0�3�2�5�3�5 �4�9�9�3 �1�3�3�1�4�7�0�9 �3�9�2�7�3�4�3�7�0�9 Dao�2�3�1�9 �2�1�3�4�9�1 �1�3�2�1 �4�1�7�5 -e
			input1.put("agency", "   ");

			////HOST�2�3 �2�0�7�1�9�7�4�9 �7�1�3�9 �2�1�4�0
			anyframe.log.Logger.debug.println("getApproval DAO M0191SP1 input==========="+input1);			
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/m0191sp1", input1);
			anyframe.log.Logger.debug.println("getApproval DAO M0191SP1 output==========="+output);						
			
			////M0191SP1�3�5 �9�1�7�9�8�5 �9�9�3�3 WB_PAYMENT�2�3 UPDATE						
			String rtn =  output.getText("rtn").trim();	////�7�1�7�7�4�9�9�3
			String err_msg = output.getText("errmsg1").trim() + output.getText("errmsg2").trim();////�2�3�0�7�0�3�1�7�3�1
			anyframe.log.Logger.debug.println("�2�3�0�7�0�3�1�7�3�1==========="+output.getText("errmsg2"));									
			String pay_amt = output.getText("amount").trim();////�2�5�3�1�8�6�8�5
			String rslt = "";
			if(rtn.equals("0"))			
			{
				rslt = "0";
			}
			else 
			{
				rslt = "2";
			}
						
			input2.put("policy_apln_no", input.getText("policy_apln_no"));
			input2.put("err_msg" ,err_msg);
			input2.put("pay_amt", pay_amt);
			input2.put("rslt", rslt);
			
			anyframe.log.Logger.debug.println("WB_payment UPDATE==========="+input2);				

			InteractionBean interact1 = new InteractionBean();		
			output1 = interact1.execute("/changeminer/payment_update", input2);			
			anyframe.log.Logger.debug.println("WB_payment �7�1�7�7==========="+output1);				
			
			
			////WB_PROCESS�2�3 �6�7�9�0 �7�1�7�7�7�3 UPDATE
			input3.put("policy_apln_no", input.getText("policy_apln_no"));
			input3.put("proc_emp_no", input4.getText("proc_emp_no"));////�1�7�0�7
			input3.put("proc_status", rslt);////�1�8�5�1�7�3
			input3.put("err_msg", err_msg);
			
			InteractionBean interact2 = new InteractionBean();		
			output2 = interact2.execute("/changeminer/usp_wb_process_update", input3);			
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}		
}
