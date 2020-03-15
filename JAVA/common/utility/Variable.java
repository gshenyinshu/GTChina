package gtone.changeminer.common.utility;

import java.util.HashMap;

import gtone.changeminer.common.constant.Constant;

public  class Variable
{
	public static HashMap map = null;
	public Variable()
	{
	}

	public void put(String key, String value)
	{
		map.put(key, value);
	}

	public static String get(String key)
	{
		if (map == null)
			initialize();

		String value = (String)map.get(key);
		if (value == null) value = "�8�1";	

		/**
		 *	<val>${doc-root}/sub/bus</val>
		 *	�3�1�4�9�0�3 �9�9�0�3 �1�3�2�1�3�5 �8�3�3�5�8�0�8�5 �7�5�8�6
		 */
		if (value.indexOf("${") != -1)
		{
			char[] chars = value.toCharArray();

			StringBuffer buffer = new StringBuffer();
			int s = 0, f = 0;
			for (int i = 0; i < chars.length; i++)
			{
				if (chars[i] == '$' && chars[i + 1] == '{')
				{
					s = i + 2;
					if (value.indexOf("}", s) != -1)
					{
						f = value.indexOf("}", s);
						buffer.append(get(value.substring(s, f)));
					}
				}
				if (s < 2 || i < s - 2 || i > f)
					buffer.append(chars[i]);
			}
			value = buffer.toString();
		}

		return value;
	}

	public static String get(String key, boolean isInit)
	{
		if (isInit)
			initialize();

		return get(key);
	}

	public static void initialize()
	{
		try
		{
			VariableLoader.initialize(Constant.PRUHOME_XML);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
};

