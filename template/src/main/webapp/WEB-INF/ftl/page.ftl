<#if page?has_content && page.totalPages gt 0 >
<div class="dataTables_paginate light_page">
        ${page.number+1} / ${page.totalPages}&nbsp;&nbsp;
        <#if page.number+1 == 1>
            <a class="first ui-state-disabled" href="#"> 首页 </a>
            <a class="previous ui-state-disabled" href="#"> 上一页 </a>
        <#else >
            <a href="#" class="first" onclick="new Page(1).toPage(this)"> 首页 </a>
            <a href="#" class="previous" onclick="new Page(${(page.number)?c }).toPage(this)"> 上一页 </a>
        </#if>
        <#if page.number-1 <=1 && (page.totalPages <= page.number+3)>
            <#list 1.. page.totalPages as index>
                <#if page.number+1 == index>
                    <a class="fg-button ui-state-disabled" href="#">${index}</a>
                <#else >
                    <a class="fg-button" href="#" onclick="new Page(${index?c}).toPage(this)">${index}</a>
                </#if>
            </#list>
        <#elseif page.number-1 <= 1 && page.totalPages &gt; page.number+3>
            <#list 1.. (page.number+3) as index>
                <#if page.number+1 == index>
                    <a class="fg-button ui-state-disabled" href="#">${index}</a>
                <#else >
                    <a class="fg-button" href="#" onclick="new Page(${index?c}).toPage(this)">${index}</a>
                </#if>
            </#list>
            <a class="fg-button ui-state-disabled" href="#">...</a>
            <a class="fg-button" href="#" onclick="new Page(${page.totalPages?c}).toPage(this)">${page.totalPages}</a>
        <#elseif page.number-1 &gt; 1 && page.totalPages <=page.number+3>
            <a class="fg-button" href="#" onclick="new Page(1).toPage(this)">1</a>
            <a class="fg-button ui-state-disabled" href="#">...</a>
            <#list (page.number-1).. page.totalPages as index>
                <#if page.number+1 == index>
                    <a class="fg-button ui-state-disabled" href="#">${index}</a>
                <#else>
                    <a class="fg-button" href="#" onclick="new Page(${index?c}).toPage(this)">${index}</a>
                </#if>
            </#list>
        <#else >
            <a class="fg-button" href="#" onclick="new Page(1).toPage(this)">1</a>
            <a class="fg-button ui-state-disabled" href="#">...</a>
            <#list (page.number-1).. (page.number+3) as index>
                <#if page.number+1 == index>
                    <a class="fg-button ui-state-disabled" href="#">${index?c}</a>
                <#else >
                    <a class="fg-button" href="#" onclick="new Page(${index?c}).toPage(this)">${index}</a>
                </#if>
            </#list>
            <a class="fg-button ui-state-disabled" href="#">...</a>
            <a class="fg-button" href="#" onclick="new Page(${page.totalPages?c}).toPage(this)">${page.totalPages}</a>
        </#if>

        <#if page.number+1 == page.totalPages>
            <a class="next ui-state-disabled" href="#"> 下一页 </a>
            <a class="last ui-state-disabled" href="#"> 末页 </a>
        <#else >
            <a href="#" class="next" onclick="new Page(${(page.number+2)?c }).toPage(this)"> 下一页 </a>
            <a href="#" class="last" onclick="new Page(${page.totalPages?c}).toPage(this)"> 末页 </a>
        </#if>
        <#--<li class="disabled"><div class="page"><input type="text" placeholder="1" class="medium" id="jump"  name="prependedInput" size="4"></div></li>-->
        <#--<li><a href="#" onclick="$('#jump').val() != undefined && $('#jump').val() != ''?new Page($('#jump').val()).toPage():showError('跳转输入框不能为空','slow',15000)">go</a></li>-->
</div>
</#if>

<script type="text/javascript">

    $('.light_page').each(function(){
        var pageName = $(this).attr('page');
        if (pageName == undefined) {
            $(this).attr('page', Page.current);
        }
    });
    $('#pageSize').bind('change',function(){
        new Page(1,$('#pageSize').val()).toPage();
    });

</script>
