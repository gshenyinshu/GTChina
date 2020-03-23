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
    
    
	////상태변경 : 접수 -> 발송,반송
 	public DataSet findPolicyReissue_up(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("보험증권재발행 - 상태변경 : 접수 -> 발송,반송(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_update", input);
anyframe.log.Logger.debug.println("보험증권재발행 - 상태변경 : 접수 -> 발송,반송(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }


	////상태변경 : 접수 -> 즉시처리
 	public DataSet findPolicyReissue_up1(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("보험증권재발행 - 상태변경 : 접수 -> 즉시처리(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_update1", input);
anyframe.log.Logger.debug.println("보험증권재발행 - 상태변경 : 접수 -> 즉시처리(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }



	////일괄처리시 - list 가져오기
	public DataSet findChange_list(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("보험증권재발행 ----(일괄처리시 - list 가져오기)  input  : "+input );				
			DataSet output = executor.execute("/changeminer/policy_reissue_change_list", input);
anyframe.log.Logger.debug.println("보험증권재발행 ----(일괄처리시 - list 가져오기)  output  : "+output );				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
    }


	////일괄처리시 - Host저장
	public DataSet findSave_host(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("보험증권재발행 ----(일괄처리시 -저장)  input  : "+input );				
			DataSet output = executor.execute("/changeminer/ksps1300", input);
anyframe.log.Logger.debug.println("보험증권재발행 ----(일괄처리시 -저장)  output  : "+output );				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
    }



	////일괄처리시 - 저장(msdb)
	public DataSet findSave_msdb(DataSet input) throws Exception
	{
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
anyframe.log.Logger.debug.println("보험증권재발행 ----(일괄처리시-저장-msdb)  input  : "+input );				
			DataSet output = executor.execute("/changeminer/wb_letter_msdb_ins", input);
anyframe.log.Logger.debug.println("보험증권재발행 ----(일괄처리시-저장-msdb)  output  : "+output );				
			return output;
		}

		catch(Exception e)
		{
			throw(e);	
		}
	}	



	////레이블 - list
 	public DataSet findPolicyReissue_pop_list(DataSet input)
    throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("보험증권재발행 - 레이블 - list(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_pop_list", input);
anyframe.log.Logger.debug.println("보험증권재발행 - 레이블 - list(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }


	////레이블 - update
 	public DataSet findPolicyReissue_label_upt(DataSet input)
    throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
anyframe.log.Logger.debug.println("보험증권재발행 - 레이블 - update(DAO) ======== input : "+input);
            DataSet output = executor.execute("/changeminer/policy_reissue_label_upt", input);
anyframe.log.Logger.debug.println("보험증권재발행 - 레이블 - update(DAO) ======== output : "+output);            
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }


    
    
}