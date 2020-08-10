<#include "../../include/import_global.ftl">
<#include "../../include/html_doctype.ftl">
<#--
titleMessageKey 标题标签I18N关键字，不允许null
selectOperation 是否选择操作，允许为null
boolean readonly 是否只读操作，默认为false
-->
<#assign selectOperation=(selectOperation!false)>
<#assign isMultipleSelect=(isMultipleSelect!false)>
<#assign readonly=(readonly!false)>
<#assign DataSetEntity=statics['org.datagear.management.domain.DataSetEntity']>
<html>
<head>
<#include "../../include/html_head.ftl">
<title><#include "../../include/html_title_app_name.ftl"><@spring.message code='${titleMessageKey}' /></title>
</head>
<body class="fill-parent">
<#if !isAjaxRequest>
<div class="fill-parent">
</#if>
<#include "../../include/page_js_obj.ftl">
<div id="${pageId}" class="page-grid page-grid-dataSet">
	<div class="head">
		<div class="search">
			<#include "../../include/page_obj_searchform_data_filter.ftl">
		</div>
		<div class="operation">
			<#if selectOperation>
				<input name="confirmButton" type="button" class="recommended" value="<@spring.message code='confirm' />" />
			</#if>
			<#if readonly>
				<input name="viewButton" type="button" value="<@spring.message code='view' />" />
			<#else>
				<div class="add-button-wrapper">
					<button class="add-button" type="button">
						<@spring.message code='add' />
						<span class="ui-icon ui-icon-triangle-1-s"></span>
					</button>
					<div class="add-button-panel ui-widget ui-widget-content ui-corner-all ui-widget-shadow ui-front">
						<ul class="add-button-list">
							<li addURL="addForSql"><div><@spring.message code='dataSet.dataSetType.SQL' /></div></li>
							<li addURL="addForJsonValue"><div><@spring.message code='dataSet.dataSetType.JSON_VALUE' /></div></li>
						</ul>
					</div>
				</div>
				<#if !selectOperation>
				<input name="editButton" type="button" value="<@spring.message code='edit' />" />
				</#if>
				<input name="viewButton" type="button" value="<@spring.message code='view' />" />
				<#if !selectOperation>
				<#if !(currentUser.anonymous)>
				<input name="shareButton" type="button" value="<@spring.message code='share' />" />
				</#if>
				<input name="deleteButton" type="button" value="<@spring.message code='delete' />" />
				</#if>
			</#if>
		</div>
	</div>
	<div class="content">
		<table id="${pageId}-table" width="100%" class="hover stripe">
		</table>
	</div>
	<div class="foot">
		<div class="pagination-wrapper">
			<div id="${pageId}-pagination" class="pagination"></div>
		</div>
	</div>
</div>
<#if !isAjaxRequest>
</div>
</#if>
<#include "../../include/page_obj_pagination.ftl">
<#include "../../include/page_obj_grid.ftl">
<#include "../../include/page_obj_data_permission.ftl" >
<script type="text/javascript">
(function(po)
{
	$.initButtons(po.element(".operation"));
	po.initDataFilter();

	po.currentUser = <@writeJson var=currentUser />;
	
	po.element(".add-button-list").menu(
	{
		select: function(event, ui)
		{
			var item = $(ui.item);
			
			var addURL = item.attr("addURL");
			
			po.open(po.url(addURL),
			{
				width: "85%",
				<#if selectOperation>
				pageParam:
				{
					afterSave: function(data)
					{
						po.pageParamCallSelect(true, data);
					}
				}
				</#if>
			});
		}
	});
	
	po.url = function(action)
	{
		return "${contextPath}/analysis/dataSet/" + action;
	};

	po.element(".add-button").click(function()
	{
		po.element(".add-button-panel").toggle();
	});
	po.element(".add-button-wrapper").hover(function(){}, function()
	{
		po.element(".add-button-panel").hide();
	});
	
	po.element("input[name=editButton]").click(function()
	{
		po.executeOnSelect(function(row)
		{
			var data = {"id" : row.id};
			
			po.open(po.url("edit"), { data : data });
		});
	});

	po.element("input[name=shareButton]").click(function()
	{
		po.executeOnSelect(function(row)
		{
			if(!po.canAuthorize(row, po.currentUser))
			{
				$.tipInfo("<@spring.message code='error.PermissionDeniedException' />");
				return;
			}
			
			var options = {};
			$.setGridPageHeightOption(options);
			po.open(contextPath+"/authorization/${DataSetEntity.AUTHORIZATION_RESOURCE_TYPE}/query?"
					+"${statics['org.datagear.web.controller.AuthorizationController'].PARAM_ASSIGNED_RESOURCE}="+encodeURIComponent(row.id), options);
		});
	});
	
	po.element("input[name=viewButton]").click(function()
	{
		po.executeOnSelect(function(row)
		{
			var data = {"id" : row.id};
			
			po.open(po.url("view"),
			{
				data : data
			});
		});
	});
	
	po.element("input[name=deleteButton]").click(
	function()
	{
		po.executeOnSelects(function(rows)
		{
			po.confirmDeleteEntities(po.url("delete"), rows);
		});
	});
	
	po.element("input[name=confirmButton]").click(function()
	{
		<#if isMultipleSelect>
		po.executeOnSelects(function(rows)
		{
			po.pageParamCallSelect(true, rows);
		});
		<#else>
		po.executeOnSelect(function(row)
		{
			po.pageParamCallSelect(true, row);
		});
		</#if>
	});
	
	var dataSetTypeColumn = $.buildDataTablesColumnSimpleOption("<@spring.message code='dataSet.dataSetType' />", "dataSetType");
	dataSetTypeColumn.render = function(data)
	{
		if("${DataSetEntity.DATA_SET_TYPE_SQL}" == data)
			return "<@spring.message code='dataSet.dataSetType.SQL' />";
		else if("${DataSetEntity.DATA_SET_TYPE_JSON_VALUE}" == data)
			return "<@spring.message code='dataSet.dataSetType.JSON_VALUE' />";
		else
			return "";
	};
	
	var tableColumns = [
		$.buildDataTablesColumnSimpleOption("<@spring.message code='id' />", "id", true),
		$.buildDataTablesColumnSimpleOption($.buildDataTablesColumnTitleSearchable("<@spring.message code='dataSet.name' />"), "name"),
		dataSetTypeColumn,
		$.buildDataTablesColumnSimpleOption("<@spring.message code='dataSet.createUser' />", "createUser.realName"),
		$.buildDataTablesColumnSimpleOption("<@spring.message code='dataSet.createTime' />", "createTime")
	];
	
	po.initPagination();
	
	var tableSettings = po.buildDataTableSettingsAjax(tableColumns, po.url("pagingQueryData"));
	tableSettings.order = [[$.getDataTableColumn(tableSettings, "createTime"), "desc"]];
	po.initDataTable(tableSettings);
	po.bindResizeDataTable();
})
(${pageId});
</script>
</body>
</html>
