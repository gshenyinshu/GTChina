package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class AddPremiumpaidinfoDao
{
	////약관대출 기본항목
	public DataSet findPremiumpaidinfo(DataSet input) throws Exception
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
	
	////증번에 대한 기본정보 display
	public DataSet findUserinfo(DataSet input, DataSet input1) throws Exception
	{		
		try
		{			
			DataSet input3 = new DataSet();
			DataSet input4 = new DataSet();
			DataSet input5	= new DataSet();		
			
			
			Executor executor = null;
			executor = Executor.getInstance();			
			DataSet output = executor.execute("/changeminer/coveragenormal", input);////3501			
		
			InteractionBean interact1 = new InteractionBean();																		
			DataSet output1 = interact1.execute("/changeminer/contract_sum", input1);////3500			
			
			String policy = output.getText("plyno").trim();
			
			input4.put("deptcd","INT");
			input4.put("init","     ");
			input4.put("plcyno",policy);
			
			input5.put("policy", policy);
			
			int cnt = output1.getCount("plcyno");
			for(int i=0;i<cnt;i++)
			{
				if(policy.equals(output1.getText("plcyno",i).trim()))
				{
					output.put("issdate",output1.getText("issdate",i).trim());////계약일
					output.put("ownna",output1.getText("ownna",i).trim());////계약자	
					output.put("insna",output1.getText("insna",i).trim());////피보험자 
					output.put("nfopt",output1.getText("nfopt",i).trim());////실효선택
					output.put("ptd",output1.getText("ptd",i).trim());////차기납일일
					output.put("fund",output1.getText("fund",i).trim());////펀드유형
					output.put("svclpname",output1.getText("svclpname",i).trim());////LP명
					output.put("hcind",output1.getText("hcind",i).trim());////가압류					
					output.put("payna",output1.getText("payna",i).trim());////예금주
					output.put("fbsday",output1.getText("fbsday",i).trim());////이체일
					output.put("bankcode",output1.getText("bankcode",i).trim());////은행코드
					output.put("bankacc",output1.getText("bankacc",i).trim());////계좌번호
						
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
					
					/*
					InteractionBean interact4 = new InteractionBean();
					DataSet output4 = interact4.execute("/changeminer/ksps0300", input5);				

					output.put("modp", output4.getText("modp"));////납방보험료		
					output.put("ptd", output4.getText("ptd"));	////차기납입일	
					*/
				}
				else
				{
					continue;
				}
			}
			anyframe.log.Logger.debug.println("보험료 수납 ----------------: "+output);				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

}
