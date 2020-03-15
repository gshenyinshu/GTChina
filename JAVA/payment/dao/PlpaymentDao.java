package gtone.changeminer.payment.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;
////import gtone.home.cybercenter.dao.PremiumPaidDao;
////import gtone.home.common.utility.*;////Util.getTodayToYMD()
import java.util.Calendar;
import anyframe.util.*;

import java.util.*;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

//Payment DAO Class -----------
import gtone.changeminer.common.constant.*;
import gtone.changeminer.common.utility.Utility;
import gtone.changeminer.common.manager.SessionManager;
import gtone.changeminer.receipt.manager.PlrepaymentsearchManager;

//Payment DAO Class -----------
public  class PlpaymentDao
{	
	public static boolean isInit = false;
	
	public PlpaymentDao() {
		isInit = true; 
	}
	//
	public DataSet findPlpayment(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("==========="+input);				
			DataSet output = executor.execute("/changeminer/m0161sp1", input);
			anyframe.log.Logger.debug.println("==========="+output);			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	//
	public DataSet Inpayment(DataSet input, DataSet input2) throws Exception
	{		
		try
		{
			
			String bank_code = "";
			DataSet input1 = new DataSet();
			
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/wb_payment_sel", input);
			anyframe.log.Logger.debug.println(" WB_PAYMENT SEL==========="+output);							
			bank_code = output.getText("bank_cd").trim();
			if(bank_code.trim().equals("") || bank_code.trim() == null ) 										
			{
				output.put("bank_name", "");
			}
			else
			{
				input1.put("bank_code", bank_code);
				

// Input data
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
	
	//
	public DataSet confBank(DataSet input1, DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			DataSet output1  = new DataSet();
			
			executor = Executor.getInstance();
			DataSet output = executor.execute("/changeminer/ksps0340", input1);
			String rtn = "";
			rtn = output.getText("rtn").trim();						
			anyframe.log.Logger.debug.println(" RTN input==========="+rtn);			
			
			InteractionBean interact1 = new InteractionBean();		
			if(rtn.equals("0"))
			{
				anyframe.log.Logger.debug.println(" input==========="+input);
				
				output1 = interact1.execute("/changeminer/bank_conf", input);
			} else if(rtn.equals("1")) {
				output1 = interact1.execute("/changeminer/bank2_conf", input);
			}
			
			return output;
		}

		catch(Exception e)
		{    
			throw(e);	
		}
	}
	

	public DataSet findValidDay(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();	
			anyframe.log.Logger.debug.println("ValidDay ----  input : "+input);								
			DataSet output = executor.execute("/changeminer/validday", input);
			anyframe.log.Logger.debug.println("ValidDay ----  output : "+output);		
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	

	public DataSet getApproval(DataSet input1, DataSet input, DataSet input4) throws Exception
	{		
		try
		{

			Executor executor = null;
			DataSet output1  = new DataSet();
			DataSet output2  = new DataSet();
			
			DataSet input2 = new DataSet();
			DataSet input3 = new DataSet();

			String strSPName= "/changeminer/m0181sp1";
			if("Y".equals(input4.getText("variable_div"))) {
				System.out.println("--------------------");
				strSPName = "/changeminer/m0181sp5";
			}

			////HOST
			executor = Executor.getInstance();
			DataSet output = executor.execute(strSPName, input1);
			anyframe.log.Logger.debug.println("getApproval DAO " + strSPName + " output==========="+output);						
			
			////M0181SP1 WB_PAYMENT UPDATE						
			String rtn =  output.getText("rtn").trim();	
			anyframe.log.Logger.debug.println("rtn의 값은===========["+rtn+"]");					
			String err_msg = output.getText("errmsg1").trim() + output.getText("errmsg2").trim();
			String pay_amt = output.getText("netpay").trim();
			String rslt = "";
			if(rtn.equals("0"))
			{
				rslt = "0";
			}
			else if(rtn.equals("3"))
			{
				rslt = "3";
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
			anyframe.log.Logger.debug.println("WB_payment ==========="+output1);				
						
			////WB_PROCESS UPDATE
			input3.put("policy_apln_no", input.getText("policy_apln_no"));
			input3.put("proc_emp_no", input4.getText("proc_emp_no"));
			input3.put("proc_status", rslt);
			input3.put("err_msg1", err_msg);
			
			InteractionBean interact2 = new InteractionBean();		
			output2 = interact2.execute("/changeminer/usp_wb_process_update", input3);			
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	
	
	public DataSet getRecon(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			DataSet output1  = new DataSet();
			
			anyframe.log.Logger.debug.println("  input==========="+input);			
			System.out.println("  input==========="+input);			
			DataSet output = executor.execute("/changeminer/usp_wb_payment_rslt", input);
			anyframe.log.Logger.debug.println("  output==========="+output);	
			System.out.println("  output==========="+output);	
			
			anyframe.log.Logger.debug.println("  wb_process input==========="+input);			
			InteractionBean interact1 = new InteractionBean();		
			output1 = interact1.execute("/changeminer/usp_wb_process_rslt", input);			
			anyframe.log.Logger.debug.println("  wb_process  output==========="+output);	
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	
	
	////20060601 

	public DataSet Chkpayment(String policy) throws Exception
	{		
		try
		{			

			////step1. 
			Calendar cal = Calendar.getInstance();                 
			String days = ""; 
			String month = ""; 
			String year = ""; 
			String today = "";
			    
			//// Step2.
			days = String.valueOf( cal.get(Calendar.DATE) ); 
			month = String.valueOf( cal.get(Calendar.MONTH) + 1 ); 
			year = String.valueOf( cal.get(Calendar.YEAR) );
			             
			//// Step3-1.Days
			if( days.length() == 1 )        days = "0" + days;                 
			//// Step3-2.Month
			if( month.length() == 1 ) 	month = "0" + month; 
			
			//// Step4.  
			today = year + month;
				
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println(" ==========="+policy);				
			DataSet output = new DataSet();
			////	
			////PremiumPaidDao premiumPaid = new PremiumPaidDao();
			String selopt = "";
			String modx = "";
			String lstpdat = "";
			DataSet seloptSP =  getSelOption(policy);////premiumPaid.getSelOption(policy);
			////
			selopt = seloptSP.getText("option");
			modx = seloptSP.getText("modx");
			lstpdat = seloptSP.getText("lstpdat");
			output.put("selopt",            selopt);
			

			String tempdate  = today; 
			String advcnt_s  = modx;
			int advcnt_i 	 = Integer.parseInt(advcnt_s);
			
			String lpaidyy 	 = "";
			String lpaidmm 	 = "";
			String lstpdat_s = lstpdat.trim();
			if(lstpdat_s.length() > 0)
			{
				lpaidyy 	 = lstpdat.substring(0,4);
				lpaidmm 	 = lstpdat.substring(4,6);
			}
			int ilpaidyy 	 = Integer.parseInt(lpaidyy);
			int ilpaidmm 	 = Integer.parseInt(lpaidmm);
			
			int compday 	 = 0;
			compday			 = ilpaidmm + advcnt_i;
			if(compday > 12)
			{
				ilpaidyy = ilpaidyy + 1;
				compday = compday - 12;
			}
			String  compyy  = Integer.toString(ilpaidyy);
			String  compmm 	= StringFormater.fillZero(Integer.toString(compday),2);
			
			String totsum = compyy + compmm;
			String advcnt = "";
			if( Integer.parseInt(tempdate) > Integer.parseInt(totsum))
			{
				advcnt = "2";
			}
			else 
			{
				advcnt = "1";
			}	
			output.put("advcnt", advcnt);

			
			anyframe.log.Logger.debug.println(" ==========="+output);			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	
	
	////20060601 
	public DataSet Workinginfo(String today) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println(" ==========="+today);				
			DataSet input = new DataSet();
			input.put("today", today);
			DataSet output = executor.execute("/changeminer/delay_close_day", input);
			anyframe.log.Logger.debug.println("Workingday  ==========="+output);			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}


	public DataSet Working2after(String today) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet sWorkingSet = new DataSet();
			sWorkingSet.put("today", today);

			DataSet output = executor.execute("/changeminer/working2after", sWorkingSet);			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}


	public DataSet getOhterSystemStatus(DataSet input) throws Exception
	{		
		try
		{
			DataSet output = new DataSet();

			/////////////////////////////////////////////////////////////////////////////////////////////////////////
			//// 
			/////////////////////////////////////////////////////////////////////////////////////////////////////////
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet outputTemp = executor.execute("/changeminer/othersystem_capsil_status", input);
			String strTemp = "";
			if("2".equals(outputTemp.getText("rtn"))) {
				if("".equals(outputTemp.getText("msg1").trim()) == false) {
					strTemp += "[Debug] " + outputTemp.getText("msg1") + "<br>";
				}
				if("".equals(outputTemp.getText("msg2").trim()) == false) {
					strTemp += "[Output] " + outputTemp.getText("msg2") + "<br>";
				}
				if("".equals(outputTemp.getText("msg3").trim()) == false) {
					strTemp += "[Temp] " + outputTemp.getText("msg3") + "<br>";
				}
				if("".equals(outputTemp.getText("msg4").trim()) == false) {
					strTemp += "[Msg] " + outputTemp.getText("msg4") + "<br>";
				}
				if("".equals(outputTemp.getText("msg5").trim()) == false) {
					strTemp += "[Send] " + outputTemp.getText("msg5") + "<br>";
				}
				if("".equals(outputTemp.getText("msg6").trim()) == false) {
					strTemp += "[Msg] " + outputTemp.getText("msg6") + "<br>";
				}					
				
				output.put("capsil_message", strTemp);
			}

			/////////////////////////////////////////////////////////////////////////////////////////////////////////
			//// 
			/////////////////////////////////////////////////////////////////////////////////////////////////////////
			executor = Executor.getInstance();
			outputTemp = executor.execute("/changeminer/othersystem_image_status", input);

			strTemp = "";
			String strDay  = "";
			String strDay1 = "";
			String strDay2 = "";
			String strDay3 = "";
			String strDay4 = "";
			String strDay5 = "";

			if(outputTemp.getText("STATUS").length() >= 45) strDay1 = Utility.replaceDate(outputTemp.getText("STATUS").substring(5,13));
			if(outputTemp.getText("STATUS").length() >= 45) strDay2 = Utility.replaceDate(outputTemp.getText("STATUS").substring(13,21));
			if(outputTemp.getText("STATUS").length() >= 45) strDay3 = Utility.replaceDate(outputTemp.getText("STATUS").substring(21,29));
			if(outputTemp.getText("STATUS").length() >= 45) strDay4 = Utility.replaceDate(outputTemp.getText("STATUS").substring(29,37));
			if(outputTemp.getText("STATUS").length() >= 45) strDay5 = Utility.replaceDate(outputTemp.getText("STATUS").substring(37,45));
			
			if(outputTemp.getText("STATUS").length() >= 5 && outputTemp.getText("STATUS").substring(0,1).equals("Y")) {
				strTemp += "[ ] " + strDay1 + "  <br>";
			}
			if(outputTemp.getText("STATUS").length() >= 5 && outputTemp.getText("STATUS").substring(1,2).equals("Y")) {
				strTemp += "[ ] " + strDay2 + "  <br>";
			}
			if(outputTemp.getText("STATUS").length() >= 5 && outputTemp.getText("STATUS").substring(2,3).equals("Y")) {
				strTemp += "[ ] " + strDay3 + "  <br>";
			}
			if(outputTemp.getText("STATUS").length() >= 5 && outputTemp.getText("STATUS").substring(3,4).equals("Y")) {
				strTemp += "[ ] " + strDay4 + "  <br>";
			}
			if(outputTemp.getText("STATUS").length() >= 5 && outputTemp.getText("STATUS").substring(4,5).equals("Y")) {
				strTemp += "[ ] " + strDay5 + "  <br>";
			}
			System.out.println("ㅇㅇㅇ33");
			output.put("image_message", strTemp);

			/////////////////////////////////////////////////////////////////////////////////////////////////////////
			//// 
			/////////////////////////////////////////////////////////////////////////////////////////////////////////
			executor = Executor.getInstance();
			outputTemp = executor.execute("/changeminer/othersystem_callcenter_status", input);

			if(outputTemp.getText("STATUS").length() >= 9) strDay = Utility.replaceDate(outputTemp.getText("STATUS").substring(1,9));

			if(outputTemp.getText("STATUS").length() >= 1 && outputTemp.getText("STATUS").substring(0,1).equals("Y")) {
				output.put("callcenter_message", "[ ] " + strDay + "  ");
			}

			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}

	////20060615 : 
	////20060921 : 
	public DataSet getSelOption(String policy) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet input = new DataSet();
			DataSet output = new DataSet();
			input.put("plyno", policy);
			DataSet output1 =  executor.execute("/changeminer/seloption", input);
			output.put("option" , output1.getText("option"));
			InteractionBean interact = new InteractionBean();
			DataSet output2 = interact.execute("/changeminer/selmodx", input);				
			output.put("modx" , output2.getText("modx"));
			InteractionBean interact2 = new InteractionBean();
			DataSet output3 = interact2.execute("/changeminer/sellstpdat", input);
			anyframe.log.Logger.debug.println("======output3 : lstpdat==========="+output3);
			anyframe.log.Logger.debug.println("======trim()  : lstpdat==========="+output3.getText("lstpdat").trim());		
			output.put("lstpdat" , output3.getText("lstpdat").trim());
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
	

	////20080201 :  METHOD=P
	public DataSet ContractDetail(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			DataSet output = new DataSet();
			
			output =  executor.execute("/changeminer/coveragenormal", input);
			
			anyframe.log.Logger.debug.println("======ContractDetail : output ==========="+output);
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}
/*    

	public DataSet Reflash(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;			
			executor = Executor.getInstance();
			
			anyframe.log.Logger.debug.println("   input==========="+input);			
			DataSet output = executor.execute("/changeminer/ksps0450", input);
			anyframe.log.Logger.debug.println("  output==========="+output);	
			
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	
*/	
}
