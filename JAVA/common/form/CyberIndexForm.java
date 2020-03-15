/**
 * Title       : cyberindex�5�8�7�1
 * Description : cyberindex�5�8�7�1 form
 * �3�9�1�6�7�1 2006.06.01
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

    private String today        = null ;//////�2�7�8�3�8�9�3�9

    private String termDiv      = null ;//////�8�5�7�9�7�9�1�9( 1: �3�1�1�7 , 2 �3�3�1�7) 
    
    private String fromDate     = null ;//////(�8�9�3�9�1�7�3�5�6�7)�7�3�1�6�2�7�3�2�3�1
    private String toDate       = null ;//////(�8�9�3�9�1�7�3�5�6�7)�7�3�1�6�3�6�0�1�3�1
	
    private String quater       = null ;
    private String year         = null ;
    private String quatertoDate   = null ; //////�4�7�5�5�1�7 �7�3�1�6�3�6�0�1�3�1
    private String quaterfromDate = null ; //////�4�7�5�5�1�7 �7�3�1�6�2�7�3�2�3�1
    
	private int current		= 1;		////// �5�1�3�3�3�1�7�3..
   
	private String confrim_process = null;
	
    //////set �2�7�8�3�8�9�3�9
    public void setCurrent(int current){
        this.current = current;
    }
    //////get �2�7�8�3�8�9�3�9
    public int getCurrent(){
        return current ;
    }

    //////set �2�7�8�3�8�9�3�9
    public void setToday(String today){
        this.today = today;
    }
    //////get �2�7�8�3�8�9�3�9
    public String getToday(){
        return today ;
    }
    
    //////set �8�5�7�9�7�9�1�9
    public void setTermDiv(String termDiv){
        this.termDiv = termDiv;
    }
    //////get �8�5�7�9�7�9�1�9
    public String getTermDiv(){
        return termDiv ;
    }
    
    //////set (�8�9�3�9�1�7�3�5�6�7)�7�3�1�6�2�7�3�2�3�1
    public void setFromDate(String fromDate){
        this.fromDate = fromDate;
    }
    //////get (�8�9�3�9�1�7�3�5�6�7)�7�3�1�6�2�7�3�2�3�1 
    public String getFromDate(){
        return fromDate ;
    }

    //////set (�8�9�3�9�1�7�3�5�6�7)�7�3�1�6�3�6�0�1�3�1
    public void setToDate(String toDate){
        this.toDate = toDate;
    }
    //////get (�8�9�3�9�1�7�3�5�6�7)�7�3�1�6�3�6�0�1�3�1 
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
     * form�3�7�0�9 �0�8�8�5 �3�7 �4�1�8�5�6�1
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
        toDate  = todayFormat.format(calendar.getTime());//////(�8�9�3�9�1�7�3�5�6�7)�7�3�1�6�3�6�0�1�3�1
//////        today= todayFormat.format(calendar.getTime());//////�2�7�8�3�8�9�3�9
        
        System.out.println("ysg toDate : "+toDate);
        
//////        System.out.println("ysg today : "+today);
        
        
        //////calendar.add(Calendar.YEAR,-1);
        
//////        System.out.println("ysg yesterday : " + todayFormat.format(calendar.getTime()) );
        
        fromDate=todayFormat.format(calendar.getTime());//////(�8�9�3�9�1�7�3�5�6�7)�7�3�1�6�2�7�3�2�3�1
        
        calendar.add(Calendar.YEAR,0);
        year = toDate.substring(0,4);
        
        //////�4�1�8�5�6�1�8�9 �3�3�0�7�9�7�3�3 �2�5�8�5 �1�9�8�5�2�3 �2�2�6�9�8�9�7�5�0�7 �7�9�1�7�6�7�1�9 �3�8�2�5�8�0�8�9�9�9.
        //////quater 1~3 1�1�9�8�5 4~6 2�1�9�8�5 7~9 3�1�9�8�5 10~12 4�1�9�8�5
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
