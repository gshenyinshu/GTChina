/**
 * Title       : 
 * Description : MyDiary dao
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author 
 * @version 1.0
 */
package gtone.changeminer.receipt.dao;


import java.util.List;
import java.util.ArrayList;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.form.ScheduleForm ;
import gtone.changeminer.common.dao.Executor ;
import gtone.changeminer.common.utility.FormToDataset ;
 
public  class ScheduleDao{
    
    /**
     * Schedule �2�1�4�5�3�3�4�5�0�9�9�9�1�5�8�5
     * @param   
     * @return  
     */
    public DataSet readView(ScheduleForm form)throws Exception{

        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query�3�7�2�2
	    int         cnt     ;////[DB]�4�7�0�5�4�9�0�4�7�2�2�1
        
        try{
            input   = new DataSet();
            output  = new DataSet();
            FormToDataset.copyProperties(input,form);
            executor = Executor.getInstance();           
            output = executor.execute("cybercenter/schedule_view", input);
            return output ;
		}catch(Exception e){
			throw(e);	
		}
    }
    /**
     * Schedule �3�3�7�9�0�3�0�7�4�1�7�5�3�0�0�4�2�7.
     * @param   
     * @return void
     */
    public boolean write(ScheduleForm form)throws Exception{
        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query�3�7�2�2
        
        try{
            input   = new DataSet();
            output  = new DataSet();

            FormToDataset.copyProperties(input,form);
            executor = Executor.getInstance();           
            executor.execute("mypage/schedule_write", input);
            return true ;
		}catch(Exception e){
			throw(e);	
		}   
    }

    /**
     * Schedule �3�1�7�9�4�1�7�5�3�0�0�4�2�7.
     * @param   
     * @return void
     */
    public boolean createDay(ScheduleForm form)throws Exception{
        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query�3�7�2�2
        
        try{
            input   = new DataSet();
            output  = new DataSet();

            FormToDataset.copyProperties(input,form);
            executor = Executor.getInstance();           
            executor.execute("mypage/schedule_day_create", input);
            return true ;
		}catch(Exception e){
			throw(e);	
        }		
    }

    /**
     * Schedule �6�7�9�0�3�3 �0�7�9�7 day�2�1�4�5�3�3 �7�5�3�9�2�7�8�5
     * @param   
     * @return void
     */
    public DataSet selectAllDay(ScheduleForm form)throws Exception{

        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query�3�7�2�2
	    int         cnt     ;////[DB]�4�7�0�5�4�9�0�4�7�2�2�1
        
        try{
            input   = new DataSet();
            output  = new DataSet();
            FormToDataset.copyProperties(input,form);
            executor = Executor.getInstance();           
            output = executor.execute("mypage/schedule_all", input);
            return output ;
		}catch(Exception e){
			throw(e);	
		}
    }

    /**
     * Schedule �6�7�9�0�3�3�3�5 �1�5�6�7�8�8�3�1�3�1 �7�5�3�9�2�7�8�5
     * @param   
     * @return void
     */
    public DataSet selectContract(DataSet input)throws Exception{
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query�3�7�2�2
	    int         cnt     ;////[DB]�4�7�0�5�4�9�0�4�7�2�2�1
        
        try{
            output  = new DataSet();
            executor = Executor.getInstance();           
            output = executor.execute("cybercenter/contract_sum", input);
            return output ;
		}catch(Exception e){
			throw(e);	
		}
    }

    /**
     * Schedule �5�8�2�2�3�7�0�9 �3�1�3�1�8�9�3�0�1�5�8�5
     * @param   
     * @return void
     */
    public DataSet selectDay(ScheduleForm form)throws Exception{

        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query�3�7�2�2
	    int         cnt     ;////[DB]�4�7�0�5�4�9�0�4�7�2�2�1
        
        try{
            input   = new DataSet();
            output  = new DataSet();
 
            
            String where = null ;
            if( form.getViewType().equals("sameDay") ){
                where = "where userID='"+form.getUserID()+"'" ;
                where +=" and scheduleDate='"+form.getScheduleDate()+"'" ;

            }else if( form.getViewType().equals("sameType") ){
                where = "where userID='"+form.getUserID()+"'" ;
                where +=" and scheduleDate='"+form.getScheduleDate()+"'" ;
                where +=" and scheduleType='"+form.getScheduleType()+"'" ;

            }else if( form.getViewType().equals("onlyOne") ){
                where = "where userID='"+form.getUserID()+"'" ;
                where +=" and scheduleDate='"+form.getScheduleDate()+"'" ;
                where +=" and insertDate='"+form.getInsertDate()+"'" ;
            }

            input.put("where",where);
            executor = Executor.getInstance();  
            output = executor.execute("mypage/schedule_day_view", input);
            return output ;
		}catch(Exception e){
			throw(e);	
		}
    }

    /**
     * Schedule �3�1�3�1�2�1�4�5�3�3 �1�8�3�1
     * @param   
     * @return void
     */
    public void removeDay(ScheduleForm form)throws Exception{
        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query�3�7�2�2
        
        try{
            input   = new DataSet();
            output  = new DataSet();

            FormToDataset.copyProperties(input,form);
            executor = Executor.getInstance();           
            executor.execute("mypage/schedule_day_remove", input);
		}catch(Exception e){
			throw(e);	
        }		
    }

    /**
     * Schedule �3�1�3�1�2�1�4�5�3�3 �2�1�3�4
     * @param   
     * @return void
     */
    public boolean updateDay(ScheduleForm form)throws Exception{
        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query�3�7�2�2
        
        try{
            input   = new DataSet();
            output  = new DataSet();

            FormToDataset.copyProperties(input,form);
            executor = Executor.getInstance();           
            executor.execute("mypage/schedule_day_update", input);
            return true ;
		}catch(Exception e){
			throw(e);	
        }		
    }
}