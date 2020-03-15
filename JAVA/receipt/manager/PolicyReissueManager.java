package gtone.changeminer.receipt.manager;

import java.util.List;
import anyframe.data.DataSet;
import gtone.changeminer.receipt.dao.PolicyReissueDao;
import gtone.changeminer.receipt.form.*;

import java.util.*;////Vector�2�3 �1�7�3�0
import anyframe.log.*;
import anyframe.Entity;
import anyframe.util.*;


public  class PolicyReissueManager
{
	private PolicyReissueManager()
	{}

	private static PolicyReissueManager instance = null;

	public static PolicyReissueManager getInstance()
	{
		if( instance == null )
			instance = new PolicyReissueManager();

		return instance; 
	}

	public static PolicyReissueManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////�3�6�7�1�0�7�6�3�0�6 �8�5�5�3�3�4�1�5 select
	public DataSet findPolicyReissueList(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyReissueDao dao = getPolicyReissueDao();
			output = dao.findPolicyReissueList(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�4�2�7�2�2�1
	public DataSet findPolicyReissueCount(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyReissueDao dao = getPolicyReissueDao();
			output = dao.findPolicyReissueCount(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	


	////�1�8�5�1�1�3�7�4
	public DataSet findPolicyReissue_up(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyReissueDao dao = getPolicyReissueDao();
			output = dao.findPolicyReissue_up(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�1�8�5�1�1�3�7�4
	public DataSet findPolicyReissue_up1(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyReissueDao dao = getPolicyReissueDao();
			output = dao.findPolicyReissue_up1(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}



	////�3�1�7�5�4�9�0�5�2�7 - list�7�5�3�9�2�7�8�5
	public DataSet findChange_list(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyReissueDao dao = getPolicyReissueDao();
			output = dao.findChange_list(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}


	////�3�1�7�5�4�9�0�5�2�7 - Host�3�3�3�2
	public DataSet findSave_host(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyReissueDao dao = getPolicyReissueDao();
			output = dao.findSave_host(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	
	////�3�1�7�5�4�9�0�5�2�7 - �3�3�3�2(msdb)
	public DataSet findSave_msdb(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyReissueDao dao = getPolicyReissueDao();
			output = dao.findSave_msdb(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	


	////�0�5�3�3�1�3 - list
	public List findPolicyReissue_pop_list1(DataSet input) throws Exception
	{
		try
		{
			DataSet input1 = new DataSet();
			DataSet input2 = new DataSet();
			
			
			/****************************************************************/
			////�4�7�5�9�9�1�7�3 �7�5�3�9�2�7�8�5 - S
			Vector v_chkcode = new Vector();		
	        int ct  = 0;
	        String chk_code_v = input.getText("chk_code");
        	StringTokenizer stk = new StringTokenizer(chk_code_v, "/");
        	while (stk.hasMoreTokens()) {
        		v_chkcode.addElement(stk.nextToken());				
        		ct++;
        	}
			anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - �4�7�5�9�7�3 :  ct -----------------: "+ct);	
			////�4�7�5�9�9�1�7�3 �7�5�3�9�2�7�8�5 - E
			/****************************************************************/
			
			
			java.util.List list = new ArrayList();
			String policy ="";////�3�6�0�7
	        String indate ="";////�3�0�2�1�3�1�3�1
	        String subcode ="";////�1�7�3�0�0�2�0�0
	        String param_value ="";////�3�6�0�7+�3�0�2�1�3�1�3�1
			for (int i=0; i<ct; i++)
			{
			    param_value = (String)v_chkcode.elementAt(i);
	            anyframe.log.Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 - param_value -----------------: "+param_value);	
	            
	            policy = param_value.substring(0,10);
				indate = param_value.substring(10,18);		
				subcode = param_value.substring(18);
					
	            if( subcode.equals("�3�1�5�2") )
				{
					subcode = "H";
				}
				else
				{
					subcode = "O";
				}
				
				input1.put("indate",  	indate);////�3�0�2�1�3�1�3�1
		    	input1.put("policy",  	policy);////�3�6�0�7
		    	input1.put("code",    	"3");////�1�5�6�7�3�6�7�1�3�9�0�9�6�8
		    	input1.put("subcode", 	subcode);////�1�5�6�7�3�6�7�1�3�9�0�9�6�8
				Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 ---- input1 :"+input1);

	            DataSet output = null;
				PolicyReissueDao dao = getPolicyReissueDao();
				output = dao.findPolicyReissue_pop_list(input1);
	            
	            
	            PolicyReissueEntity	entity = new PolicyReissueEntity();
				entity.policy	    = output.getText("policy").trim();     
				entity.name	    	= output.getText("name").trim();     
				entity.post	    	= output.getText("post").trim();     
				entity.addr1	    = output.getText("addr1").trim();     
				entity.addr2	    = output.getText("addr2").trim();     
				entity.addr3	    = output.getText("addr3").trim();     
				entity.addr4	    = output.getText("addr4").trim();     
				
				list.add(entity);		 
	        }
			Logger.debug.println("�1�5�6�7�3�6�7�1�3�9�0�9�6�8 ---- list :"+list);
			
			
			return list;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	


	
	////�0�5�3�3�1�3 - update
	public DataSet findPolicyReissue_label_upt(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			PolicyReissueDao dao = getPolicyReissueDao();
			output = dao.findPolicyReissue_label_upt(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	


		
	private PolicyReissueDao getPolicyReissueDao()
	{
		return new PolicyReissueDao();
	}
}

