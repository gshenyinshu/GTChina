package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class ReturnnewpopDao
{
	
	////��������
	public DataSet findReturnsave(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�ݼۻ������� ���� ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_add", input);
			anyframe.log.Logger.debug.println("�ݼ۳��� ���� ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
			
	
	////���� - update
	public DataSet Returnupt(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("���� ����dao ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_upt", input);
			anyframe.log.Logger.debug.println("���� ����dao ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	

	////�ݼۻ��� - list
	public DataSet findReturndesc(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("���� �ڵ� ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/return_list", input);
			anyframe.log.Logger.debug.println("���� �ڵ� ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}	
	
	////�ݼۻ��� - ����
	public DataSet Selcon(DataSet input) throws Exception
	{		
		try
		{
			Executor executor = null;
			executor = Executor.getInstance();
			anyframe.log.Logger.debug.println("�������� �ڵ� ----  input : "+input);				
			DataSet output = executor.execute("/changeminer/sel_indiv", input);
			anyframe.log.Logger.debug.println("���� �ڵ� ----  output : "+output);				
			return output;
		}
		catch(Exception e)
		{
			throw(e);	
		}
	}						
}