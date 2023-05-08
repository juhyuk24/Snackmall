"use strict";


const dataURL = "http://192.168.1.140:8000//SnackMallProject/allproductsPro.jsp";
const _div1 = document.querySelector('.mt-5')
const _div2 = document.querySelector('.justify-content-center')
let _HIDEBTN;
const list = {
    init:function(){
        list.ajax();
    },
    listView:function(jdata){
		let price = (jdata.가격).toLocaleString()	;
        let _div = document.createElement('div');
        _div.className = 'col mb-5';
        _div.innerHTML = `<div class="col mb-5" onClick="location.href='item.jsp?상품번호=${jdata.상품번호}'">
        					<div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="snackImgs/${jdata.상품명}.PNG" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${jdata.상품명}</h5>
                                    <!-- Product price-->
                                    ${price}원
                                </div>
                            </div>
                        </div>`
        return _div;
    },
    more:function(length,max,cnt){
        //more button
            let _BTN = document.createElement('div');
            _BTN.className = 'text-center';
            _BTN.innerHTML = `<button class="btn btn-outline-dark mt-auto">더보기</button>`
            _HIDEBTN = _BTN;
            return length > max && _div1.appendChild( _BTN ); 
    },
    
    ajax:function(){
        $.ajax ({
            type : 'get',
            url: dataURL,
            datatype : 'json',
            //contentType : "application/json; charset=utf-8;",
            success : function(data){    
                const max = 8; // 최대 8개
                let start = 0; // 리스트데이터 시작번호
                let ss = $(data).text();
                let jdata = JSON.parse(ss);
				//alert(jdata[0].재고량);
                // 처음 리스트 데이터
                for(let i=jdata.length-1;i>=jdata.length-8;i--){
                  _div2.appendChild( list.listView(jdata[i]) );
                }
          
                let cnt = 1; // 버튼클릭수 
                list.more(jdata.length,max,cnt).addEventListener('click',function(e){
		            // 클릭수
		            cnt++;
		            //
		            //보여질 데이터 초과시 
		            //
		            // 더보기버튼으로 불러올 리스트 개수
		            // data.length(총 데이터 개수) / max(최대 8개)          

	                for(let i=jdata.length-9;i>=0;i--){
	                    _div2.appendChild( list.listView(jdata[i]) );
	                };
	                _HIDEBTN.className = 'valid-feedback';
		              
		        });    
            },
            error : function(err){
                 console.log('err : ',err)
            }
        })
    },
}

list.init();
