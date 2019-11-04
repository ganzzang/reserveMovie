package com.cinema.web.common.bean;

public class PagingBean {

	/** 한페이지당 보여줄 레코드 갯수 (즉 글의 갯수) */
	public final int COUNT_PER_RECORD = 2; 
	
	/** 한 화면에 보여질 페이지의 갯수 **/
	public final int COUNT_PER_PAGE = 3;

	/** 전체 레코드의 갯수 */
	private int totalRecordCount = 0;
	
	/** 전체 페이지의 갯수 **/
	private int totalPageCount = 0;
	/** 현재 보여주는 페이지(현재 요청 페이지) */
	private int pageNo = 1;
	/** DB로우 시작 인덱스 */
	private int startRow;
	/** DB로우 종료 인덱스 */
	private int endRow;
	/////////////////////////////////////////////////////////
	
	/** 전체 페이지의 그룹갯수 */
	private int totalGroupCount;
	/** 현재 페이지의 그룹번호 (그룹번호는 1부터 시작) */
	private int groupNo;
	/**시작 페이지 번호 */
	private int pageStartNo;
	/** 끝 페이지 번호 */
	private int pageEndNo;
	
	
	private String keywordType;
	private String keyword;
	
	
	/** 페이징 계산을 시작한다. 
	 * @param totalRecordCount 전체 레코드의 갯수
	 * **/
	public void calcPage(int totalRecordCount) {
		//페이지 디폴트값은 무조건 1 이다.
		this.pageNo = pageNo <= 0 ? 1 : pageNo;
		
		this.totalRecordCount = totalRecordCount;
		
		//전체 페이지 갯수
		totalPageCount = calcTotalPageCount(totalRecordCount, COUNT_PER_RECORD);
		
		//DB에서 가져올 시작행의 번호
		startRow = ((pageNo - 1) * COUNT_PER_RECORD) + 1;
		
		//DB에서 가져올 끝행 번호
		endRow =  pageNo * COUNT_PER_RECORD;
		
		///////////////////////////////////////////////////////////
		
		//전체 페이징 그룹 갯수
		totalGroupCount = calcTotalPageCount(totalPageCount, COUNT_PER_PAGE );
		//현재 페이지의 소속 그룹번호
		groupNo = calcTotalPageCount(pageNo, COUNT_PER_PAGE);
		//시작, 끝 페이지번호 구하기
		pageStartNo = ((groupNo - 1) * COUNT_PER_PAGE) + 1;
		pageEndNo = groupNo * COUNT_PER_PAGE;
				
		//마지막 페이지 번호보다 같거나 크다면 더이상의 페이지가 없는것이기 
		//때문에 전체 페이지 갯수를 대입해준다.
		if(pageEndNo >= totalPageCount) {
			pageEndNo = totalPageCount;
		}
		
	}
	
	/** 전체 페이지의 갯수를 계산한다. **/
	public int calcTotalPageCount(int totalRecordCount, int countPerRecord) {
		int totalPageCount = 0;
		if(totalRecordCount > 0){
			totalPageCount = totalRecordCount / countPerRecord;
			if( (totalRecordCount % countPerRecord) > 0 ){
				totalPageCount ++;
			}
		}
		return totalPageCount;
	}

	
	
	public String getKeywordType() {
		return keywordType;
	}
	public void setKeywordType(String keywordType) {
		this.keywordType = keywordType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getTotalRecordCount() {
		return totalRecordCount;
	}
	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}
	public int getTotalPageCount() {
		return totalPageCount;
	}
	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public int getTotalGroupCount() {
		return totalGroupCount;
	}
	public void setTotalGroupCount(int totalGroupCount) {
		this.totalGroupCount = totalGroupCount;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	public int getPageStartNo() {
		return pageStartNo;
	}
	public void setPageStartNo(int pageStartNo) {
		this.pageStartNo = pageStartNo;
	}
	public int getPageEndNo() {
		return pageEndNo;
	}
	public void setPageEndNo(int pageEndNo) {
		this.pageEndNo = pageEndNo;
	}
	
}