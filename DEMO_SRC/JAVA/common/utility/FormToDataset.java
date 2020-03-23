package gtone.changeminer.common.utility;


import java.util.*;
import java.beans.*;
import java.lang.reflect.*;
import org.apache.commons.collections.FastHashMap;
import org.apache.commons.beanutils.MethodUtils;
import anyframe.data.DataSet;

public  class FormToDataset
{
	public static void copyProperties(DataSet dataSet, Object orig)
	{
		try	{
			PropertyDescriptor origDescriptors[] = getPropertyDescriptors(orig);				
			for(int i = 0; i < origDescriptors.length; i++)
			{
				String name = origDescriptors[i].getName();
				Object value = null;
				try
				{
					value = getSimpleProperty(orig, name);
				}
				 catch (NoSuchMethodException nsme)
				{
					continue;
				}
				dataSet.put(name, value);
			}
		}
		catch(Exception e)
		{
			
			e.printStackTrace();
		}
	}

	public static Object getSimpleProperty(Object bean, String name)
		throws IllegalAccessException, InvocationTargetException, NoSuchMethodException
	{
		if (bean == null)
			throw new IllegalArgumentException("No bean specified");

		if (name == null)
			throw new IllegalArgumentException("No name specified");

		PropertyDescriptor descriptor = getPropertyDescriptor(bean, name);

		if (descriptor == null)
			throw new NoSuchMethodException("Unknown property '" + name + "'");

		Method readMethod = getReadMethod(descriptor);
		
		if (readMethod == null)
		{
			throw new NoSuchMethodException("Property '" + name + "' has no getter method");
		}
		else
		{
			Object value = readMethod.invoke(bean, new Object[0]);
			return value;
		}
	}



	public static PropertyDescriptor[] getPropertyDescriptors(Object bean)
	{
		if (bean == null)
			throw new IllegalArgumentException("No bean specified");
		else
			return getPropertyDescriptors(bean.getClass());
	}



	public static PropertyDescriptor[] getPropertyDescriptors(Class beanClass)
	{
		if (beanClass == null)
			throw new IllegalArgumentException("No bean class specified");
		
		PropertyDescriptor descriptors[] = null;
		descriptors = (PropertyDescriptor[])descriptorsCache.get(beanClass);
		
		if (descriptors != null)
			return descriptors;
		
		BeanInfo beanInfo = null;
		
		try
		{
			beanInfo = Introspector.getBeanInfo(beanClass);
		}
		catch(IntrospectionException e)
		{
			return new PropertyDescriptor[0];
		}
		
		descriptors = beanInfo.getPropertyDescriptors();
		if (descriptors == null)
			descriptors = new PropertyDescriptor[0];
		
		descriptorsCache.put(beanClass, descriptors);
		
		return descriptors;
	}


	public static PropertyDescriptor getPropertyDescriptor(Object bean, String name)
		throws IllegalAccessException, InvocationTargetException, NoSuchMethodException
	{
		if (bean == null)
			throw new IllegalArgumentException("No bean specified");

		if (name == null)
			throw new IllegalArgumentException("No name specified");
		
		if (bean == null || name == null)
			return null;
		
		PropertyDescriptor descriptors[] = getPropertyDescriptors(bean);

		for(int i = 0; i < descriptors.length; i++)
			if (name.equals(descriptors[i].getName()))
				return descriptors[i];

		return null;
	}

	public static Method getReadMethod(PropertyDescriptor descriptor)
	{
		return MethodUtils.getAccessibleMethod(descriptor.getReadMethod());
	}

	private static FastHashMap descriptorsCache;

	static 
	{
		descriptorsCache = null;
		descriptorsCache = new FastHashMap();
		descriptorsCache.setFast(true);
	}
};


