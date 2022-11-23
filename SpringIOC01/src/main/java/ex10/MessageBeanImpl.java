package ex10;

import java.io.IOException;

public class MessageBeanImpl implements MessageBean {
	
	private String name;
	private String greeting;
	
	private Output out;
	
	public MessageBeanImpl(Output out) {
		this.out=out;
	}

	@Override
	public void sayHello() {
		try {
			out.out(greeting+" "+name);
		}catch(IOException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void sayHi(String... names) {
		try {
			out.out(greeting);
			if(names!=null) {
				for(String name:names)
					out.out(name+", ");
			}
			}catch(Exception e) {
				e.printStackTrace();
			}

	}

	public void setName(String name) {
		this.name = name;
	}

	public void setGreeting(String greeting) {
		this.greeting = greeting;
	}

	
}
