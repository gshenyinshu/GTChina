
package gtone.changeminer.report.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public class PayprocreportDao
{

   //this is a comment for findPolicyviewList method
   public DataSet findPolicyviewList(DataSet input)
        throws Exception
    {
        try
        {	  
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policy_list1", input);

            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }

   //comment
    public DataSet findPolicyview(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policyview_count3", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
    
   //�����ޱ��հ�� ���� (����)
    public DataSet findSumcount(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policysumcount", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
 
    //�����ޱ��հ�� ���� (����)
    public DataSet findSumcount1(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/policysumrec", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }
           
    //���ฮ��Ʈ
    public DataSet findSelBank(DataSet input)
        throws Exception
    {
        try
        {
            Executor executor = null;
            executor = Executor.getInstance();
            DataSet output = executor.execute("/changeminer/bank_list", input);
            return output;
        }
        catch(Exception e)
        {
            throw e;
        }
    }    
    
    
}