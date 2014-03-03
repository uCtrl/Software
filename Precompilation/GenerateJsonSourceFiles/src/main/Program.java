package main;

import generator.SourceFileGenerator;

public class Program {

	public static void main(String[] args) {
		SourceFileGenerator generator = new SourceFileGenerator();
		generator.GenerateFiles();
		//generator.GenerateFile("test.txt");

	}

}
