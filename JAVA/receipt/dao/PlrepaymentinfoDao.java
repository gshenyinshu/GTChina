package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PlrepaymentinfoDao
{
	////�2�0�7�1�1�8�6�5 �8�5�1�9�6�0�0�8
	public DataSet findPlrepaymentinfo(DataSet input) throws Exception
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
	
	////�3�6�0�7�2�3 �9�7�6�3 �8�5�1�9�3�4�1�5 display
	public DataSet findUserinfo(DataSet input, DataSet input1) throws Exception
	{		
		try
		{			
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			
			
			
			Executor executor = null;
			executor = Executor.getInstance();			
			DataSet output = executor.execute("/changeminer/coveragenormal", input);////3501			
		
			InteractionBean interact1 = new InteractionBean();																		
			DataSet output1 = interact1.execute("/changeminer/contract_sum", input1);////3500			
			
			String policy = output.getText("plyno").trim();
			
			input4.put("deptcd","INT");
			input4.put("init","     ");
			input4.put("plcyno",policy);
			
			int cnt = output1.getCount("plcyno");
					
			for(int i=0;i<cnt;i++)
			{
				
				if(policy.equals(output1.getText("plcyno",i).trim()))
				{
					output.put("issdate",output1.getText("issdate",i).trim());////�7�1�2�0�3�1
					output.put("ownna",output1.getText("ownna",i).trim());////�7�1�2�0�3�1	
					output.put("insna",output1.getText("insna",i).trim());////�6�1�1�5�6�7�3�1
					output.put("nfopt",output1.getText("nfopt",i).trim());////�2�5�6�5�1�3�5�2
					output.put("ptd",output1.getText("ptd",i).trim());////�4�7�8�5�8�8�3�1�3�1
					output.put("fund",output1.getText("fund",i).trim());////�5�7�9�3�3�9�6�8
					output.put("svclpname",output1.getText("svclpname",i).trim());////LP�0�2
					output.put("hcind",output1.getText("hcind",i).trim());////�7�5�2�0�0�1					
					output.put("payna",output1.getText("payna",i).trim());////�2�9�8�5�3�5
					output.put("fbsday",output1.getText("fbsday",i).trim());////�3�3�4�7�3�1
					output.put("bankcode",output1.getText("bankcode",i).trim());////�3�1�6�8�4�9�9�3
					output.put("bankacc",output1.getText("bankacc",i).trim());////�7�1�3�3�0�7�6�3
						
					String bankcode = output1.getText("bankcode",i);
					if(bankcode.trim().equals("") || bankcode.trim() == null ) 
					{
						output.put("bank_name", " ");					
					}
					else 
					{
						input3.put("bank_code", bankcode);
											
						InteractionBean interact2 = new InteractionBean();
						DataSet output2 = interact2.execute("/changeminer/bank_name", input3);				
	
						output.put("bank_name", output2.getText("bank_name"));					
					}							
															
					InteractionBean interact3 = new InteractionBean();
					DataSet output3 = interact3.execute("/changeminer/ksps0910", input4);				

					output.put("pdf", output3.getText("pdf"));					
					
				}
				else
				{
					continue;
				}
			}		
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
}