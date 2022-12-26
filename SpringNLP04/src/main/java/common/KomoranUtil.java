package common;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Set;

import org.springframework.stereotype.Component;

import common.nlp.WordCount;
import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class KomoranUtil {
	
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
	}//----------------------------------------
	
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
			//�ߺ��� �ܾ��Ͽ��� �ߺ����� ���� �ܾ��� ī��Ʈ���� ����
			int frequency=Collections.frequency(nounList, word);
			log.info(word+": "+word+", frequency: "+frequency);
			wMap.put(word, frequency);
		}
		return wMap;
	}//--------------------------------
	
	//ī���� �� �ܾ� �󵵼� �ʿ��� �󵵼��� 2�� �̻��� �ܾ�鸸 sorting�ؼ� ��ȭ�� �޼���
	public static List<WordCount> getWordCountSortProc(Map<String, Integer> map, int n){
		
		PriorityQueue<WordCount> pq=new PriorityQueue<WordCount>();
		Set<String> set=map.keySet();//key���鸸 set�������� ����
		for(String key:set) {
			Integer val=map.get(key);
			WordCount wc=new WordCount();
			wc.setWord(key);
			wc.setCnt(val);
			pq.add(wc);
		}
		
		List<WordCount> arr=new ArrayList<>();
		while(! pq.isEmpty()) {
			WordCount wc=pq.poll();
			if(wc.getWord().length()>=1&& wc.getCnt()>n) {
				//Ư�� �󵵼� �̻��� ��ҵ鸸 ArrayList�� ����
				arr.add(wc);
			}			
		}
		return arr;
	}//-----------------------------------
	
	//pos�±� �߿��� ������ ǰ���� ���ڿ��� �����ؼ� ī��Ʈ�� ���� ��ȯ�ϴ� �޼���
	public static List<WordCount> getWordByTag(String text, int minCnt,String...tags){
		KomoranResult res=nlp.analyze(text);
		List<String> arr=res.getMorphesByTags(tags);
		if(arr==null) {
			arr=new ArrayList<>();
		}
		
		Map<String, Integer> wordCount=getWordCount(arr);
		if(wordCount==null) {
			wordCount=new HashMap<String,Integer>();
		}
		
		List<WordCount> arr2=getWordCountSortProc(wordCount, minCnt);
		return arr2;		
	}
	
	

}



