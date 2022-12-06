db
//myDB 데이터베이스 생성
use mydb
db
show dbs
//mydb에 collection을 생성해 보자
db.createCollection("employees",{capped:true,size:10000});
show collections
db.dropDatabase("emp");
db.employees.find()
db.employees.isCapped()
db.employees.stats()

db.employees.renameCollection("emp")

db.emp.drop()
//capped옵션 살펴보기-----------------
//컬렉션 생성
db.createCollection("cappedCollection",{capped:true,size:10000})
//capped:true => 최초 제한된 크기로 생성된 공간에서만 데이터를 저장하는 설정
//size:10000==>10000보다 크면서 가장 가까운 256배수로 maxsize가 설정된다=>10240

show collections

db.cappedCollection.find()
db.cappedCollection.stats()
//도큐먼트(row)를 size를 초과하도록 반복문 이용해서 넣어보자
for(i=0;i<1000;i++){
    db.cappedCollection.insertOne({x:i})
}
db.cappedCollection.find()
db.cappedCollection.find().count()
//처음 넣었던 데이터들이 사라진 것을 확인할 수 있다.
db.cappedCollection.isCapped()
//====================================================================
//CRUD
/*[1] Create :
        -insertOne({}): 한 개의 document 생성
        -insertMany([]): 여러 개의 document생성
        db.emp.insertOne({<----collection(table)
            id:'a001',    <----field----+ (column)
            name:'James', <----field----+----document (record)
            dept:'Sales'  <----field----+
        })
*/
use mydb
db
db.createCollection('member')
show collections
db.member.find()
db.getCollection('member').find()
db.member.insertOne({
    name:'김민중',
    userid:'min',
    tel:'010-7878-8888',
    age:20
})
db.member.find()
/*
_id 필드가 자동으로 생성된다.document의 유일성을 보장하는 키
    전체 : 12bytes
          4bytes: 현재 timestamp => 문서생성시전
          3bytes: machine id
          2byte : 몽고디비 프로세스 id
          3byte : 일련번호
*/
db.member.insertOne({
    _id:1,//비권장
    name:'홍길동',
    userid:'hong',
    tel:'010-4545-4444',
    age:22
})
db.member.find()
//document를 bson으로 변환하여 몽고디비에 저장
//_id : 자동으로index가 생성된다.==>검색을 빠르게 할 수 있다. 중복저장 불가

db.member.insertMany([
    {name:'이민수',userid:'Lee',age:22},
    {name:'최민자',userid:'Choi',tel:'011-9999-8888',age:25 },
    {name:'유재석', userid:'You', tel:'011-5999-5888', age:21}
])
db.dropDatabase("emp");
db.getCollection("member").find()

db.member.insertOne({name:'표진우',userid:'Pyo',passwd:'123',grade:'A'})

db.user.insertMany([
    {_id:1,name:'김철',userid:'Kim1',passwd:'1111'},
    {_id:2,name:'최철',userid:'choi1',passwd:'2111'}
])
db.user.find();
db.user.insertMany([
    {_id:3,name:'김철',userid:'Kim1',passwd:'1111'},
    {_id:2,name:'최철',userid:'choi1',passwd:'2111'},
    {_id:4,name:'최철',userid:'choi1',passwd:'2111'}
],{ordered:false});

//ordered옵션의 기본값 true, 순서대로 insert할지 여부를 지정.
//false를 주면 순서대로 입력하지 않음

/*
[실습1]---------------------------------------------------------------------
1. boardDB생성
2. board 컬렉션 생성
3. board 컬렉션에 name 필드값으로 "자유게시판"을 넣어본다
4. article 컬렉션을 만들어 document들을 삽입하되,
   bid필드에 3에서 만든 board컬렉션 자유게시판의 _id값이 참조되도록 처리해보자.

5. 똑 같은 방법으로 "공지사항게시판"을 만들고 그 안에 공지사항 글을 작성하자.
--------------------------------------------------------------------------
*/
use boardDB
db
db.board.drop()
db.article.drop()
db.createCollection("board")
freeboard_res=db.board.insertOne({name:'자유게시판'})
//freedoard_res에는 자유게시판 도큐먼트의 _id값이 담긴다
freeboard_id=freeboard_res.insertedId

db.article.insertMany([
    {bid:freeboard_id,title:'자유게시판 첫번째 글',content:'안녕하세요?',writer:'kim'},
    {bid:freeboard_id,title:'자유게시판 두번째 글',content:'반가워요',writer:'choi'},
    {bid:freeboard_id,title:'자유게시판 세번째 글',content:'Hello',writer:'lee'}
])
db.article.find()

noticeboard_res=db.board.insertOne({name:'공지게시판'})
noticeboard_id=noticeboard_res.insertedId

db.article.insertMany([
    {bid:noticeboard_id,title:'공지게시판 첫번째 글',content:'가입 환영합니다!',writer:'moon'},
    {bid:noticeboard_id,title:'공지게시판 두번째 글',content:'모두 규칙을 지켜주세요',writer:'moon'},
    {bid:noticeboard_id,title:'공지게시판 세번째 글',content:'즐겁게 활동합니다',writer:'moon'}
])


/* R:read 조회
    - findOne() : 매칭되는 1 개의 document를 조회
    - find() : 매칭디는 document list 조회
    find({조건들},{필드들})

*/
use mydb
db.member.find({})
//select * from member
arr=db.member.find().toArray()
//모든 문서를 배열로 반환
arr[0]
arr[1]
db.member.find()
//member에서 name,tel만 조회하고 싶다면
db.member.find({},{name:true,tel:true,_id:false})
//select name, tel from member

db.member.find({},{name:1,tel:1,_id:0})
//위 문장과 동일함 true=>1로, false:0으로 호환가능

//select * from member where age=20
db.member.find({age:20},{})

//select name,userid,age from member where age=22
db.member.find({age:22},{name:1,userid:1,age:1,_id:0})

//userid 가 'You'이고 age:21인 회원정보를 가져와 출력하세요
db.member.find({userid:'You',age:21},{})

//age가 20 이거나 userid가 'You'인 회원정보를 보여주세요
db.member.find({$or:[{age:20},{userid:'You'}]},{})
//select * from member where age=20 or userid=You'


//논리연산
//$or : 배열 안 두 개 이상의 조건 중 하나라도 참인 경우를 반환
//$and : 배열 안 두 개 이상의 조건 이 모두 참인 경우를 반환
//$nor :$or의 반대:배열 안 두 개 이상의 조건이 모두 아닌 경우를 반환함

//<1> userid가 'Choi'인 회원의 name,userid,tel 만 가져오기
db.member.find({userid:'Choi'},{name:1,userid:1,tel:1})
//<2> age가 21세 이거나 userid가 'Lee'인 회원정보 가져오기
db.member.find({$or:[{age:21},{userid:'Lee'}]},{})
//<3> 이름이 이민수 이면서 나이가 22세인 회원정보 가져오기
db.member.find({$and:[{name:'이민수'},{age:22}]},{})
db.member.find()

/*
[실습2]
1. emp Collection 생성 {capped:true, size:100000} Capped Collection, size는 100000 으로 생성
2. scott계정의 emp레코드를 mydb의 emp Document 데이터로 넣기 
  => insertOne()으로 3개 문서 삽입, 
     insertMany로 나머지 문서 삽입해보기
*/
db.emp.drop()
use mydb

db.createCollection("emp",{capped: true,size:100000})
db.createCollection("emp",{capped: true,size:100000})

db.emp.insertOne({
    empno:7396,ename:"SMITH",job:"CLERK",mgr:7902,hiredate:"80/12/17",sal:800,deptno:20
})
db.emp.insertOne({
    empno:7499,ename:"ALLEN",job:"SALESMAN",mgr:7698,hiredate:"81/02/20",sal:1600,comm:300,deptno:10
})
db.emp.insertOne({
    empno:7521,ename:"WARD",job:"SALESMAN",mgr:7698,hiredate:"81/02/22",sal:1250,comm:500,deptno:30
})
db.emp.insertMany([
    {empno:7566,ename:"JONES",job:"MANAGER",mgr:7839,hiredate:"81/04/02",sal:2975,deptno:20},
    {empno:7654,ename:"MARTIN",job:"SALESMAN",mgr:7698,hiredate:"81/09/28",sal:1250,comm:1400,deptno:30},
    {empno:7698,ename:"BLAKE",job:"MANAGER",mgr:7839,hiredate:"81/05/01",sal:2850,deptno:30},
    
    {empno:7782,ename:"CLARK",job:"MANAGER",mgr:7839,hiredate:"81/06/09",sal:2450,deptno:10},
    {empno:7788,ename:"SCOTT",job:"ANALYST",mgr:7566,hiredate:"82/12/09",sal:3000,deptno:20},
    {empno:7839,ename:"KING",job:"PRESIDENT",hiredate:"81/11/17",sal:5000,comm:0,deptno:10},
    {empno:7844,ename:"TURNER",job:"SALESMAN",mgr:7698,hiredate:"81/09/08",sal:1500,deptno:30},
    {empno:7876,ename:"ADAMS",job:"CLERK",mgr:7788,hiredate:"83/01/12",sal:1100,deptno:20},
    {empno:7900,ename:"JAMES",job:"CLERK",mgr:7698,hiredate:"81/12/03",sal:950,deptno:30},
    {empno:7902,ename:"FORD",job:"ANALYST",mgr:7566,hiredate:"81/12/03",sal:3000,deptno:20},
    {empno:7934,ename:"MILLER",job:"CLERK",mgr:7782,hiredate:"82/01/23",sal:1300,deptno:10}
   
])
//////////////////////////////////////////////////////////////////////////////////
var empArr=[
        {
                "empno" : "7499",
                "ename" : "ALLEN",
                "job" : "SALESMAN",
                "mgr" : "7698",
                "hiredate" : "1981-02-20",
                "sal" : "1600.00",
                "comm" : "300.00",
                "deptno" : "30"
        },
        {
                "empno" : "7521",
                "ename" : "WARD",
                "job" : "SALESMAN",
                "mgr" : "7698",
                "hiredate" : "1981-02-22",
                "sal" : "1250.00",
                "comm" : "500.00",
                "deptno" : "30"
        },
        {
                "empno" : "7654",
                "ename" : "MARTIN",
                "job" : "SALESMAN",
                "mgr" : "7698",
                "hiredate" : "1981-09-28",
                "sal" : "1250.00",
                "comm" : "1400.00",
                "deptno" : "30"
        },
        {
                "empno" : "7844",
                "ename" : "TURNER",
                "job" : "SALESMAN",
                "mgr" : "7698",
                "hiredate" : "1981-09-08",
                "sal" : "1500.00",
                "comm" : "0.00",
                "deptno" : "30"
              },

{"empno":7369, "ename":"SMITH","job":"CLERK",mgr:7902,"hiredate" : "1980-12-17","sal":800.0, "comm" : "0.00","deptno":20},
{"empno":7566, "ename":"JONES","job":"MANAGER",mgr:7839,"hiredate" : "1981-04-02","sal":2975.0, "comm" : "0.00","deptno":20.0},
{"empno":7782,"ename":"CLARK","job":"MANAGER",mgr:7839,"hiredate" : "1981-09-08","sal":2450.0, "comm" : "0.00","deptno":10.0},
{"empno":7934,"ename":"MILLER","job":"CLERK",mgr:7782,"hiredate" : "1981-09-08","sal":1300.0, "comm" : "0.00","deptno":10.0},
{"empno":7788,"ename":"SCOTT","job":"ANALYST",mgr:7566,"hiredate" : "1982-12-09","sal":3000.0, "comm" : "0.00","deptno":10.0},
{"empno":7839,"ename":"KING","job":"PRESIDENT","hiredate" : "1981-11-17","sal":5000.0, "comm" : "0.00","deptno":10.0},
{"empno":7876,"ename":"ADAMS","job":"CLERK",mgr:7788,"hiredate" : "1983-01-12","sal":1100.0, "comm" : "0.00","deptno":20.0},
{"empno":7902,"ename":"FORD","job":"ANALYST",mgr:7566,"hiredate" : "1981-12-03","sal":3000.0, "comm" : "0.00","deptno":20.0},
{"empno":7934,"ename":"MILLER","job":"CLERK",mgr:7782,"hiredate" : "1982-01-23","sal":1300.0, "comm" : "0.00","deptno":10.0}
]
db.emp.insertMany(empArr)

var deptArr=[{
                "deptno" : "10",
                "dname" : "ACCOUNTING",
                "loc" : "NEW YORK"
        },
        {
                "deptno" : "20",
                "dname" : "RESEARCH",
                "loc" : "DALLAS"
        },
        {
                "deptno" : "30",
                "dname" : "SALES",
                "loc" : "CHICAGO"
        },
        {
                "deptno" : "40",
                "dname" : "OPERATIONS",
                "loc" : "BOSTON"
        }
  ]
db.dept.insertMany(deptArr)
db.emp.find()

db.emp.find({empno:7788},{ename:1,empno:1,job:1,_id:0})
//emp에서 사원의 이름과 급여를 가져와 보여주세요
db.emp.find({},{ename:1,sal:1})
//emp에서 job이 'SALESMAN'이거나 급여가 3000인 사원정보를 보여주세요
db.emp.find({$or:[{job:'SALESMAN'},{sal:3000}]},{})
db.emp.find({$nor:[{job:'SALESMAN'},{sal:3000}]},{})
/*
$eq:    =
$gt     >    
$gte    >=   
$in          목록 중의 어느 하나라도 있는지 여부를 체크
$lt     <    
$lte    <=   
$ne     !=   not equal
$nin         $in의 반대. not in

*/
//member에서 age가 20세를 초과하는 회원의 이름,나이를 출력하세요
db.member.find({age:{$gt:20}},{name:1,age:1})

//emp에서 급여가 3000이상인 사원의 사변,이름,업무,급여를 출력하세요
db.emp.find({sal:{$gt:3000}},{empno:1,ename:1,job:1,sal:1})
//emp에서 급여가 1300~2600사이의 사원의 이름,업무,급여 부서번호를 출력하세요
db.emp.find({$and:[{sal:{$gte:1300}},{sal:{$lte:2600}}]},{ename:1,job:1,sal:1,deptno:1})

//emp에서 담당 업무가 'MANAGER'인 사원의 사번,이름,업무를 보여주세요
db.emp.find({job:'MANAGER'},{empno:1,ename:1,job:1})
//emp에서 사원번호가 7369,7654,7934인 사원의 사원번호,이름,업무,급여를 출력하세요.
db.emp.find({empno:{$in:[7369,"7654",7934]}},{empno:1,ename:1,job:1,sal:1})
db.emp.find()
//20번 부서인 사원의 이름,업무,부서번호를 출력하세요
db.emp.find({deptno:20},{empno:1,ename:1,job:1})
//부서번호가 20번이 아닌 사원의 모든 정보를 출력하세요
db.emp.find({deptno:{$nin:[20]}})
//업무가 CLERK이거나 ANALYST인 사원의 모든 정보를 출력하세요
db.emp.find({job:{$in:["CLERK","ANALYST"]}})
//업무가 CLERK 또는 ANALYST가 아닌 사원의 모든 정보를 출력하세요
db.emp.find({job:{$nin:["CLERK","ANALYST"]}})
db.emp.find({},{})


//sql문의 like절==> 정규식을 이용해보자
//ename에 KING인 사원의 모든 정보를 출력하세요
db.emp.find({ename:{$regex:/KING/}})
//select * from emp where like'%S'
db.emp.find({ename:/^S/})
//select * from emp where like'S%'
db.emp.find({ename:/S$/})
//select * from emp where like'%S%'
db.emp.find({ename:/S/})
//member 의 userid 중 'o'자가 들어가는 회원정보 출력하세요
db.member.find({userid:/o/})

//order by절
db.member.find().sort({age:-1})//1:asc(오름차순),-1:desc(내림차순)

/*
<1>member에서 회원의 나이를 내림차순으로 정렬하고, 
  같은 나이일 때는 이름 가나다순으로 정렬해서 출력하세요*/
  db.member.find().sort({age:-1,name:1})
/*<2> emp에서 부서번호로 정렬한 후 부서번호가 같을 경우
	급여가 많은 순으로 정렬하여 사번,이름,부서번호,급여를 출력하세요*/
db.emp.find({},{empno:1,ename:1,deptno:1,sal:1}).sort({deptno:1,sal:-1})
/*<3> emp에서 부서번호가 10,20인 사원의 이름,부서번호,업무를 출력하되
    이름 순으로 정렬하시오*/
db.emp.find({deptno:{$in:[10,20]}},{ename:1,deptno:1,job:1}).sort({ename:1})

//전체 사원수를 보여주세요
db.emp.find().count()
db.member.find()

//member에서 연락처를 가지고 있는 회원정보를 보여주세요
db.member.find({tel:{$exists:1}})
db.member.find({tel:{$exists:1}}).count()
//select count(tel) from member

db.member.find({tel:{$exists:0}})
//select *from member where tel is null

//member에서 나이가 23세 이상인 회원이 몇명인지 보여주세요
db.member.find({age:{$gte:23}}).count()

//distinct
db.emp.distinct("deptno").length
//select distinct(deptno) from emp
//emp의 업무 종류를 출력하세요
db.emp.distinct("job").length
/*<1> employees에서 30번 부서의 사원수를 출력하시오.*/
db.emp.find({deptno:'30'}).count()

/*<2> employees에서 보너스(comm)을 받는 사원의 수를 출력하시오*/
db.emp.find({comm:{$exists:1}})
db.emp.find({comm:{$gt:'0.00'}},{})
db.emp.find({comm:{$ne:'0.00'}},{}).count()
/*<3> 직업이 SALESMAN이면서 보너스를 100이상 받는 사원수를 출력하시오*/
db.emp.find({$and:[{job:'SALESMAN'},{comm:{$gte:'100.00'}}]}).count()

//내장형 문서 조회-Embeded Document
db.products.insertMany([
    {item:'journal',qty:25,size:{h:14,w:21,uom:'cm'},status:'A'},
    {item:'notebook',qty:50,size:{h:8.5,w:11,uom:'in'},status:'A'},
    {item:'paper',qty:100,size:{h:10,w:13,uom:'in'},status:'D'},
    {item:'planner',qty:75,size:{h:22.85,w:30,uom:'cm'},status:'C'},
    {item:'postcard',qty:45,size:{h:10,w:15.25,uom:'cm'},status:'B'}
])
db.products.find({})
//size가 h:8.5, w:11, uom:'in' 인 상품을 조회해서 출력하세요
db.products.find({size:{h:8.5,w:11,uom:'in'}})
//size중  h가 10이상인 상품만 가져와 출력하세요
db.products.find({size:{h:{$gte:10}}})//===>결과가 나오지 않음
db.products.find({'size.h':{$gte:10}})//===>0
//단위가 cm인 상품만 가져와 출력하기
db.products.find({"size.uom":"cm"})
//size.h가 10미만이고 status가 A인 것들만 가져오기
db.products.find({"size.h":{$lt:10},status:'A'})

//배열값 조회
db.inventory.insertMany([
	{ item: "journal", qty: 25, tags: ["blank", "red"], dim_cm: [ 14, 21 ] },
	 { item: "notebook", qty: 50, tags: ["red", "blank"], dim_cm: [ 14, 21 ] },
	 { item: "paper", qty: 100, tags: ["red", "blank", "plain"], dim_cm: [ 14, 21 ] },
	 { item: "planner", qty: 75, tags: ["blank", "red"], dim_cm: [ 22.85, 30 ] },
	 { item: "postcard", qty: 45, tags: ["blue"], dim_cm: [ 10, 15.25 ] } 
	 ]);
/*
배열 선택자
$all: 주어진 조건의 모든 요소를 포함하는 배열
$elemMatch: 주어진 조건의 모든 요소와 일치하는 배열
$size: 주어진 크기 조건과 일치하는 배열
*/

//tags 필드에 red,blank 값만 배열에 가지고 있는 상품을 조회하세요
db.inventory.find({})

db.inventory.find({tags:['red','blank']})
//'red','blank' 만 가지고 있는 경우만 출력된다==>$all선택자를 사용하면 해당 내용을 모두 포함하는 문서를 조회함
db.inventory.find({tags:{$all:['red','blank']}})

db.inventory.find({tags:'red'})
//'red'를 포함하는 모든 문서를 가져온다

//dim_cm 필드에 25이산의 값이 포함된 상품을 가져와 출력하세요
db.inventory.find({dim_cm:{$gte:20}})

db.inventory.find({"dim_cm.0":{$gte:20}})
//=>dim_cm중 인덱스번호가 0인 요소가 20이상인 상품을 가져온다

//tags 중에서 배열크기가 2인 상품을 출력하세요
//$size
db.inventory.find({tags:{$size:2}})

//find()로 조회한 결과는 cursor형태로 객체로 반환된다
var mycr=db.emp.find({})
while(mycr.hasNext()){
    printjson(mycr.next())
}
//부서번호가 20번인 부서의 사원정보를 커서를 이용해서 출력하세요
var cr=db.emp.find({deptno:20})

//forEach()함수 이용
cr.forEach(printjson)

//member에서 나이가 높은순으로 정렬해서 3명만 출력하세요
db.member.find({}).sort({age:-1}).limit(3)
