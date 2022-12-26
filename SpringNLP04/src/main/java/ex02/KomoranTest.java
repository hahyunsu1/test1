package ex02;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.sound.sampled.Port.Info;

import common.KomoranUtil;
import common.nlp.WordCount;
import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import lombok.extern.log4j.Log4j;

//https://github.com/shineware/KOMORAN
/*
 * ====pom.xml================================
 * <!-- Komoran repository -->
	<repositories>
		<repository>
			<id>jitpack.id</id>
			<url>https://jitpack.io</url>
		</repository>
	</repositories>
	<dependencies>
	<!--dependencies �κп� �Ʒ� ���̺귯�� ���-->
	<!-- https://mvnrepository.com/artifact/com.github.shin285/KOMORAN -->
		<dependency>
			<groupId>com.github.shin285</groupId>
			<artifactId>KOMORAN</artifactId>
			<version>3.3.4</version>
		</dependency>
   </dependencies>		
 * */
@Log4j
public class KomoranTest {
	
	static Komoran nlp=new Komoran(DEFAULT_MODEL.FULL);
	
	public static List<String> getWordNouns(String str){
		String txt=str.replaceAll("[^��-�Ra-zA-Z0-9]", " ");
		txt=txt.trim();//�յ� ���� ����
		System.out.println(txt);
		System.out.println("----------------------------");
		//���¼� �м� ����
		KomoranResult res=nlp.analyze(txt);
		//���¼� �м� ��� �� ��縸 �����غ���.
		List<String> nounList=res.getNouns();
		
		if(nounList==null) {
			nounList=new ArrayList<>();
		}
		log.info("nounList===="+nounList);
		//nounList.forEach((s)->System.out.println(s));
		return nounList;
	}//---------------------------------
	
	public static Map<String, Integer> getWordCount(List<String> nounList){
		if(nounList==null) {
			nounList=new ArrayList<>();
		}
		//(�ܾ�, �󵵼�) (��, 3)
		Map<String, Integer> wMap=new HashMap<>();
		Set<String> set=new HashSet<>(nounList);
		//Set������ �ߺ��� �����Ͱ� ������� ����.
		
		Iterator<String> it=set.iterator();
		
		while(it.hasNext()) {
			String word=it.next();
			int frequency=Collections.frequency(nounList, word);
			log.info(word+": "+word+", frequency: "+frequency);
			wMap.put(word, frequency);
		}
		return wMap;
	}//--------------------------------
	
	
	public static void main(String[] args) {
		String str="���� �νð� Ǫ���� ���� �ڡ� �׸��� ����� �׸��� ����. ���� ���� ��, ���� �� �ڸ� �ʷ��� ���� ��ǳ ��µ�";
		str+="���� ������ ���� �ϸ��� ���� �� ���� ���� �ϸ��� ���� �װ� �װ� ��ٸ�!�ڡڡ� �װ� �װ� ���� ��ٸ�? ";
		str+="���� �νð� Ǫ���� ���� �׸��� ����� �׸��� ���� -������ Ǫ���� �� Poem  12345";
		//�ѱ�,���ĺ�,���ڰ� �ƴ� ���ڿ��� �����غ���.
		//[^\\w]
		String txt=str.replaceAll("[^��-�Ra-zA-Z0-9]", " ");
		txt=txt.trim();//�յ� ���� ����
		System.out.println(txt);
		System.out.println("----------------------------");
		//���¼� �м� ����
		KomoranResult res=nlp.analyze(txt);
		//���¼� �м� ��� �� ��縸 �����غ���.
		List<String> nounList=res.getNouns();
		
		if(nounList==null) {
			nounList=new ArrayList<>();
		}
		
		nounList.forEach((s)->System.out.println(s));
		
		Map<String,Integer> map=getWordCount(nounList);
		
		List<WordCount> wordList=KomoranUtil.getWordCountSortProc(map, 1);//�󵵼��� 2���̻� ������ �ܾ� ��� ��������
		
		System.out.println(wordList);
		System.out.println("***************************");
		
		List<WordCount> wordList2=KomoranUtil.getWordByTag(str, 0, "NNG","NNP");
		System.out.println(wordList2);
		
		
		
		
	}

}
