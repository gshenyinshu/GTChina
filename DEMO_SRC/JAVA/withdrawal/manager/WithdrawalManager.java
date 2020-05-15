package gtone.changeminer.withdrawal.manager;

import java.util.HashMap;

import anyframe.data.DataSet;
import anyframe.log.Logger;
import gtone.changeminer.withdrawal.dao.WithdrawalDao;

public class WithdrawalManager
{
	private WithdrawalManager()
	{}

	private static WithdrawalManager instance = null;

	public static WithdrawalManager getInstance(){
		if( instance == null )
			instance = new WithdrawalManager();

		return instance; 
	}


	public static WithdrawalManager getInstance(boolean newInstance){
		if (newInstance)
			instance = null; //comment

		return getInstance();
	}

	private WithdrawalDao getWithdrawalDao(){
		return new WithdrawalDao();
	}
	
	public DataSet findList(DataSet input) throws Exception{
		WithdrawalDao dao = getWithdrawalDao();
		return dao.findList(input);
	}
		
	public DataSet findListCount(DataSet input) throws Exception{
		WithdrawalDao dao = getWithdrawalDao();
		return dao.findListCount(input);
	}

	/**
	 * Schedule management
	 * @param   DataSet 
	 * @return  void
	 */
	public DataSet selectContract(DataSet input) throws Exception{
		WithdrawalDao dao  = getWithdrawalDao() ;
		return dao.selectContract(input) ;
	}

	public void save(DataSet input) throws Exception{
		WithdrawalDao dao = getWithdrawalDao();
		dao.save(input);
	}
	
}


