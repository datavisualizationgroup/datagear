<#--
 *
 * Copyright 2018 datagear.tech
 *
 * Licensed under the LGPLv3 license:
 * http://www.gnu.org/licenses/lgpl-3.0.html
 *
-->
<#include "../include/page_import.ftl">
<#include "../include/html_doctype.ftl">
<#--
Schema schema 数据库，不允许为null
-->
<html>
<head>
<#include "../include/html_head.ftl">
<title>
	<#include "../include/html_title_app_name.ftl">
	<@spring.message code='sqlpad.sqlpad' />
	<@spring.message code='bracketLeft' />
	${schema.title}
	<@spring.message code='bracketRight' />
</title>
</head>
<body class="fill-parent">
<#if !isAjaxRequest>
<div class="fill-parent">
</#if>
<#include "../include/page_obj.ftl">
<div id="${pageId}" class="page-sqlpad">
	<div class="head button-operation">
		<button id="executeSqlButton" class="ui-button ui-corner-all ui-widget ui-button-icon-only first" title="<@spring.message code='sqlpad.executeWithShortcut' />"><span class="ui-button-icon ui-icon ui-icon-play"></span><span class="ui-button-icon-space"> </span><@spring.message code='execute' /></button>
		<button id="stopSqlButton" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.stopExecution' />"><span class="ui-button-icon ui-icon ui-icon-stop"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.stopExecution' /></button>
		<div class="button-divider ui-widget ui-widget-content"></div>
		<button id="commitSqlButton" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.commit' />"><span class="ui-button-icon ui-icon ui-icon-check"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.commit' /></button>
		<button id="rollbackSqlButton" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.rollback' />"><span class="ui-button-icon ui-icon ui-icon-arrowreturnthick-1-w"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.rollback' /></button>
		<div class="button-divider ui-widget ui-widget-content"></div>
		<input id="sqlDelimiterInput" type="text" class="sql-delimiter-input ui-widget ui-widget-content ui-corner-all" value=";"  title="<@spring.message code='sqlpad.sqlDelimiter' />"/>
		<button id="insertSqlDelimiterDefineButton" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.insertSqlDelimiterDefine' />"><span class="ui-button-icon ui-icon ui-icon-grip-dotted-horizontal"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.insertSqlDelimiterDefine' /></button>
		<button id="insertSqlDelimiterButton" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.insertSqlDelimiter' />"><span class="ui-button-icon ui-icon ui-icon-grip-solid-horizontal"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.insertSqlDelimiter' /></button>
		<div class="button-divider ui-widget ui-widget-content"></div>
		<button id="clearSqlButton" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.clearEditSql' />"><span class="ui-button-icon ui-icon ui-icon-trash"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.clearEditSql' /></button>
		<div class="setting-wrapper">
			<button id="settingButton" auto-close-prevent="setting-panel" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.setting' />"><span class="ui-button-icon ui-icon ui-icon-caret-1-s"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.setting' /></button>
			<div class="setting-panel auto-close-panel ui-widget ui-widget-content ui-corner-all ui-widget-shadow ui-front">
				<form id="settingForm" method="POST" action="#">
					<div class="form-content">
						<div class="form-item">
							<div class="form-item-label"><label><@spring.message code='sqlpad.sqlCommitMode' /></label></div>
							<div class="form-item-value">
								<div id="sqlCommitModeSet" class="ui-corner-all">
									<input type="radio" id="${pageId}-sqlcm-0" name="sqlCommitMode" value="AUTO"><label for="${pageId}-sqlcm-0"><@spring.message code='sqlpad.sqlCommitMode.auto' /></label>
									<input type="radio" id="${pageId}-sqlcm-1" name="sqlCommitMode" value="MANUAL"><label for="${pageId}-sqlcm-1"><@spring.message code='sqlpad.sqlCommitMode.manual' /></label>
								</div>
							</div>
						</div>
						<div class="form-item">
							<div class="form-item-label"><label><@spring.message code='sqlpad.sqlExceptionHandleMode' /></label></div>
							<div class="form-item-value">
								<div id="sqlExceptionHandleModeSet" class="ui-corner-all">
									<input type="radio" id="${pageId}-sqlehm-0" name="sqlExceptionHandleMode" value="ABORT" checked="checked"><label for="${pageId}-sqlehm-0"><@spring.message code='sqlpad.sqlExceptionHandleMode.abort' /></label>
									<input type="radio" id="${pageId}-sqlehm-1" name="sqlExceptionHandleMode" value="IGNORE"><label for="${pageId}-sqlehm-1"><@spring.message code='sqlpad.sqlExceptionHandleMode.ignore' /></label>
									<input type="radio" id="${pageId}-sqlehm-2" name="sqlExceptionHandleMode" value="ROLLBACK"><label for="${pageId}-sqlehm-2"><@spring.message code='sqlpad.sqlExceptionHandleMode.rollback' /></label>
								</div>
							</div>
						</div>
						<div class="form-item">
							<div class="form-item-label">
								<label title="<@spring.message code='sqlpad.overTimeThreashold.desc' />">
									<@spring.message code='sqlpad.overTimeThreashold' />
								</label>
							</div>
							<div class="form-item-value">
								<input type="text" name="overTimeThreashold" value="10" required="required" maxlength="10" class="ui-widget ui-widget-content ui-corner-all" style="width:4em;" />
								<@spring.message code='sqlpad.overTimeThreashold.unit' />
							</div>
						</div>
						<div class="form-item">
							<div class="form-item-label">
								<label title="<@spring.message code='sqlpad.resultsetFetchSize.desc' />">
									<@spring.message code='sqlpad.resultsetFetchSize' />
								</label>
							</div>
							<div class="form-item-value">
								<input type="text" name="resultsetFetchSize" value="20" required="required" maxlength="10" class="ui-widget ui-widget-content ui-corner-all" style="width:4em;" />
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="view-sql-history-wrapper">
			<button id="viewSqlHistoryButton" auto-close-prevent="view-sql-history-panel" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.viewSqlHistory' />"><span class="ui-button-icon ui-icon ui-icon-clock"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.viewSqlHistory' /></button>
			<div class="view-sql-history-panel auto-close-panel ui-widget ui-widget-content ui-corner-all ui-widget-shadow ui-front">
				<div class="sql-history-head">
					<form id="viewSqlHistorySearchForm" method="POST" action="${contextPath}/sqlpad/${schema.id}/sqlHistoryData" class="sql-history-search-form">
						<input type="hidden" name="page" value="1" />
						<input type="hidden" name="pageSize" value="20" />
						<div class="form-content">
							<div class="form-item">
								<div class="form-item-value">
									<input type="text" name="keyword" value="" class="ui-widget ui-widget-content ui-corner-all" maxlength="50" />
									<button type="submit"><@spring.message code='query' /></button>
								</div>
							</div>
						</div>
					</form>
					<div class="sql-history-operation">
						<button id="insertSqlHistoryToEditorButton" title="<@spring.message code='sqlpad.insertSqlHistoryToEditor' />"><@spring.message code='insert' /></button>
						<button id="copySqlHistoryToClipbordButton"  title="<@spring.message code='sqlpad.copySqlHistoryToClipbord' />"><@spring.message code='copy' /></button>
					</div>
				</div>
				<div class="sql-history-list ui-widget ui-widget-content ui-corner-all">
				</div>
				<div class="sql-history-foot">
					<button id="sqlHistoryLoadMoreButton" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='loadMore' />"><span class="ui-button-icon ui-icon ui-icon-arrowthick-1-s"></span><span class="ui-button-icon-space"> </span><@spring.message code='loadMore' /></button>
					<button id="sqlHistoryRefreshButton" class="ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='refresh' />"><span class="ui-button-icon ui-icon ui-icon-refresh"></span><span class="ui-button-icon-space"> </span><@spring.message code='refresh' /></button>
				</div>
			</div>
		</div>
	</div>
	<div class="content ui-widget ui-widget-content ui-corner-all">
		<div class="content-editor">
			<div class="content-edit-content">
				<div id="${pageId}-sql-editor" class="sql-editor code-editor"></div>
			</div>
		</div>
		<div class="content-result">
			<div id="${pageId}-sqlResultTabs" class="result-tabs minor-tabs minor-dataTable">
				<ul>
					<li class="result-message-tab not-closable"><a class="result-message-anchor" href="#${pageId}-resultMessage"><@spring.message code='sqlpad.message' /></a></li>
				</ul>
				<div id="${pageId}-resultMessage" class="result-message">
				</div>
				<div class="tabs-more-operation-menu-wrapper ui-widget ui-front ui-corner-all ui-widget-shadow" style="position: absolute; left:0px; top:0px; display: none;">
					<ul class="tabs-more-operation-menu">
						<li class="tab-operation-close-left"><div><@spring.message code='main.closeLeft' /></div></li>
						<li class="tab-operation-close-right"><div><@spring.message code='main.closeRight' /></div></li>
						<li class="tab-operation-close-other"><div><@spring.message code='main.closeOther' /></div></li>
						<li class="tab-operation-close-all"><div><@spring.message code='main.closeAll' /></div></li>
					</ul>
				</div>
				<div class="tabs-more-tab-menu-wrapper ui-widget ui-front ui-widget-content ui-corner-all ui-widget-shadow" style="position: absolute; left:0px; top:0px; display: none;">
					<ul class="tabs-more-tab-menu">
					</ul>
				</div>
				<div id="viewLongTextResultPanel" class="view-long-text-result-panel auto-close-panel ui-widget ui-front ui-widget-content ui-corner-all ui-widget-shadow">
					<textarea class="long-text-content ui-widget ui-widget-content ui-corner-all"></textarea>
				</div>
			</div>
			<div class="result-operations button-operation">
				<div class="result-message-buttons">
					<button id="toggleAutoClearResultButton" class="result-message-button ui-button ui-corner-all ui-widget ui-button-icon-only stated-active" title="<@spring.message code='sqlpad.keepResult' />"><span class="ui-button-icon ui-icon ui-icon-pin-s"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.keepResult' /></button>
					<button id="clearSqlResultMessageButton" class="result-message-button ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.clearSqlResultMessage' />"><span class="ui-button-icon ui-icon ui-icon-trash"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.clearSqlResultMessage' /></button>
				</div>
				<div class="sql-result-buttons">
					<button id="moreSqlResultTabButton" class="sql-result-button ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.loadMoreData' />"><span class="ui-button-icon ui-icon ui-icon-arrowthick-1-s"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.loadMoreData' /></button>
					<button id="refreshSqlResultTabButton" class="sql-result-button ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.refreshSqlResult' />"><span class="ui-button-icon ui-icon ui-icon-refresh"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.refreshSqlResult' /></button>
					<button id="exportSqlResultTabButton" class="sql-result-button ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.exportSqlResult' />"><span class="ui-button-icon ui-icon ui-icon-arrowthick-1-ne"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.exportSqlResult' /></button>
					&nbsp;&nbsp;
					<button id="viewSqlResultTabButton" auto-close-prevent="view-sql-statement-panel" class="sql-result-button ui-button ui-corner-all ui-widget ui-button-icon-only" title="<@spring.message code='sqlpad.viewSqlStatement' />"><span class="ui-button-icon ui-icon ui-icon-lightbulb"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.viewSqlStatement' /></button>
					<button id="lockSqlResultTabButton" class="sql-result-button ui-button ui-corner-all ui-widget ui-button-icon-only stated-active" title="<@spring.message code='sqlpad.lockSqlResultTab' />"><span class="ui-button-icon ui-icon ui-icon-locked"></span><span class="ui-button-icon-space"> </span><@spring.message code='sqlpad.lockSqlResultTab' /></button>
				</div>
			</div>
			<div id="viewSqlStatementPanel" class="view-sql-statement-panel auto-close-panel ui-widget ui-front ui-widget-content ui-corner-all ui-widget-shadow">
				<textarea class="sql-content ui-widget ui-widget-content ui-corner-all"></textarea>
			</div>
		</div>
	</div>
	<div class="foot">
	</div>
	<div id="sqlExceptionDetailPanel" class="sql-exception-detail-panel ui-widget ui-widget-content ui-corner-all ui-widget-shadow">
		<div class="sql-exception-detail-content-wrapper">
			<div class="sql-exception-detail-content"></div>		
		</div>
	</div>
</div>
<#if !isAjaxRequest>
</div>
</#if>
<#include "../include/page_obj_form.ftl">
<#include "../include/page_obj_grid.ftl">
<#include "../include/page_obj_tabs.ftl" >
<#include "../include/page_obj_format_time.ftl" >
<#include "../include/page_obj_data_permission.ftl">
<#include "../include/page_obj_data_permission_ds_table.ftl">
<#include "../include/page_obj_codeEditor.ftl" >
<#include "../include/page_obj_sqlEditor.ftl">
<script type="text/javascript">
(function(po)
{
	po.schemaId = "${schema.id}";
	po.sqlpadId = "${sqlpadId}";
	po.sqlResultReadActualBinaryRows = parseInt("${sqlResultRowMapper.readActualBinaryRows}");
	po.sqlResultBinaryPlaceholder = "${sqlResultRowMapper.binaryPlaceholder?js_string?no_esc}";
	
	po.resultMessageElement = po.elementOfId("${pageId}-resultMessage");
	po.sqlResultTabs = po.elementOfId("${pageId}-sqlResultTabs");
	
	$.initButtons(po.element(".head, .result-operations"));
	po.element().autoCloseSubPanel();
	po.elementOfId("sqlCommitModeSet").checkboxradiogroup();
	po.elementOfId("sqlExceptionHandleModeSet").checkboxradiogroup();
	
	po.sqlpadTaskClient = new $.TaskClient("${contextPath}/sqlpad/"+po.schemaId+"/message",
			function(message)
			{
				return po.handleMessage(message);
			},
			{
				data: { sqlpadId: po.sqlpadId }
			}
		);
	
	po.getSqlEditorSchemaId = function(){ return po.schemaId; };
	po.sqlEditor = po.createSqlEditor(po.elementOfId("${pageId}-sql-editor"),
	{
		value: "${(initSql!'')?js_string?no_esc}",
		extraKeys:
		{
			"Ctrl-Enter": function()
			{
				po.elementOfId("executeSqlButton").click();
			}
		}
	});
	po.sqlEditor.focus();
	
	//数据库表条目、SQL历史拖入自动插入SQL
	$.enableTableNodeDraggable = true;
	po.elementOfId("${pageId}-sql-editor").droppable(
	{
		accept: ".table-draggable, .sql-draggable",
		drop: function(event, ui)
		{
			var draggable = ui.draggable;
			var dropText = "";
			
			var cursor = po.sqlEditor.getDoc().getCursor();
			
			if(draggable.hasClass("table-draggable"))
			{
				dropText = ui.draggable.text();
				
				if(cursor.ch == 0)
					dropText = "SELECT * FROM " +dropText;
			}
			else if(draggable.hasClass("sql-draggable"))
			{
				dropText = $(".sql-content", draggable).text();
			}
			
			if(dropText)
			{
				var delimiter = po.getSqlDelimiter();
				dropText += delimiter + "\n";
				
				po.insertCodeText(po.sqlEditor, dropText);
				po.sqlEditor.focus();
			}
		}
	});
	
	//当前在执行的SQL语句数
	po.executingSqlCount = -1;
	
	$.resizableStopPropagation(po.element(".content-editor"),
	{
		containment : "parent",
		handles : "s",
		classes : { "ui-resizable-s" : "ui-widget-header" },
		resize : function(event, ui)
		{
			var parent = ui.element.parent();
			var parentHeight = parent.height();
			var editorHeight = ui.element.height();
			var editorHeightPercent =  (editorHeight/parentHeight * 100) + "%";
			var resultHeightpercent = ((parentHeight-editorHeight)/parentHeight * 100) + "%";
			
			ui.element.css("height", editorHeightPercent);
			$(".content-result", parent).css("height", resultHeightpercent);
			
			$.resizeAutoResizable(po.sqlResultTabs, function(ele){ po.resizeAutoResizable(ele); });
		}
	});
	
	po.getSqlDelimiter = function()
	{
		var delimiter = po.elementOfId("sqlDelimiterInput").val();
		
		if(!delimiter)
			delimiter = ";";
			
		return delimiter;
	};
	
	po.requestExecuteSql = function(sql, sqlStartRow, sqlStartColumn, commitMode, exceptionHandleMode, overTimeThreashold, resultsetFetchSize)
	{
		if(!po.elementOfId("toggleAutoClearResultButton").hasClass("ui-state-active"))
			po.resultMessageElement.empty();
		
		$.ajax(
		{
			type : "POST",
			url : "${contextPath}/sqlpad/"+po.schemaId+"/execute",
			data :
			{
				"sqlpadId" : po.sqlpadId,
				"sql" : sql,
				"sqlDelimiter" : po.getSqlDelimiter(),
				"sqlStartRow" : sqlStartRow,
				"sqlStartColumn" : sqlStartColumn,
				"commitMode" : commitMode,
				"exceptionHandleMode" : exceptionHandleMode,
				"overTimeThreashold" : overTimeThreashold,
				"resultsetFetchSize" : resultsetFetchSize
			},
			error : function()
			{
				po.sqlpadTaskClient.stop();
				po.updateExecuteSqlButtonState(po.elementOfId("executeSqlButton"), "init");
			}
		});
	},
	
	po.appendSqlStatementMessage = function($msgContent, sqlStatement, sqlStatementIndex)
	{
		if(sqlStatement == null)
			return;
		
		$("<div class='sql-index'>["+(sqlStatementIndex + 1)+"]</div>").appendTo($msgContent);
		var $sqlValue = $("<div class='sql-value' />").text($.truncateIf(sqlStatement.sql, "...", 100)).appendTo($msgContent);
		
		$sqlValue.click(function()
		{
			po.sqlEditor.setSelection({line: sqlStatement.startRow, ch: sqlStatement.startColumn},
					{line: sqlStatement.endRow, ch: sqlStatement.endColumn});
		});
		
		<#assign messageArgs=['"+(sqlStatement.startRow+1)+"', '"+sqlStatement.startColumn+"', '"+(sqlStatement.endRow+1)+"', '"+sqlStatement.endColumn+"'] />
		$sqlValue.attr("title", "<@spring.messageArgs code='sqlpad.executionSqlselectionRange' args=messageArgs />");
	};
	
	po.appendSQLExecutionStatMessage = function($msgContent, sqlExecutionStat)
	{
		if(sqlExecutionStat == null)
			return;
		
		var text = "<@spring.message code='sqlpad.sqlExecutionStat.quoteLeft' />";
		
		<#assign messageArgs=['"+(sqlExecutionStat.totalCount)+"', '"+sqlExecutionStat.successCount+"', '"+(sqlExecutionStat.exceptionCount)+"', '"+(sqlExecutionStat.abortCount)+"'] />
		text += "<@spring.messageArgs code='sqlpad.sqlExecutionStat.infoNoDuration' args=messageArgs />";
		
		if(sqlExecutionStat.sqlDuration >= 0)
		{
			<#assign messageArgs=['"+po.formatDuration(sqlExecutionStat.sqlDuration)+"'] />
			text += "<@spring.messageArgs code='sqlpad.sqlExecutionStat.infoSqlDurationSuffix' args=messageArgs />";
		}
		
		if(sqlExecutionStat.taskDuration >= 0)
		{
			<#assign messageArgs=['"+po.formatDuration(sqlExecutionStat.taskDuration)+"'] />
			text += "<@spring.messageArgs code='sqlpad.sqlExecutionStat.infoTaskDurationSuffix' args=messageArgs />";
		}
		
		text += "<@spring.message code='sqlpad.sqlExecutionStat.quoteRight' />";
		
		$("<div class='sql-stat' />").text(text).appendTo($msgContent);
	};
	
	po.handleMessage = function(message)
	{
		var isFinish = false;
		var msgData = message;
		var msgDataType = (msgData ? msgData.type : "");
		var $msgDiv = $("<div class='execution-message' />");
		
		if(msgData.timeText)
			$("<div class='message-time' />").html("["+msgData.timeText+"] ").appendTo($msgDiv);
		
		var $msgContent = $("<div class='message-content' />").appendTo($msgDiv);
		
		if(msgDataType == "START")
		{
			po.executingSqlCount = msgData.sqlCount;
			
			$msgDiv.addClass("execution-start");
			
			<#assign messageArgs=['"+msgData.sqlCount+"'] />
			$("<div />").html("<@spring.messageArgs code='sqlpad.executionStart' args=messageArgs />").appendTo($msgContent);
		}
		else if(msgDataType == "SQLSUCCESS")
		{
			$msgDiv.addClass("execution-success");
			
			po.appendSqlStatementMessage($msgContent, msgData.sqlStatement, msgData.sqlStatementIndex);
			
			if(msgData.sqlResultType == "UPDATE_COUNT")
			{
				<#assign messageArgs=['"+msgData.updateCount+"'] />
				$("<div class='sql-update-count' />").text("<@spring.messageArgs code='sqlpad.affectDataRowCount' args=messageArgs />")
						.appendTo($msgContent);
			}
			else if(msgData.sqlResultType == "RESULT_SET")
			{
				var tabId = po.elementOfId("lockSqlResultTabButton").attr("lock-tab-id");
				
				if(!tabId)
					tabId = po.genSqlResultTabId();
				
				po.renderSqlResultTab(tabId, msgData.sqlStatement.sql, msgData.sqlSelectResult, (po.executingSqlCount == 1));
				
				$("<a href='javascript:void(0);' class='sql-result-link link' />")
					.html("<@spring.message code='sqlpad.viewResult' />")
					.attr("tab-id", tabId)
					.data("sql", msgData.sqlStatement.sql)
					.appendTo($msgContent)
					.click(function()
					{
						var $this = $(this);
						
						var tabId = $this.attr("tab-id");
						var sql = $this.data("sql");
						
						var tab  = po.tabsGetTabById(po.sqlResultTabs, tabId);
						
						if(tab.length == 0)
						{
							$.tipInfo("<@spring.message code='sqlpad.selectResultExpired' />");
							return;
						}
						
						var tabPanel = po.tabsGetPaneByTabId(po.sqlResultTabs, tabId);
						var tabForm = po.elementOfId(po.getSqlResultTabPanelFormId(tabId), tabPanel);
						var tabSql = po.elementOfName("sql", tabForm).val();
						
						var sqlEquals = (sql == tabSql);
						if(!sqlEquals)
							sqlEquals = (sql.replace(/\s/g, "") == tabSql.replace(/\s/g, ""));
						
						if(!sqlEquals)
						{
							$.tipInfo("<@spring.message code='sqlpad.selectResultExpired' />");
							return;
						}
						
						po.sqlResultTabs.tabs( "option", "active",  tab.index());
					});
			}
			else
				;
		}
		else if(msgDataType == "SQLEXCEPTION")
		{
			$msgDiv.addClass("execution-exception");
			
			po.appendSqlStatementMessage($msgContent, msgData.sqlStatement, msgData.sqlStatementIndex);
			
			var $seInfoSummary = $("<div class='sql-exception-summary' />").html(msgData.content).appendTo($msgContent);
			if(msgData.detailTrace)
			{
				$seInfoSummary.addClass("has-detail");
				$("<div class='sql-exception-detail' />").text(msgData.detailTrace).appendTo($msgContent);
				
				$seInfoSummary.click(function(event)
				{
					var $this = $(this);
					
					var uid = $this.attr("uid");
					if(!uid)
					{
						uid = $.uid();
						$this.attr("uid", uid);
					}
					
					var $seDetailPanel = po.elementOfId("sqlExceptionDetailPanel");
					var $seDetailContent = $(".sql-exception-detail-content", $seDetailPanel);
					
					if(!$seDetailPanel.is(":hidden") && uid == $seDetailPanel.attr("uid"))
						$seDetailPanel.hide();
					else
					{
						$seDetailPanel.attr("uid", uid);
						
						$seDetailContent.empty();
						$("<pre />").text($this.next(".sql-exception-detail").text()).appendTo($seDetailContent);
						
						//XXX "of: $this"如果$this很长的话，$seDetailPanel定位不对
						$seDetailPanel.show().position({ my : "center bottom", at : "center top", of : po.resultMessageElement});
					}
				});
			}
		}
		else if(msgDataType == "SQLCOMMAND")
		{
			var appendContent = true;
			
			if(msgData.sqlCommand == "RESUME")
			{
				po.updateExecuteSqlButtonState(po.elementOfId("executeSqlButton"), "executing");
				appendContent = false;
				$msgDiv = null;
			}
			else if(msgData.sqlCommand == "PAUSE")
			{
				po.updateExecuteSqlButtonState(po.elementOfId("executeSqlButton"), "paused");
			}
			
			if(appendContent)
			{
				$("<div />").html(msgData.content).appendTo($msgContent);
				po.appendSQLExecutionStatMessage($msgContent, msgData.sqlExecutionStat);
			}
		}
		else if(msgDataType == "EXCEPTION")
		{
			$msgDiv.addClass("execution-exception");
			
			$("<div />").html(msgData.content).appendTo($msgContent);
		}
		else if(msgDataType == "TEXT")
		{
			$msgDiv.addClass("execution-text");
			
			if(msgData.cssClass)
				$msgContent.addClass(msgData.cssClass);
			
			$("<div />").html(msgData.text).appendTo($msgContent);
			po.appendSQLExecutionStatMessage($msgContent, msgData.sqlExecutionStat);
		}
		else if(msgDataType == "FINISH")
		{
			isFinish = true;
			po.executingSqlCount = -1;
			
			$msgDiv.addClass("execution-finish");
			
			$("<div />").html("<@spring.message code='sqlpad.executeionFinish' />").appendTo($msgContent);
			po.appendSQLExecutionStatMessage($msgContent, msgData.sqlExecutionStat);
			
			po.updateExecuteSqlButtonState(po.elementOfId("executeSqlButton"), "init");
		}
		else
			$msgDiv = null;
		
		if($msgDiv)
		{
			$msgDiv.appendTo(po.resultMessageElement);
			po.resultMessageElement.scrollTop(po.resultMessageElement.prop("scrollHeight"));
		}
		
		//如果在暂停，则应挂起（比如暂停时执行命令）；否则，应唤醒（比如暂停超时）
		if(po.isExecutionStatePaused())
			po.sqlpadTaskClient.suspend();
		else
			po.sqlpadTaskClient.resume();
		
		return isFinish;
	};
	
	po.sendSqlCommand = function(sqlCommand, $commandButton)
	{
		if($commandButton != undefined)
			$commandButton.button("disable");
		
		$.ajax(
		{
			type : "POST",
			url : "${contextPath}/sqlpad/"+po.schemaId+"/command",
			data :
			{
				"sqlpadId" : po.sqlpadId,
				"command" : sqlCommand
			},
			complete : function()
			{
				if($commandButton != undefined)
					$commandButton.button("enable");
			}
		});
	};
	
	po.updateExecuteSqlButtonState = function($executeSqlButton, state)
	{
		if(state == "paused")
		{
			$executeSqlButton.attr("execution-state", "paused").attr("title", "<@spring.message code='sqlpad.resumeExecutionWithShortcut' />");
			$(".ui-button-icon", $executeSqlButton).removeClass("ui-icon-pause").addClass("ui-icon-play");
		}
		else if(state == "executing")
		{
			$executeSqlButton.attr("execution-state", "executing").attr("title", "<@spring.message code='sqlpad.pauseExecutionWithShortcut' />");
			$(".ui-button-icon", $executeSqlButton).removeClass("ui-icon-play").addClass("ui-icon-pause");
		}
		else if(state == "init")
		{
			$executeSqlButton.removeAttr("execution-state").attr("title", "<@spring.message code='sqlpad.executeWithShortcut' />");
			$(".ui-button-icon", $executeSqlButton).removeClass("ui-icon-pause").addClass("ui-icon-play");
		}
	};
	
	po.sqlResultTabTemplate = "<li class='sql-result-tab' style='vertical-align:middle;'><a href='"+'#'+"{href}'>"+'#'+"{label}</a>"
		+"<div class='tab-operation'>"
		+"<span class='ui-icon ui-icon-close' title='<@spring.message code='close' />'>close</span>"
		+"<div class='tabs-more-operation-button' title='<@spring.message code='moreOperation' />'><span class='ui-icon ui-icon-caret-1-e'></span></div>"
		+"</div>"
		+"</li>";
	
	po.getSqlResultTabPanelTableId = function(tabId)
	{
		return tabId + "-table";
	};
	
	po.getSqlResultTabPanelFormId = function(tabId)
	{
		return tabId + "-form";
	};
	
	po.renderSqlResultTab = function(tabId, sql, sqlSelectResult, active)
	{
		var tab = po.tabsGetTabById(po.sqlResultTabs, tabId);
		var tabPanel = null;
		
		if(tab.length > 0)
	    {
			tabPanel = po.tabsGetPaneByTabId(po.sqlResultTabs, tabId);
			tabPanel.empty();
	    }
	    else
	    {
	    	var nameSeq = po.getNextSqlResultNameSeq();
	    	<#assign messageArgs=['"+nameSeq+"'] />
	    	var tabLabel = "<@spring.messageArgs code='sqlpad.selectResultWithIndex' args=messageArgs />";
	    	
	    	tab = $(po.sqlResultTabTemplate.replace( /#\{href\}/g, "#" + tabId).replace(/#\{label\}/g, tabLabel)).attr("id", $.uid("sqlResult-tab-"))
	    		.appendTo(po.tabsGetNav(po.sqlResultTabs));
	    	
	    	tabPanel = $("<div id='"+tabId+"' class='sql-result-tab-panel' />").appendTo(po.sqlResultTabs);
	    	
    	    $(".tab-operation .ui-icon-close", tab).click(function()
    	    {
    	    	po.tabsCloseTab(po.sqlResultTabs, $(this).parent().parent());
    	    });
    	    
    	    $(".tab-operation .tabs-more-operation-button", tab).click(function()
    	    {
    	    	var tab = $(this).parent().parent();
    	    	po.tabsShowMoreOptMenu(po.sqlResultTabs, tab, $(this));
    	    });
	    }
		
	    po.sqlResultTabs.tabs("refresh");
		
	    if(active)
	    	po.sqlResultTabs.tabs( "option", "active",  tab.index());
	    else
	    {
	    	$.resizeAutoResizableOnShow(tabPanel, true);
	    	po.tabsRefreshNavForHidden(po.sqlResultTabs);
	    }
	    
		var table = $("<table width='100%' class='hover stripe'></table>").attr("id", po.getSqlResultTabPanelTableId(tabId)).appendTo(tabPanel);
		po.initSqlResultDataTable(tabId, table, sql, sqlSelectResult);
		
		$("<div class='no-more-data-flag ui-widget ui-widget-content' />")
			.attr("title", "<@spring.message code='sqlpad.noMoreData' />").appendTo(tabPanel);
		
	    var form = $("<form style='display:none;' />")
	    	.attr("id", po.getSqlResultTabPanelFormId(tabId))
	    	.attr("action", "${contextPath}/sqlpad/"+po.schemaId+"/select")
	    	.attr("method", "POST")
	    	.attr("tab-id", tabId)
	    	.appendTo(tabPanel);
	    
	    $("<input name='sqlpadId' type='hidden' />").val(po.sqlpadId).appendTo(form);
	    $("<textarea name='sql' />").val(sql).appendTo(form);
	    $("<input name='startRow' type='hidden' />").val(sqlSelectResult.nextStartRow).appendTo(form);

	    if(sqlSelectResult.rows == null || sqlSelectResult.rows.length < sqlSelectResult.fetchSize)
	    {
	    	form.attr("no-more-data", "1");
	    	$(".no-more-data-flag", tabPanel).show();
	    }
	    
	    form.submit(function()
	    {
	    	var $this = $(this);
	    	
	    	if("1" == $this.attr("no-more-data"))
	    	{
	    		$.tipInfo("<@spring.message code='sqlpad.noMoreData' />");
	    	}
	    	else
	    	{
		    	po.elementOfId("moreSqlResultTabButton").button("disable");
		    	po.elementOfId("refreshSqlResultTabButton").button("disable");
		    	
		    	$this.ajaxSubmitJson(
	   			{
	   				handleData: function(data)
	   				{
	   					var fetchSize = po.getResultsetFetchSize(po.elementOfId("settingForm"));
	   					data.fetchSize = fetchSize;
	   				},
	   				success : function(sqlSelectResult, statusText, xhr)
	   				{
	   					po.elementOfName("startRow", $this).val(sqlSelectResult.nextStartRow);
	   					
	   					var tabId = $this.attr("tab-id");
	   					var tabPanel = po.tabsGetPaneByTabId(po.sqlResultTabs, tabId);
	   					
	   					var dataTable = po.elementOfId(po.getSqlResultTabPanelTableId(tabId), tabPanel).DataTable();
	   					
	   					$.addDataTableData(dataTable, sqlSelectResult.rows, sqlSelectResult.startRow-1);
	   					
	   					if(sqlSelectResult.rows.length < sqlSelectResult.fetchSize)
	   					{
	   						$this.attr("no-more-data", "1");
	   						$(".no-more-data-flag", tabPanel).show();
	   					}
	   					else
	   					{
	   						$this.attr("no-more-data", "0");
	   						$(".no-more-data-flag", tabPanel).hide();
	   					}
	   				},
	   				complete : function()
	   				{
	   			    	po.elementOfId("moreSqlResultTabButton").button("enable");
	   			    	po.elementOfId("refreshSqlResultTabButton").button("enable");
	   				}
	   			});
	    	}
	    	
	    	return false;
	    });
	};
	
	po.renderRowNumberColumn = function(data, type, row, meta)
	{
		var row = meta.row;
		
		if(row.length > 0)
			row = row[0];
		
		return row + 1;
	};
	
	po.viewSqlResultLongText = function(target)
	{
		target = $(target);
		var value = $("span", target).text();
		
		var panel = po.elementOfId("viewLongTextResultPanel");
		$("textarea", panel).val(value);
		panel.show().position({ my : "left bottom", at : "left top-5", of : target});
	};
	
	po.resizeAutoResizable = function(ele)
	{
		ele = $(ele);
		
		if(ele.is("table"))
		{
			var height = po.evalSqlResultTableHeight(ele);
			$.updateDataTableHeight(ele, height, true);
		}
	};
	
	po.evalSqlResultTableHeight = function(ele)
	{
		return $(ele).closest(".ui-tabs-panel").height() - 37;
	};
	
	po.initSqlResultDataTable = function(tabId, $table, sql, sqlSelectResult)
	{
		var dtColumns = $.buildDataTablesColumns(sqlSelectResult.table,
		{
			postRender : function(data, type, rowData, meta, rowIndex, renderValue, table, column, thisColumn)
			{
				if(!data)
					return renderValue;
				
				if($.tableMeta.isBinaryColumn(column))
				{
					if(rowIndex < po.sqlResultReadActualBinaryRows)
					{
						return "<a href='${contextPath}/sqlpad/"+po.schemaId+"/downloadResultField?sqlpadId="+po.sqlpadId+"&value="+encodeURIComponent(data)+"'>"
								+ $.escapeHtml(po.sqlResultBinaryPlaceholder) + "</a>";
					}
					else
						return renderValue;
				}
				else if(data != renderValue)
				{
					return "<a href='javascript:void(0);' onclick='${pageId}.viewSqlResultLongText(this)' auto-close-prevent='view-long-text-result-panel' class='view-sql-result-long-text-link'>"
							+ renderValue
							+ "<span style='display:none;'>"+$.escapeHtml(data)+"</span>" + "</a>";
				}
				else
					return renderValue;
			}
		});
		
		var newDtColumns = [
			{
				title: "<@spring.message code='rowNumber' />", data: null, defaultContent: "",
				render: po.renderRowNumberColumn, className: "column-row-number", width: "5em"
			}
		];
		newDtColumns = newDtColumns.concat(dtColumns);
		
		var settings =
		{
			"columns" : newDtColumns,
			"data" : (sqlSelectResult.rows ? sqlSelectResult.rows : []),
			"scrollX": true,
			"autoWidth": true,
			"scrollY" : po.evalSqlResultTableHeight($table),
	        "scrollCollapse": false,
			"paging" : false,
			"searching" : false,
			"ordering": false,
			"select" : { style : 'os' },
		    "language":
		    {
				"emptyTable": "<@spring.message code='dataTables.noData' />",
				"zeroRecords" : "<@spring.message code='dataTables.zeroRecords' />"
			}
		};
		
		po.initTable(settings, $table);
		$.resizeAutoResizable(po.elementOfId(tabId), function(ele){ po.resizeAutoResizable(ele); });
	};
	
	po.getNextSqlResultNameSeq = function()
	{
		if(po.tabsGetTabCount(po.sqlResultTabs) == 1)
			po.nextSqlResultNameSeq = null;
		
		var seq = (po.nextSqlResultNameSeq == null ? 1 : po.nextSqlResultNameSeq);
		po.nextSqlResultNameSeq = seq + 1;
		
		return seq;
	};
	
	po.genSqlResultTabId = function()
	{
		var seq = (po.nextSqlResultIdSeq == null ? 0 : po.nextSqlResultIdSeq);
		po.nextSqlResultIdSeq = seq + 1;
		
		return "${pageId}-sqlResultTabs-tab-" + seq;
	};
	
	po.getOverTimeThreashold = function($form)
	{
		var overTimeThreashold = parseInt(po.elementOfName("overTimeThreashold", $form).val());
		
		if(isNaN(overTimeThreashold))
			overTimeThreashold = 10;
		else if(overTimeThreashold < 1)
			overTimeThreashold = 1;
		else if(overTimeThreashold > 60)
			overTimeThreashold = 60;
		
		return overTimeThreashold;
	};
	
	po.getResultsetFetchSize = function($form)
	{
		var resultsetFetchSize = parseInt(po.elementOfName("resultsetFetchSize", $form).val());
		
		if(isNaN(resultsetFetchSize))
			resultsetFetchSize = 20;
		else if(resultsetFetchSize < 1)
			resultsetFetchSize = 1;
		else if(resultsetFetchSize > 1000)
			resultsetFetchSize = 1000;
		
		return resultsetFetchSize;
	};
	
	po.isExecutionStatePaused = function()
	{
		var executionState = po.elementOfId("executeSqlButton").attr("execution-state");
		
		return (executionState == "paused");
	};
	
	po.elementOfId("executeSqlButton").click(function()
	{
		var $this = $(this);
		
		var executionState = $this.attr("execution-state");
		
		if(executionState == "executing")
		{
			po.sendSqlCommand("PAUSE", $this);
		}
		else if(executionState == "paused")
		{
			po.sqlpadTaskClient.resume();
			po.sendSqlCommand("RESUME", $this);
		}
		else
		{
			var selInfo = po.getSelectedCodeInfo(po.sqlEditor);
			
			var sql = (selInfo.text ? selInfo.text : po.getCodeText(po.sqlEditor));
			var sqlStartRow = (selInfo.text && selInfo.from ? selInfo.from.line : po.sqlEditor.getDoc().firstLine());
			var sqlStartColumn = (selInfo.text && selInfo.from ? selInfo.from.ch : 0);
			
			if(!sql)
				return;
			
			if(po.sqlpadTaskClient.isActive())
				return;
			
			var settingForm = po.elementOfId("settingForm");
			
			var commitMode = po.element("[name='sqlCommitMode']:checked", settingForm).val();
			var exceptionHandleMode = po.element("[name='sqlExceptionHandleMode']:checked", settingForm).val();
			var overTimeThreashold = po.getOverTimeThreashold(settingForm);
			var resultsetFetchSize = po.getResultsetFetchSize(settingForm);
			
			po.updateExecuteSqlButtonState($this, "executing");
			
			po.sqlpadTaskClient.start();
			po.requestExecuteSql(sql, sqlStartRow, sqlStartColumn, commitMode, exceptionHandleMode, overTimeThreashold, resultsetFetchSize);
		}
		
		po.sqlEditor.focus();
	});
	
	po.elementOfId("stopSqlButton").click(function()
	{
		if(po.sqlpadTaskClient.isActive())
		{
			//如果挂起，则应唤醒接收命令响应
			if(po.sqlpadTaskClient.isSuspend())
				po.sqlpadTaskClient.resume();
			
			po.sendSqlCommand("STOP", $(this));
		}
		
		po.sqlEditor.focus();
	});
	
	po.elementOfId("commitSqlButton").click(function()
	{
		if(po.sqlpadTaskClient.isActive())
		{
			//如果挂起，则应唤醒接收命令响应
			if(po.sqlpadTaskClient.isSuspend())
				po.sqlpadTaskClient.resume();
			
			po.sendSqlCommand("COMMIT", $(this));
		}
		
		po.sqlEditor.focus();
	});
	
	po.elementOfId("rollbackSqlButton").click(function()
	{
		if(po.sqlpadTaskClient.isActive())
		{
			//如果挂起，则应唤醒接收命令响应
			if(po.sqlpadTaskClient.isSuspend())
				po.sqlpadTaskClient.resume();
			
			po.sendSqlCommand("ROLLBACK", $(this));
		}
		
		po.sqlEditor.focus();
	});
	
	po.elementOfId("clearSqlButton").click(function()
	{
		po.sqlEditor.setValue("");
		po.sqlEditor.focus();
	});
	
	po.elementOfId("insertSqlDelimiterDefineButton").click(function()
	{
		var delimiter = po.getSqlDelimiter();
		
		if(delimiter)
		{
			var text = "";
			
			var cursor = po.sqlEditor.getDoc().getCursor();
			
			if(cursor.ch == 0)
			{
				if(cursor.line != 0)
					text += "\n";
			}
			else
				text += "\n\n";
			
			text += "--@DELIMITER "+delimiter+"\n";
			
			po.insertCodeText(po.sqlEditor, text);
		}
		
		po.sqlEditor.focus();
	});
	
	po.elementOfId("insertSqlDelimiterButton").click(function()
	{
		var delimiter = po.getSqlDelimiter();
		
		if(delimiter)
			po.insertCodeText(po.sqlEditor, delimiter+"\n");
		
		po.sqlEditor.focus();
	});
	
	po.elementOfId("viewSqlHistorySearchForm").submit(function()
	{
		var $form = $(this);
		
		$form.ajaxSubmitJson(
		{
			success : function(pagingData)
			{
				var sqlHistories = pagingData.items;
				
				if(pagingData.page >= pagingData.pages)
					po.elementOfId("sqlHistoryLoadMoreButton").button("disable");
				else
					po.elementOfId("sqlHistoryLoadMoreButton").button("enable");
				
				var retainData = ($form.attr("retain-data") != null);
				if(retainData)
					$form.removeAttr("retain-data");
				
				var $hl = po.element(".sql-history-list");
				
				if(!retainData)
					$hl.empty();
				
				for(var i=0; i<sqlHistories.length; i++)
				{
					var sqlHistory = sqlHistories[i];
					
					if(i > 0 || pagingData.page > 1)
						$("<div class='sql-item-separator ui-widget ui-widget-content' />").appendTo($hl);
					
					var $item = $("<div class='sql-item' />").appendTo($hl);
					$("<div class='sql-date' />").text(sqlHistory.createTime).appendTo($item);
					$("<div class='sql-content' />").text(sqlHistory.sql).appendTo($item);
					
					$item.draggable(
					{
						helper: "clone",
						distance: 50,
						classes:
						{
							"ui-draggable" : "sql-draggable",
							"ui-draggable-dragging" : "ui-widget ui-widget-content ui-corner-all ui-widget-shadow sql-draggable-helper ui-front"
						}
					});
				}
			}
		});
		
		return false;
	});
	
	po.element(".sql-history-list").on("click", ".sql-item", function()
	{
		var $this = $(this);
		
		if($this.hasClass("ui-state-active"))
			$this.removeClass("ui-state-active");
		else
		{
			po.element(".sql-history-list .sql-item.ui-state-active").removeClass("ui-state-active");
			$this.addClass("ui-state-active");
		}
	});
	
	po.getSelectedSqlHistories = function()
	{
		var $selectedSql = po.element(".sql-history-list .sql-item.ui-state-active");
		
		if($selectedSql.length == 0)
			return null;
		
		var delimiter = po.getSqlDelimiter();
		
		var sql = "";
		
		$selectedSql.each(function()
		{
			var mySql = $(".sql-content", this).text();
			sql += mySql + delimiter + "\n";
		});
		
		return sql;
	};
	
	po.elementOfId("insertSqlHistoryToEditorButton").click(function()
	{
		var sql = po.getSelectedSqlHistories();
		
		if(!sql)
			return;
		
		po.insertCodeText(po.sqlEditor, sql);
		po.sqlEditor.focus();
	});
	
	var clipboard = new ClipboardJS(po.elementOfId("copySqlHistoryToClipbordButton")[0],
	{
		text: function(trigger)
		{
			var sql = po.getSelectedSqlHistories();
			
			if(!sql)
				sql = "";
			
			return sql;
		}
	});
	clipboard.on('success', function(e)
	{
		$.tipSuccess("<@spring.message code='copyToClipboardSuccess' />");
	});
	
	po.elementOfId("sqlHistoryLoadMoreButton").click(function()
	{
		var $form = po.elementOfId("viewSqlHistorySearchForm");
		var $page = po.elementOfName("page", $form);
		
		var page = parseInt($page.val());
		if(!page)
			page = 1;
		page += 1;
		
		$page.val(page);
		
		$form.attr("retain-data", "1");
		$form.submit();
	});
	
	po.elementOfId("sqlHistoryRefreshButton").click(function()
	{
		var $form = po.elementOfId("viewSqlHistorySearchForm");
		po.elementOfName("page", $form).val("1");
		
		$form.submit();
	});
	
	po.elementOfId("viewSqlHistoryButton").click(function()
	{
		var $vhp = po.element(".view-sql-history-panel");
		
		if(!$vhp.is(":hidden"))
		{
			$vhp.hide();
			return;
		}
		else
		{
			var $shl = po.element(".sql-history-list");
			$shl.height(po.element().height()/2.5);
			$vhp.show();
			
			var $hl = po.element(".sql-history-list");
			if($hl.children().length == 0)
				po.elementOfId("viewSqlHistorySearchForm").submit();
		}
	});
	
	po.elementOfId("settingButton").click(function()
	{
		po.element(".setting-panel").toggle();
	});
	
	po.elementOfName("sqlCommitMode").change(function()
	{
		var value = $(this).val();
		
		if(value == "MANUAL")
		{
			//po.elementOfId("commitSqlButton").button("enable");
			//po.elementOfId("rollbackSqlButton").button("enable");
			
			var $rollbackExceptionHandle = po.element("[name='sqlExceptionHandleMode'][value='ROLLBACK']");
			$rollbackExceptionHandle.attr("disabled", "disabled");
			if($rollbackExceptionHandle.is(":checked"))
				po.element("[name='sqlExceptionHandleMode'][value='ABORT']").prop("checked", true);
			po.elementOfId("sqlExceptionHandleModeSet").controlgroup("refresh");
		}
		else
		{
			//po.elementOfId("commitSqlButton").button("disable");
			//po.elementOfId("rollbackSqlButton").button("disable");
			
			po.element("[name='sqlExceptionHandleMode'][value='ROLLBACK']").removeAttr("disabled");
			po.elementOfId("sqlExceptionHandleModeSet").controlgroup("refresh");
		}
	});
	
	po.elementOfId("toggleAutoClearResultButton").click(function()
	{
		var $this = $(this);
		
		if($this.hasClass("ui-state-active"))
		{
			$(this).removeClass("ui-state-active");
		}
		else
		{
			$(this).addClass("ui-state-active");
		}
	});
	
	po.elementOfId("clearSqlResultMessageButton").click(function()
	{
		po.resultMessageElement.empty();
	});
	
	po.elementOfId("moreSqlResultTabButton").click(function()
	{
		var activeTab = po.tabsGetActiveTab(po.sqlResultTabs);
		var activeTabId = po.tabsGetTabId(po.sqlResultTabs, activeTab);
		var activeTabFormId = po.getSqlResultTabPanelFormId(activeTabId);
		var activeTabForm = po.elementOfId(activeTabFormId);
		
		activeTabForm.submit();
	});
	
	po.elementOfId("refreshSqlResultTabButton").click(function()
	{
		var activeTab = po.tabsGetActiveTab(po.sqlResultTabs);
		var activeTabId = po.tabsGetTabId(po.sqlResultTabs, activeTab);
		var activeTabFormId = po.getSqlResultTabPanelFormId(activeTabId);
		var activeTabForm = po.elementOfId(activeTabFormId);
		
		po.elementOfName("startRow", activeTabForm).val(1);
		activeTabForm.attr("no-more-data", "0");
		
		activeTabForm.submit();
	});

	po.elementOfId("exportSqlResultTabButton").click(function()
	{
		var activeTab = po.tabsGetActiveTab(po.sqlResultTabs);
		
		if(activeTab.hasClass("sql-result-tab"))
		{
			var tabId = po.tabsGetTabId(po.sqlResultTabs, activeTab);
			var tabFormId = po.getSqlResultTabPanelFormId(tabId);
			var tabForm = po.elementOfId(tabId);
			var sql = po.elementOfName("sql", tabForm).val();
			
			var options = {data: {"initSqls": sql}};
			$.setGridPageHeightOption(options);
			po.open("${contextPath}/dataexchange/"+po.schemaId+"/export", options);
		}
	});
	
	po.elementOfId("viewSqlResultTabButton").click(function()
	{
		var $this = $(this);
		
		var viewSqlStatementPanel = po.elementOfId("viewSqlStatementPanel");
		
		if(!viewSqlStatementPanel.is(":hidden"))
		{
			viewSqlStatementPanel.hide();
			return;
		}
		
		var activeTab = po.tabsGetActiveTab(po.sqlResultTabs);
		
		if(activeTab.hasClass("sql-result-tab"))
		{
			var tabId = po.tabsGetTabId(po.sqlResultTabs, activeTab);
			var tabFormId = po.getSqlResultTabPanelFormId(tabId);
			var tabForm = po.elementOfId(tabId);
			var sql = po.elementOfName("sql", tabForm).val();
			
			$("textarea", viewSqlStatementPanel).val(sql);
			viewSqlStatementPanel.show().position({ my : "right bottom", at : "right top-5", of : $this});
		}
	});
	
	po.elementOfId("lockSqlResultTabButton").click(function()
	{
		var $this = $(this);
		
		if($this.hasClass("ui-state-active"))
		{
			$this.removeAttr("lock-tab-id");
			$this.removeClass("ui-state-active");
		}
		else
		{
			var activeTab = po.tabsGetActiveTab(po.sqlResultTabs);
			
			if(activeTab.hasClass("sql-result-tab"))
			{
				var tabId = po.tabsGetTabId(po.sqlResultTabs, activeTab);
				
				$this.attr("lock-tab-id", tabId);
				$this.addClass("ui-state-active");
			}
		}
	});
	
	po.validateForm(
	{
		rules :
		{
			overTimeThreashold : { integer : true, min : 1, max : 60 },
			resultsetFetchSize : { integer : true, min : 1, max : 1000 }
		},
		submitHandler : function(form)
		{
			return false;
		}
	},
	po.elementOfId("settingForm"));
	
	po.elementOfId("sqlExceptionDetailPanel").mouseleave(function()
	{
		$(this).hide();
	});
	
	po.sqlResultTabs.tabs(
	{
		event: "click",
		activate: function(event, ui)
		{
			var $this = $(this);
			var newTab = $(ui.newTab);
			var newPanel = $(ui.newPanel);
			
			po.tabsRefreshNavForHidden($this, newTab);
			
			var resultOperations = po.element(".result-operations");
			
			if(newTab.hasClass("sql-result-tab"))
			{
				$(".result-message-buttons", resultOperations).hide();
				$(".sql-result-buttons", resultOperations).show();
				
				var lockSqlResultTabButton = po.elementOfId("lockSqlResultTabButton");
				var newTabId = po.tabsGetTabId($this, newTab);
				
				if(newTabId == lockSqlResultTabButton.attr("lock-tab-id"))
					lockSqlResultTabButton.addClass("ui-state-active");
				else
					lockSqlResultTabButton.removeClass("ui-state-active");
			}
			else if(newTab.hasClass("result-message-tab"))
			{
				$(".sql-result-buttons", resultOperations).hide();
				$(".result-message-buttons", resultOperations).show();
			}
			
			$.callPanelShowCallback(newPanel);
		}
	});
	
	po.tabsGetTabMoreOptMenu(po.sqlResultTabs).menu(
	{
		select: function(event, ui)
		{
			var $this = $(this);
			var item = ui.item;
			
			po.tabsHandleMoreOptMenuSelect($this, item, po.sqlResultTabs);
			po.tabsGetTabMoreOptMenuWrapper(po.sqlResultTabs).hide();
		}
	});
	
	po.tabsGetMoreTabMenu(po.sqlResultTabs).menu(
	{
		select: function(event, ui)
		{
			po.tabsHandleMoreTabMenuSelect($(this), ui.item, po.sqlResultTabs);
	    	po.tabsGetMoreTabMenuWrapper(po.sqlResultTabs).hide();
		}
	});
	
	po.element("[name='sqlCommitMode'][value='AUTO']").click();
	po.element(".result-operations .sql-result-buttons").hide();
	
	po.tabsBindMenuHiddenEvent(po.sqlResultTabs);
})
(${pageId});
</script>
</body>
</html>