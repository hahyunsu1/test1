<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String myctx=request.getContextPath();
    %>
</article>
        <aside>
            <nav>
                <ul>
                    <li><a href="<%=myctx%>/example/ex06.jsp">성적계산</a></li>
                    <li><a href="<%=myctx%>/login/sessionTest.jsp">Session</a></li>
                    <li><a href="<%=myctx%>/login/cookieTest.jsp">Cookie</a></li>
                    <li><a href="<%=myctx%>/login/myPage.jsp">MyPage</a></li>
                </ul>
            </nav>
        </aside>
        <div class="clear"></div>
        
        <footer>
            &copyCopyrigh/회사소개
        </footer>
    </div>
    <!--  div#wrap. container end -->
</body>
</html>