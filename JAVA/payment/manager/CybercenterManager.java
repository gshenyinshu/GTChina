/**
 * Title       	: CybercenterManager
 * Description 	: 약관대출자동내역
 * Copyright   	: Copyright (c) 2004
 * Company     : CyberImagination
 * @author 	Son,HoJun
 * @version 1.0
 */

package gtone.changeminer.payment.manager;

import java.util.List;

import anyframe.data.DataSet;

import gtone.changeminer.payment.dao.CybercenterDao;

public  class CybercenterManager
{
	private CybercenterManager()
	{}

	private static CybercenterManager instance = null;

	public static CybercenterManager getInstance()
	{
		if( instance == null )
			instance = new CybercenterManager();

		return instance; 
	}


	public static CybercenterManager getInstance(boolean newInstance)
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
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findKsps2000(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	

	////WebDB Process에서 승인 처리상태 조회 : 80이 있는지 확인
	////2006-09-07:김보영:0601914:승인 시에 WEBDB에서 이미 승인 된 건이 없는지 체크하는 부분 추가
	public DataSet findAppvProcessStatus(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findAppvProcessStatus(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	

	////WebDB Payment에서 승인 처리상태 조회 
	////2006-09-07:김보영:0601914:승인 시에 WEBDB에서 이미 승인 된 건이 없는지 체크하는 부분 추가
	public DataSet findAppvPaymentStatus(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findAppvPaymentStatus(input);
			
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
			CybercenterDao dao = getCybercenterDao();
				
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
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findSend(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////KSPS0450
	public DataSet findIsaogong(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findIsaogong(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	////WB_PAYMENT에서 접수번호로 한 ROW 검색
	public DataSet findRecei(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.findRecei(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}
	
	////실지급금저장
	public DataSet Realpaysave(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.Realpaysave(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}	

	////웹에서 신청한 고객의 당일 약대 지급액이 얼마인지 확인
	public DataSet getProcamtInfo(DataSet input) throws Exception
	{
		try
		{
			DataSet output = null;
			CybercenterDao dao = getCybercenterDao();
				
			output = dao.getProcamtInfo(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}
	}

	private CybercenterDao getCybercenterDao()
	{
		return new CybercenterDao();
	}
}

