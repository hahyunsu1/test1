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
db.dropDatabase("member");
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
db.emp.find({})
