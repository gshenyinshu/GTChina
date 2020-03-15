package gtone.changeminer.common.utility;

import java.lang.*;
import java.text.*;
import java.math.*;
import java.io.*;

public  class ToolString extends Object
{
/* -----------------------------------------------------------------------------
* Comment  : 반각문자를 전각문자로
----------------------------------------------------------------------------- */
	private static final char fullCharReplaceTable[][] = {
		/*{ '0'   , '０' },
		{ '1'   , '１' },
		{ '2'   , '２' },
		{ '3'   , '３' },
		{ '4'   , '４' },
		{ '5'   , '５' },
		{ '6'   , '６' },
		{ '7'   , '７' },
		{ '8'   , '８' },
		{ '9'   , '９' },
		{ ' '   , '　' },
		{ '-'   , '－' },
		{ '+'   , '＋' },
		{ '|'   , '｜' },		
		{ '<'   , '＜' },
		{ '>'   , '＞' },
		{ '`'   , '＇' },
		{ '"'   , '＂' },
		{ ','   , '，' },
		{ '.'   , '．' },
		{ '*'   , '＊' },
		{ '!'   , '！' },
		{ '@'   , '＠' },
		{ '#'   , '＃' },
		{ '$'   , '＄' },
		{ '%'   , '％' },
		{ '^'   , '＾' },
		{ '&'   , '＆' },
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
		{ 'z'   , 'ｚ' },		
		{ '('  ,  '（' },
		{ ')'  ,  '）' }		
		//////{ '（'  ,  '(' },
		//////{ '）'  ,  ')' } */  
	};


	public static String hanToFull (String string) {
		for ( int idx = 0 ; idx < fullCharReplaceTable.length ; idx ++ ) {
			string = string.replace(fullCharReplaceTable[idx][0],fullCharReplaceTable[idx][1]);
		}
		return string;
	}
/*----------------------------------------------------------------------------- */



/*----------------------------------------------------------------------------- */
	private static final char fullCharReplaceTable1[][] = {		
		{ '（'  ,  '(' },
		{ '）'  ,  ')' }
	};
		
	public static String hanToFullc (String string) {
		for ( int idx = 0 ; idx < fullCharReplaceTable1.length ; idx ++ ) {
			string = string.replace(fullCharReplaceTable1[idx][0],fullCharReplaceTable1[idx][1]);
		}
		return string;
	}
/*----------------------------------------------------------------------------- */




/* -----------------------------------------------------------------------------
* Comment  : 전각문자를 반각문자로
----------------------------------------------------------------------------- */
	private static final char halfCharReplaceTable[][] = {
		{  '０' ,  '0' },
		{  '１' ,  '1' },
		{  '２' ,  '2' },
		{  '３' ,  '3' },
		{  '４' ,  '4' },
		{  '５' ,  '5' },
		{  '６' ,  '6' },
		{  '７' ,  '7' },
		{  '８' ,  '8' },
		{  '９' ,  '9' },
		{  '　' ,  ' ' },
		{ 'Ａ'  ,  'A' },
		{ 'Ｐ'  ,  'P' },
		{ 'Ｌ'  ,  'L' },
		{ '（'  ,  '(' },
		{ '）'  ,  ')' },
		{ '－'  ,  '-' },
		{ '＋'  ,  '+' },
		{ '｜'  ,  '|' },
		{ '＜'  ,  '<' },
		{ '＞'  ,  '>' },
		{ '＇'  ,  '`' },
		{ '＂'  ,  '"' },
		{ '，'  ,  ',' },
		{ '．'  ,  '.' },
		{ '＊'  ,  '*' },
		{ '！'  ,  '!' },
		{ '＠'  ,  '@' },
		{ '＃'  ,  '#' },
		{ '＄'  ,  '$' },
		{ '％'  ,  '%' },
		{ '＾'  ,  '^' },
		{ '＆'  ,  '&' },
		{ '＿'  ,  '_' },
		{ '＝'  ,  '=' },
		{ '｛'  ,  '{' },
		{ '｝'  ,  '}' },
		{ '［'  ,  '[' },
		{ '］'  ,  ']' },
		{ 'Ａ'  ,  'A' },
		{ 'Ｂ'  ,  'B' },
		{ 'Ｃ'  ,  'C' },
		{ 'Ｄ'  ,  'D' },
		{ 'Ｅ'  ,  'E' },
		{ 'Ｆ'  ,  'F' },
		{ 'Ｇ'  ,  'G' },
		{ 'Ｈ'  ,  'H' },
		{ 'Ｉ'  ,  'I' },
		{ 'Ｊ'  ,  'J' },
		{ 'Ｋ'  ,  'K' },
		{ 'Ｌ'  ,  'L' },
		{ 'Ｍ'  ,  'M' },
		{ 'Ｎ'  ,  'N' },
		{ 'Ｏ'  ,  'O' },
		{ 'Ｐ'  ,  'P' },
		{ 'Ｑ'  ,  'Q' },
		{ 'Ｒ'  ,  'R' },
		{ 'Ｓ'  ,  'S' },
		{ 'Ｔ'  ,  'T' },
		{ 'Ｕ'  ,  'U' },
		{ 'Ｖ'  ,  'V' },
		{ 'Ｗ'  ,  'W' },
		{ 'Ｘ'  ,  'X' },
		{ 'Ｙ'  ,  'Y' },
		{ 'Ｚ'  ,  'Z' },
		{ 'ａ'  ,  'a' },
		{ 'ｂ'  ,  'b' },
		{ 'ｃ'  ,  'c' },
		{ 'ｄ'  ,  'd' },
		{ 'ｅ'  ,  'e' },
		{ 'ｆ'  ,  'f' },
		{ 'ｇ'  ,  'g' },
		{ 'ｈ'  ,  'h' },
		{ 'ｉ'  ,  'i' },
		{ 'ｊ'  ,  'j' },
		{ 'ｋ'  ,  'k' },
		{ 'ｌ'  ,  'l' },
		{ 'ｍ'  ,  'm' },
		{ 'ｎ'  ,  'n' },
		{ 'ｏ'  ,  'o' },
		{ 'ｐ'  ,  'p' },
		{ 'ｑ'  ,  'q' },
		{ 'ｒ'  ,  'r' },
		{ 'ｓ'  ,  's' },
		{ 'ｔ'  ,  't' },
		{ 'ｕ'  ,  'u' },
		{ 'ｖ'  ,  'v' },
		{ 'ｗ'  ,  'w' },
		{ 'ｘ'  ,  'x' },
		{ 'ｙ'  ,  'y' },
		{ 'ｚ'  ,  'z' }		
	};

	public static String fullTohalf (String string) {
		for ( int idx = 0 ; idx < halfCharReplaceTable.length ; idx ++ ) {
			string = string.replace(halfCharReplaceTable[idx][0],halfCharReplaceTable[idx][1]);
		}
		return string;
	}
/*----------------------------------------------------------------------------- */




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
