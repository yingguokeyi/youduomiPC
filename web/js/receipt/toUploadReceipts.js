
$(function(){
    // 判断是否填写小票号
    $("#le").blur(function() {
        var name = document.getElementById("le").value;
        if(name !=''){
            $('.push_button').css({display: 'block'});
            // $('.below').css({display: 'block'});
          
        }else {
            $('.push_button').css({display: 'none'});
            // $('.below').css({display: 'none'});
        }
    });

  // 弹框 ----上传
  $(".up").click(function() {
    layer.open({
        type: 1,
        content: $('.warm').html(),
        anim: 'up',
        scrollbar: false,
        shadeClose: false,
        style: 'position:fixed;bottom:50%;left: 8%; right:8%;height: auto;border:none;border-radius:6px'
        
    });
    
})
//点击确定退出登录
$(document).on("click", ".warm_login", function(){
    layer.closeAll('page');
    });



 

})

//下面用于图片上传预览功能
function setImagePreview(avalue) {
    //input
    var docObj = document.getElementById("doc");
    //img
    var imgObjPreview = document.getElementById("preview");
    //div
    var divs = document.getElementById("localImag");
    var add = document.getElementById("add");
        if (docObj.files && docObj.files[0]) {
            //火狐下，直接设img属性
            imgObjPreview.style.display = 'block';
            imgObjPreview.style.width = '1.8rem';
            imgObjPreview.style.height = '1.8rem';
            //imgObjPreview.src = docObj.files[0].getAsDataURL();
            //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
            imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
            add.style.display="none";
            $("#btn").removeAttr("disabled");
			$('#btn').css({'background':'#b61c25','color':'#fff'});
        } else {
            //IE下，使用滤镜
            docObj.select();
            var imgSrc = document.selection.createRange().text;
            var localImagId = document.getElementById("localImag");
            //必须设置初始大小
            localImagId.style.width = "1.8rem";
            localImagId.style.height = "1.8rem";
            //图片异常的捕捉，防止用户修改后缀来伪造图片
            try {
                localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
                add.style.display="none";
                $("#btn").removeAttr("disabled");
				$('#btn').css({'background':'#b61c25','color':'#fff'});
            } catch(e) {
                alert("您上传的图片格式不正确，请重新选择!");
                return false;
            }
            imgObjPreview.style.display = 'none';
            document.selection.empty();
        }
    return true;
}


