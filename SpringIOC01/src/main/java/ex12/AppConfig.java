package ex12;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

@Configuration
public class AppConfig {
	@Value("${adminId}")
	private String id;
	@Value("${adminPwd}")
	private String pwd;
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer properties() {
		PropertySourcesPlaceholderConfigurer conf
		=new PropertySourcesPlaceholderConfigurer();
		Resource[] resources=new Resource[1];
		resources[0]=new ClassPathResource("admin.properties");
		
		conf.setLocations(resources);
		
		return conf;
	}
	@Bean
	public AdminVO adminInfo() {
		AdminVO vo=new AdminVO();
		vo.setAdminId(id);
		vo.setAdminPwd(pwd);
		return vo;
	}
}
