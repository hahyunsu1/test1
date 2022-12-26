package common.nlp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
//�󵵼� ������������ ������ �� �ֵ��� Comparable�� ������
@Data
@NoArgsConstructor
@AllArgsConstructor
public class WordCount implements Comparable<WordCount>{
	
	private String word;//�ܾ�
	private int cnt;//�󵵼�
	
	@Override
	public int compareTo(WordCount o) {

		//return this.cnt-o.cnt;//��������
		return o.cnt-this.cnt;//��������
	}

}
