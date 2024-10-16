package com.bloomall.util;

import java.util.List;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int displayPageNum = 5;
	
	private Criteria cri;

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	private void calcData() {
		endPage = (int)(Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		
		startPage = (endPage - displayPageNum) + 1;
		
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	
	public String makeQuery(int page) {
		
		UriComponents uric
			= UriComponentsBuilder.newInstance()
								  .queryParam("page", page)
								  .queryParam("perPageNum", cri.getPerPageNum())
								  .build();
		
		return uric.toUriString();		
	}
	
//	public String makeQuery(int page
//							, String all, String prime_ctgr_cd
//							) {
//		
//		UriComponents uric
//			= UriComponentsBuilder.newInstance()
//								  .queryParam("page", page)
//								  .queryParam("ctgr_cd", "all")
//								  .queryParam("prime_ctgr_cd", prime_ctgr_cd)
//								  .queryParam("perPageNum", cri.getPerPageNum())
//								  .build();
//		
//		return uric.toUriString();		
//	}
	
	public String makeSearch(int page) {
		
		UriComponents uric
			= UriComponentsBuilder.newInstance()
								  .queryParam("page", page)
								  .queryParam("perPageNum", cri.getPerPageNum())
								  .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
								  .queryParam("keyword", ((SearchCriteria)cri).getKeyword())
								  .build();
		
		return uric.toUriString();
	}
	
	public String makeSearch(int page, List<String> stateList) {

//		System.out.println(stateList);
	
		UriComponents uric = null;
		String state = "";
	   
//	    if(((SearchCriteria)cri).getSearchType().equals("state")) {
		
		   
		
//		if(stateList.get(0).equals("noSel") && stateList.size() == 1) {
//			   // searchType이 [주문처리상태]가 아닐때
//			   state = "";
//		
		   if(stateList.get(0).equals("noSel")) {
			   // searchType이 [주문처리상태]가 아닐때
			   state = "";
//			   System.out.println("1");
		   
		   }else {
			  // searchType이 [주문처리상태]일 때
			   for(int i=0; i < stateList.size(); i++) {
				   state += stateList.get(i) + ",";
			   }
//			   System.out.println("2");
			   
			   state = state.substring(0, state.lastIndexOf(","));
		   }
		   
		   uric	= UriComponentsBuilder.newInstance()
					  .queryParam("page", page)
					  .queryParam("perPageNum", cri.getPerPageNum())
					  .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
					  .queryParam("keyword", ((SearchCriteria)cri).getKeyword())
					  .queryParam("state", state)
					  .build();
	   
//	    }else {
//		   
//	   
//	
//		   uric	= UriComponentsBuilder.newInstance()
//								  .queryParam("page", page)
//								  .queryParam("perPageNum", cri.getPerPageNum())
//								  .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
//								  .queryParam("keyword", ((SearchCriteria)cri).getKeyword())
//								  .queryParam("state", state)
//								  .build();
//	   }
		
		return uric.toUriString();
	}

	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", cri=" + cri + "]";
	}
}








