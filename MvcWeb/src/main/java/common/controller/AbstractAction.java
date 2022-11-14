package common.controller;

public abstract class AbstractAction implements Action{
	//execute()추상 메서드 가지고 있음
	private String viewPage;//보여줄 뷰페이지 이름
	private boolean isRedirect;
	//redirect방식의 이동이면 true, forward방식 이동이면 false값을 갖는다
	public String getViewPage() {
		return viewPage;
	}
	//setter,getter 구성
	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
	
	
}
