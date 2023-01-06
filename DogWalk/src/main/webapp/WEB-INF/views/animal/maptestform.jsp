<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<li>
    <div>
        <h2>찾아 오시는 길</h2>
        
        <div id="map_box">
            <div id="map"></div>
            
            <div id="position_box">
                <button class="storePosition" ><i class="far fa-dot-circle"></i> 가게 위치로</button>
                <button class="userPosition"> <i class="far fa-dot-circle"></i> 내 위치로</button>
            </div>
        </div>
        
        <h2>위치안내</h2>
        <div id="store_address" data-address="${info.storeAddress2 }">${info.storeAddress2 }  ${info.storeAddress3 }</div>
    </div>
</li>
 
<li>
    <div>
       <h2>가게 소개</h2>
       <div>${info.storeDes }</div>
   </div>
</li>
 
<li>
    <div>
        <h2>영업 정보</h2>
        
        <div class="info_detail_title">
            <div>상호명</div>
            <div>영업시간</div>
            <div>전화번호</div>
            
        </div>
        
        <div class="info_detail">
            <div>${info.storeName }</div>
            <div>
                <span><fm:formatNumber value="${info.openingTime }" minIntegerDigits="2" />시 ~</span>
                <span><fm:formatNumber value="${info.closingTime }" minIntegerDigits="2" />시 </span>
            </div>
            <div>${info.storePhone }</div>
            
        </div>
    </div>
</li>
 
<li>
    <div>
        <h2>가계 통계</h2>
        <div class="info_detail_title">
            <div>최근 주문수</div>
            <div>전체 리뷰 수</div>
            <div>찜</div>
        </div>
        
        <div class="info_detail">
            <%-- 
            <div>${info.orderCount }</div>
            <div>${info.reviewCount }</div>
            <div>${info.likesCount }</div> 
            --%>
        </div>
    </div>	
</li>