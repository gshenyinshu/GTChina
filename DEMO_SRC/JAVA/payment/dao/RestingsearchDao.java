package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class RestingsearchDao
{
	////�޸麸��� ����
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

	////�޸麸��� ��û
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


	////����
	public DataSet getApproval(DataSet input1, DataSet input, DataSet input4) throws Exception
	{		
		try
		{
			Executor executor = null;
			DataSet output1  = new DataSet();
			DataSet output2  = new DataSet();
			
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();
	
			////m0191sp1 ������.  ActionŬ���������� �Ǽ������� �ڵ� ����ġ�� �ӽ������� Dao���� ������ ���� �߰� -s
			input1.put("disbyn", " ");
			input1.put("amount", "00000000000");
			////m0191sp1 ������.  ActionŬ���������� �Ǽ������� �ڵ� ����ġ�� �ӽ������� Dao���� ������ ���� �߰� -e
			input1.put("agency", "   ");

			////HOST�� ������� ���� ��û
			anyframe.log.Logger.debug.println("getApproval DAO M0191SP1 input==========="+input1);			
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/m0191sp1", input1);
			anyframe.log.Logger.debug.println("getApproval DAO M0191SP1 output==========="+output);						
			
			////M0191SP1�� ���� ���� WB_PAYMENT�� UPDATE						
			String rtn =  output.getText("rtn").trim();	////����ڵ�
			String err_msg = output.getText("errmsg1").trim() + output.getText("errmsg2").trim();////�����޼���
			anyframe.log.Logger.debug.println("�����޼���==========="+output.getText("errmsg2"));									
			String pay_amt = output.getText("amount").trim();////�����ޱ�
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
			anyframe.log.Logger.debug.println("WB_payment ���==========="+output1);				
			
			
			////WB_PROCESS�� �ش� ����� UPDATE
			input3.put("policy_apln_no", input.getText("policy_apln_no"));
			input3.put("proc_emp_no", input4.getText("proc_emp_no"));////���
			input3.put("proc_status", rslt);////���°�
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
