/**
 * Title       : ScheduleCalendar
 * Description : ScheduleCalendar Ŭ������ �޷��� ���鶧 �ʿ��� ��¥�� ��¹迭.
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author       Sang-Mi Lee
 * @version 1.0
 */
package gtone.changeminer.receipt.action;

import java.util.Calendar ;
import java.util.Vector   ;

public  class ScheduleCalendar{
    
    Calendar rightNow = null ; ////Calendar Ŭ���� ����
    int nowY          = 0    ; ////����� ����-�⵵
    int nowM          = 0    ; ////����� ����-��
    int nowD          = 0    ; ////����� ����-��

    /**
     * ScheduleCalendar�� ����Ʈ ������
     */
    public ScheduleCalendar(){
    }

    /**
     * ScheduleCalendar�� ������ default�� ��� �ϰ� �������� -1�� �ִ´�.
     * @param   int year    ��()
     * @param   int month   ��()
     * @param   int day     ��()
     * @return  void        
     */
    public ScheduleCalendar(int year, int month, int day){
        returnCalendar( year , month , day ) ;
    }

    /**
     * ���ϳ�¥ ��������
     * @param   int year    ��()
     * @param   int month   ��()
     * @param   int day     ��()
     * @return  int[]        
     */
    public int[] toDay(){   
        Calendar rightNow = Calendar.getInstance();
        return new int[]{   rightNow.get(rightNow.YEAR),
                        rightNow.get(rightNow.MONTH ),
                        rightNow.get(rightNow.DAY_OF_MONTH )
                };
    }

    /**
     * ��/��/�� �Է��ϸ� ��¥�� �ٽ� �����Ѵ�. default�� ��� �ϰ� �������� -1�� �ִ´�.
     * @param   int year    ��()
     * @param   int month   ��()
     * @param   int day     ��()
     * @return  void        
     */
    public void returnCalendar(int year, int month, int day){   
        rightNow = Calendar.getInstance();

        if(year==-1 || month==-1 || day==-1 ){
            if( year==-1  )  year = rightNow.get(rightNow.YEAR);////�����-��
            if( month==-1 ) month = rightNow.get(rightNow.MONTH );////�����-��
            if( day==-1   )   day = rightNow.get(rightNow.DAY_OF_MONTH );////�����-��
        }
        nowY          = year             ;////����� ����-�⵵
        nowM          = month            ;////����� ����-��
        nowD          = day              ;////����� ����-��
        rightNow.set( nowY, nowM , nowD );////����ڰ� ���ϴ� ��¥�� �ٽ� ���� 
    }

    /**
     * making calendar : �޷�����(day of month, day of week, week of month)<br>
     * int[]�� ���� �ִ´�.<br>
     * [0] : day of month <br>
     * [1] : day of week<br>
     * [2] : week of month<br>
     * ���� int[]�� �����ϴ� ����ŭ vector�� add�Ѵ�.<br>
     * @return  Vector    - userCalendar
     */
    public Vector makeCalendar(){
        Vector   userCalendar = new Vector() ;
        int[]    dataInfo     = null ;
        int      nowDay       = 1 ;////set�Ǿ��� ��
        int      nextDay      = 2 ;////set�Ǿ��� ���� ������
        
        ////��¥�����ϱ�(��,��,��);
        rightNow.set(nowY, nowM, nowDay);
        
        ////�ش糯¥�� ���� ��¥���� ����������(�������� �Ǳ�������
        while(nowDay<nextDay){
            nowDay = rightNow.get( rightNow.DAY_OF_MONTH ) ;
            dataInfo = new int[]{rightNow.get(rightNow.DAY_OF_MONTH ),
                                 rightNow.get(rightNow.DAY_OF_WEEK  ),
                                 rightNow.get(rightNow.WEEK_OF_MONTH)
                                };
            rightNow.set(nowY, nowM, (nowDay+1));
            nextDay = rightNow.get(rightNow.DAY_OF_MONTH ) ;
            userCalendar.add(dataInfo);
        }
        return userCalendar ;////�Ϸ� �Ϸ��� ������ ����ִ� ���͹�ȯ
    }

    /**
     * makeHtmlCalendar : ȭ�鿡 ������ �迭������ ����.<br>
     * @param   Vector   makeCalendar - �޷������� ��� vector
     * @param   int      wantType     - ����ڰ� ���ϴ� �޷�Ÿ�� 0:�޷½� 1:������ �޷�
     * @param   int      needWeek     - ����ڰ� ���ϴ� �� 0:�Ѵ� ��� ������ 
     * @return  String[] userCalendar - ������ ��¥ ������ �迭�� ������.
     */
    public String[][] makeHtmlCalendar( Vector makeCalendar ,
                                      int    wantType     ,
                                      int    needWeek     
                                    ){

        String[][]   userCalendar = null ;
        if(makeCalendar.size()!=0){
            int[] lastD =null ;
            ////�޷������� �ƴ� �޿� ������ ȭ������ �� ��
            if(wantType==1){
                ////�Ѵ� ��� ������ ��
                if( needWeek!=0 ){
                    userCalendar = new String[7][1];
                    for(int i=0 ; i<makeCalendar.size() ; i++){
                        lastD = (int[])makeCalendar.elementAt(i);
                        if(needWeek==lastD[2]){
                            userCalendar[ lastD[1]-1 ][0] = lastD[0]+"";
                        }
                    }
                ////���ϴ� �ָ� ������ ��
                }else{
                    userCalendar = new String[makeCalendar.size()][1];
                    for(int i=0 ; i<makeCalendar.size() ; i++){
                        lastD = (int[])makeCalendar.elementAt(i);
                        userCalendar[i][0] = lastD[1]+"";
                    }
                }
            ////�޷��������� �� ��
            }else if(wantType==0){
                lastD = (int[])makeCalendar.elementAt(makeCalendar.size()-1);
                userCalendar = new String[lastD[2]][7];
                
                ////�޷��ϼ���ŭ ����.
                for(int i=0 ; i<makeCalendar.size() ; i++){
                    lastD = (int[])makeCalendar.elementAt(i);
                    userCalendar[ lastD[2]-1 ][ lastD[1]-1 ] = lastD[0]+"";
                }
            }
        }
        return userCalendar ;
    }

    /**
     * main Test    
     */   
    public static void main(String[] args){
        ScheduleCalendar test = new ScheduleCalendar(2004, 8, 1);
        Vector   userCalendar = test.makeCalendar();
        int[]      dateInfo = null ;
        String[][] lsm = test.makeHtmlCalendar(userCalendar,0,0);

        for(int i=0 ; i<lsm.length ; i++){
            System.out.println((i+1)+" : "+lsm[i][0]);
            System.out.println((i+1)+" : "+lsm[i][1]);
            System.out.println((i+1)+" : "+lsm[i][2]);
            System.out.println((i+1)+" : "+lsm[i][3]);
            System.out.println((i+1)+" : "+lsm[i][4]);
            System.out.println((i+1)+" : "+lsm[i][5]);
            System.out.println((i+1)+" : "+lsm[i][6]);
        }
    }  
}