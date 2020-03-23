/**
 * Title       	: CyberRecManager
 * Description 	: 보험료수납
 * Copyright   	: Copyright (c) 2004
 * Company     : CyberImagination
 * @author 	Son,HoJun
 * @version 1.0
 */

package gtone.changeminer.receipt.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.dao.CyberRecDao;

public  class CyberRecManager
{
	private CyberRecManager()
	{}

	private static CyberRecManager instance = null;

	public static CyberRecManager getInstance()
	{
		if( instance == null )
			instance = new CyberRecManager();

		return instance; 
	}


	public static CyberRecManager getInstance(boolean newInstance)
	{
		if (newInstance)
			instance = null;

		return getInstance();
	}


	////C-W
	public DataSet findKsps2000(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
				
			output = dao.findKsps2000(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////전송번호 저장
	public DataSet Sendingsave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
				
			output = dao.Sendingsave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////전송번호 저장
	public DataSet findSend(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
				
			output = dao.findSend(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////자동이체
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
				
			output = dao.findIsaogong(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////예금주확인
	public DataSet confBank(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
			output = dao.confBank(input);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////WB_PROCESS에서 상태값 검색
	public DataSet findProcstatus(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CyberRecDao dao = getCyberRecDao();
			output = dao.findProcstatus(input);
			
			return output;
		}		
		catch(Exception e)
		{
			throw (e);	
		}
	}	
	
	private CyberRecDao getCyberRecDao()
	{
		return new CyberRecDao();
	}
}

