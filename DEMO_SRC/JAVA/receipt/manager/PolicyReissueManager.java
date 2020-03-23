package gtone.changeminer.receipt.manager;

import java.util.List;
import anyframe.data.DataSet;
import gtone.changeminer.receipt.dao.PolicyReissueDao;
import gtone.changeminer.receipt.form.*;

import java.util.*;////Vector�� ���
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

	////���ǹ�ȣ�� ��Ÿ���� select
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


	////�Ѱ���
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


	////���º���
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


	////���º���
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



	////�ϰ�ó���� - list��������
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


	////�ϰ�ó���� - Host����
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
	
	
	////�ϰ�ó���� - ����(msdb)
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
	


	////���̺� - list
	public List findPolicyReissue_pop_list1(DataSet input) throws Exception
	{
		try
		{
			DataSet input1 = new DataSet();
			DataSet input2 = new DataSet();
			
			
			/****************************************************************/
			////üũ�Ȱ� �������� - S
			Vector v_chkcode = new Vector();		
	        int ct  = 0;
	        String chk_code_v = input.getText("chk_code");
        	StringTokenizer stk = new StringTokenizer(chk_code_v, "/");
        	while (stk.hasMoreTokens()) {
        		v_chkcode.addElement(stk.nextToken());				
        		ct++;
        	}
			anyframe.log.Logger.debug.println("������������� - üũ�� :  ct -----------------: "+ct);	
			////üũ�Ȱ� �������� - E
			/****************************************************************/
			
			
			java.util.List list = new ArrayList();
			String policy ="";////����
	        String indate ="";////��������
	        String subcode ="";////�����
	        String param_value ="";////����+��������
			for (int i=0; i<ct; i++)
			{
			    param_value = (String)v_chkcode.elementAt(i);
	            anyframe.log.Logger.debug.println("������������� - param_value -----------------: "+param_value);	
	            
	            policy = param_value.substring(0,10);
				indate = param_value.substring(10,18);		
				subcode = param_value.substring(18);
					
	            if( subcode.equals("����") )
				{
					subcode = "H";
				}
				else
				{
					subcode = "O";
				}
				
				input1.put("indate",  	indate);////��������
		    	input1.put("policy",  	policy);////����
		    	input1.put("code",    	"3");////�������������
		    	input1.put("subcode", 	subcode);////�������������
				Logger.debug.println("������������� ---- input1 :"+input1);

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
			Logger.debug.println("������������� ---- list :"+list);
			
			
			return list;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	


	
	////���̺� - update
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

