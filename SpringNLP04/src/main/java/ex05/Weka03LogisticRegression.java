package ex05;

import java.util.Random;

import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.functions.Logistic;
import weka.core.Instances;
import weka.core.SerializationHelper;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Normalize;

public class Weka03LogisticRegression {
	
	String path="C:\\Weka-3-9\\data\\UniversalBank_preprocess.arff";
	String path2="C:\\Weka-3-9\\data\\UniversalBank_realData.arff";
	Instances data, train, test;
	Logistic model;
	
	public void loadArff(String file) throws Exception {
		DataSource ds=new DataSource(file);
		data=ds.getDataSet();
		//정규화
		Normalize normalize=new Normalize();
		normalize.setInputFormat(data);
		//정규화 필터를 data에 적용시킨다
		Instances newData=Filter.useFilter(data, normalize);
		//newData를 학습데이터와 테스트 데이터로 분리
		train=newData.trainCV(10, 0, new Random(1));
		test=newData.testCV(10, 0);
		train.setClassIndex(train.numAttributes()-1);
		test.setClassIndex(test.numAttributes()-1);
		
	}
	
	public void generateModel_Evaluate() throws Exception{
		Evaluation eval=new Evaluation(train);
		model=new Logistic();
		eval.crossValidateModel(model, train, 10, new Random(1));
		model.buildClassifier(train);//학습 진행
		eval.evaluateModel(model, test);
		
		
		System.out.println("전체 데이터 건수: "+(int)eval.numInstances()+"개");
		System.out.println("정 분류 건수: "+(int)eval.correct()+"개");
		double percent=(eval.correct()/eval.numInstances()*100);
		System.out.println("정분류율 : "+percent+"%");
		
		saveModel("C:\\Weka-3-9\\data\\UniveralBank.model");
	}
	public void testPredict(String file) {
		Classifier model2=this.loadModel("C:\\Weka-3-9\\data\\UniveralBank.model");
		try {
			Instances testData=new DataSource(file).getDataSet();
			testData.setClassIndex(testData.numAttributes()-1);
			System.out.println("실제 데이터 수: "+testData.numInstances()+"개");
			//실제 데이터로 예측할 때도 정규화 필터를 적용해야 한다 
			Normalize norm=new Normalize();//정규화
			norm.setInputFormat(testData);
			Instances newData=Filter.useFilter(testData, norm);
			
			Logistic lmodel=null;
			if(model2 instanceof Logistic) {
				lmodel=(Logistic)model2;
				//복원한 모델을 Logistic으로 형변환
			}
			for(int i=0;i<newData.numInstances();i++) {
				System.out.println("---"+i+"번째 데이터-------------");
				double pred=lmodel.classifyInstance(newData.instance(i));
				System.out.println("pred: "+pred);
				int k=(int)newData.instance(i).classValue();
				System.out.println("실제 데이터 값: "+newData.classAttribute().value(k));
				System.out.println("예측한 데이터 값: "+newData.classAttribute().value((int)pred));
				
				double[] prob=lmodel.distributionForInstance(newData.instance(i));
				System.out.println("확률 분포 -----");
				System.out.println("No: prob[0]="+prob[0]);
				System.out.println("Yes: prob[1]="+prob[1]);
			}//for-----------------------
		} catch (Exception e) {
			e.printStackTrace();
		}
	}//---------------------------------------
	
	public void saveModel(String path) {
		try {
			SerializationHelper.write(path, model);
			System.out.println(path+"에 Logistic모델 저장 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}//------------------------------------
	public Classifier loadModel(String path) {
		try {
			Classifier model2=(Classifier)SerializationHelper.read(path);
			return model2;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}		
	}//------------------------------
	public static void main(String[] args) throws Exception{
		Weka03LogisticRegression app=new Weka03LogisticRegression();
		app.loadArff(app.path);
		app.generateModel_Evaluate();
		app.testPredict(app.path2);
	}

	

}
