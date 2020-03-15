package gtone.changeminer.common.utility;

import java.lang.*;
import java.text.*;
import java.math.*;
import java.io.*;

public  class ToolString extends Object
{
/* -----------------------------------------------------------------------------
* Comment  : �0�5�7�6�0�1�3�1�0�7 �3�7�7�6�0�1�3�1�0�9
----------------------------------------------------------------------------- */
	private static final char fullCharReplaceTable[][] = {
		/*{ '0'   , '��' },
		{ '1'   , '��' },
		{ '2'   , '��' },
		{ '3'   , '��' },
		{ '4'   , '��' },
		{ '5'   , '��' },
		{ '6'   , '��' },
		{ '7'   , '��' },
		{ '8'   , '��' },
		{ '9'   , '��' },
		{ ' '   , '��' },
		{ '-'   , '��' },
		{ '+'   , '��' },
		{ '|'   , '��' },		
		{ '<'   , '��' },
		{ '>'   , '��' },
		{ '`'   , '��' },
		{ '"'   , '��' },
		{ ','   , '��' },
		{ '.'   , '��' },
		{ '*'   , '��' },
		{ '!'   , '��' },
		{ '@'   , '��' },
		{ '#'   , '��' },
		{ '$'   , '��' },
		{ '%'   , '��' },
		{ '^'   , '��' },
		{ '&'   , '��' },
		{ '_'   , '��' },
		{ '='   , '��' },
		{ '{'   , '��' },
		{ '}'   , '��' },
		{ '['   , '��' },
		{ ']'   , '��' },
		{ 'A'   , '��' },
		{ 'B'   , '��' },
		{ 'C'   , '��' },
		{ 'D'   , '��' },
		{ 'E'   , '��' },
		{ 'F'   , '��' },
		{ 'G'   , '��' },
		{ 'H'   , '��' },
		{ 'I'   , '��' },
		{ 'J'   , '��' },
		{ 'K'   , '��' },
		{ 'L'   , '��' },
		{ 'M'   , '��' },
		{ 'N'   , '��' },
		{ 'O'   , '��' },
		{ 'P'   , '��' },
		{ 'Q'   , '��' },
		{ 'R'   , '��' },
		{ 'S'   , '��' },
		{ 'T'   , '��' },
		{ 'U'   , '��' },
		{ 'V'   , '��' },
		{ 'W'   , '��' },
		{ 'X'   , '��' },
		{ 'Y'   , '��' },
		{ 'Z'   , '��' },
		{ 'a'   , '��' },
		{ 'b'   , '��' },
		{ 'c'   , '��' },
		{ 'd'   , '��' },
		{ 'e'   , '��' },
		{ 'f'   , '��' },
		{ 'g'   , '��' },
		{ 'h'   , '��' },
		{ 'i'   , '��' },
		{ 'j'   , '��' },
		{ 'k'   , '��' },
		{ 'l'   , '��' },
		{ 'm'   , '��' },
		{ 'n'   , '��' },
		{ 'o'   , '��' },
		{ 'p'   , '��' },
		{ 'q'   , '��' },
		{ 'r'   , '��' },
		{ 's'   , '��' },
		{ 't'   , '��' },
		{ 'u'   , '��' },
		{ 'v'   , '��' },
		{ 'w'   , '��' },
		{ 'x'   , '��' },
		{ 'y'   , '��' },
		{ 'z'   , '��' },		
		{ '('  ,  '��' },
		{ ')'  ,  '��' }		
		//////{ '��'  ,  '(' },
		//////{ '��'  ,  ')' } */  
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
		{ '��'  ,  '(' },
		{ '��'  ,  ')' }
	};
		
	public static String hanToFullc (String string) {
		for ( int idx = 0 ; idx < fullCharReplaceTable1.length ; idx ++ ) {
			string = string.replace(fullCharReplaceTable1[idx][0],fullCharReplaceTable1[idx][1]);
		}
		return string;
	}
/*----------------------------------------------------------------------------- */




/* -----------------------------------------------------------------------------
* Comment  : �3�7�7�6�0�1�3�1�0�7 �0�5�7�6�0�1�3�1�0�9
----------------------------------------------------------------------------- */
	private static final char halfCharReplaceTable[][] = {
		{  '��' ,  '0' },
		{  '��' ,  '1' },
		{  '��' ,  '2' },
		{  '��' ,  '3' },
		{  '��' ,  '4' },
		{  '��' ,  '5' },
		{  '��' ,  '6' },
		{  '��' ,  '7' },
		{  '��' ,  '8' },
		{  '��' ,  '9' },
		{  '��' ,  ' ' },
		{ '��'  ,  'A' },
		{ '��'  ,  'P' },
		{ '��'  ,  'L' },
		{ '��'  ,  '(' },
		{ '��'  ,  ')' },
		{ '��'  ,  '-' },
		{ '��'  ,  '+' },
		{ '��'  ,  '|' },
		{ '��'  ,  '<' },
		{ '��'  ,  '>' },
		{ '��'  ,  '`' },
		{ '��'  ,  '"' },
		{ '��'  ,  ',' },
		{ '��'  ,  '.' },
		{ '��'  ,  '*' },
		{ '��'  ,  '!' },
		{ '��'  ,  '@' },
		{ '��'  ,  '#' },
		{ '��'  ,  '$' },
		{ '��'  ,  '%' },
		{ '��'  ,  '^' },
		{ '��'  ,  '&' },
		{ '��'  ,  '_' },
		{ '��'  ,  '=' },
		{ '��'  ,  '{' },
		{ '��'  ,  '}' },
		{ '��'  ,  '[' },
		{ '��'  ,  ']' },
		{ '��'  ,  'A' },
		{ '��'  ,  'B' },
		{ '��'  ,  'C' },
		{ '��'  ,  'D' },
		{ '��'  ,  'E' },
		{ '��'  ,  'F' },
		{ '��'  ,  'G' },
		{ '��'  ,  'H' },
		{ '��'  ,  'I' },
		{ '��'  ,  'J' },
		{ '��'  ,  'K' },
		{ '��'  ,  'L' },
		{ '��'  ,  'M' },
		{ '��'  ,  'N' },
		{ '��'  ,  'O' },
		{ '��'  ,  'P' },
		{ '��'  ,  'Q' },
		{ '��'  ,  'R' },
		{ '��'  ,  'S' },
		{ '��'  ,  'T' },
		{ '��'  ,  'U' },
		{ '��'  ,  'V' },
		{ '��'  ,  'W' },
		{ '��'  ,  'X' },
		{ '��'  ,  'Y' },
		{ '��'  ,  'Z' },
		{ '��'  ,  'a' },
		{ '��'  ,  'b' },
		{ '��'  ,  'c' },
		{ '��'  ,  'd' },
		{ '��'  ,  'e' },
		{ '��'  ,  'f' },
		{ '��'  ,  'g' },
		{ '��'  ,  'h' },
		{ '��'  ,  'i' },
		{ '��'  ,  'j' },
		{ '��'  ,  'k' },
		{ '��'  ,  'l' },
		{ '��'  ,  'm' },
		{ '��'  ,  'n' },
		{ '��'  ,  'o' },
		{ '��'  ,  'p' },
		{ '��'  ,  'q' },
		{ '��'  ,  'r' },
		{ '��'  ,  's' },
		{ '��'  ,  't' },
		{ '��'  ,  'u' },
		{ '��'  ,  'v' },
		{ '��'  ,  'w' },
		{ '��'  ,  'x' },
		{ '��'  ,  'y' },
		{ '��'  ,  'z' }		
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
