//////작성자 : 유섭교 2006.05.30

package gtone.changeminer.common.manager;

import anyframe.data.DataSet;
import anyframe.log.Logger;
import gtone.changeminer.common.dao.CyberIndexDao;

public  class CyberIndexManager
{
	private CyberIndexManager()
	{}

	private static CyberIndexManager instance = null;

	public static CyberIndexManager getInstance(){
		if ( instance == null )
			instance = new CyberIndexManager();

		return instance; 
	}


	public static CyberIndexManager getInstance(boolean newInstance){
		if (newInstance)
			instance = null;

		return getInstance();
	}

	private CyberIndexDao getCyberIndexDao(){
		return new CyberIndexDao();
	}
	
	public DataSet findList(DataSet input) throws Exception{
		CyberIndexDao dao = getCyberIndexDao();
		return dao.findList(input);
	}
	
	public DataSet findListAdd(DataSet input) throws Exception{
		CyberIndexDao dao = getCyberIndexDao();
		return dao.findListAdd(input);
	} 
	
	public DataSet findPubStat(DataSet input) throws Exception{
		CyberIndexDao dao = getCyberIndexDao();
		return dao.findPubStat(input); 
	} 
	
	public void causeAdd(DataSet input) throws Exception{
		CyberIndexDao dao = getCyberIndexDao();
		Logger.debug.println("causeAdd Manager "+input);
		dao.causeAdd(input);
	}
	
	public DataSet findCause(DataSet input) throws Exception{
		CyberIndexDao dao = getCyberIndexDao();
		return dao.findCause(input); 
	}
	
	public String findCauseTotal(DataSet input) throws Exception{
		CyberIndexDao dao = getCyberIndexDao();
		return dao.findCauseTotal(input); 
	}
	/*
	public DataSet findStandardList() throws Exception{
		CyberIndexDao dao = getCyberIndexDao();
		return dao.findStandardList(); 
	}
	
	public void findStandardUpdate(DataSet input) throws Exception{
		CyberIndexDao dao = getCyberIndexDao();
		dao.findStandardUpdate(input); 
	}*/
}


