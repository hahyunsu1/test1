package ex10;

import java.io.FileWriter;
import java.io.IOException;

public class FileOutput implements Output {

	private String path;
	
	public void setPath(String path) {
		this.path=path;
	}

	@Override
	public void out(String msg) throws IOException {
		FileWriter fw=new FileWriter(path,true);
		fw.write(msg);
		fw.flush();
		fw.close();
	}


}
