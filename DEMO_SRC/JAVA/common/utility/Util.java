// Util Class
/**
 * Title       : Util 
 * Description : MyLp.com Utility
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author Robin
 * @version 1.0
 */

package gtone.changeminer.common.utility;

import java.io.*;
import java.text.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import anyframe.data.DataSet;

public  class Util
{
	public static String replaceStr(String line, String oldString, String newString)
	{
		for(int index = 0;(index = line.indexOf(oldString, index)) >= 0; index += newString.length())
			line = line.substring(0, index) + newString + line.substring(index + oldString.length());
		return line;
	}


	public static String[] split(String str, String d)
	{
		ArrayList list = new ArrayList();

		int dLen = d.length();

		if (str.indexOf(d) == -1)
			list.add(str);
		else
			while (str.indexOf(d) != -1)
			{
				list.add(str.substring(0, str.indexOf(d)));
				str = str.substring(str.indexOf(d) + dLen);
				if (str.indexOf(d) == -1)
					list.add(str);
			}

		String[] array = new String[list.size()];
		list.toArray(array);

		return array;
	}



	public static String nvl(String str, String def)
	{
		def = (def == null)? "": def;
		return (str == null || str.trim().equals(""))?def:str;
	}

	public static String nvl(String str, int def)
	{
		return nvl(str, String.valueOf(def));
	}

	public static String nvl(String str)
	{
		return nvl(str, "");
	}

	public static String nvl(int str, String def)
	{
		return nvl(String.valueOf(str), def);
	}


	public static int nvlToNumber(String str, int def)
	{
		return Integer.parseInt(nvl(str, String.valueOf(def)));
	}

	public static int nvlToNumber(String str)
	{
		return nvlToNumber(str, 0);
	}




	public static boolean toBoolean(String str)
	{
		try
		{
			int number = 0;
			if (str != null && !str.trim().equals(""))
				number = Integer.parseInt(str);

			return toBoolean(number);
		}
		catch (NumberFormatException ne)
		{
			return false;
		}
	}

	public static boolean toBoolean(int i)
	{
		if (i < 1)
			return false;
		else
			return true;
	}


	public static String toNumberFormat(String str)
	{
		if (str == null || str.trim().equals(""))
			return str;

		String pre  = str;
		String post = "";

		if (str.indexOf(".") != -1)
		{
			pre  = str.substring(0, str.indexOf("."));
			post = str.substring(str.indexOf(".") + 1);
		}
		pre = toMoneyType(pre, ",");

		return (post.trim().equals(""))?pre:(pre += "." + post);
	}

	public static String toMoneyType2(String str, String delim)
	{
		int mod = str.length() % 3;

		StringBuffer sb = new StringBuffer(str);
		for (int i = mod, j = 0; i < str.length(); i++)
			if (i > 0 && i % 3 == mod)
			{
				sb.insert(i + j, delim);
				j++;
			}

		return sb.toString();
	}

	public static String toMoneyType(String str, String delim)
	{
		DecimalFormat df = new DecimalFormat();
		DecimalFormatSymbols dfs = new DecimalFormatSymbols();

		dfs.setGroupingSeparator(delim.charAt(0));
		df.setGroupingSize(3);
		df.setDecimalFormatSymbols(dfs);

		return (df.format(Double.parseDouble(str))).toString();
	}
/*	//////
	public static void setDatasetFromRequest(DataSet input, HttpServletRequest request)
	{
		Enumeration enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements())
		{
			String name  = (String)enumeration.nextElement();
			String value = request.getParameter(name);
			input.put(name, value);
		}
	}
*/
	//////	request.getParameterNames() -> String[] names
	public static String[] getParameterNames(HttpServletRequest request)
	{
		Enumeration enumeration = request.getParameterNames();
		ArrayList list = new ArrayList();
		while (enumeration.hasMoreElements())
			list.add(enumeration.nextElement());

		String[] names = new String[list.size()];
		list.toArray(names);

		return names;
	}

	public static String getToday()
	{
/*		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date         date = new Date();

		return format.format(date);
*/
		Calendar   calendar   = Calendar.getInstance();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

		return dateFormat.format(calendar.getTime());
	}
        public static String getSecond(){
                Calendar   calendar   = Calendar.getInstance();
                DateFormat dateFormat = new SimpleDateFormat("ss");

                return dateFormat.format(calendar.getTime());
        }

	public static String getTodayToYMD(){
		Calendar   calendar   = Calendar.getInstance();
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

		return dateFormat.format(calendar.getTime());
	}

	public static boolean over24Hours(String once)
	{
		String today = getToday();

		int year    = Integer.parseInt(once.substring(0,4));
		int month   = Integer.parseInt(once.substring(5,7));
		int day     = Integer.parseInt(once.substring(8,10));
		int hour    = Integer.parseInt(once.substring(11,13));
		int minute  = Integer.parseInt(once.substring(14,16));

		int nyear   = Integer.parseInt(today.substring(0,4));
		int nmonth  = Integer.parseInt(today.substring(5,7));
		int nday    = Integer.parseInt(today.substring(8,10));
		int nhour   = Integer.parseInt(today.substring(11,13));
		int nminute = Integer.parseInt(today.substring(14,16));

		if (  (nyear  - year)  * 12 * 31 * 24 * 60
			+ (nmonth - month) * 31 * 24 * 60
			+ (nday   - day)   * 24 * 60
			+ (nhour  - hour)  * 60
			+ nminute - minute                     < 24 * 60)
			return false;
		else
			return true;
	}

	public String toText(String str)
	{
		char[] chars = str.toCharArray();

		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < chars.length; i++)
		{
			if (chars[i] == '%')
				buffer.append("&#37");

			else if (chars[i] == '<')
				buffer.append("&lt;");

			else if (chars[i] == '>')
				buffer.append("&gt;");

			else if (chars[i] == '&')
				buffer.append("&amp;");

			else
				buffer.append(chars[i]);
		}
		return buffer.toString();
	}

//////옛 캐릭터를 새캐릭터로 치환
	public static String replace(String line, String oldString, String newString) {
		if (line == null)		line = new String();
		for (int index = 0;	(index = line.indexOf(oldString, index)) >= 0; index += newString.length())
			line =	line.substring(0, index) + newString	+ line.substring(index + oldString.length());

		return line;
	}

	//////2byte를 1byte로, 연속된 공백을 하나의 공백으로 치환 - S
	public static String doubleTrim(String str)
	{
		String target = "";//////리턴값
		String temp ="";//////가상으로 담아놓는곳
		int space_i = 0;//////공백 체크
		
		for (int i = 0; i < str.length(); i++)
		{
			temp = str.substring(i, i + 1);
			
			if ( temp.equals(" ") || temp.equals("　") )
			{
				temp = Util.replace(temp, "　", " ");//////전각-2byte
				temp = Util.replace(temp, "  ", " ");//////공백2개
				
				if ( space_i > 0 )//////연속된 공백지우기 - 2번째부터 컬럼 비교
				{
					temp = Util.replace(temp, " ", "");//////공백없애기
				}
				space_i++;
			}
			else
			{
				space_i = 0;
			}
			target += temp;
		}
		
		return target;
	}
	//////2byte를 1byte로, 연속된 공백을 하나의 공백으로 치환 - E

//////일반 텍스트를 HTML코드로 변환
	public static String toHtml(String str) {
		String tmp = new String(str);

		tmp = Util.replace(tmp, "&", "&amp;");
		tmp = Util.replace(tmp, "<", "&lt;");
		tmp = Util.replace(tmp, ">", "&gt;");
		tmp = Util.replace(tmp, "\"", "&#034;");
		tmp = Util.replace(tmp, "\'", "&#039;");
		tmp = Util.replace(tmp, "\r\n", "<br>");
		tmp = Util.replace(tmp, "\n\r", "<br>");
		tmp = Util.replace(tmp, "\n", "<br>");
		tmp = Util.replace(tmp, "\r", "<br>");
		return tmp;
	}

	public static String fillSpace(String str, int width, String s)
	{
		int fillLen = width - str.getBytes().length;
		String space = "";
		for (int i = 0; i < fillLen; i++)
			space += s;

		return str + space;
	}

	public static String fillSpace(String str, int width)
	{
		return fillSpace(str, width, " ");
	}

	public static String fillSpace(int str, int width)
	{
		return fillSpace(String.valueOf(str), width, " ");
	}

	//////HTML 태그를 DELETING
    public static String removeTag(String source){
        if (source == null)  return "";

        String result = "";
        int cursor = 0;
        int tagFront = 0;
        int tagLast = 0;
        int cursorLast = 0;
        boolean check = false;

        while(cursor != -1 && cursor < source.length() && (tagFront = source.indexOf("<", cursor)) != -1) {

            for(cursorLast = cursor; (tagLast = source.indexOf(">", cursorLast)) != -1 && tagLast < tagFront; cursorLast = tagLast + 1);
            result = String.valueOf(result) + String.valueOf(source.substring(cursor, tagFront));

            if (tagLast != -1){
                check = true;
                int i = 0;
                do{
                    if (i >= shortTag.length)  break;
                    if (source.substring(tagFront, tagLast + 1).toLowerCase().equals(shortTag[i])){
                        result = String.valueOf(result) + String.valueOf(shortTag[i]);
                        check = false;
                        break;
                    }
                    i++;
                } while(true);
                cursor = tagLast + 1;
            } else{
                cursor = -1;
            }
        }
        if (cursor > -1 && cursor < source.length()) result = String.valueOf(result) + String.valueOf(source.substring(cursor));
        
		return result;
    }

    private static String shortTag[] = {
        "<br>"
    };
    private static String longTag[] = {
        "br"
    };

	public static char indexToAlphabet(int index)
	{
		String alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		char[] chars = alphabets.toCharArray();
		return chars[index];
	}
	
    public static String addComma(String org)
    {
        String oldStr = "0";
        String newStr = "";
        if (org != null)
            oldStr = org;
        int length = oldStr.length();
        int cntOfComma = length / 3;
        int matchValue = length % 3;
        if (matchValue == 0)
        {
            cntOfComma--;
            matchValue = 3;
        }
        for(int i = 0; i <= cntOfComma * 3; i += 3)
        {
            String temp = null;
            if (i == cntOfComma * 3)
                temp = oldStr.substring(0, matchValue);
            else
                temp = "," + oldStr.substring(oldStr.length() - 3 - i, oldStr.length() - i);
            newStr = temp + newStr;
        }

        return newStr;
    }

    public static String toTel(String str)
    {
        String retVal = "";
        int dLen = 0;
        try
        {
            dLen = str.length();
            if (str.substring(0, 2).equals("02") && dLen == 9)
                retVal = str.substring(0, 2) + "-" + str.substring(2, 5) + "-" + str.substring(5, dLen);
            else
            if (str.substring(0, 2).equals("02") && dLen == 10)
                retVal = str.substring(0, 2) + "-" + str.substring(2, 6) + "-" + str.substring(6, dLen);
            else
            if (dLen == 9 && !str.substring(0,2).equals("02"))
            	  retVal = str.substring(0,2) + "-" + str.substring(2, 5) + "-" + str.substring(5, dLen);
            else            
            if (dLen == 10 && !str.substring(0, 2).equals("02"))
                retVal = str.substring(0, 3) + "-" + str.substring(3, 6) + "-" + str.substring(6, dLen);
            else
            if (dLen == 11)
                retVal = str.substring(0, 3) + "-" + str.substring(3, 7) + "-" + str.substring(7, dLen);
        }
        catch(Exception e) { }
        return retVal;
    }	
    
  
	public static String to_Cell(String phonenum)
	{
		String tmp = "";
		String firstNum = "";		
		String allPhone = "";
		int      phonelength = phonenum.length();
		tmp = phonenum;
		if (tmp.length() > 0)
		{
			firstNum = tmp.substring(0,2);	
			if (firstNum.equals("01"))
			{
				if (phonelength == 10)
				{
					allPhone = tmp.substring(0,3) + "-" + tmp.substring(3,6) + "-" + tmp.substring(6);
				}
				else if (phonelength > 10)
				{
					allPhone = tmp.substring(0,3) + "-" + tmp.substring(3,7) + "-" + tmp.substring(7);
				}
			}
			else
			{
				if (phonelength == 12)
				{
					allPhone = tmp.substring(0,4) + "-" + tmp.substring(4,7) + "-" + tmp.substring(7);
				}
				else if (phonelength > 11)
				{
					allPhone = tmp.substring(0,4) + "-" + tmp.substring(3,8) + "-" + tmp.substring(8);
				}
			}
		}
		return allPhone;	
	}    
	
	public static String superTrim(String source)
	{
		String target = "";
		String temp = "";
		if (source == null)
			return target;
		for (int i = 0; i < source.length(); i++) {
			temp = source.substring(i, i + 1);
			if (!(temp.equals(" ") || temp.equals("　")))
				target += temp;
		}
		return target;
	}		
}

