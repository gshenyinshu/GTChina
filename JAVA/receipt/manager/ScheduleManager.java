/**
 * Title       : 
 * Description : Schedule manager
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author       Sang-Mi Lee
 * @version 1.0
 */ 
package gtone.changeminer.receipt.manager;

import java.util.HashMap ;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.form.ScheduleForm ;
import gtone.changeminer.receipt.dao.ScheduleDao ;
import gtone.changeminer.receipt.action.ScheduleCalendar ;

public  class ScheduleManager{

    private static ScheduleManager instance = null ;

    private ScheduleManager(){
    }

    public static ScheduleManager getInstance(){
        if(instance == null)
            instance = new ScheduleManager();
        return instance ;
    }

	public static ScheduleManager getInstance(boolean newInstance){
		if (newInstance)
			instance = null;
		return getInstance();
	}

	private ScheduleDao getScheduleDao(){
		return new ScheduleDao();
	}
 
    /**
     * Schedule �0�3�0�7�1�5�8�5
     * @param   DataSet 
     * @return  
     */  
	public DataSet readView(ScheduleForm form) throws Exception{
		try{
			ScheduleDao dao = getScheduleDao() ;
			return dao.readView(form) ;
		}catch (Exception e){
			throw (e);
		}
	}

    /**
     * Schedule �0�3�0�7�2�9�8�5
     * @param   DataSet 
     * @return  void
     */
	public boolean write(ScheduleForm form) throws Exception{
        boolean rst = false ;
		try{

			ScheduleDao dao = getScheduleDao() ;
            rst = dao.write(form);
            return rst ;
		}catch (Exception e){
			throw (e);
		}
	}

    /**
     * Schedule �3�1�7�9�1�8�1�7�2�9�8�5
     * @param   DataSet 
     * @return  void
     */
	public boolean  createDay(ScheduleForm form) throws Exception{
		try{
			ScheduleDao dao = getScheduleDao() ;
            return dao.createDay(form);
		}catch (Exception e){
			throw (e);
		}
	}

    /**
     * Schedule �3�1�3�1�2�1�4�5�3�3 �2�1�3�4
     * @param   DataSet 
     * @return  void
     */
	public boolean updateDay(ScheduleForm form) throws Exception{
		try{
			ScheduleDao dao = getScheduleDao() ;
            return dao.updateDay(form);
		}catch (Exception e){
			throw (e);
		}
	}

    /**
     * Schedule �6�7�9�0�3�3�3�5 �1�5�6�7�8�8�3�1�3�1 �7�5�3�9�2�7�8�5
     * @param   DataSet 
     * @return  void
     */
	public HashMap selectContract(DataSet input) throws Exception{
		try{

			ScheduleDao dao  = null ;
            DataSet     out  = null ;
            HashMap     rst  = null ;
            String      d    = null ;
            int         temp = 0    ;

			dao  = getScheduleDao() ;
            out  = dao.selectContract(input) ;

            rst  = new HashMap() ;

            for( int i=0 ; i<out.getCount("plcyno") ; i++ ){
                d = out.getText("ptd",i).trim().substring(0,6) ;

                if( out.getText("status",i).trim().equals("1")
                        && d.equals(input.getText("date"))){

                    temp = 1 ;
                    d = out.getText("ptd",i).trim() ;
                    d = d.substring(6,8);

                    if(rst.get(d)!=null){
                        temp = Integer.parseInt((String)rst.get(d)) ;
                        temp++ ;
                    }
                    rst.put( d ,temp+"");
                }
            } 

            return rst ;
		}catch (Exception e){
			throw (e);
		}
	}

    /**
     * Schedule �6�7�9�0�3�3 �0�7�9�7 day�2�1�4�5�3�3 �7�5�3�9�2�7�8�5
     * @param   DataSet 
     * @return  void
     */
	public DataSet selectAllDay(ScheduleForm form) throws Exception{
		try{
			ScheduleDao dao     = getScheduleDao() ;
            DataSet     output  = dao.selectAllDay(form) ;
            return output ;
		}catch (Exception e){
			throw (e);
		}
	}

    /**
     * Schedule �5�8�2�2�3�7�0�9 �3�1�3�1�8�9�3�0�1�5�8�5
     * @param   DataSet 
     * @return  void
     */
	public DataSet selectDay(ScheduleForm form) throws Exception{
		try{
			ScheduleDao dao     = null ;
            DataSet     output  = null ;
            DataSet     in2     = null ;
            DataSet     out2    = null ;

			dao = getScheduleDao() ;

            if( form.getScheduleType().equals("4") ){

                in2 = new DataSet()  ;
                in2.put("deptcd", "INT"     );
                in2.put("init"  , "     "   );
                in2.put("ssn"   , form.getUserSsn());
                out2 = dao.selectContract(in2) ;

                int     cnt  = 0        ;
                String  temp = null     ;
                output = new DataSet()  ;

                for( int i=0 ; i<out2.getCount("plcyno") ; i++ ){
                    if( out2.getText("status",i).trim().equals("1") 
                        && out2.getText("ptd",i).trim().equals(form.getScheduleDate()) ){
                        output.put("userID"       , form.getUserID()          ,cnt );
                        output.put("scheduleDate" , form.getScheduleDate()    ,cnt );
                        output.put("scheduleType" , "4"                       ,cnt );
                        output.put("plcyno"       , out2.getText("plcyno",i)  ,cnt );
                        output.put("plnname"      , out2.getText("plnname",i) ,cnt );
                        cnt++ ;
                    }
                }
            }else{
                output  = dao.selectDay(form) ;
            }
            return output ;
		}catch (Exception e){
			throw (e);
		}
	}

    /**
     * Schedule �5�8�2�2�3�7�0�9 �3�1�3�1�8�9�3�0�1�5�8�5
     * @param   DataSet 
     * @return  void
     */
	public void removeDay(ScheduleForm form) throws Exception{
		try{
			ScheduleDao dao     = getScheduleDao() ;
            dao.removeDay(form) ;
		}catch (Exception e){
			throw (e);
		}
	}
    /**
     * Schedule �9�7�0�4�7�5�3�9�2�7�8�5
     * @param   form
     * @return  
     */
	public String[][] readCalendar(ScheduleForm form) throws Exception{
        ScheduleCalendar sc = null;
        String[][] calendar = null;
		try{
            sc = new ScheduleCalendar(form.getYear(), form.getMonth(), 1) ;
            calendar = sc.makeHtmlCalendar(sc.makeCalendar(),0,0);  
			return calendar ;
		}catch (Exception e){
			throw (e);
		}
	}
    
    /**
     * �2�7�8�3�8�9�3�9 �7�5�3�9�2�7�8�5
     * @return  int[]
     */
	public int[] toDay() throws Exception{
        ScheduleCalendar sc = null;
		try{
            sc = new ScheduleCalendar() ;
			return sc.toDay();
		}catch (Exception e){
			throw (e);
		}
	}
}
