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
     * Schedule 스케줄카렌다보기
     * @param   
     * @return  
     */
    public DataSet readView(ScheduleForm form)throws Exception{

        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query전송
	    int         cnt     ;////[DB]쿼리출력갯수
        
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
     * Schedule 월간메모추가입력시.
     * @param   
     * @return void
     */
    public boolean write(ScheduleForm form)throws Exception{
        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query전송
        
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
     * Schedule 일간추가입력시.
     * @param   
     * @return void
     */
    public boolean createDay(ScheduleForm form)throws Exception{
        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query전송
        
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
     * Schedule 해당월 모든 day스케줄 가져오기
     * @param   
     * @return void
     */
    public DataSet selectAllDay(ScheduleForm form)throws Exception{

        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query전송
	    int         cnt     ;////[DB]쿼리출력갯수
        
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
     * Schedule 해당월의 보험납일일 가져오기
     * @param   
     * @return void
     */
    public DataSet selectContract(DataSet input)throws Exception{
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query전송
	    int         cnt     ;////[DB]쿼리출력갯수
        
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
     * Schedule 팝업으로 일일내용보기
     * @param   
     * @return void
     */
    public DataSet selectDay(ScheduleForm form)throws Exception{

        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query전송
	    int         cnt     ;////[DB]쿼리출력갯수
        
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
     * Schedule 일일스케줄 삭제
     * @param   
     * @return void
     */
    public void removeDay(ScheduleForm form)throws Exception{
        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query전송
        
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
     * Schedule 일일스케줄 수정
     * @param   
     * @return void
     */
    public boolean updateDay(ScheduleForm form)throws Exception{
        DataSet     input   ;////[DB]input  data
        DataSet     output  ;////[DB]output data
        Executor    executor;////[DB]query전송
        
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