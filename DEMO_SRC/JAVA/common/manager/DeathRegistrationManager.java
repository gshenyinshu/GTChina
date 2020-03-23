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
					clntno[i] 	= output.getText("clntno",i).trim(); ////// �ֹι�ȣ
					rlown[i] 	= output.getText("rlown",i).trim();  ////// ����ڿ���
					rlins[i] 	= output.getText("rlins",i).trim();  ////// �Ǻ����ڿ���
					rlpyr[i] 	= output.getText("rlpyr",i).trim();  ////// ������(������)����
					rlbnf[i] 	= output.getText("rlbnf",i).trim();  ////// �����ڿ���
				}
			
				String result_arr[]	= new String[output.getCount("clntno")];
			
				////// ����� ��ȸ

				result_arr = DeathRegistration(clntno);
			
				for (int i=0;i<output.getCount("clntno");i++) {
					////// ����/����ں��� ó���� �����/�Ǻ�����/�����ڿ� ���� ����� Ȯ��

					if (jobGb.equals("P") || jobGb.equals("C")) {
						////// �����
						if (result_arr[i].equals("Y") && !"".equals(rlown[i]) && rlown[i] != null) {
							result_rtn = "1";
							return result_rtn; 
						}
						////// �Ǻ�����
						if (result_arr[i].equals("Y") && !"".equals(rlins[i]) && rlins[i] != null) {
							result_rtn = "2";
							return result_rtn; 
						}
						////// ������
						if (result_arr[i].equals("Y") && !"".equals(rlbnf[i]) && rlbnf[i] != null) {
							result_rtn = "3";
							return result_rtn; 
						}
					}
					////// ����/�ڵ���ü ó���� �����/�Ǻ����ڿ� ���� ����� Ȯ��
					if (jobGb.equals("R") || jobGb.equals("A")) {
						////// �����
						if (result_arr[i].equals("Y") && !"".equals(rlown[i]) && rlown[i] != null) {
							result_rtn = "1";
							return result_rtn; 
						}
						////// �Ǻ�����
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
