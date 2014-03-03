package generator;

import java.awt.List;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Vector;

public class SourceFileGenerator {

	private static final String ROOT_FOLDER_NAME = "uCtrl";
	
	public void GenerateFiles()
	{
		boolean rootFolderFound = false;
		
		File rootFolder = new File(".");
		rootFolder = rootFolder.getAbsoluteFile();
		
		while(!rootFolderFound)
		{
			rootFolder = rootFolder.getParentFile();
			File[] subFiles = rootFolder.listFiles();
			
			for (File subFile : subFiles)
			{
				if (subFile.isDirectory() && subFile.getName().equals(ROOT_FOLDER_NAME))
				{
					rootFolderFound = true;
					rootFolder = subFile;
				}
			}
		}
		
		GenerateFile(rootFolder);
	}
	
	public void GenerateFile(File file)
	{
		if (file.isDirectory())
		{
			File[] subFiles = file.listFiles();
			for (File subFile : subFiles)
			{
				GenerateFile(subFile);
			}
			
			return;
		}
		
		if (file.getName().endsWith(".h"))
		{
			try
			{
				BufferedReader reader = new BufferedReader(new FileReader(file));
				
				String line;
				while ((line = reader.readLine()) != null)
				{
					if (line.contains("DECLARE_JSON_CLASS_ARGS") && !line.contains("#define"))
					{
						String[] arguments = GetArguments(line);
						JsonClass jsonClass = new JsonClass(false, file.getParent(), file.getName().replace(".h", ""), arguments);
						jsonClass.GenerateSourceFile();
					}
					else if (line.contains("DECLARE_JSON_CHILD_CLASS_ARGS") && !line.contains("#define"))
					{
						String[] arguments = GetArguments(line);
						JsonClass jsonClass = new JsonClass(true, file.getParent(), file.getName().replace(".h", ""), arguments);
						jsonClass.GenerateSourceFile();
					}
				}
				
				reader.close();
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
			}
		}
		
	}
	
	private String[] GetArguments(String line)
	{
		int openingParenthesis = line.indexOf("(") + 1;
		int closingParenthesis = line.indexOf(")");
		
		String[] splitArgs = line.substring(openingParenthesis, closingParenthesis).replace(" ",  "").split(",");
		
		return splitArgs;
	}
	
}
