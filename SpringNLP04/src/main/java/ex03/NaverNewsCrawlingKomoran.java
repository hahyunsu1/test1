package ex03;

import java.awt.Dimension;
import java.awt.Insets;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.swing.JFrame;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import common.KomoranUtil;
import common.nlp.CloudImageGenerator;
import common.nlp.CloudViewer;
import common.nlp.StringProcessor;
import common.nlp.WordCount;
import lombok.extern.log4j.Log4j;

@Log4j
public class NaverNewsCrawlingKomoran {

	public static void main(String[] args) throws Exception{
		// TODO Auto-generated method stub
		String url="https://n.news.naver.com/mnews/article/277/0005195057?sid=105";
		
		NaverNewsCrawlingKomoran app=new NaverNewsCrawlingKomoran();
		app.getNewsContents(url);
		
		
	}//----------------------------------
	public String getNewsContents(String url) throws Exception{
		String str="";
		//http�������ݸ� ����. https���������� ���Ȼ� �ȵȴ�
		Document doc=Jsoup.connect(url).get();
		//System.out.println(doc);
		//#newsct_article
		Elements newsContent=doc.select("div#newsct_article");
		str=newsContent.text();
		
		List<String> nounArr=KomoranUtil.getWordNouns(str);
		Map<String,Integer> wordCountMap= KomoranUtil.getWordCount(nounArr);
		List<WordCount> wordCountList=KomoranUtil.getWordCountSortProc(wordCountMap, 0);
		
		log.info(wordCountList);
		HashSet<String> stopWord=new HashSet<>();//�ҿ�� �÷���
		stopWord.add("�ΰ�");
		stopWord.add("��");
		stopWord.add("����");
		
		StringProcessor strProc=new StringProcessor(str, stopWord);
		
		ArrayList<WordCount> arrList=strProc.processString2(wordCountMap, 0);
		
		makeWordCloudView(strProc);
		
		return str;
	}//-----------------------------------
	
	public static final int WIDTH=1200;
	public static final int HEIGHT=800;
	public static final int PADDING=30;
	private void makeWordCloudView(StringProcessor strProc) {
		JFrame f=new JFrame("WordCloudView");
		f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		f.setLocationByPlatform(true);
		f.pack();
		Insets inset=f.getInsets();//���� ����
		Dimension dim=calcScreenSize(inset);//��,����, �е� ������ ��ü ��ȯ
		f.setSize(dim);
		
		CloudImageGenerator gen=new CloudImageGenerator(WIDTH,HEIGHT,PADDING);
							//w:1200, h:800, padding:30
		BufferedImage bufImg=gen.generateImage(strProc, 1);
		CloudViewer panel=new CloudViewer(bufImg);//JPanel
		f.setContentPane(panel);
		f.setVisible(true);
		
	}
	
	 private static Dimension calcScreenSize(Insets insets) {
	        int width = insets.left + insets.right + WIDTH + PADDING * 2;
	        int height = insets.top + insets.bottom + HEIGHT + PADDING * 2;
	        return new Dimension(width, height);
	  }

}



