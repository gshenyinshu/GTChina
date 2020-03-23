/**
 * Title       : cyberindex���
 * Description : cyberindex��� form
 * ������ 2006.06.01
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

    private String today        = null ;//////���ó�¥

    private String termDiv      = null ;//////�Ⱓ����( 1: �Ϻ� , 2 ����) 
    
    private String fromDate     = null ;//////(��¥����ȸ)�˻�������
    private String toDate       = null ;//////(��¥����ȸ)�˻�������
	
    private String quater       = null ;
    private String year         = null ;
    private String quatertoDate   = null ; //////���ͺ� �˻�������
    private String quaterfromDate = null ; //////���ͺ� �˻�������
    
	private int current		= 1;		////// ��������..
   
	private String confrim_process = null;
	
    //////set ���ó�¥
    public void setCurrent(int current){
        this.current = current;
    }
    //////get ���ó�¥
    public int getCurrent(){
        return current ;
    }

    //////set ���ó�¥
    public void setToday(String today){
        this.today = today;
    }
    //////get ���ó�¥
    public String getToday(){
        return today ;
    }
    
    //////set �Ⱓ����
    public void setTermDiv(String termDiv){
        this.termDiv = termDiv;
    }
    //////get �Ⱓ����
    public String getTermDiv(){
        return termDiv ;
    }
    
    //////set (��¥����ȸ)�˻�������
    public void setFromDate(String fromDate){
        this.fromDate = fromDate;
    }
    //////get (��¥����ȸ)�˻������� 
    public String getFromDate(){
        return fromDate ;
    }

    //////set (��¥����ȸ)�˻�������
    public void setToDate(String toDate){
        this.toDate = toDate;
    }
    //////get (��¥����ȸ)�˻������� 
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
     * form���� �ޱ� �� �ʱ�ȭ
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
        toDate  = todayFormat.format(calendar.getTime());//////(��¥����ȸ)�˻�������
//////        today= todayFormat.format(calendar.getTime());//////���ó�¥
        
        System.out.println("ysg toDate : "+toDate);
        
//////        System.out.println("ysg today : "+today);
        
        
        //////calendar.add(Calendar.YEAR,-1);
        
//////        System.out.println("ysg yesterday : " + todayFormat.format(calendar.getTime()) );
        
        fromDate=todayFormat.format(calendar.getTime());//////(��¥����ȸ)�˻�������
        
        calendar.add(Calendar.YEAR,0);
        year = toDate.substring(0,4);
        
        //////�ʱ�ȭ�� �̹����� ��� �б⿡ ���ϴ°��� �����ؼ� ����ִ´�.
        //////quater 1~3 1�б� 4~6 2�б� 7~9 3�б� 10~12 4�б�
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
