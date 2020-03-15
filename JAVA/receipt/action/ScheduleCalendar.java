/**
 * Title       : ScheduleCalendar
 * Description : ScheduleCalendar �5�7�9�3�2�1�8�9 �9�7�0�4�3�5 �0�7�9�1�9�5 �6�9�3�9�6�3 �8�9�3�9�3�5 �4�9�0�4�0�9�2�9.
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author       Sang-Mi Lee
 * @version 1.0
 */
package gtone.changeminer.receipt.action;

import java.util.Calendar ;
import java.util.Vector   ;

public  class ScheduleCalendar{
    
    Calendar rightNow = null ; ////Calendar �5�7�9�3�2�1 �1�3�2�9
    int nowY          = 0    ; ////�1�7�3�0�3�1 �1�7�3�4-�8�3�9�3
    int nowM          = 0    ; ////�1�7�3�0�3�1 �1�7�3�4-�3�3
    int nowD          = 0    ; ////�1�7�3�0�3�1 �1�7�3�4-�3�1

    /**
     * ScheduleCalendar�3�5 �9�9�5�3�5�7 �1�6�1�0�3�1
     */
    public ScheduleCalendar(){
    }

    /**
     * ScheduleCalendar�3�5 �1�6�1�0�3�1 default�0�7 �1�7�3�0 �6�9�7�9 �2�3�3�5�9�5�8�9 -1�8�9 �8�0�8�9�9�9.
     * @param   int year    �8�3()
     * @param   int month   �3�3()
     * @param   int day     �3�1()
     * @return  void        
     */
    public ScheduleCalendar(int year, int month, int day){
        returnCalendar( year , month , day ) ;
    }

    /**
     * �8�5�3�1�8�9�3�9 �7�5�3�9�2�7�8�5
     * @param   int year    �8�3()
     * @param   int month   �3�3()
     * @param   int day     �3�1()
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
     * �8�3/�3�3/�3�1 �3�0�0�4�6�9�0�5 �8�9�3�9�0�7 �9�9�2�7 �1�6�5�4�6�3�9�9. default�0�7 �1�7�3�0 �6�9�7�9 �2�3�3�5�9�5�8�9 -1�8�9 �8�0�8�9�9�9.
     * @param   int year    �8�3()
     * @param   int month   �3�3()
     * @param   int day     �3�1()
     * @return  void        
     */
    public void returnCalendar(int year, int month, int day){   
        rightNow = Calendar.getInstance();

        if(year==-1 || month==-1 || day==-1 ){
            if( year==-1  )  year = rightNow.get(rightNow.YEAR);////�1�7�3�0�3�1-�8�3
            if( month==-1 ) month = rightNow.get(rightNow.MONTH );////�1�7�3�0�3�1-�3�3
            if( day==-1   )   day = rightNow.get(rightNow.DAY_OF_MONTH );////�1�7�3�0�3�1-�3�1
        }
        nowY          = year             ;////�1�7�3�0�3�1 �1�7�3�4-�8�3�9�3
        nowM          = month            ;////�1�7�3�0�3�1 �1�7�3�4-�3�3
        nowD          = day              ;////�1�7�3�0�3�1 �1�7�3�4-�3�1
        rightNow.set( nowY, nowM , nowD );////�1�7�3�0�3�1�7�5 �3�9�6�9�8�9 �8�9�3�9�0�9 �9�9�2�7 �1�6�5�4 
    }

    /**
     * making calendar : �9�7�0�4�3�4�1�5(day of month, day of week, week of month)<br>
     * int[]�2�3 �7�3�3�5 �8�0�8�9�9�9.<br>
     * [0] : day of month <br>
     * [1] : day of week<br>
     * [2] : week of month<br>
     * �3�1�3�5 int[]�0�7 �3�9�3�9�6�9�8�9 �8�9�0�7�5�5 vector�2�3 add�6�3�9�9.<br>
     * @return  Vector    - userCalendar
     */
    public Vector makeCalendar(){
        Vector   userCalendar = new Vector() ;
        int[]    dataInfo     = null ;
        int      nowDay       = 1 ;////set�9�7�2�5�3�5 �8�9
        int      nextDay      = 2 ;////set�9�7�2�5�3�5 �8�9�3�5 �9�9�3�3�8�9
        
        ////�8�9�3�9�1�6�5�4�6�9�8�5(�8�3,�3�3,�3�1);
        rightNow.set(nowY, nowM, nowDay);
        
        ////�6�7�9�0�8�9�3�9�7�5 �9�9�3�3 �8�9�3�9�1�5�9�9 �3�2�3�5�9�5�8�3�3�1(�9�9�3�3�9�7�3�3 �9�7�8�5�3�7�8�3�3�1
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
        return userCalendar ;////�6�9�0�9 �6�9�0�9�3�5 �3�4�1�5�7�5 �9�1�2�5�3�3�8�9 �1�2�5�5�0�5�6�5
    }

    /**
     * makeHtmlCalendar : �6�1�0�5�2�3 �1�5�2�1�3�3 �0�9�2�9�9�9�3�3�5�5 �1�6�5�4.<br>
     * @param   Vector   makeCalendar - �9�7�0�4�3�4�1�5�7�5 �9�5�8�9 vector
     * @param   int      wantType     - �1�7�3�0�3�1�7�5 �3�9�6�9�8�9 �9�7�0�4�5�3�3�0 0:�9�7�0�4�2�7 1:�5�7�3�9�3�5 �9�7�0�4
     * @param   int      needWeek     - �1�7�3�0�3�1�7�5 �3�9�6�9�8�9 �3�5 0:�6�3�9�7 �0�7�9�3 �1�5�2�1�3�1 
     * @return  String[] userCalendar - �1�5�2�1�3�3 �8�9�3�9 �6�8�2�8�3�5 �0�9�2�9�0�9 �1�5�8�3�9�9.
     */
    public String[][] makeHtmlCalendar( Vector makeCalendar ,
                                      int    wantType     ,
                                      int    needWeek     
                                    ){

        String[][]   userCalendar = null ;
        if(makeCalendar.size()!=0){
            int[] lastD =null ;
            ////�9�7�0�4�6�8�2�8�3�3 �2�3�9�5 �3�3�3�8 �5�7�4�5�3�5 �6�1�0�5�3�7�0�9 �1�3 �9�5
            if(wantType==1){
                ////�6�3�9�7 �0�7�9�3 �1�5�2�1�3�3 �9�5
                if( needWeek!=0 ){
                    userCalendar = new String[7][1];
                    for(int i=0 ; i<makeCalendar.size() ; i++){
                        lastD = (int[])makeCalendar.elementAt(i);
                        if(needWeek==lastD[2]){
                            userCalendar[ lastD[1]-1 ][0] = lastD[0]+"";
                        }
                    }
                ////�3�9�6�9�8�9 �3�5�0�7 �1�5�2�1�3�3 �9�5
                }else{
                    userCalendar = new String[makeCalendar.size()][1];
                    for(int i=0 ; i<makeCalendar.size() ; i++){
                        lastD = (int[])makeCalendar.elementAt(i);
                        userCalendar[i][0] = lastD[1]+"";
                    }
                }
            ////�9�7�0�4�6�8�2�8�3�7�0�9 �1�3 �9�5
            }else if(wantType==0){
                lastD = (int[])makeCalendar.elementAt(makeCalendar.size()-1);
                userCalendar = new String[lastD[2]][7];
                
                ////�9�7�0�4�3�1�2�1�0�7�5�5 �3�5�6�8.
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