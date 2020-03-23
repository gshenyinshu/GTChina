package gtone.changeminer.payment.dao;

import anyframe.data.*;
import anyframe.db.*;

import gtone.changeminer.common.utility.*;

import gtone.changeminer.common.dao.Executor;

public  class CybercenterDao
{
	/////////C-W
	public DataSet findKsps2000(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("findKsps2000(ksps2000) input==========="+input);			
			DataSet output = executor.execute("/changeminer/ksps2000", input);
			anyframe.log.Logger.debug.println("findKsps2000(ksps2000) output==========="+output);						
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}

	////WebDB Process���� ���� ó������ ��ȸ : 80�� �ִ��� Ȯ��
	////2006-09-07:�躸��:0601914:���� �ÿ� WEBDB���� �̹� ���� �� ���� ������ üũ�ϴ� �κ� �߰�
	public DataSet findAppvProcessStatus(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("findKsps2000(ksps2000) input==========="+input);			
			DataSet output = executor.execute("/changeminer/appv_process_select", input);
			anyframe.log.Logger.debug.println("findAppvProcessStatus output==========="+output);						
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}
	////WebDB Payment���� ���� ó������ ��ȸ 
	////2006-09-07:�躸��:0601914:���� �ÿ� WEBDB���� �̹� ���� �� ���� ������ üũ�ϴ� �κ� �߰�
	public DataSet findAppvPaymentStatus(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("findKsps2000(ksps2000) input==========="+input);			
			DataSet output = executor.execute("/changeminer/appv_payment_select", input);
			anyframe.log.Logger.debug.println("findAppvPaymentStatus output==========="+output);						
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}
	////���۹�ȣ ����
	public DataSet Sendingsave(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("���۹�ȣ ����  input==========="+input);			
			DataSet output = executor.execute("/changeminer/usp_wb_sending_update", input);
			anyframe.log.Logger.debug.println("���۹�ȣ ���� output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

	////���۹�ȣ �˻�
	public DataSet findSend(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("���۹�ȣ �˻�  input==========="+input);			
			DataSet output = executor.execute("/changeminer/wb_payment_sending", input);
			anyframe.log.Logger.debug.println("���۹�ȣ �˻� output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////����ó������
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance(); 
			////anyframe.log.Logger.debug.println("����ó������  input1==========="+input);						
			DataSet output = executor.execute("/changeminer/ksps0450", input);
			anyframe.log.Logger.debug.println("����ó������ output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	////WB_PAYMENT���� ������ȣ�� �� ROW �˻�
	public DataSet findRecei(DataSet input) throws Exception
	{
		try
		{
			DataSet input1 = new DataSet();	  
			DataSet input2 = new DataSet();	
			
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("WB_PAYMENT one row search  input==========="+input);			
			DataSet output = executor.execute("/changeminer/wb_payment_display", input);
			anyframe.log.Logger.debug.println("WB_PAYMENT one row search output==========="+output);						
			
			int cnt = output.getCount("policy_no");
			for(int i=0;i<cnt;i++)
			{
				String policy = "";
				policy = output.getText("policy_no");
				
				input1.put("deptcd", "INT");
				input1.put("init", "CYBER");
				input1.put("plyno", policy);
				
				InteractionBean interact1 = new InteractionBean();
				DataSet output1 = interact1.execute("/changeminer/ksps0790", input1);			     					
				
				output.put("plan_nm", output1.getText("plnname"), 0);				
				
				InteractionBean interact3 = new InteractionBean();
				DataSet output3 = interact3.execute("/changeminer/coveragenormal", input1);			     					
				output.put("lstpdat", output3.getText("lstpdat"), 0);


				//// 2007 5�� 29�� LPCODE�� ������ ��������� �����ͼ� ���������� ����
				String lpcode = "";

				lpcode = Util.nvl(output.getText("lp_id"));

				//// LPCODE�� ������ �ٷ� �ִ´�.
				if("".equals(lpcode) == false) {

					lpcode = output.getText("lp_id");	
					input2.put("lpcode", lpcode);

					System.out.println("[LPCODE��ȸ]LPCODE�� ������ �ٷ� �ִ´�. lpcode : [" + lpcode + "]");
				//// LPCODE�� ������ ����������� ��ȸ�� �´�. 
				}else {
					input1.put("ssn", output.getText("payor_ssn"));

					System.out.println(output.getText("payor_ssn"));
					InteractionBean interact4 = new InteractionBean();																		
					DataSet output4 = interact1.execute("/changeminer/contract_sum", input1);////3500			

					int cnt4 = output4.getCount("plcyno");
					
					for(int j=0;j<cnt4;j++)
					{
						System.out.println("policy : [" + policy + "] output4[" + output4.getText("plcyno",j) + "]");
						//// ���� ������ ���LP�� LPCODE�� �����´�. 
						if(policy.equals(output4.getText("plcyno",j).trim()))
						{
							lpcode = output4.getText("svclp",j);
							input2.put("lpcode", lpcode);
						}
					}
					System.out.println("[LPCODE��ȸ]LPCODE�� ������ ����������� ��ȸ�� �´�. lpcode : [" + lpcode + "]");
				}
				/*
				String lpcode = "";
				lpcode = output.getText("lp_id");	
				input2.put("lpcode", lpcode);
				*/

				InteractionBean interact2 = new InteractionBean();
				DataSet output2 = interact2.execute("/changeminer/lpsm_info_search", input2);			     					
				output.put("lpname", output2.getText("lp_name"),0);
				output.put("lp_email", output2.getText("lp_email"),0);
				
				output.put("sm_code", output2.getText("sm_code"),0);
				output.put("sm_name", output2.getText("sm_name"),0);
				output.put("sm_email", output2.getText("sm_email"),0);
				
			}			

			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}		
	
	
	////�����ޱ� ����
	public DataSet Realpaysave(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("�����ޱ� ����  input==========="+input);			
			DataSet output = executor.execute("/changeminer/usp_wb_realpay_update", input);
			anyframe.log.Logger.debug.println("�����ޱ� ���� output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////������ ��û�� ���� ���� ��� ���޾��� ������ Ȯ��
	public DataSet getProcamtInfo(DataSet input) throws Exception
	{
		try
		{
			InteractionBean interact = new InteractionBean();
			////anyframe.log.Logger.debug.println("getProcamtInfo(get_procamt_info) input==========="+input);			
			DataSet output = interact.execute("/changeminer/get_procamt_info", input);
			anyframe.log.Logger.debug.println("getProcamtInfo(get_procamt_info) output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
}