// 轮播图
var swiper = new Swiper('.swiper-container', {
    spaceBetween: 30,
    centeredSlides: true,
    autoplay: {
        delay: 2500,
        disableOnInteraction: false,
    },
    pagination: {
        el: '.swiper-pagination',
        clickable: true,
    },
    observer: true, //调完接口不能翻页解决方法，修改swiper自己或子元素时，自动初始化swiper  
    observeParents: true, //调完接口不能翻页解决方法，修改swiper的父元素时，自动初始化swiper 

});
// 复制功能
var clipboard = new ClipboardJS('.copy');
clipboard.on('success', function(e) {
    layer.open({
        content: '复制成功',
        skin: 'msg',
        time: 2
    });
});

clipboard.on('error', function(e) {
    // console.log(e);
});