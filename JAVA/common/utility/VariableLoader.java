package gtone.changeminer.common.utility;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.HashMap;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

public  class VariableLoader
{
	public static void initialize(String mylp_xml)
		 throws JDOMException, IOException
	{
		Document doc = readXmlFile(mylp_xml);
		Element rootElement = doc.getRootElement();

		List varList = rootElement.getChildren("variable");
		Element varElement = null;
		Element subElement = null;
		
		List subList = null;
		Variable.map = new HashMap();
		for (int i = 0; i < varList.size(); i++)
		{
			varElement = (Element)varList.get(i);
			String element_name = varElement.getAttributeValue("name");
			subList = varElement.getChildren();
			for (int j = 0; j < subList.size(); j++)
			{
				subElement = (Element)subList.get(j);
				Variable.map.put(element_name + "." + subElement.getName(), subElement.getTextTrim());
			}
		}
	}

	private static Document readXmlFile(String file) throws JDOMException
	{

		SAXBuilder builder = new SAXBuilder();
		Document doc = builder.build(new File(file));
		return doc;
	}
};

