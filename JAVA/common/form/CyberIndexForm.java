/**
 * Title       : cyberindex통계
 * Description : cyberindex통계 form
 * 유섭교 2006.06.01
 */
package gtone.changeminer.common.form    ;

import java.util.Calendar;
import java.text.SimpleDateFormat;

import org.apache.struts.action.ActionForm      ;
import org.apache.struts.action.ActionMapping   ;
import org.apache.struts.action.ActionErrors    ;
import org.apache.struts.action.ActionMessage   ;

import javax.servlet.http.HttpServletRequest    ;

public  class CyberIndexForm extends ActionForm{

    private String today        = null ;//////오늘날짜

    private String termDiv      = null ;//////기간구분( 1: 일별 , 2 월별) 
    
    private String fromDate     = null ;//////(날짜별조회)검색시작일
    private String toDate       = null ;//////(날짜별조회)검색종료일
	
    private String quater       = null ;
    private String year         = null ;
    private String quatertoDate   = null ; //////쿼터별 검색종료일
    private String quaterfromDate = null ; //////쿼터별 검색시작일
    
	private int current		= 1;		////// 페이지값..
   
	private String confrim_process = null;
	
    //////set 오늘날짜
    public void setCurrent(int current){
        this.current = current;
    }
    //////get 오늘날짜
    public int getCurrent(){
        return current ;
    }

    //////set 오늘날짜
    public void setToday(String today){
        this.today = today;
    }
    //////get 오늘날짜
    public String getToday(){
        return today ;
    }
    
    //////set 기간구분
    public void setTermDiv(String termDiv){
        this.termDiv = termDiv;
    }
    //////get 기간구분
    public String getTermDiv(){
        return termDiv ;
    }
    
    //////set (날짜별조회)검색시작일
    public void setFromDate(String fromDate){
        this.fromDate = fromDate;
    }
    //////get (날짜별조회)검색시작일 
    public String getFromDate(){
        return fromDate ;
    }

    //////set (날짜별조회)검색종료일
    public void setToDate(String toDate){
        this.toDate = toDate;
    }
    //////get (날짜별조회)검색종료일 
    public String getToDate(){
        return toDate ;
    }
    
          
    public String getConfrim_process() {
		return confrim_process;
	}
	public void setConfrim_process(String confrim_process) {
		this.confrim_process = confrim_process;
	}
	
	/**
     * form으로 받기 전 초기화
     * @return  ActionErrors
     */ 
    public void reset(ActionMapping mapping, HttpServletRequest request){ 
        
    	confrim_process = ""; 
    	
    	termDiv         = "1"    ;//////
        
        SimpleDateFormat todayFormat  
            = new SimpleDateFormat( "yyyyMMdd" );

        Calendar calendar 
            = Calendar.getInstance();
        
       //////calendar.add(Calendar.DATE, -1);
        toDate  = todayFormat.format(calendar.getTime());//////(날짜별조회)검색종료일
//////        today= todayFormat.format(calendar.getTime());//////오늘날짜
        
        System.out.println("ysg toDate : "+toDate);
        
//////        System.out.println("ysg today : "+today);
        
        
        //////calendar.add(Calendar.YEAR,-1);
        
//////        System.out.println("ysg yesterday : " + todayFormat.format(calendar.getTime()) );
        
        fromDate=todayFormat.format(calendar.getTime());//////(날짜별조회)검색시작일
        
        calendar.add(Calendar.YEAR,0);
        year = toDate.substring(0,4);
        
        //////초기화는 이번달이 어느 분기에 속하는가를 구별해서 집어넣는다.
        //////quater 1~3 1분기 4~6 2분기 7~9 3분기 10~12 4분기
        String month =  toDate.substring(4,6);
        int month_int = Integer.parseInt(month);
        
        if ( month_int <4){
            quater = "1";
           	quaterfromDate = year+"01";
           	quatertoDate = year+"03";       	
        }else if (month_int>3 && month_int <7 ){
            quater = "2";
           	quaterfromDate = year+"04";
           	quatertoDate = year+"06";       	
        }else if (month_int>8 && month_int <10){
            quater = "3";
           	quaterfromDate = year+"07";
           	quatertoDate = year+"09";        	
        }else if (month_int>9 && month_int <13){
            quater = "4";
           	quaterfromDate = year+"10";
           	quatertoDate = year+"12";       	
        }
        	
        	

    }
    
	public String getQuater() {
		return quater;
	}
	public void setQuater(String quater) {
		this.quater = quater;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getQuaterfromDate() {
		return quaterfromDate;
	}
	public void setQuaterfromDate(String quaterfromDate) {
		this.quaterfromDate = quaterfromDate;
	}
	public String getQuatertoDate() {
		return quatertoDate;
	}
	public void setQuatertoDate(String quatertoDate) {
		this.quatertoDate = quatertoDate;
	}   
}
