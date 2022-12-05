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
db.createCollection("cappedCollection",{cappde:true,size:10000})