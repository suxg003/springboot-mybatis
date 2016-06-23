/**
 * Created by lxl on 15/7/22.
 */
var CC = CC || {};
CC.requestId = '${data.request.id}';
CC.user = {
    id: '${data.user.id}',
    name: '${data.user.name}',
    loginName: '${data.user.loginName}'
};
var loanAmount = $('#loanAmount').data('amount');
var chineseAmount = toChinese(loanAmount);
$('#amountToChinese').text('（' + chineseAmount + '）');

function initRoyalSlider(){
    $(".royalSlider").royalSlider({
        keyboardNavEnabled: true,
        controlNavigation: 'thumbnails',
        globalCaption: 'true',
        //slidesOrientation: 'vertical',
        thumbs: {
            appendSpan: true,
            firstMargin: true,
            paddingBottom: 4,
            orientation: 'vertical'
        },
        autoScaleSlider: true,
        //imageScaleMode: 'fit',
        fullscreen: {
            nativeFS: true,
            enabled: true
        }
    });
}

initRoyalSlider();

//借款信息 选项卡
$('#loanDetails .detail-box:gt(0)').hide();
var li_tab = $('#loanTabs li');
li_tab.click(function(){
    //alert(1);
    $(this).addClass('active').siblings().removeClass('active');

    $('#loanDetails .detail-box').eq(li_tab.index(this)).show().siblings().hide();

    if($('#loanDetails .detail-box').eq(3)){
        initCDPage();
        cd.isFirstType=true;
    }
});
