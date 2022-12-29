package ex07;

import weka.classifiers.functions.LinearRegression;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;

public class weka04LinearRegression {
	DataSource ds;
	Instances data;
	LinearRegression model;
	public void loadArff(String file) throws Exception{
		ds=new DataSource(file);
		data=ds.getDataSet();
		//종속변수(y)-target
		data.setClassIndex(data.numAttributes()-1);
	}
	public void generateModel() throws Exception{
		model=new LinearRegression();
		model.buildClassifier(data);
		System.out.println("model 공식: "+model);
	}
	public void predictHouse() throws Exception{
		//데이터셋의 첫번째 집이 시세를 모델을 통해 예측해보자.
		//Instance myHouse =data.firstInstance();
		//Instance myHouse =data.lastInstance();//마지막집
		//Instance myHouse =data.instance(3);
		Instance myHouse =data.instance(data.numInstances()-2);
		double price=model.classifyInstance(myHouse);//4번째집
		
		System.out.println("----------------------------------------------");
		System.out.println(myHouse+"의 예측 판매 가격: "+price);
		System.out.println("----------------------------------------------");
	}
	public double predictOne(double houseSize,double lotSize,int bedrooms, int bathroom) {
		double sellPrice=-26.6882 * houseSize + 7.0551 * lotSize + 43166.0767 * bedrooms + 42292.0901 * bathroom + -21661.1208;
		return sellPrice;
	}
	
	public static void main(String[] args) throws Exception{
		weka04LinearRegression app=new weka04LinearRegression();
		app.loadArff("C:\\Weka-3-9\\data\\house\\house.arff");
		app.generateModel();
		app.predictHouse();
		double price=app.predictOne(5120, 10000, 7, 2);
		System.out.println("House price: "+price);
	}
}
