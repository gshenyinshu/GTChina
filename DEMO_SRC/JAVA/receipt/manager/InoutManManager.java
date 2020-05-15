/**
 * Title       	: InoutManManager.java
 * Description 	: 홈페이지 사이버 센터 로그인 상태 변경 
 * Company     : gtone
 * @author 	: Kim Bo Young
 * @version 1.0
 */
package gtone.changeminer.receipt.manager;

import java.util.List;

import gtone.changeminer.receipt.dao.InoutManDao;

import anyframe.data.DataSet;


public  class InoutManManager{
	private InoutManManager(){
	}

	private static InoutManManager instance = null;

	public static InoutManManager getInstance(){
		if( instance == null )
			instance = new InoutManManager();

		return instance; 
	}

	public static InoutManManager getInstance(boolean newInstance){
		if (newInstance)
			instance = null;

		return getInstance();
	}

	////save inout status 
	public void changeInoutSts(DataSet input)  throws Exception{
		try{
			
			InoutManDao dao = getInoutManDao();
			dao.changeInoutSts(input);
			
		}catch(Exception e){
			throw (e);	
		}
	}
	
	////get inout status
	public DataSet getInoutSts(DataSet input)  throws Exception{
		try
		{
			DataSet output = new DataSet();
			InoutManDao dao = getInoutManDao();
			output = dao.getInoutSts(input);
			
			return output;
		}
		
		catch(Exception e)
		{
			throw (e);	
		}		
	}
	
	private InoutManDao getInoutManDao()
	{
		return new InoutManDao();
	}

}

