$(function () {
    // submit 했을 때 처리
    $('#ocrForm').on('submit', function (event) {
        event.preventDefault();
        var formData = new FormData($('#ocrForm')[0]);
        var fileName = $('#uploadFile').val().split("\\").pop();
       	var values = [];
        $.ajax({        	
            type : "post",
            enctype : "multipart/form-data",
            url : "clovaOCR",
            data : formData,
            processData : false, // 필수
            contentType : false, // 필수
            success:function (retVal) {
            	
            	//console.log(retVal);
            	values = $(retVal).find('OCRlist');
            	
            	
            	var jcode=values[8].innerHTML;
            	today=new Date();
            	if(jcode.length==10){
            	var yy=jcode.substr(0,4);
            	var yyy=today.getFullYear()-yy;
            	var mm=jcode.substr(5,2);            	
            	};
            	//console.log(yy);
            	//console.log(today.getYear());
            	//console.log(values[1].find);
            	var OCRdata = {
            		petname : values[2].innerHTML,
            		sex : values[4].innerHTML,
            		age_year : yyy,
            		age_month : mm,
            		nstate : values[12].innerHTML           		
            	};
            	//$('#petname').text(OCRdata.petname);
            	petname2(OCRdata.petname);
            	//console.log(OCRdata);
            	makeAgeYear(OCRdata.age_year);
            	makeAgeMonth(OCRdata.age_month);
            	radioCheck(OCRdata.nstate);
                //$('#resultDiv').text(OCRdata.age_year+"=="+OCRdata.age_month);
                // 이미지 출력 (div에 append)                
               
            },
            error:function (e) {
                alert("오류 발생" + e);
            }
            
        });
        
    })
})