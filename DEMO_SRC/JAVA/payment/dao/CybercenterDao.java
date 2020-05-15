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

	////WebDB Process에서 승인 처리상태 조회 : 80이 있는지 확인
	////2006-09-07:김보영:0601914:승인 시에 WEBDB에서 이미 승인 된 건이 없는지 체크하는 부분 추가
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
	////WebDB Payment에서 승인 처리상태 조회 
	////2006-09-07:김보영:0601914:승인 시에 WEBDB에서 이미 승인 된 건이 없는지 체크하는 부분 추가
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
	////전송번호 저장
	public DataSet Sendingsave(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("전송번호 저장  input==========="+input);			
			DataSet output = executor.execute("/changeminer/usp_wb_sending_update", input);
			anyframe.log.Logger.debug.println("전송번호 저장 output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

	////전송번호 검색
	public DataSet findSend(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("전송번호 검색  input==========="+input);			
			DataSet output = executor.execute("/changeminer/wb_payment_sending", input);
			anyframe.log.Logger.debug.println("전송번호 검색 output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	////은행처리지연
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance(); 
			////anyframe.log.Logger.debug.println("은행처리지연  input1==========="+input);						
			DataSet output = executor.execute("/changeminer/ksps0450", input);
			anyframe.log.Logger.debug.println("은행처리지연 output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	////WB_PAYMENT에서 접수번호로 한 ROW 검색
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


				//// 2007 5월 29일 LPCODE가 없으면 계약정보를 가져와서 가져오도록 수정
				String lpcode = "";

				lpcode = Util.nvl(output.getText("lp_id"));

				//// LPCODE가 있으면 바로 넣는다.
				if("".equals(lpcode) == false) {

					lpcode = output.getText("lp_id");	
					input2.put("lpcode", lpcode);

					System.out.println("[LPCODE조회]LPCODE가 있으면 바로 넣는다. lpcode : [" + lpcode + "]");
				//// LPCODE가 없으면 계약정보에서 조회해 온다. 
				}else {
					input1.put("ssn", output.getText("payor_ssn"));

					System.out.println(output.getText("payor_ssn"));
					InteractionBean interact4 = new InteractionBean();																		
					DataSet output4 = interact1.execute("/changeminer/contract_sum", input1);////3500			

					int cnt4 = output4.getCount("plcyno");
					
					for(int j=0;j<cnt4;j++)
					{
						System.out.println("policy : [" + policy + "] output4[" + output4.getText("plcyno",j) + "]");
						//// 같은 증번의 담당LP의 LPCODE를 가져온다. 
						if(policy.equals(output4.getText("plcyno",j).trim()))
						{
							lpcode = output4.getText("svclp",j);
							input2.put("lpcode", lpcode);
						}
					}
					System.out.println("[LPCODE조회]LPCODE가 없으면 계약정보에서 조회해 온다. lpcode : [" + lpcode + "]");
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
	
	
	////실지급금 저장
	public DataSet Realpaysave(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("실지급금 저장  input==========="+input);			
			DataSet output = executor.execute("/changeminer/usp_wb_realpay_update", input);
			anyframe.log.Logger.debug.println("실지급금 저장 output==========="+output);						
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////웹에서 신청한 고객의 당일 약대 지급액이 얼마인지 확인
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