package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class PolicyReissueDao
{

   public DataSet findPolicyReissueList(DataSet input)
        throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policy_reissue_list", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }

    public DataSet findPolicyReissueCount(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policy_reissue_account", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
    
	////���º��� : ���� -> �߼�,�ݼ�
 	public DataSet findPolicyReissue_up(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("������������� - ���º��� : ���� -> �߼�,�ݼ�(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_update", input);
anyframe.log.Logger.debug.println("������������� - ���º��� : ���� -> �߼�,�ݼ�(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }


	////���º��� : ���� -> ���ó��
 	public DataSet findPolicyReissue_up1(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("������������� - ���º��� : ���� -> ���ó��(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_update1", input);
anyframe.log.Logger.debug.println("������������� - ���º��� : ���� -> ���ó��(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }



	////�ϰ�ó���� - list ��������
	public DataSet findChange_list(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("������������� ----(�ϰ�ó���� - list ��������)  input  : "+input );				
			DataSet output = executor.execute("/changeminer/policy_reissue_change_list", input);
anyframe.log.Logger.debug.println("������������� ----(�ϰ�ó���� - list ��������)  output  : "+output );				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
    }


	////�ϰ�ó���� - Host����
	public DataSet findSave_host(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("������������� ----(�ϰ�ó���� -����)  input  : "+input );				
			DataSet output = executor.execute("/changeminer/ksps1300", input);
anyframe.log.Logger.debug.println("������������� ----(�ϰ�ó���� -����)  output  : "+output );				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
    }



	////�ϰ�ó���� - ����(msdb)
	public DataSet findSave_msdb(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("������������� ----(�ϰ�ó����-����-msdb)  input  : "+input );				
			DataSet output = executor.execute("/changeminer/wb_letter_msdb_ins", input);
anyframe.log.Logger.debug.println("������������� ----(�ϰ�ó����-����-msdb)  output  : "+output );				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	



	////���̺� - list
 	public DataSet findPolicyReissue_pop_list(DataSet input)
    throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("������������� - ���̺� - list(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_pop_list", input);
anyframe.log.Logger.debug.println("������������� - ���̺� - list(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }


	////���̺� - update
 	public DataSet findPolicyReissue_label_upt(DataSet input)
    throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("������������� - ���̺� - update(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_label_upt", input);
anyframe.log.Logger.debug.println("������������� - ���̺� - update(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }


    
    
}