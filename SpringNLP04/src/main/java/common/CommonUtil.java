package common;

import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.stereotype.Component;

@Component
public class CommonUtil {

	// null���� ���ڿ��� ġȯ
	public static String nvl(String str, String chg_str) {
		String res = "";
		if (str == null) {
			res = chg_str;
		} else if (str.equals("")) {
			res = chg_str;
		} else {
			res = str;
		}
		return res;
	}// ----------------------------------------

	public static String nvl(String str) {
		return nvl(str, "");
	}// ----------------------------------------

	// ���ĺ��� ������ �����ϰ� ��� �����ϴ� �޼���
	public static String remainAlphaSpace(String str) {
		if (str != null)
//				String replace_text = text.replaceAll("[^��-�Ra-zA-Z0-9]", " ");
			str = str.replaceAll("[^a-zA-Z ]", " ");
		return str;
	}// ----------------------------------------
		// �ѱ�,���ĺ�, ���ڰ� �ƴ� ���ڴ� ��������� ġȯ�Ѵ�

	public static String remainKorAlpha(String str) {
		if (str != null)
			str = str.replaceAll("[^��-�Ra-zA-Z0-9]", " ");
		return str;
	}// ----------------------------------------
		// �ѱ۰� ������ �ƴ� ���ڴ� ���ڷ� ġȯ

	public static String remainKorSpace(String str) {
		if (str != null)
			str = str.replaceAll("[^��-����-�Ӱ�-�R ]", " ");
		return str;
	}// ----------------------------------------

	// ���鹮�ڰ� ������ ���� ��� ���ڿ��� ��ġ
	public static String spaceToEmpty(String str) {
		if (str != null)
			str = str.replaceAll("\\s+", " ");
		return str;
	}// ----------------------------------------

	public Map<String, Long> getFrequency(String str) {
		// String [] tks=str.toLowerCase().split("[\\.\\s]+");
		// System.out.println(Arrays.toString(tks));
		Stream<String> stream = Stream.of(str.toLowerCase().split("[\\.\\s,']+")).parallel();

		Map<String, Long> wordCountMap = stream.collect(Collectors.groupingBy(String::toString, Collectors.counting()));

		return wordCountMap;
	}

}
