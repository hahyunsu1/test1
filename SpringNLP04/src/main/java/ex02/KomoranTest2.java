package ex02;

import java.util.List;

import common.KomoranUtil;
import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import kr.co.shineware.nlp.komoran.model.Token;
import lombok.extern.log4j.Log4j;
//https://docs.komoran.kr/firststep/postypes.html
@Log4j
public class KomoranTest2 {
	
	static Komoran nlp=new Komoran(DEFAULT_MODEL.LIGHT);

	public static void main(String[] args) {
		String str="���� �νð� Ǫ���� ���� �ڡ� �׸��� ����� �׸��� ����. ���� ���� ��, ���� �� �ڸ� �ʷ��� ���� ��ǳ ��µ�";
		str+="���� ������ ���� �ϸ��� ���� �� ���� ���� �ϸ��� ���� �װ� �װ� ��ٸ�!�ڡڡ� �װ� �װ� ���� ��ٸ�? ";
		str+="���� �νð� Ǫ���� ���� �׸��� ����� �׸��� ���� -������ Ǫ���� �� Poem  12345";
		
		KomoranResult res=nlp.analyze(str);
		//getTokenList(): token���·� ����� ��µ�, �� ��ū���� ���¼Ұ� ���ڿ��� ��� ��ġ���� �����Ǵ���, ��������, ���¼� �м� ��� ���� ��ȯ�Ѵ�.
		List<Token> tkList=res.getTokenList();
		log.info("====1. getTokenList==================");
		for(Token tk:tkList) {
			//log.info(tk.toString());
			log.info(tk.getMorph()+"/"+tk.getPos()+"("+tk.getBeginIndex()+","+tk.getEndIndex()+")");
		}
		log.info("==2. getPlainText====================");
		String info=res.getPlainText();
		log.info(info);
		//pos tagging �� �پ��ִ� �ؽ�Ʈ ���·� ��ȯ
		
		log.info("==3. getMorphByTag=====================");
		List<String> arr=res.getMorphesByTags("NNG","NNP","NNB");//���鸸 �����Ѵ�.
		log.info(arr);
		
		log.info(res.getMorphesByTags("VV"));//���縸 ����

		
		

	}

}
