package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PlpaymentinfoDao
{
	////find Payment Info.
	public DataSet findPlpaymentinfo(DataSet input) throws Exception
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
	
	////User display
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
					output.put("issdate",output1.getText("issdate",i).trim());
					output.put("ownna",output1.getText("ownna",i).trim());
					output.put("insna",output1.getText("insna",i).trim());
					output.put("nfopt",output1.getText("nfopt",i).trim());
					output.put("ptd",output1.getText("ptd",i).trim());
					output.put("fund",output1.getText("fund",i).trim());
					output.put("svclpname",output1.getText("svclpname",i).trim());
					output.put("hcind",output1.getText("hcind",i).trim());					
					output.put("payna",output1.getText("payna",i).trim());
					output.put("fbsday",output1.getText("fbsday",i).trim());
					output.put("bankcode",output1.getText("bankcode",i).trim());
					output.put("bankacc",output1.getText("bankacc",i).trim());
						
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