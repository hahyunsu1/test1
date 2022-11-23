package ex10;

import java.io.FileWriter;
import java.io.IOException;

public class ConsoleOutput implements Output {
	
	private String path;
	
	public void setPath(String path) {
		this.path=path;
	}

	@Override
	public void out(String msg) throws IOException {
		System.out.println(msg);
		System.out.println(path);
	}

}
