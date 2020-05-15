/**
 * Title       : ScheduleCalendar
 * Description : ScheduleCalendar 클래스는 달력을 만들때 필요한 날짜의 출력배열.
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author       Sang-Mi Lee
 * @version 1.0
 */
package gtone.changeminer.receipt.action;

import java.util.Calendar ;
import java.util.Vector   ;

public  class ScheduleCalendar{
    
    Calendar rightNow = null ; ////Calendar 클래스 선언
    int nowY          = 0    ; ////사용자 설정-년도
    int nowM          = 0    ; ////사용자 설정-월
    int nowD          = 0    ; ////사용자 설정-일

    /**
     * ScheduleCalendar의 디폴트 생성자
     */
    public ScheduleCalendar(){
    }

    /**
     * ScheduleCalendar의 생성자 default를 사용 하고 싶을때는 -1는 넣는다.
     * @param   int year    년()
     * @param   int month   월()
     * @param   int day     일()
     * @return  void        
     */
    public ScheduleCalendar(int year, int month, int day){
        returnCalendar( year , month , day ) ;
    }

    /**
     * 금일날짜 가져오기
     * @param   int year    년()
     * @param   int month   월()
     * @param   int day     일()
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
     * 년/월/일 입력하면 날짜를 다시 셋팅한다. default를 사용 하고 싶을때는 -1는 넣는다.
     * @param   int year    년()
     * @param   int month   월()
     * @param   int day     일()
     * @return  void        
     */
    public void returnCalendar(int year, int month, int day){   
        rightNow = Calendar.getInstance();

        if(year==-1 || month==-1 || day==-1 ){
            if( year==-1  )  year = rightNow.get(rightNow.YEAR);////사용자-년
            if( month==-1 ) month = rightNow.get(rightNow.MONTH );////사용자-월
            if( day==-1   )   day = rightNow.get(rightNow.DAY_OF_MONTH );////사용자-일
        }
        nowY          = year             ;////사용자 설정-년도
        nowM          = month            ;////사용자 설정-월
        nowD          = day              ;////사용자 설정-일
        rightNow.set( nowY, nowM , nowD );////사용자가 원하는 날짜로 다시 셋팅 
    }

    /**
     * making calendar : 달력정보(day of month, day of week, week of month)<br>
     * int[]에 값을 넣는다.<br>
     * [0] : day of month <br>
     * [1] : day of week<br>
     * [2] : week of month<br>
     * 위의 int[]를 존재하는 날만큼 vector에 add한다.<br>
     * @return  Vector    - userCalendar
     */
    public Vector makeCalendar(){
        Vector   userCalendar = new Vector() ;
        int[]    dataInfo     = null ;
        int      nowDay       = 1 ;////set되어진 날
        int      nextDay      = 2 ;////set되어진 날의 다음날
        
        ////날짜셋팅하기(년,월,일);
        rightNow.set(nowY, nowM, nowDay);
        
        ////해당날짜가 다음 날짜보다 작을때까지(다음달이 되기전까지
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
        return userCalendar ;////하루 하루의 정보가 들어있는 벡터반환
    }

    /**
     * makeHtmlCalendar : 화면에 보여줄 배열데이터 셋팅.<br>
     * @param   Vector   makeCalendar - 달력정보가 담긴 vector
     * @param   int      wantType     - 사용자가 원하는 달력타입 0:달력시 1:펼져진 달력
     * @param   int      needWeek     - 사용자가 원하는 주 0:한달 모두 보여줌 
     * @return  String[] userCalendar - 보여줄 날짜 형식을 배열로 보낸다.
     */
    public String[][] makeHtmlCalendar( Vector makeCalendar ,
                                      int    wantType     ,
                                      int    needWeek     
                                    ){

        String[][]   userCalendar = null ;
        if(makeCalendar.size()!=0){
            int[] lastD =null ;
            ////달력형식이 아닌 쭈욱 펼쳐진 화면으로 볼 때
            if(wantType==1){
                ////한달 모두 보여줄 때
                if( needWeek!=0 ){
                    userCalendar = new String[7][1];
                    for(int i=0 ; i<makeCalendar.size() ; i++){
                        lastD = (int[])makeCalendar.elementAt(i);
                        if(needWeek==lastD[2]){
                            userCalendar[ lastD[1]-1 ][0] = lastD[0]+"";
                        }
                    }
                ////원하는 주만 보여줄 때
                }else{
                    userCalendar = new String[makeCalendar.size()][1];
                    for(int i=0 ; i<makeCalendar.size() ; i++){
                        lastD = (int[])makeCalendar.elementAt(i);
                        userCalendar[i][0] = lastD[1]+"";
                    }
                }
            ////달력형식으로 볼 때
            }else if(wantType==0){
                lastD = (int[])makeCalendar.elementAt(makeCalendar.size()-1);
                userCalendar = new String[lastD[2]][7];
                
                ////달력일수만큼 진행.
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