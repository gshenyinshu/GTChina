package gtone.changeminer.common.manager;

import gtone.changeminer.common.dao.Executor;
import anyframe.data.DataSet;

// DeathRegistration Manager Class 
public final class DeathRegistrationManager {

	/**
	 * 
	 */
	private DeathRegistrationManager() {
	}

	private static DeathRegistrationManager instance = null;

	public static DeathRegistrationManager getInstance()
	{
		if ( instance == null )
			instance = new DeathRegistrationManager();

		return instance; 
	}

	public static DeathRegistrationManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	public static String[] DeathRegistration(String[] ctlno) throws Exception {
		try {

			DataSet input  = new DataSet();
			
			for (int i=0;i<ctlno.length;i++) {
				input.put("ssno", ctlno[i], i);
			}
			
			Executor executor = Executor.getInstance();
			DataSet  output   = executor.execute("/changeminer/ksps0440", input);
			
			String temp[] = new String[output.getCount("ssno")];
			if (output.getCount("ssno") != 0) {

				for (int i=0;i<output.getCount("ssno");i++) {
					temp[i] = output.getText("ckyn",i);
				}
			}
			return temp;
			
			} catch(Exception e) {
				System.out.println("[DeathRegistration][getDeathRegistration] : error - " + e.toString());
				throw(e);
			}
	}

	public static String DeathRegistration(String ctlno) throws Exception {
		try {

			DataSet input  = new DataSet();

			input.put("ssno", ctlno, 0);
			
			Executor executor = Executor.getInstance();
			DataSet  output   = executor.execute("/changeminer/ksps0440", input);
			
			String ckyn = output.getText("ckyn",0);

			return ckyn;
			
			} catch(Exception e) {
				System.out.println("[DeathRegistration][getDeathRegistration] : error - " + e.toString());
				throw(e);
			}
	}

	public static String DeathRegistration2(String policy, String jobGb) throws Exception {
		try {

			String result_rtn = "N";
			DataSet input = new DataSet();
			
			input.put("deptcd"	, "INT");
			input.put("init"	, "     ");	
			input.put("policy"	, policy);

			Executor executor 	= Executor.getInstance();
			DataSet  output 	= executor.execute("/changeminer/ksps1140", input);
			
			String clntno[] 	= new String[output.getCount("clntno")];
			String rlown[] 		= new String[output.getCount("clntno")];
			String rlins[] 		= new String[output.getCount("clntno")];
			String rlpyr[] 		= new String[output.getCount("clntno")];
			String rlbnf[] 		= new String[output.getCount("clntno")];
			
			if (output.getText("rtn").equals("0")) {
				for (int i=0;i<output.getCount("clntno");i++) {
					clntno[i] 	= output.getText("clntno",i).trim(); ////// �3�5�0�7�0�7�6�3
					rlown[i] 	= output.getText("rlown",i).trim();  ////// �7�1�2�0�3�1�2�1�1�5
					rlins[i] 	= output.getText("rlins",i).trim();  ////// �6�1�1�5�6�7�3�1�2�1�1�5
					rlpyr[i] 	= output.getText("rlpyr",i).trim();  ////// �8�8�3�0�3�1(�2�9�8�5�3�5)�2�1�1�5
					rlbnf[i] 	= output.getText("rlbnf",i).trim();  ////// �2�1�3�4�3�1�2�1�1�5
				}
			
				String result_arr[]	= new String[output.getCount("clntno")];
			
				////// �1�7�0�4�3�1 �3�5�6�7

				result_arr = DeathRegistration(clntno);
			
				for (int i=0;i<output.getCount("clntno");i++) {
					////// �3�1�8�6/�7�1�2�0�3�1�1�3�7�4 �4�9�0�5�2�7 �7�1�2�0�3�1/�6�1�1�5�6�7�3�1/�2�1�3�4�3�1�2�3 �9�7�6�3 �1�7�0�4�3�1 �6�2�3�7

					if (jobGb.equals("P") || jobGb.equals("C")) {
						////// �7�1�2�0�3�1
						if (result_arr[i].equals("Y") && !"".equals(rlown[i]) && rlown[i] != null) {
							result_rtn = "1";
							return result_rtn; 
						}
						////// �6�1�1�5�6�7�3�1
						if (result_arr[i].equals("Y") && !"".equals(rlins[i]) && rlins[i] != null) {
							result_rtn = "2";
							return result_rtn; 
						}
						////// �2�1�3�4�3�1
						if (result_arr[i].equals("Y") && !"".equals(rlbnf[i]) && rlbnf[i] != null) {
							result_rtn = "3";
							return result_rtn; 
						}
					}
					////// �2�1�8�8/�3�1�9�4�3�3�4�7 �4�9�0�5�2�7 �7�1�2�0�3�1/�6�1�1�5�6�7�3�1�2�3 �9�7�6�3 �1�7�0�4�3�1 �6�2�3�7
					if (jobGb.equals("R") || jobGb.equals("A")) {
						////// �7�1�2�0�3�1
						if (result_arr[i].equals("Y") && !"".equals(rlown[i]) && rlown[i] != null) {
							result_rtn = "1";
							return result_rtn; 
						}
						////// �6�1�1�5�6�7�3�1
						if (result_arr[i].equals("Y") && !"".equals(rlins[i]) && rlins[i] != null) {
							result_rtn = "2";
							return result_rtn; 
						}
					}
				}
				System.out.println("[#############] : bf check - " + result_rtn);
			}
			
			return result_rtn;
			
			} catch(Exception e) {
				System.out.println("[DeathRegistration][getDeathRegistration2] : error - " + e.toString());
				throw(e);
			}
	}

}
