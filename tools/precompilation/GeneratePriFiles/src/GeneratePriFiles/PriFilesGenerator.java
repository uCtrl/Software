package GeneratePriFiles;

import java.awt.List;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Vector;

public class PriFilesGenerator {

	private static final String ROOT_FOLDER_NAME = "uCtrl";
	
	public static void main(String[] args) {
		GenerateFiles();
	}
	
	private static void GenerateFiles()
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
	
	private static void GenerateFile(File folder)
	{
		File[] subFiles = folder.listFiles();
		
		for (File subFile : subFiles)
		{
			if (subFile.isDirectory())
			{
				GenerateFile(subFile);
			}
			
			if (subFile.getName().endsWith(".pri"))
			{
				UpdatePriFile(subFile);
			}
		}
	}
	
	private static void UpdatePriFile(File priFile)
	{
		// Ignore the common.pri
		if (priFile.getName().equals("common.pri"))
			return;
		
		try {
			priFile.delete();
			priFile.createNewFile();
			
			Vector<String> headerFilesName = new Vector<String>();
			Vector<String> sourceFilesName = new Vector<String>();
						
			UpdatePriStrings(priFile.getParentFile(), headerFilesName, sourceFilesName);
			
			// Convert to relative paths
			String parentPath = priFile.getParent() + "\\";
			for (int i = 0; i < headerFilesName.size(); i++)
			{
				headerFilesName.set(i, headerFilesName.get(i).replace(parentPath, "").replace("\\", "/"));
			}
			
			for (int i = 0; i < sourceFilesName.size(); i++)
			{
				sourceFilesName.set(i, sourceFilesName.get(i).replace(parentPath, "").replace("\\", "/"));
			}
			
			FileWriter fileWriter = new FileWriter(priFile);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			
			bufferedWriter.write("HEADERS += "	);
			for (String headerPath : headerFilesName)
			{
				bufferedWriter.write(headerPath + " \\\n");
			}
			bufferedWriter.write("\n");
			bufferedWriter.write("SOURCES += "	);
			for (String sourcePath : sourceFilesName)
			{
				bufferedWriter.write(sourcePath + " \\\n");
			}
			
			bufferedWriter.close();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	private static void UpdatePriStrings(File currentFile, Vector<String> headerFilesName, Vector<String> sourceFilesName)
	{
		if (currentFile.isDirectory())
		{
			File[] subFiles = currentFile.listFiles();
			for (File subFile : subFiles)
			{
				UpdatePriStrings(subFile, headerFilesName, sourceFilesName);
			}
		}
		
		if (currentFile.getName().endsWith(".h"))
		{
			headerFilesName.add(currentFile.getAbsolutePath());
			return;
		}
		
		if (currentFile.getName().endsWith(".cpp"))
		{
			sourceFilesName.add(currentFile.getAbsolutePath());
			return;
		}
	}
}
