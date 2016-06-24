<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/25
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="/assets/css/cms.css" rel="stylesheet" />
    
</head>
<body>
<%@include file="../common/navbar.jspf" %>
<!-- Main Container -->
<div class="main-container container-fluid">
    <!-- Page Container -->
    <div class="page-container">
        <%@include file="../common/sidebar.jspf" %>
        <!-- Page Content -->
        <div class="page-content">
            <!-- Page Breadcrumb -->
            <div class="page-breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="fa fa-home"></i>
                        <a href="/">首页</a>
                    </li>
                    <li class="active">系统管理</li>
                    <li class="active">CMS管理</li>
                </ul>
            </div>
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                       CMS管理
                    </h1>
                </div>
                <!--Header Buttons-->
                <div class="header-buttons">
                    <a class="sidebar-toggler" href="#">
                        <i class="fa fa-arrows-h"></i>
                    </a>
                    <a class="refresh" id="refresh-toggler" href="">
                        <i class="glyphicon glyphicon-refresh"></i>
                    </a>
                    <a class="fullscreen" id="fullscreen-toggler" href="#">
                        <i class="glyphicon glyphicon-fullscreen"></i>
                    </a>
                </div>
                <!--Header Buttons End-->
			</div>
            <!-- /Page Header -->
            <!-- Page Body -->
            <div class="page-body">
                <div>


					<div class="row">
						<!-- 分类列表 -->
						<div class="col-lg-3">
							<div class="widget-box transparent">
								<div class="widget-header widget-header-flat">
									<h4 class="lighter">模块分类</h4>
									<cm:securityTag privilegeString="CHANNEL_ADD">
									<button id="createChannel" class="btn btn-sm btn-success pull-right" style="margin-top:5px;margin-right:10px;">
										<i class="fa fa-plus"></i>  创建栏目
									</button>
									</cm:securityTag>
								</div>
								<div class="widget-body">
									<div class="widget-main no-padding-left no-padding-right">
										<div id="categorys" class="accordion">
											  <c:forEach var="categoryMap" items="${data}">
                                                <div id="category${categoryMap}" class="accordion-group" style="margin-bottom: 8px;">
                                                    <div class="accordion-heading">
                                                        <a class="accordion-toggle collapsed"
                                                           data-toggle="collapse"
                                                           data-parent="#categorys"
                                                           href="#${categoryMap.key}">${categoryMap.key.key}
                                                        </a>
                                                    </div>

                                                    <div id="${categoryMap.key}" class="category-name accordion-body collapse" style="height: 0px;">
                                                        <c:choose>
                                                            <c:when test="${fn:length(categoryMap.value)==0}"><!--此处判断是否有栏目,没有栏目则显示无-->
                                                                <div class="accordion-inner">无</div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:forEach var ="channel" items= "${categoryMap.value}">
                                                                <cm:securityTag privilegeString="CHANNEL_ADD">
                                                                    <div class="accordion-inner" data-id="${categoryMap.key}" >
                                                                        <label class="detailChannelLink" data-id="${channel.channelId}" data-name="${channel.channelName}" data-category="${categoryMap.key}">${channel.channelName}
                                                                        <cm:securityTag privilegeString="CHANNEL_ALTER">
                                                                            <span class="pull-right size-12 edit-link red" style="margin-left: 10px;">
                                                                                <i class="fa fa-trash-o bigger-110 red"></i>
                                                                                <a href="javascript:void(0);" class="deleteChannelLink red" data-id="${channel.channelId}">删除</a>
                                                                            </span>
                                                                            <span class="pull-right size-12 edit-link blue">
                                                                                <i class="fa fa-edit"></i>
                                                                                <a href="javascript:void(0);" class="editChannelLink" data-id="${channel.channelId}" data-name="${channel.channelName}" data-category="${categoryMap.key}">修改</a>
                                                                            </span>
                                                                            </cm:securityTag>
                                                                        </label>
                                                                    </div>
                                                                    </cm:securityTag>
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </c:forEach>
											
										</div>
									</div>
										
								</div>
									 
							</div>
						</div><!--分类列表-->
						
						<div class="col-lg-9"> <!--栏目详情和文章列表-->
							<!-- 栏目详情 -->
							<div class="widget-box transparent" id="editChannelPanel">
								<div class="widget-header widget-header-flat">
									<h4 class="lighter">
										栏目详情
									</h4>
									<div class="widget-toolbar no-border" style="margin-top:5px;margin-right:10px;">
										<button id="updateChannel" class="btn btn-sm btn-primary">
											<i class="fa fa-check"></i> 保存修改
										</button>
										<button type="submit" id="saveChannel" class="btn btn-sm btn-success">
											<i class="fa fa-check"></i>
											创建
										</button>
										<button type="submit" id="cancelCreateChannel" class="btn btn-sm btn-light">
											<i class="fa fa-times"></i>
											取消
										</button>
									</div>
								</div>
								
								<div class="widget-body">
									<div class="widget-main no-padding">
										<div class="space-10"></div>
										<div class="row-fluid form-horizontal">
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="whichCategory">栏目分类</label>
												<div class="controls  col-sm-10">
													<select id="whichCategory" name="whichCategory" class="row-fluid">
                                                        <c:forEach var="category" items="${category}">
                                                            <option value="${category}">${category.key}</option>
                                                        </c:forEach>
                                                    </select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="channelName">栏目名称</label>
												<div class="controls col-sm-10 ">
													<input id="channelName" name="channelName" type="text" placeholder="栏目名称" class="form-control">
													<input id="channelId" name="channelId" type="hidden">
												</div>
											</div>
										</div>
										<div class="space-20"></div>
									</div>
								</div>
							</div><!--栏目详情-->
						
							<!-- 文章列表 -->
							<cm:securityTag privilegeString="ARTICLE_ALTER">
							<div class="widget-box transparent" id="articleListPanel" style="display: block;">
								<div class="widget-header widget-header-flat">
									<h4 class="lighter">
										文章列表
									</h4>
									<div class="widget-toolbar no-border" style="margin-top:5px;margin-right:10px">
										<button id="openCreateArticleBtn" class="btn btn-sm btn-primary" style="display: inline-block;">
											<i class="fa fa-plus"></i>
											添加文章
										</button>
									</div>
								</div>
								<div class="widget-body">
									<div class="widget-main no-padding">
										<div id="articleTable_wrapper" class="dataTables_wrapper" role="grid">
											
											
											<table id="articleTable" class="table table-hover  dataTable" aria-describedby="articleTable_info" style="">
												<thead>
													<tr role="row">
														<th class="hidden sorting_disabled" role="columnheader" rowspan="1" colspan="1">序号</th>
														<th class="sorting_disabled" role="columnheader" rowspan="1" colspan="1" style="width: 30%;"><i class="fa fa-tag"></i> 标题</th>
														<th class="sorting_disabled" role="columnheader" rowspan="1" colspan="1" style="width: 20%;"><i class="fa fa-user"></i> 作者</th>
														<th class="sorting_disabled" role="columnheader" rowspan="1" colspan="1" style="width: 25%;"><i class="fa fa-clock-o"></i> 发布时间</th>
														<th rowspan="1" colspan="1"><i class="fa fa-gears"></i> 操作</th>
													</tr>
												</thead>
												<tbody role="alert" aria-live="polite" aria-relevant="all">
													
												</tbody>
											</table>
											
										</div>
									</div>
								</div>	
					
							</div>
							</cm:securityTag>
							<div class="widget-box transparent" id="createArticlePanel" style="display: none;">
								<div class="widget-header widget-header-flat">
									<h4 class="lighter">
										创建文章
									</h4>
									<div class="widget-toolbar no-border" style="margin-top:5px; margin-right:10px;">
										<button id="updateArticleBtn" class="btn btn-sm btn-primary" style="display: none;">
											<i class="fa fa-check"></i> 保存修改
										</button>
										<button id="createArticleBtn" class="btn btn-sm btn-success">
											<i class="fa fa-check"></i>
											创建文章
										</button>
										<button id="cancelCreateArticleBtn" class="btn btn-sm btn-light">
											<i class="fa fa-times"></i>
											取消
										</button>
									</div>
								</div>
								<div class="widget-body">
									<div class="widget-main no-padding">
										<div class="row-fluid form-horizontal">
											<div class="space-10"></div>
											<div class="form-group" id="artChannel">
												<label class="col-sm-2 control-label no-padding-right" for="artChannel">所属栏目</label>
												<div class="controls col-sm-10">
													<input name="artChannel" type="text" class="form-control" placeholder="文章标题" disabled="" >
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artCategory">文章类型</label>
												<div class="controls col-sm-10">
													<select id="artCategory" name="artCategory" class="row-fluid">
                                                        <c:forEach var="categoryMap" items="${category}">
                                                            <option value="${categoryMap}">${categoryMap.key}</option>
                                                        </c:forEach>
                                                    </select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artId">文章唯一号</label>
												<div class="controls col-sm-10">
													<input id="artId" name="artId" class="form-control" type="text" placeholder="文章唯一号">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artTitle">文章标题</label>
												<div class="controls col-sm-10">
													<input id="artTitle" name="artTitle" class="form-control" type="text" placeholder="文章标题">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artKeyWords">文章关键字</label>
												<div class="controls col-sm-10">
													<input id="artKeyWords" name="artKeyWords" class="form-control" type="text" placeholder="文章关键字">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artDescription">文章描述</label>
												<div class="controls col-sm-10">
													<input id="artDescription" name="artDescription" class="form-control" type="text" placeholder="文章描述">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artTitleImageUrl">标题图片</label>
												<div class="controls col-sm-10">
													<input id="artTitleImageUrl" name="artTitleImageUrl" class="form-control" type="text" placeholder="标题图片地址">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artAuthor">文章作者</label>
												<div class="controls col-sm-10">
													<input id="artAuthor" name="artAuthor" class="form-control" type="text" placeholder="文章作者">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artMedia">发布媒体</label>
												<div class="controls col-sm-10">
													<input id="artMedia" name="artMedia" class="form-control" type="text" placeholder="发布媒体">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artUrl">文章链接</label>
												<div class="controls col-sm-10">
													<input id="artUrl" name="artUrl" class="form-control" type="text" placeholder="文章链接">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artUrl">发布日期</label>
												<div class="controls col-sm-10">
													<div class="col-sm-6" style="padding-left:0;">
														<div class="input-group">
			                                                <input class="form-control date-picker"  data-date-format="yyyy-mm-dd" readonly  name="pubDate" type="text" >
			                                                <span class="input-group-addon">
			                                                    <i class="fa fa-calendar"></i>
			                                                </span>
			                                            </div>
		                                            </div>
		                                            <div class="col-sm-6"  style="padding-left:0;">
														<div class="input-group bootstrap-timepicker-widget">
			                                                <input class="form-control" name="timepicker" id="timepicker" value="" type="text">
			                                                <span class="input-group-addon">
			                                                    <i class="fa fa-clock-o"></i>
			                                                </span>
			                                            </div>
		                                            </div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artTop">置顶显示</label>
												<div class="controls col-sm-10">
													<div class="radio">
														<label>
	                                                        <input name="artTop" type="radio" class="colored-blue" value="true">
	                                                        <span class="text"> 是</span>
	                                                    </label>
	                                                    <label >
	                                                        <input name="artTop" type="radio" class="colored-blue" value="false">
	                                                        <span class="text"> 否</span>
	                                                    </label>
													</div>
												</div>
											</div>
											
											<div class="form-group putIn-location">
												<label class="col-sm-2 control-label no-padding-right" for="putIn">投放位置</label>
												<div class="controls col-sm-10">
													<div class="radio">
														<label>
	                                                        <input name="putIn-app" type="checkbox" class="colored-blue" value="">
	                                                        <span class="text"> APP</span>
	                                                    </label>
	                                                    <label >
	                                                        <input name="putIn-pc" type="checkbox" class="colored-blue" value="">
	                                                        <span class="text"> PC</span>
	                                                    </label>
	                                                    <label >
	                                                        <input name="putIn-m" type="checkbox" class="colored-blue" value="">
	                                                        <span class="text"> M站</span>
	                                                    </label>
													</div>
												</div>
											</div>
											<div class="form-group img-app" style="display:none;">
												<label class="col-sm-2 control-label no-padding-right" style="width:95px;" for="cbcontainer">上传App封面</label>
												<div class="controls col-sm-10">
													<div class="row-fluid cbcontainer">
                                                        <ul class="ace-thumbnails ace-thumbnails-APP"></ul>
                                                        <div id="uploadImageBtn-APP">
                                                            <i class="fa fa-plus"></i> 上传图片
                                                        </div>
                                                        <form action="" name="uploadImageForm-APP">
                                                            <input type="file" id="imageFileInput-APP"/> 
                                                            <button class="btn btn-danger btn-mini hidden" id="uploadBtn"><i class="fa fa-arrow-up"></i> 上传</button>
                                                        </form>
                                                    </div>
												</div>
											</div>
											<div class="form-group img-m" style="display:none;">
												<label class="col-sm-2 control-label no-padding-right" style="width:95px;" for="cbcontainer">上传M站封面</label>
												<div class="controls col-sm-10">
													<div class="row-fluid cbcontainer">
                                                        <ul class="ace-thumbnails ace-thumbnails-M"></ul>
                                                        <div id="uploadImageBtn-M">
                                                            <i class="fa fa-plus"></i> 上传图片
                                                        </div>
                                                        <form action="" name="uploadImageForm-M">
                                                            <input type="file" id="imageFileInput-M"/> 
                                                            <button class="btn btn-danger btn-mini hidden" id="uploadBtn"><i class="fa fa-arrow-up"></i> 上传</button>
                                                        </form>
                                                    </div>
												</div>
											</div>
											
											
											
											
											
											<%--
											<div class="form-group" id="artPlaceDiv">
												<label class="col-sm-2 control-label no-padding-right" for="artPlace">首页展示</label>
												<div class="controls col-sm-10">
													<div class="radio">
														<label>
															<input id="l_artPlace" name="artPlace" type="radio" class="colored-blue" value="LEFT" onclick="getArticlePlace('LEFT')">
															<span class="text"> 左</span>
														</label>
														<label >
															<input id="m_artPlace" name="artPlace" type="radio" class="colored-blue" value="MEDIUM" onclick="getArticlePlace('MEDIUM')">
															<span class="text"> 中</span>
														</label>
														<label >
															<input id="r_artPlace" name="artPlace" type="radio" class="colored-blue" value="RIGHT" onclick="getArticlePlace('RIGHT')">
															<span class="text"> 右</span>
														</label>
													</div>
												</div>
											</div>
											--%>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artHasImg">包含图片</label>
												<div class="controls col-sm-10">
													<div class="radio">
														<label>
	                                                        <input name="artHasImg" type="radio" class="colored-blue" checked>
	                                                        <span class="text"> 是</span>
	                                                    </label>
	                                                    <label >
	                                                        <input name="artHasImg" type="radio" class="colored-blue">
	                                                        <span class="text"> 否</span>
	                                                    </label>
													</div>
													
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="cbcontainer">图片列表</label>
												<div class="controls col-sm-10">
													<div class="row-fluid cbcontainer">
                                                        <ul class="ace-thumbnails ace-thumbnails-list"></ul>
                                                        <div id="uploadImageBtn">
                                                            <i class="fa fa-plus"></i> 上传图片
                                                        </div>
                                                        <form action="" name="uploadImageForm">
                                                            <input type="file" id="imageFileInput"/> 
                                                            <button class="btn btn-danger btn-mini hidden" id="uploadBtn"><i class="fa fa-arrow-up"></i> 上传</button>
                                                        </form>
                                                    </div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="artContent">文章内容</label>
												<div class="controls col-sm-10">
													<textarea name="contentEditor" id="contentEditor" rows="20" placeholder="输入项目详情" required></textarea>												
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label no-padding-right" for="seq">序号</label>
												<div class="controls col-sm-10">
													<input id="seq" name="seq" class="form-control" type="text" placeholder="序号">
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div><!--栏目详情和文章列表的div布局-->
					</div>


                </div>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>
<div id="modal-success" class="modal modal-message modal-success " style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <i class="glyphicon glyphicon-check"></i>
            </div>
            <div class="modal-title">成功</div>

            <div class="modal-body modal-message"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success reload-page-btn" >确定</button>
            </div>
        </div> <!-- / .modal-content -->
    </div> <!-- / .modal-dialog -->
</div>
<div id="modal-danger" class="modal modal-message modal-danger modal-failed" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <i class="glyphicon glyphicon-fire"></i>
            </div>
            <div class="modal-title">失败</div>

            <div class="modal-body modal-message"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger reload-page-btn">确定</button>
            </div>
        </div> <!-- / .modal-content -->
    </div> <!-- / .modal-dialog -->
</div>

<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.min.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/jquery.colorbox-min.js"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/datetime/bootstrap-datepicker.js"></script>
<script src="/assets/js/datetime/bootstrap-timepicker.js"></script>
<script src="/assets/js/datetime/daterangepicker.js"></script>
<script src="/assets/js/datetime/moment.min.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/ckeditor/ckeditor.js"></script>
<script src="/assets/js/ckeditor/jquery.js"></script>

<script type="text/template" id="cbLiTemplate">
            <li>
                <a href="link1" target="_blank" data-rel="colorbox">
                    <img alt="150x150" src="link2" />
                </a>
                <div class="imageInfo">
                   <button class="btn btn-light btn-mini copyUrlBtn" data-clipboard-text="link3"><i class="icon-copy"></i> 复制地址</button>
                </div>
            </li>
</script>    
<script type="text/template" id="cbLiTemplateAPP">
            <li>
                <a href="link1" target="_blank" data-rel="colorbox">
                    <img alt="150x150" src="link2" />
                </a>
                <div class="imageInfo">
                   <button class="btn btn-light btn-mini copyUrlBtn" data-clipboard-text="link3"><i class="icon-copy"></i> 复制地址</button>
                </div>
            </li>
</script>    
<script type="text/template" id="cbLiTemplateM">
            <li>
                <a href="link1" target="_blank" data-rel="colorbox">
                    <img alt="150x150" src="link2" />
                </a>
                <div class="imageInfo">
                   <button class="btn btn-light btn-mini copyUrlBtn" data-clipboard-text="link3"><i class="icon-copy"></i> 复制地址</button>
                </div>
            </li>
</script>    
<script type="text/javascript" src="/assets/js/cms/channel.js"></script>
</body>
</html>