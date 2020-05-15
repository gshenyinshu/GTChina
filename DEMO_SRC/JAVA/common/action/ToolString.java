package gtone.changeminer.common.action;

import java.lang.*;
import java.text.*;
import java.math.*;
import java.io.*;
import java.util.*;

public  class ToolString extends Object
{

	private static final char fullCharReplaceTable[][] = {
		/*{ '0'  , '0' },  
		{ '1'  , '1' },
		{ '2'  , '2' },
		{ '3'  , '3' },
		{ '4'  , '4' },
		{ '5'  , '5' },
		{ '6'  , '6' },
		{ '7'  , '7' },
		{ '8'  , '8' },
		{ '9'  , '9' },
		//////{ ' '  , '10' },
		//////{ '£Á'  , 'A' },
		//////{ '£Ð'  , 'P' },
		//////{ '£Ì'  , 'L' },
		//////{ '('   , '£¨'},
		//////{  ')'  , '£©' },
		//////{ '-'   , '£­' },
		//////{ '+'   , '£«' },
		//////{ '|'   , '£ü' },
		//////{ '\'   , '£Ü' },
		//////{ '<'   , '£¼' },
		//////{ '>'   , '£¾' },
		//////{ '`'   , '£§' },
		//////{ '"'  , '£¢' },
		//////{ ','   , '£¬' },
		//////{ '.'   , '£®' },
		//////{ '*'   , '£ª' },
		//////{ '!'   , '£¡' },
		//////{ '@'   , '£À' },
		//////{ '#'   , '££' },
		//////{ '$'   , '£¤' },
		//////{ '%'   , '£¥' },
		//////{ '^'   , '£Þ' },
		{ '&'   , '£¦' },
		{ '('   , '£¨' },
		{ ')'   , '£©' },
		{ '_'   , '£ß' },
		{ '='   , '£½' },
		{ '{'   , '£û' },
		{ '}'   , '£ý' },
		{ '['   , '£Û' },
		{ ']'   , '£Ý' },
		{ 'A'   , '£Á' },
		{ 'B'   , '£Â' },
		{ 'C'   , '£Ã' },
		{ 'D'   , '£Ä' },
		{ 'E'   , '£Å' },
		{ 'F'   , '£Æ' },
		{ 'G'   , '£Ç' },
		{ 'H'   , '£È' },
		{ 'I'   , '£É' },
		{ 'J'   , '£Ê' },
		{ 'K'   , '£Ë' },
		{ 'L'   , '£Ì' },
		{ 'M'   , '£Í' },
		{ 'N'   , '£Î' },
		{ 'O'   , '£Ï' },
		{ 'P'   , '£Ð' },
		{ 'Q'   , '£Ñ' },
		{ 'R'   , '£Ò' },
		{ 'S'   , '£Ó' },
		{ 'T'   , '£Ô' },
		{ 'U'   , '£Õ' },
		{ 'V'   , '£Ö' },
		{ 'W'   , '£×' },
		{ 'X'   , '£Ø' },
		{ 'Y'   , '£Ù' },
		{ 'Z'   , '£Ú' },
		{ 'a'   , '£á' },
		{ 'b'   , '£â' },
		{ 'c'   , '£ã' },
		{ 'd'   , '£ä' },
		{ 'e'   , '£å' },
		{ 'f'   , '£æ' },
		{ 'g'   , '£ç' },
		{ 'h'   , '£è' },
		{ 'i'   , '£é' },
		{ 'j'   , '£ê' },
		{ 'k'   , '£ë' },
		{ 'l'   , '£ì' },
		{ 'm'   , '£í' },
		{ 'n'   , '£î' },
		{ 'o'   , '£ï' },
		{ 'p'   , '£ð' },
		{ 'q'   , '£ñ' },
		{ 'r'   , '£ò' },
		{ 's'   , '£ó' },
		{ 't'   , '£ô' },
		{ 'u'   , '£õ' },
		{ 'v'   , '£ö' },
		{ 'w'   , '£÷' },
		{ 'x'   , '£ø' },
		{ 'y'   , '£ù' },
		{ 'z'   , '£ú' } */
	};

	public static String hanToFull (String string) {
		for ( int idx = 0 ; idx < fullCharReplaceTable.length ; idx ++ ) {
			string = string.replace(fullCharReplaceTable[idx][0],fullCharReplaceTable[idx][1]);
		}
		return string;
	}
	
	private static String replace(String str, String oldstr, String newstr) {
		String tmp = str;
		int i = 0;
		while(true) {
			int	start = tmp.indexOf(oldstr, i);
			if (start == -1) {
				break;
			}
			int	end = start + oldstr.length();
			tmp = tmp.substring(0, start) + newstr + tmp.substring(end);
			i = start + 1;
		}
		return tmp;
	}
  
	private static String to_Cell(String phonenum)
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
}

