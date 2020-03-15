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
		//////{ 'Ａ'  , 'A' },
		//////{ 'Ｐ'  , 'P' },
		//////{ 'Ｌ'  , 'L' },
		//////{ '('   , '（'},
		//////{  ')'  , '）' },
		//////{ '-'   , '－' },
		//////{ '+'   , '＋' },
		//////{ '|'   , '｜' },
		//////{ '\'   , '￦' },
		//////{ '<'   , '＜' },
		//////{ '>'   , '＞' },
		//////{ '`'   , '＇' },
		//////{ '"'  , '＂' },
		//////{ ','   , '，' },
		//////{ '.'   , '．' },
		//////{ '*'   , '＊' },
		//////{ '!'   , '！' },
		//////{ '@'   , '＠' },
		//////{ '#'   , '＃' },
		//////{ '$'   , '＄' },
		//////{ '%'   , '％' },
		//////{ '^'   , '＾' },
		{ '&'   , '＆' },
		{ '('   , '（' },
		{ ')'   , '）' },
		{ '_'   , '＿' },
		{ '='   , '＝' },
		{ '{'   , '｛' },
		{ '}'   , '｝' },
		{ '['   , '［' },
		{ ']'   , '］' },
		{ 'A'   , 'Ａ' },
		{ 'B'   , 'Ｂ' },
		{ 'C'   , 'Ｃ' },
		{ 'D'   , 'Ｄ' },
		{ 'E'   , 'Ｅ' },
		{ 'F'   , 'Ｆ' },
		{ 'G'   , 'Ｇ' },
		{ 'H'   , 'Ｈ' },
		{ 'I'   , 'Ｉ' },
		{ 'J'   , 'Ｊ' },
		{ 'K'   , 'Ｋ' },
		{ 'L'   , 'Ｌ' },
		{ 'M'   , 'Ｍ' },
		{ 'N'   , 'Ｎ' },
		{ 'O'   , 'Ｏ' },
		{ 'P'   , 'Ｐ' },
		{ 'Q'   , 'Ｑ' },
		{ 'R'   , 'Ｒ' },
		{ 'S'   , 'Ｓ' },
		{ 'T'   , 'Ｔ' },
		{ 'U'   , 'Ｕ' },
		{ 'V'   , 'Ｖ' },
		{ 'W'   , 'Ｗ' },
		{ 'X'   , 'Ｘ' },
		{ 'Y'   , 'Ｙ' },
		{ 'Z'   , 'Ｚ' },
		{ 'a'   , 'ａ' },
		{ 'b'   , 'ｂ' },
		{ 'c'   , 'ｃ' },
		{ 'd'   , 'ｄ' },
		{ 'e'   , 'ｅ' },
		{ 'f'   , 'ｆ' },
		{ 'g'   , 'ｇ' },
		{ 'h'   , 'ｈ' },
		{ 'i'   , 'ｉ' },
		{ 'j'   , 'ｊ' },
		{ 'k'   , 'ｋ' },
		{ 'l'   , 'ｌ' },
		{ 'm'   , 'ｍ' },
		{ 'n'   , 'ｎ' },
		{ 'o'   , 'ｏ' },
		{ 'p'   , 'ｐ' },
		{ 'q'   , 'ｑ' },
		{ 'r'   , 'ｒ' },
		{ 's'   , 'ｓ' },
		{ 't'   , 'ｔ' },
		{ 'u'   , 'ｕ' },
		{ 'v'   , 'ｖ' },
		{ 'w'   , 'ｗ' },
		{ 'x'   , 'ｘ' },
		{ 'y'   , 'ｙ' },
		{ 'z'   , 'ｚ' } */
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

