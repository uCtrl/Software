package generator;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

public class JsonClass {

	private class JsonFlags
	{
		public boolean HasParent;
		
		public boolean NeedsJsonInclude;
		public boolean NeedsHeaderFileInclude;
		public boolean NeedsToObjectMethod;
		public boolean NeedsFillObjectMethod;
		public boolean NeedsSerializeMethod;
		public boolean NeedsFillMembersMethod;
		public boolean NeedsDeserializeMethod;
		
		public JsonFlags(boolean hasParent)
		{
			HasParent = hasParent;
			NeedsHeaderFileInclude = true;
			NeedsJsonInclude = true;
			NeedsToObjectMethod = true;
			NeedsFillObjectMethod = true;
			NeedsSerializeMethod = true;
			NeedsFillMembersMethod = true;
			NeedsDeserializeMethod = true;
		}
	}
	
	private static final String regexJsonInclude = "#include \".*json\\.h\"\\s*";
	private static final String regexHeaderIncludeFormat = "#include \"%s\\.h\"\\s*";
	private static final String regexToObjectMethodFormat = "\\s*json::Object %s::ToObject\\(\\).*";
	private static final String regexFillObjectMethodFormat = "\\s*void %s::FillObject\\(json::Object& obj\\).*";
	private static final String regexSerializeMethodFormat = "\\s*std::string %s::Serialize\\(\\).*";
	private static final String regexFillMembersMethodFormat = "\\s*void %s::FillMembers\\(const json::Object& obj\\).*";
	private static final String regexDeserializeMethodFormat = "%s\\s+%s::Deserialize\\(.*const\\s+json::Object\\s*&\\s+obj\\s*\\).*";
	
	private JsonFlags _flags;
	
	private String _folderPath;
	private String _fileName;
	private String _parentName;
	private String _name;
	private Vector<JsonArgument> _jsonArgs;
	
	public JsonClass(boolean hasParent, String folderPath, String fileName, String[] args)
	{
		_flags = new JsonFlags(hasParent);
		
		_fileName = fileName;
		set_folderPath(folderPath);
		set_name(args[0]);
		
		int i = 1;
		if (hasParent)
		{
			set_parentName(args[1]);
			i = 2;
		}
		
		_jsonArgs = new Vector<JsonArgument>();
		
		for (; i < args.length; i += 2)
		{
			JsonArgument arg = new JsonArgument();
			arg.setType(args[i]);
			arg.setName(args[i + 1]);
			
			_jsonArgs.add(arg);
		}
	}
	
	public void GenerateSourceFile()
	{
		String regexHeaderInclude = String.format(regexHeaderIncludeFormat, _fileName);
		String regexToObjectMethod = String.format(regexToObjectMethodFormat, _name);
		String regexFillObjectMethod = String.format(regexFillObjectMethodFormat, _name);
		String regexSerializeMethod = String.format(regexSerializeMethodFormat, _name);
		String regexFillMembersMethod = String.format(regexFillMembersMethodFormat, _name);
		String regexDeserializeMethod = String.format(regexDeserializeMethodFormat, _name, _name);
		
		File sourceFile = new File(_folderPath + "\\" + _fileName + ".cpp");
		try 
		{
			String currentContent = "";
			
			if (sourceFile.exists())
			{
				FileReader sourceFileReader = new FileReader(sourceFile);
				BufferedReader bufferedReader = new BufferedReader(sourceFileReader);
				
				String line;
				while ((line = bufferedReader.readLine()) != null)
				{
					if (line.matches(regexJsonInclude))
					{
						_flags.NeedsJsonInclude = false;
					}
					else if (line.matches(regexHeaderInclude))
					{
						_flags.NeedsHeaderFileInclude = false;
					}
					else if (line.matches(regexToObjectMethod))
					{
						_flags.NeedsToObjectMethod = false;
					}
					else if (line.matches(regexFillObjectMethod))
					{
						_flags.NeedsFillObjectMethod = false;
					}
					else if (line.matches(regexSerializeMethod))
					{
						_flags.NeedsSerializeMethod = false;
					}
					else if (line.matches(regexFillMembersMethod))
					{
						_flags.NeedsFillMembersMethod = false;
					}
					else if (line.matches(regexDeserializeMethod))
					{
						_flags.NeedsDeserializeMethod = false;
					}
					
					currentContent += line + "\n";
				}
				bufferedReader.close();
			}
			
			
			sourceFile.delete();
			sourceFile.createNewFile();
			
			FileWriter sourceFileWriter = new FileWriter(sourceFile, true);
			BufferedWriter bufferedWriter = new BufferedWriter(sourceFileWriter);
			PrintWriter printWriter = new PrintWriter(bufferedWriter);
			
			if (_flags.NeedsHeaderFileInclude)
			{
				String includeCode = String.format("#include \"%s.h\"\n\n", _fileName);
				printWriter.write(includeCode);
			}
			
			printWriter.write(currentContent);
			
			if (_flags.NeedsToObjectMethod)
			{
				GenerateToObjectCode(printWriter);
			}
			
			if (_flags.NeedsFillObjectMethod)
			{
				GenerateFillObjectCode(printWriter);
			}
			
			if (_flags.NeedsSerializeMethod)
			{
				GenerateSerializeCode(printWriter);
			}
			
			if (_flags.NeedsFillMembersMethod)
			{
				GenerateFillMembersCode(printWriter);
			}
			
			if (_flags.NeedsDeserializeMethod)
			{
				GenerateDeserializeCode(printWriter);
			}
			printWriter.close();
			
		}
		catch (IOException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void GenerateToObjectCode(PrintWriter printWriter)
	{
		printWriter.write(String.format("json::Object %s::ToObject()\n", _name));
		printWriter.write(String.format("{\n"));
		printWriter.write("\tjson::Object obj;\n");
		printWriter.write("\tFillObject(obj);\n");
		printWriter.write("\treturn obj;\n");
		printWriter.write(String.format("}\n\n"));
	}
	
	private void GenerateFillObjectCode(PrintWriter printWriter)
	{
		printWriter.write(String.format("void %s::FillObject(json::Object& obj)\n", _name));
		printWriter.write(String.format("{\n"));
		
		if (_flags.HasParent)
		{
			String parentFillObjectCall = String.format("\t%s::FillObject(obj);\n", _parentName);
			printWriter.write(parentFillObjectCall);
		}
		
		for (JsonArgument jsonArg : _jsonArgs)
		{
			GenerateObjectAssignment(printWriter, jsonArg);
		}
		
		printWriter.write(String.format("}\n\n"));
	}
	
	private void GenerateObjectAssignment(PrintWriter printWriter, JsonArgument jsonArgument)
	{
		String castCall = "";
		
		switch (jsonArgument.getType())
		{
		case "int":
		case "float":
		case "double":
		case "bool":
		case "std::string":
			break;
		default:
			castCall = ".ToObject()";
			break;
		}
		
		String assignmentCode = String.format("\tobj[\"%s\"] = %s%s;\n",
												jsonArgument.getName(),
												jsonArgument.getName(),
												castCall);
		printWriter.write(assignmentCode);
	}
	
	private void GenerateSerializeCode(PrintWriter printWriter)
	{
		printWriter.write(String.format("std::string %s::Serialize()\n", _name));
		printWriter.write(String.format("{\n"));
		
		printWriter.write("\tjson::Object obj = ToObject();\n");
		printWriter.write("\treturn json::Serialize(obj);\n");
		
		printWriter.write(String.format("}\n\n"));
	}
	
	private void GenerateFillMembersCode(PrintWriter printWriter)
	{
		printWriter.write(String.format("void %s::FillMembers(const json::Object& obj)\n", _name));
		printWriter.write(String.format("{\n"));
		
		if (_flags.HasParent)
		{
			String parentCall = String.format("\t%s::FillMembers(obj);\n", _parentName);
			printWriter.write(parentCall);
		}
		
		for (JsonArgument jsonArg : _jsonArgs)
		{
			GenerateMemberAssignment(printWriter, jsonArg);
		}
		
		printWriter.write(String.format("}\n\n"));
	}
	
	private void GenerateMemberAssignment(PrintWriter printWriter, JsonArgument jsonArgument)
	{
		String assignmentCode;

		switch (jsonArgument.getType())
		{
		case "int":
		case "float":
		case "double":
		case "bool":
			assignmentCode = String.format("\t%s = obj[\"%s\"];\n", jsonArgument.getName(), jsonArgument.getName());
			break;
		case "std::string":
			assignmentCode = String.format("\t%s = obj[\"%s\"].ToString();\n", 
											jsonArgument.getName(), 
											jsonArgument.getName());
			break;
		default:
			assignmentCode = String.format("\t%s = %s::Deserialize(obj[\"%s\"].ToObject());\n",
											jsonArgument.getName(),
											jsonArgument.getType(),
											jsonArgument.getName());
			break;
		}
		printWriter.write(assignmentCode);
	}
	
	private void GenerateDeserializeCode(PrintWriter printWriter)
	{
		printWriter.write(String.format("%s %s::Deserialize(const json::Object& obj)\n", _name, _name));
		printWriter.write(String.format("{\n"));
		
		printWriter.write(String.format("\t%s o;\n", _name));
		printWriter.write("\to.FillMembers(obj);\n");
		printWriter.write("\treturn o;\n");
		
		printWriter.write(String.format("}\n\n"));
	}

	public String get_parentName() {
		return _parentName;
	}

	public void set_parentName(String _parentName) {
		this._parentName = _parentName;
	}

	public String get_name() {
		return _name;
	}

	public void set_name(String _name) {
		this._name = _name;
	}

	public String get_folderPath() {
		return _folderPath;
	}

	public void set_folderPath(String _folderPath) {
		this._folderPath = _folderPath;
	}
}
