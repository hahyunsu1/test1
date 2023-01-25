<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
    integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
  <title>Document</title>
</head>

<style>
  /*  폰트 적용 */
  @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
  @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@800&display=swap');

  html {
    font-family: "Noto Sans KR", sans-serif;
  }

  /* 노말라이즈 */
  body,
  ul,
  li,
  h1 {
    margin: 0;
    padding: 0;
    list-style: none;
  }

  a {
    color: inherit;
    text-decoration: none;
  }

  /* 라이브러리 */
  .con {
    margin: 0 auto;
  }

  .img-box>img {
    width: 100%;
    display: block;
  }

  .row::after {
    content: "";
    display: block;
    clear: both;
  }

  .cell {
    float: left;
    box-sizing: border-box;
  }

  .cell-right {
    float: right;
    box-sizing: border-box;
  }

  .margin-0-auto {
    margin: 0 auto;
  }

  .block {
    display: block;
  }

  .inline-block {
    display: inline-block;
  }

  .text-align-center {
    text-align: center;
  }

  .line-height-0-ch-only {
    line-height: 0;
  }

  .line-height-0-ch-only>* {
    line-height: normal;
  }

  .relative {
    position: relative;
  }

  .absolute-left {
    position: absolute;
    left: 0;
  }

  .absolute-right {
    position: absolute;
    right: 0;
  }

  .absolute-middle {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
  }

  .width-100p {
    width: 100%;
  }

  .table {
    display: table;
  }

  .table-cell {
    display: table-cell;
  }

  .vertical-align-top {
    vertical-align: top;
  }

  .vertical-align-middle {
    vertical-align: middle;
  }

  .vertical-align-bottom {
    vertical-align: bottom;
  }

  /* 커스텀 */

  .con {
    width: 1180px;
  }

  .con-min-width {
    min-width: 1180px;
  }

  .navbar {
    display: flex;
    justify-content: space-between;
    position: relative;
  }




  header {
    background: -webkit-linear-gradient(rgba(255, 255, 255, 1) 50px, rgba(255, 255, 255, 0.2) 50px);
    transition: 0.4s ease-in;
    height: 50px;

  }


  nav {
    width: 1200px;
    height : 50px;
    margin: 0 auto;
    font-size: 17px;
  }

  nav>ul>li {
    float: left;
    line-height: 50px;
    margin-right: 40px;
    position: relative;
    font-weight: bold;
  }

  nav>ul>li ul {
    width: 1400%;
    opacity: 0;
    position: absolute;
    transition: 0.3s 0.2s;
  }

  nav>ul>li ul li {
    white-space: nowrap;
  }

  nav>ul>li:hover ul {
    opacity: 1;
  }

  /* 로고  */
  .container {
    font-family: 'Dosis', sans-serif;
    font-weight: 300;
    height: 100vh;
    color: #111;
    margin-top: 7px;
    text-shadow: 2px 2px grey;
  }

  .logo {
    font-size: 20px;
  }

  .mark {
    border-bottom: 4px solid #111;
    width: 2rem;
    position: absolute;
    top: 1rem;
    left: 0.25rem;
    transform: translate3d(0, 0, 0);
    animation: mark-anim 8s infinite cubic-bezier(0.55, 0, 0.1, 1);
  }

  .r,
  .e1,
  .s1,
  .s2,
  .e2 {
    will-change: margin-left, margin-right;
  }

  .r {
    margin-left: 0.25rem;
    margin-right: 0.25rem;
    animation: r-anim 10s infinite cubic-bezier(0.55, 0, 0.1, 1);
  }

  .e1 {
    margin-left: 0.5rem;
    margin-right: 0.5rem;
    animation: e1-anim 10s infinite cubic-bezier(0.55, 0, 0.1, 1);
  }

  .s1 {
    margin-left: 1rem;
    margin-right: 1rem;
    animation: s1-anim 10s infinite cubic-bezier(0.55, 0, 0.1, 1);
  }

  .s2 {
    margin-left: 1rem;
    margin-right: 1rem;
    animation: s2-anim 10s infinite cubic-bezier(0.55, 0, 0.1, 1);
  }

  .e2 {
    margin-left: 2rem;
    margin-right: 3rem;
    animation: e2-anim 10s infinite cubic-bezier(0.55, 0, 0.1, 1);
  }


  @keyframes mark-anim {

    0%,
    25%,
    100% {
      left: 1.5%;
    }

    50%,
    75% {
      left: 92%;
    }
  }


  @keyframes r-anim {

    0%,
    25%,
    100% {
      margin-left: 0.25rem;
      margin-right: 0.25rem;
    }

    50%,
    75% {
      margin-left: 3rem;
      margin-right: 2rem;
    }
  }

  @keyframes e1-anim {

    0%,
    25%,
    100% {
      margin-left: 0.5rem;
      margin-right: 0.5rem;
    }

    50%,
    75% {
      margin-left: 1rem;
      margin-right: 1rem;
    }
  }

  @keyframes s1-anim {

    0%,
    25%,
    100% {
      margin-left: 1rem;
      margin-right: 1rem;
    }

    50%,
    75% {
      margin-left: 1rem;
      margin-right: 1rem;
    }
  }

  @keyframes s2-anim {

    0%,
    25%,
    100% {
      margin-left: 1rem;
      margin-right: 2rem;
    }

    50%,
    75% {
      margin-left: 0.5rem;
      margin-right: 0.5rem;
    }
  }

  @keyframes e2-anim {

    0%,
    25%,
    100% {
      margin-left: 2rem;
      margin-right: 3rem;
    }

    50%,
    75% {
      margin-left: 0.25rem;
      margin-right: 0.25rem;
    }
  }

  .login {
    float: left;
    line-height: 50px;
    margin-right: 40px;
    position: relative;
    font-weight: bold;
  }

  /* 로그인 모달 */
  .modal {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: none;
    background-color: rgba(0, 0, 0, 0.4);
    z-index: 1;
  }

  .modal_body {
    margin: 0 auto;
    position: absolute;
    top: 30px;
    left: 50%;
    transform: translate(-50%, 0%);
    z-index: 1;

  }

  * {
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
  }


  .login-form {
    width: 300px;
    background-color: #EEEFF1;
    margin-right: auto;
    margin-left: auto;
    margin-top: 50px;
    padding: 20px;
    text-align: center;
    border: none;

  }

  .text-field {
    font-size: 14px;
    padding: 10px;
    border: none;
    width: 260px;
    margin-bottom: 10px;

  }
/*-- 
  .submit{
    
  } --*/
  .submit-btn {
    font-size: 14px;
    border: none;
    padding: 10px;
    width: 260px;
    background-color: #1BBC9B;
    margin-bottom: 10px;
    color: white;
  }

  .links {
    text-align: center;
  }

  .links a {
    font-size: 12px;
    color: #9B9B9B;
  }

  .header>li:hover {
    color: green;
    font-weight: bold;
  }

  .login:hover {
    color: green;
  }
</style>

<body>


  <header>
    <nav class="navbar">


      <div class="container flex flex-center">
        <div class="logo center mx-auto relative">
          <a href="/web/index">
            <div class="mark"></div>
            <span class="p">D</span>
            <!-- 
            --><span class="r">O</span>
            <!-- 
            --><span class="e1">L</span>
            <!-- 
            --><span class="s1">B</span>
            <!-- 
            --><span class="s2">O</span>
            <!-- 
            --><span class="e2">M</span>
            <!-- 
            --><span class="d">!</span>
          </a>
        </div>
      </div>

      <ul class="clearfix header">
        <li><a href="<c:url value ='/admin/main'/>">메인페이지</a> </li>
        <li><a href="<c:url value='/admin/userList'/>"> 회원 관리</a> </li>
        <li><a href="<c:url value='/admin/admin_boardList'/>"> 게시판 관리</a> </li>
        <li><a href="<c:url value='/admin/admin_dataTotal'/>"> 일별 데이터 조회</a> </li>
      </ul>


    </nav>

  </header>

</body>

</html>