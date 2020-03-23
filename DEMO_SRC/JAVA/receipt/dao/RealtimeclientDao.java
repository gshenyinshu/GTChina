
package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class RealtimeclientDao
{
	
	////����������
	public DataSet findClient(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("����͸�(����������) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_client", input);
			anyframe.log.Logger.debug.println("����͸�(����������) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	


	////�ڵ���ü����
	public DataSet findAccount(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("����͸�(�ڵ���ü����) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_account", input);
			anyframe.log.Logger.debug.println("����͸�(�ڵ���ü����) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		
	
	////����öȸ/���Űź�
	public DataSet findPrivate(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("����͸�(����öȸ/���Űź�) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_private_call", input);
			anyframe.log.Logger.debug.println("����͸�(����öȸ/���Űź�) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		
	////���� APL�ڵ���ȯ
	public DataSet findRepayment(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("����͸�(���� APL�ڵ���ȯ) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_repayment", input);
			anyframe.log.Logger.debug.println("����͸�(���� APL�ڵ���ȯ) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		
	
	////���ֺ���,SNC�ΰ�Ư��,LNB,FNB
	public DataSet findBillingfre(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("����͸�(���ֺ���) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_common", input);
			anyframe.log.Logger.debug.println("����͸�(���ֺ���) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		
	
	
	////���׺����ݵ庯��
	public DataSet findFundchg(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("����͸�(���׺����ݵ庯��) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("����͸�(���׺����ݵ庯��) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}		

	////APL��û"
	public DataSet findAplin(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("����͸�(APL��û) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("����͸�(APL��û) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////APL����"
	public DataSet findAplcan(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("����͸�(APL����) ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/realtime_method", input);
			anyframe.log.Logger.debug.println("����͸�(APL����) ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
}