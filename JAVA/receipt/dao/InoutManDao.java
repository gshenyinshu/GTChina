/**
 * Title       	: InoutManDao.java
 * Description 	: 홈페이지 사이버 센터 로그인 상태 변경 
 * Company     : gtone
 * @author 	: Kim Bo Young
 * @version 1.0
 */
package gtone.changeminer.receipt.dao;

import anyframe.data.DataSet;

import gtone.changeminer.common.dao.Executor;

import anyframe.data.*;

import anyframe.log.*;

import gtone.changeminer.common.utility.*;

public  class InoutManDao{
	
	////save inout status 
	public void changeInoutSts(DataSet input) throws Exception{
		try{
			
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("changeInoutSts ----  input : "+input);	
			executor.execute("/changeminer/save_inout_sts", input);		
			
		}catch(Exception e){
			throw(e);	
		}
	}

	////get inout status
	public DataSet getInoutSts(DataSet input) throws Exception{
		try{
			Executor executor = null;
			executor = Executor.getInstance();
			////anyframe.log.Logger.debug.println("getInoutSts ----  input : "+input);
			DataSet output = executor.execute("/changeminer/get_inout_sts", input);
			////anyframe.log.Logger.debug.println("getInoutSts ----  output : "+output);				
			return output;
			
		}catch(Exception e){
			throw(e);	
		}
	}	

}