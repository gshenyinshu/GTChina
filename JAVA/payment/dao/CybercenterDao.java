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

	////WebDB Process�2�3�1�9 �2�2�3�7 �4�9�0�5�1�8�5�1 �3�5�6�7 : 80�3�3 �3�3�8�9�3�1 �6�2�3�7
	////2006-09-07:�8�1�1�5�2�2:0601914:�2�2�3�7 �2�7�2�3 WEBDB�2�3�1�9 �3�3�0�3 �2�2�3�7 �9�1 �7�1�3�3 �2�3�8�9�3�1 �4�7�5�9�6�9�8�9 �1�5�1�9 �4�1�7�5
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
	////WebDB Payment�2�3�1�9 �2�2�3�7 �4�9�0�5�1�8�5�1 �3�5�6�7 
	////2006-09-07:�8�1�1�5�2�2:0601914:�2�2�3�7 �2�7�2�3 WEBDB�2�3�1�9 �3�3�0�3 �2�2�3�7 �9�1 �7�1�3�3 �2�3�8�9�3�1 �4�7�5�9�6�9�8�9 �1�5�1�9 �4�1�7�5
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
	////�3�7�2�2�0�7�6�3 �3�3�3�2
	public DataSet Sendingsave(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("�3�7�2�2�0�7�6�3 �3�3�3�2  input==========="+input);			
			DataSet output = executor.execute("/changeminer/usp_wb_sending_update", input);
			anyframe.log.Logger.debug.println("�3�7�2�2�0�7�6�3 �3�3�3�2 output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

	////�3�7�2�2�0�7�6�3 �7�3�1�6
	public DataSet findSend(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("�3�7�2�2�0�7�6�3 �7�3�1�6  input==========="+input);			
			DataSet output = executor.execute("/changeminer/wb_payment_sending", input);
			anyframe.log.Logger.debug.println("�3�7�2�2�0�7�6�3 �7�3�1�6 output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////�3�1�6�8�4�9�0�5�3�1�2�5
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance(); 
			////anyframe.log.Logger.debug.println("�3�1�6�8�4�9�0�5�3�1�2�5  input1==========="+input);						
			DataSet output = executor.execute("/changeminer/ksps0450", input);
			anyframe.log.Logger.debug.println("�3�1�6�8�4�9�0�5�3�1�2�5 output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	////WB_PAYMENT�2�3�1�9 �3�0�2�1�0�7�6�3�0�9 �6�3 ROW �7�3�1�6
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


				//// 2007 5�3�3 29�3�1 LPCODE�7�5 �2�3�3�7�0�5 �7�1�2�0�3�4�1�5�0�7 �7�5�3�9�2�5�1�9 �7�5�3�9�2�7�9�3�0�0 �2�1�3�4
				String lpcode = "";

				lpcode = Util.nvl(output.getText("lp_id"));

				//// LPCODE�7�5 �3�3�3�7�0�5 �0�1�0�9 �8�0�8�9�9�9.
				if("".equals(lpcode) == false) {

					lpcode = output.getText("lp_id");	
					input2.put("lpcode", lpcode);

					System.out.println("[LPCODE�3�5�6�7]LPCODE�7�5 �3�3�3�7�0�5 �0�1�0�9 �8�0�8�9�9�9. lpcode : [" + lpcode + "]");
				//// LPCODE�7�5 �2�3�3�7�0�5 �7�1�2�0�3�4�1�5�2�3�1�9 �3�5�6�7�6�7 �2�1�9�9. 
				}else {
					input1.put("ssn", output.getText("payor_ssn"));

					System.out.println(output.getText("payor_ssn"));
					InteractionBean interact4 = new InteractionBean();																		
					DataSet output4 = interact1.execute("/changeminer/contract_sum", input1);////3500			

					int cnt4 = output4.getCount("plcyno");
					
					for(int j=0;j<cnt4;j++)
					{
						System.out.println("policy : [" + policy + "] output4[" + output4.getText("plcyno",j) + "]");
						//// �7�0�3�1 �3�6�0�7�3�5 �9�5�9�0LP�3�5 LPCODE�0�7 �7�5�3�9�2�1�9�9. 
						if(policy.equals(output4.getText("plcyno",j).trim()))
						{
							lpcode = output4.getText("svclp",j);
							input2.put("lpcode", lpcode);
						}
					}
					System.out.println("[LPCODE�3�5�6�7]LPCODE�7�5 �2�3�3�7�0�5 �7�1�2�0�3�4�1�5�2�3�1�9 �3�5�6�7�6�7 �2�1�9�9. lpcode : [" + lpcode + "]");
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
	
	
	////�2�5�3�1�8�6�8�5 �3�3�3�2
	public DataSet Realpaysave(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("�2�5�3�1�8�6�8�5 �3�3�3�2  input==========="+input);			
			DataSet output = executor.execute("/changeminer/usp_wb_realpay_update", input);
			anyframe.log.Logger.debug.println("�2�5�3�1�8�6�8�5 �3�3�3�2 output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////�3�0�2�3�1�9 �2�1�4�0�6�3 �7�9�7�4�3�5 �9�0�3�1 �2�0�9�7 �3�1�8�6�2�2�3�3 �2�3�0�3�3�7�3�1 �6�2�3�7
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