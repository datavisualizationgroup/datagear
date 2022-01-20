<#--
 *
 * Copyright 2018 datagear.tech
 *
 * Licensed under the LGPLv3 license:
 * http://www.gnu.org/licenses/lgpl-3.0.html
 *
-->
<#--
看板表单代码编辑器功能片段
-->
<script type="text/javascript">
(function(po)
{
	po.initDashboardEditors = function()
	{
		//初始化可视编辑元素文本内容面板
		var veContentPanel = po.element(".veditor-content-panel");
		veContentPanel.draggable({ handle: ".panel-head" });
		var veContentForm = po.element("form", veContentPanel);
		veContentForm.submit(function()
		{
			veContentPanel.hide();
			
			var tabPane = po.getActiveResEditorTabPane();
			var dashboardEditor = po.dashboardEditorVisual(tabPane);
			if(dashboardEditor)
			{
				var text = po.element("input[name='content']", veContentPanel).val();
				dashboardEditor.setElementText(text);
			}
			
			return false;
		});
		
		//初始化可视编辑样式面板
		var veStylePanel = po.element(".veditor-style-panel");
		veStylePanel.draggable({ handle: ".panel-head" });
		var veStyleForm = po.element("form", veStylePanel);
		veStyleForm.submit(function()
		{
			veStylePanel.hide();
			
			var tabPane = po.getActiveResEditorTabPane();
			var dashboardEditor = po.dashboardEditorVisual(tabPane);
			if(dashboardEditor)
			{
				var styleObj = $.formToJson(this);
				
				if(po.editOperationForVisualEdit == "editStyle")
					dashboardEditor.setElementStyle(styleObj);
				else if(po.editOperationForVisualEdit == "editGlobalStyle")
					dashboardEditor.setGlobalStyle(styleObj);
			}
			
			return false;
		});
		po.element(".style-tabs", veStyleForm).tabs();
		po.element(".styleBgPositionBtnGroup", veStyleForm).controlgroupwrapper();
		po.element(".styleBgSizeBtnGroup", veStyleForm).controlgroupwrapper();
		po.element(".styleBgRepeatBtnGroup", veStyleForm).controlgroupwrapper();
		po.element(".styleDisplayBtnGroup", veStyleForm).controlgroupwrapper();
		po.element(".stylePositionBtnGroup", veStyleForm).controlgroupwrapper();
		po.element(".styleFontWeightBtnGroup", veStyleForm).controlgroupwrapper();
		po.element(".styleTextAlignBtnGroup", veStyleForm).controlgroupwrapper();
		po.element("input[name='color']", veStyleForm).listpalllet(
		{
			indicator: po.element(".color-indicator", veStyleForm),
			container: po.element("input[name='color']", veStyleForm).parent(),
			position: "fixed",
			autoCloseContext: po.element()
		});
		po.element("input[name='background-color']", veStyleForm).listpalllet(
		{
			indicator: po.element(".bgcolor-indicator", veStyleForm),
			container: po.element("input[name='background-color']", veStyleForm).parent(),
			position: "fixed",
			autoCloseContext: po.element()
		});
		
		//初始化可视编辑图表主题面板
		var veChartThemePanel = po.element(".veditor-chartTheme-panel");
		veChartThemePanel.draggable({ handle: ".panel-head" });
		var veChartThemeForm = po.element("form", veChartThemePanel);
		veChartThemeForm.submit(function()
		{
			veChartThemePanel.hide();
			
			var tabPane = po.getActiveResEditorTabPane();
			var dashboardEditor = po.dashboardEditorVisual(tabPane);
			if(dashboardEditor)
			{
				var chartThemeObj = $.formToJson(this);
				
				if(po.editOperationForVisualEdit == "editChartTheme")
					dashboardEditor.setElementChartTheme(chartThemeObj);
				else if(po.editOperationForVisualEdit == "editGlobalChartTheme")
					dashboardEditor.setGlobalChartTheme(chartThemeObj);
			}
			
			return false;
		});
		po.element("input[name='color']", veChartThemeForm).listpalllet(
		{
			indicator: po.element(".color-indicator", veChartThemeForm),
			container: po.element("input[name='color']", veChartThemeForm).parent(),
			position: "fixed",
			autoCloseContext: po.element()
		});
		po.element("input[name='backgroundColor']", veChartThemeForm).listpalllet(
		{
			indicator: po.element(".bgcolor-indicator", veChartThemeForm),
			container: po.element("input[name='backgroundColor']", veChartThemeForm).parent(),
			position: "fixed",
			autoCloseContext: po.element()
		});
		po.element("input[name='actualBackgroundColor']", veChartThemeForm).listpalllet(
		{
			indicator: po.element(".actbgcolor-indicator", veChartThemeForm),
			container: po.element("input[name='actualBackgroundColor']", veChartThemeForm).parent(),
			position: "fixed",
			autoCloseContext: po.element()
		});
		veChartThemeForm.on("click", ".del-color-btn", function(event)
		{
			$(this).parent().remove();
			//阻止冒泡，不然会触发$.fn.autoCloseSubPanel函数关闭面板
			event.stopPropagation();
		});
		veChartThemeForm.on("click", ".addGraphColorsBtn", function()
		{
			po.addChartThemeFormGraphColorsItem(po.element(".graphColorsInput", veChartThemeForm));
		});
		veChartThemeForm.on("click", ".addGraphRangeColorsBtn", function()
		{
			po.addChartThemeFormGraphRangeColorsItem(po.element(".graphRangeColorsInput", veChartThemeForm));
		});
		
		po.element(".veditor-panel .form-item-value .help-src").click(function()
		{
			var $this = $(this);
			var helpValue = ($this.attr("help-value") || "");
			po.element(".help-target", $this.closest(".form-item-value")).val(helpValue);
		});
	};
	
	po.codeEditorCompletionsTagAttr =
	[
		{name: "dg-chart-auto-resize", value: "dg-chart-auto-resize=\"true\"",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-auto-resize' />", categories: ["body", "div"]},
		{name: "dg-chart-disable-setting",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-disable-setting' />", categories: ["body", "div"]},
		{name: "dg-chart-link",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-link' />", categories: ["div"]},
		{name: "dg-chart-listener",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-listener' />", categories: ["body", "div"]},
		{name: "dg-chart-map",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-map' />", categories: ["div"]},
		{name: "dg-chart-map-urls",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-map-urls' />", categories: ["body"]},
		{name: "dg-chart-on-",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-on-' />", categories: ["div"]},
		{name: "dg-chart-options",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-options' />", categories: ["body","div"]},
		{name: "dg-chart-renderer",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-renderer' />", categories: ["div"]},
		{name: "dg-chart-theme",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-theme' />", categories: ["body", "div"]},
		{name: "dg-chart-update-group",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-update-group' />", categories: ["body", "div"]},
		{name: "dg-chart-widget",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-widget' />", categories: ["div"]},
		{name: "dg-dashboard-form",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-dashboard-form' />", categories: ["form"]},
		{name: "dg-dashboard-listener",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-dashboard-listener' />", categories: ["body"]},
		{name: "dg-dashboard-var",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-dashboard-var' />", categories: ["html"]},
		{name: "dg-echarts-theme",
			displayComment: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-echarts-theme' />", categories: ["body", "div"]},
	];
	
	po.codeEditorCompletionsJsFunction =
	[
		//看板JS对象
		{name: "addChart", value: "addChart(", displayName: "addChart()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "chartIndex", value: "chartIndex(", displayName: "chartIndex()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "chartOf", value: "chartOf(", displayName: "chartOf()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "batchSetDataSetParamValues", value: "batchSetDataSetParamValues(", displayName: "batchSetDataSetParamValues()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "charts", value: "charts", displayName: "charts", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "doRender", value: "doRender()", displayName: "doRender()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "init", value: "init()", displayName: "init()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "isHandlingCharts", value: "isHandlingCharts()", displayName: "isHandlingCharts()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "listener", value: "listener(", displayName: "listener()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "loadChart", value: "loadChart(", displayName: "loadChart()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "loadCharts", value: "loadCharts(", displayName: "loadCharts()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "loadUnsolvedCharts", value: "loadUnsolvedCharts()", displayName: "loadUnsolvedCharts()", displayComment: "dashboard", categories: ["dashboard"], categories: ["dashboard"]},
		{name: "mapURLs", value: "mapURLs(", displayName: "mapURLs()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "originalInfo", value: "originalInfo(", displayName: "originalInfo()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "refreshData", value: "refreshData(", displayName: "refreshData()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "removeChart", value: "removeChart(", displayName: "removeChart()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "render", value: "render()", displayName: "render()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "renderContext", value: "renderContext", displayName: "renderContext", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "renderContextAttr", value: "renderContextAttr(", displayName: "renderContextAttr()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "renderForm", value: "renderForm(", displayName: "renderForm()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "renderedChart", value: "renderedChart(", displayName: "renderedChart()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "resizeAllCharts", value: "resizeAllCharts()", displayName: "resizeAllCharts()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "resizeChart", value: "resizeChart(", displayName: "resizeChart()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "resultDataFormat", value: "resultDataFormat(", displayName: "resultDataFormat()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "serverDate", value: "serverDate()", displayName: "serverDate()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "startHandleCharts", value: "startHandleCharts()", displayName: "startHandleCharts()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "stopHandleCharts", value: "stopHandleCharts()", displayName: "stopHandleCharts()", displayComment: "dashboard", categories: ["dashboard"]},
		{name: "user", value: "user()", displayName: "user()", displayComment: "dashboard", categories: ["dashboard"]},
		
		//图表JS对象
		{name: "autoResize", value: "autoResize(", displayName: "autoResize() ", displayComment: "chart", categories: ["chart"], categories: ["chart"]},
		{name: "bindLinksEventHanders", value: "bindLinksEventHanders(", displayName: "bindLinksEventHanders() ", displayComment: "chart", categories: ["chart"]},
		{name: "callEventHandler", value: "callEventHandler(", displayName: "callEventHandler() ", displayComment: "chart", categories: ["chart"]},
		{name: "chartDataSetAt", value: "chartDataSetAt(", displayName: "chartDataSetAt() ", displayComment: "chart", categories: ["chart"]},
		{name: "chartDataSetFirst", value: "chartDataSetFirst(", displayName: "chartDataSetFirst() ", displayComment: "chart", categories: ["chart"]},
		{name: "chartDataSets", value: "chartDataSets", displayName: "chartDataSets ", displayComment: "chart", categories: ["chart"]},
		{name: "chartDataSetsAttachment", value: "chartDataSetsAttachment()", displayName: "chartDataSetsAttachment() ", displayComment: "chart", categories: ["chart"]},
		{name: "chartDataSetsMain", value: "chartDataSetsMain()", displayName: "chartDataSetsMain() ", displayComment: "chart", categories: ["chart"]},
		{name: "dashboard", value: "dashboard", displayName: "dashboard ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetAlias", value: "dataSetAlias(", displayName: "dataSetAlias() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetParam", value: "dataSetParam(", displayName: "dataSetParam() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetParamValue", value: "dataSetParamValue(", displayName: "dataSetParamValue() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetParamValueFirst", value: "dataSetParamValueFirst(", displayName: "dataSetParamValueFirst() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetParamValues", value: "dataSetParamValues(", displayName: "dataSetParamValues() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetParamValuesFirst", value: "dataSetParamValuesFirst(", displayName: "dataSetParamValuesFirst() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetParams", value: "dataSetParams(", displayName: "dataSetParams() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetProperties", value: "dataSetProperties(", displayName: "dataSetProperties() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetPropertiesOfSign", value: "dataSetPropertiesOfSign(", displayName: "dataSetPropertiesOfSign() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetProperty", value: "dataSetProperty(", displayName: "dataSetProperty() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetPropertyAlias", value: "dataSetPropertyAlias(", displayName: "dataSetPropertyAlias() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetPropertyOfSign", value: "dataSetPropertyOfSign(", displayName: "dataSetPropertyOfSign() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetPropertyOrder", value: "dataSetPropertyOrder(", displayName: "dataSetPropertyOrder() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetPropertySign", value: "dataSetPropertySign(", displayName: "dataSetPropertySign() ", displayComment: "chart", categories: ["chart"]},
		{name: "dataSetPropertySigns", value: "dataSetPropertySigns(", displayName: "dataSetPropertySigns() ", displayComment: "chart", categories: ["chart"]},
		{name: "destroy", value: "destroy()", displayName: "destroy() ", displayComment: "chart", categories: ["chart"]},
		{name: "disableSetting", value: "disableSetting(", displayName: "disableSetting() ", displayComment: "chart", categories: ["chart"]},
		{name: "doRender", value: "doRender()", displayName: "doRender() ", displayComment: "chart", categories: ["chart"]},
		{name: "doUpdate", value: "doUpdate(", displayName: "doUpdate() ", displayComment: "chart", categories: ["chart"]},
		{name: "echartsGetThemeName", value: "echartsGetThemeName()", displayName: "echartsGetThemeName() ", displayComment: "chart", categories: ["chart"]},
		{name: "echartsInit", value: "echartsInit(", displayName: "echartsInit() ", displayComment: "chart", categories: ["chart"]},
		{name: "echartsLoadMap", value: "echartsLoadMap(", displayName: "echartsLoadMap() ", displayComment: "chart", categories: ["chart"]},
		{name: "echartsMapRegistered", value: "echartsMapRegistered(", displayName: "echartsMapRegistered() ", displayComment: "chart", categories: ["chart"]},
		{name: "echartsOffEventHandler", value: "echartsOffEventHandler(", displayName: "echartsOffEventHandler() ", displayComment: "chart", categories: ["chart"]},
		{name: "echartsOptions", value: "echartsOptions(", displayName: "echartsOptions() ", displayComment: "chart", categories: ["chart"]},
		{name: "echartsThemeName", value: "echartsThemeName(", displayName: "echartsThemeName() ", displayComment: "chart", categories: ["chart"]},
		{name: "element", value: "element()", displayName: "element() ", displayComment: "chart", categories: ["chart"]},
		{name: "elementId", value: "elementId", displayName: "elementId ", displayComment: "chart", categories: ["chart"]},
		{name: "elementJquery", value: "elementJquery()", displayName: "elementJquery() ", displayComment: "chart", categories: ["chart"]},
		{name: "elementStyle", value: "elementStyle(", displayName: "elementStyle() ", displayComment: "chart", categories: ["chart"]},
		{name: "elementWidgetId", value: "elementWidgetId()", displayName: "elementWidgetId() ", displayComment: "chart", categories: ["chart"]},
		{name: "eventData", value: "eventData(", displayName: "eventData() ", displayComment: "chart", categories: ["chart"]},
		{name: "eventHandlers", value: "eventHandlers(", displayName: "eventHandlers() ", displayComment: "chart", categories: ["chart"]},
		{name: "eventNewEcharts", value: "eventNewEcharts(", displayName: "eventNewEcharts() ", displayComment: "chart", categories: ["chart"]},
		{name: "eventNewHtml", value: "eventNewHtml(", displayName: "eventNewHtml() ", displayComment: "chart", categories: ["chart"]},
		{name: "eventOriginalChartDataSetIndex", value: "eventOriginalChartDataSetIndex(", displayName: "eventOriginalChartDataSetIndex() ", displayComment: "chart", categories: ["chart"]},
		{name: "eventOriginalData", value: "eventOriginalData(", displayName: "eventOriginalData() ", displayComment: "chart", categories: ["chart"]},
		{name: "eventOriginalInfo", value: "eventOriginalInfo(", displayName: "eventOriginalInfo() ", displayComment: "chart", categories: ["chart"]},
		{name: "eventOriginalResultDataIndex", value: "eventOriginalResultDataIndex(", displayName: "eventOriginalResultDataIndex() ", displayComment: "chart", categories: ["chart"]},
		{name: "extValue", value: "extValue(", displayName: "extValue() ", displayComment: "chart", categories: ["chart"]},
		{name: "gradualColor", value: "gradualColor(", displayName: "gradualColor() ", displayComment: "chart", categories: ["chart"]},
		{name: "handleChartEventLink", value: "handleChartEventLink(", displayName: "handleChartEventLink() ", displayComment: "chart", categories: ["chart"]},
		{name: "hasDataSetParam", value: "hasDataSetParam()", displayName: "hasDataSetParam() ", displayComment: "chart", categories: ["chart"]},
		{name: "id", value: "id", displayName: "id ", displayComment: "chart", categories: ["chart"]},
		{name: "inflateRenderOptions", value: "inflateRenderOptions(", displayName: "inflateRenderOptions() ", displayComment: "chart", categories: ["chart"]},
		{name: "inflateUpdateOptions", value: "inflateUpdateOptions(", displayName: "inflateUpdateOptions() ", displayComment: "chart", categories: ["chart"]},
		{name: "init", value: "init()", displayName: "init() ", displayComment: "chart", categories: ["chart"]},
		{name: "internal", value: "internal()", displayName: "internal( ", displayComment: "chart", categories: ["chart"]},
		{name: "isActive", value: "isActive()", displayName: "isActive() ", displayComment: "chart", categories: ["chart"]},
		{name: "isAsyncRender", value: "isAsyncRender()", displayName: "isAsyncRender() ", displayComment: "chart", categories: ["chart"]},
		{name: "isAsyncUpdate", value: "isAsyncUpdate()", displayName: "isAsyncUpdate() ", displayComment: "chart", categories: ["chart"]},
		{name: "isDataSetParamValueReady", value: "isDataSetParamValueReady()", displayName: "isDataSetParamValueReady() ", displayComment: "chart", categories: ["chart"]},
		{name: "isInstance", value: "isInstance(", displayName: "isInstance() ", displayComment: "chart", categories: ["chart"]},
		{name: "links", value: "links(", displayName: "links() ", displayComment: "chart", categories: ["chart"]},
		{name: "listener", value: "listener(", displayName: "listener() ", displayComment: "chart", categories: ["chart"]},
		{name: "loadMap", value: "loadMap(", displayName: "loadMap() ", displayComment: "chart", categories: ["chart"]},
		{name: "map", value: "map(", displayName: "map() ", displayComment: "chart", categories: ["chart"]},
		{name: "mapURL", value: "mapURL(", displayName: "mapURL() ", displayComment: "chart", categories: ["chart"]},
		{name: "name", value: "name", displayName: "name ", displayComment: "chart", categories: ["chart"]},
		{name: "off", value: "off(", displayName: "off() ", displayComment: "chart", categories: ["chart"]},
		{name: "on", value: "on(", displayName: "on() ", displayComment: "chart", categories: ["chart"]},
		{name: "onClick", value: "onClick(", displayName: "onClick() ", displayComment: "chart", categories: ["chart"]},
		{name: "onDblclick", value: "onDblclick(", displayName: "onDblclick() ", displayComment: "chart", categories: ["chart"]},
		{name: "onMousedown", value: "onMousedown(", displayName: "onMousedown() ", displayComment: "chart", categories: ["chart"]},
		{name: "onMouseout", value: "onMouseout(", displayName: "onMouseout() ", displayComment: "chart", categories: ["chart"]},
		{name: "onMouseover", value: "onMouseover(", displayName: "onMouseover() ", displayComment: "chart", categories: ["chart"]},
		{name: "onMouseup", value: "onMouseup(", displayName: "onMouseup() ", displayComment: "chart", categories: ["chart"]},
		{name: "options", value: "options(", displayName: "options() ", displayComment: "chart", categories: ["chart"]},
		{name: "originalInfo", value: "originalInfo(", displayName: "originalInfo() ", displayComment: "chart", categories: ["chart"]},
		{name: "plugin", value: "plugin", displayName: "plugin ", displayComment: "chart", categories: ["chart"]},
		{name: "refreshData", value: "refreshData()", displayName: "refreshData() ", displayComment: "chart", categories: ["chart"]},
		{name: "registerEventHandlerDelegation", value: "registerEventHandlerDelegation(", displayName: "registerEventHandlerDelegation() ", displayComment: "chart", categories: ["chart"]},
		{name: "removeEventHandlerDelegation", value: "removeEventHandlerDelegation(", displayName: "removeEventHandlerDelegation() ", displayComment: "chart", categories: ["chart"]},
		{name: "render", value: "render()", displayName: "render() ", displayComment: "chart", categories: ["chart"]},
		{name: "renderContext", value: "renderContext", displayName: "renderContext ", displayComment: "chart", categories: ["chart"]},
		{name: "renderContextAttr", value: "renderContextAttr(", displayName: "renderContextAttr() ", displayComment: "chart", categories: ["chart"]},
		{name: "renderOptions", value: "renderOptions(", displayName: "renderOptions() ", displayComment: "chart", categories: ["chart"]},
		{name: "renderer", value: "renderer(", displayName: "renderer() ", displayComment: "chart", categories: ["chart"]},
		{name: "resetDataSetParamValues", value: "resetDataSetParamValues(", displayName: "resetDataSetParamValues() ", displayComment: "chart", categories: ["chart"]},
		{name: "resetDataSetParamValuesFirst", value: "resetDataSetParamValuesFirst()", displayName: "resetDataSetParamValuesFirst() ", displayComment: "chart", categories: ["chart"]},
		{name: "resize", value: "resize()", displayName: "resize() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultAt", value: "resultAt(", displayName: "resultAt() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultCell", value: "resultCell(", displayName: "resultCell() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultColumnArrays", value: "resultColumnArrays(", displayName: "resultColumnArrays() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultData", value: "resultData(", displayName: "resultData() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultDataElement", value: "resultDataElement(", displayName: "resultDataElement() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultDataFormat", value: "resultDataFormat(", displayName: "resultDataFormat() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultDatas", value: "resultDatas(", displayName: "resultDatas() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultDatasFirst", value: "resultDatasFirst(", displayName: "resultDatasFirst() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultFirst", value: "resultFirst(", displayName: "resultFirst() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultMapObjects", value: "resultMapObjects(", displayName: "resultMapObjects() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultNameValueObjects", value: "resultNameValueObjects(", displayName: "resultNameValueObjects() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultOf", value: "resultOf(", displayName: "resultOf() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultRowArrays", value: "resultRowArrays(", displayName: "resultRowArrays() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultRowCell", value: "resultRowCell(", displayName: "resultRowCell() ", displayComment: "chart", categories: ["chart"]},
		{name: "resultValueObjects", value: "resultValueObjects(", displayName: "resultValueObjects() ", displayComment: "chart", categories: ["chart"]},
		{name: "status", value: "status(", displayName: "status() ", displayComment: "chart", categories: ["chart"]},
		{name: "statusDestroyed", value: "statusDestroyed(", displayName: "statusDestroyed() ", displayComment: "chart", categories: ["chart"]},
		{name: "statusPreRender", value: "statusPreRender(", displayName: "statusPreRender() ", displayComment: "chart", categories: ["chart"]},
		{name: "statusPreUpdate", value: "statusPreUpdate(", displayName: "statusPreUpdate() ", displayComment: "chart", categories: ["chart"]},
		{name: "statusRendered", value: "statusRendered(", displayName: "statusRendered() ", displayComment: "chart", categories: ["chart"]},
		{name: "statusRendering", value: "statusRendering(", displayName: "statusRendering() ", displayComment: "chart", categories: ["chart"]},
		{name: "statusUpdated", value: "statusUpdated(", displayName: "statusUpdated() ", displayComment: "chart", categories: ["chart"]},
		{name: "statusUpdating", value: "statusUpdating(", displayName: "statusUpdating() ", displayComment: "chart", categories: ["chart"]},
		{name: "styleString", value: "styleString(", displayName: "styleString() ", displayComment: "chart", categories: ["chart"]},
		{name: "theme", value: "theme(", displayName: "theme() ", displayComment: "chart", categories: ["chart"]},
		{name: "themeStyleName", value: "themeStyleName()", displayName: "themeStyleName() ", displayComment: "chart", categories: ["chart"]},
		{name: "themeStyleSheet", value: "themeStyleSheet(", displayName: "themeStyleSheet() ", displayComment: "chart", categories: ["chart"]},
		{name: "update", value: "update(", displayName: "update() ", displayComment: "chart", categories: ["chart"]},
		{name: "updateGroup", value: "updateGroup(", displayName: "updateGroup() ", displayComment: "chart", categories: ["chart"]},
		{name: "updateInterval", value: "updateInterval", displayName: "updateInterval ", displayComment: "chart", categories: ["chart"]},
		{name: "updateResults", value: "updateResults(", displayName: "updateResults() ", displayComment: "chart", categories: ["chart"]},
		{name: "widgetId", value: "widgetId()", displayName: "widgetId() ", displayComment: "chart", categories: ["chart"]}
	];
	
	po.getActiveResEditorTabPane = function()
	{
		return po.tabsGetActivePane(po.resourceEditorTabs());
	};
	
	po.evalTopWindowSize = function()
	{
		var topWindow = window;
		while(topWindow.parent  && topWindow.parent != topWindow)
			topWindow = topWindow.parent;
		
		var size =
		{
			width: $(topWindow).width(),
			height: $(topWindow).height()
		};
		
		return size;
	};
	
	po.iframeWindow = function($iframe)
	{
		$iframe = $iframe[0];
		return $iframe.contentWindow;
	};
	
	po.iframeDocument = function($iframe)
	{
		$iframe = $iframe[0];
		return ($iframe.contentDocument || $iframe.contentWindow.document);
	};
	
	//设置可视编辑iframe的尺寸，使其适配父元素尺寸而不会出现滚动条
	po.setVisualEditorIframeScale = function($iframeWrapper, $iframe)
	{
		var ww = $iframeWrapper.width(), wh = $iframeWrapper.height();
		var iw = $iframe.width(), ih = $iframe.height();
		
		//下面的计算只有$iframe在$iframeWrapper中是绝对定位的才准确
		var rightGap = 5, bottomGap = 5;
		var ileft = parseInt($iframe.css("left")), itop = parseInt($iframe.css("top"));
		ww = ww - ileft - rightGap;
		wh = wh - itop - bottomGap;
		
		if(iw <= ww && ih <= wh)
			return;
		
		var scaleX = ww/iw, scaleY = wh/ih;
		$iframe.css("transform-origin", "0 0");
		$iframe.css("transform", "scale("+Math.min(scaleX, scaleY)+")");
	};
	
	po.dashboardEditorVisual = function(tabPane)
	{
		var visualEditorIfm = po.element(".tpl-visual-editor-ifm", tabPane);
		var ifmWindow = po.iframeWindow(visualEditorIfm);
		
		var dashboardEditor = (ifmWindow && ifmWindow.dashboardFactory ? ifmWindow.dashboardFactory.dashboardEditor : null);
		
		if(dashboardEditor && !dashboardEditor._OVERWRITE_BY_CONTEXT)
		{
			dashboardEditor._OVERWRITE_BY_CONTEXT = true;
			
			dashboardEditor.i18n.insertInsideChartOnChartEleDenied="<@spring.message code='dashboard.opt.tip.insertInsideChartOnChartEleDenied' />";
			dashboardEditor.i18n.selectElementForSetChart="<@spring.message code='dashboard.opt.tip.selectElementForSetChart' />";
			dashboardEditor.i18n.canEditOnlyTextElement="<@spring.message code='dashboard.opt.tip.canOnlyEditTextElement' />";
			dashboardEditor.i18n.selectedElementRequired="<@spring.message code='dashboard.opt.tip.selectedElementRequired' />";
			dashboardEditor.i18n.selectedNotChartElement="<@spring.message code='dashboard.opt.tip.selectedNotChartElement' />";
			dashboardEditor.tipInfo = function(msg)
			{
				$.tipInfo(msg);
			};
			
			dashboardEditor.defaultInsertChartEleStyle = po.defaultInsertChartEleStyle;
		}
		
		return dashboardEditor;
	};
	
	po.getResourceEditorData = function()
	{
		var data = {};
		data.resourceNames=[];
		data.resourceContents=[];
		data.resourceIsTemplates=[];
		
		po.element(".resource-editor-tab-pane").each(function()
		{
			var d = po.getSingleResourceEditorData(this);
			
			data.resourceNames.push(d.resourceName);
			data.resourceIsTemplates.push(d.isTemplate);
			data.resourceContents.push(d.resourceContent);
		});
		
		return data;
	};
	
	po.getSingleResourceEditorData = function(tabPane, returnResourceContent)
	{
		tabPane = $(tabPane);
		returnResourceContent = (returnResourceContent == null ? true : returnResourceContent);
		
		var resourceName = po.element(".resourceName", tabPane).val();
		var isTemplate = (po.element(".resourceIsTemplate", tabPane).val() == "true");
		
		var data =
		{
			resourceName: resourceName,
			isTemplate: isTemplate
		};
		
		if(returnResourceContent)
		{
			var resourceContent = "";
			var codeEditorDiv = po.element(".code-editor", tabPane);
			var codeEditor = codeEditorDiv.data("resourceEditorInstance");
			
			if(isTemplate)
			{
				var visualEditorIfm = po.element(".tpl-visual-editor-ifm", tabPane);
				if(visualEditorIfm.hasClass("show-editor"))
				{
					var dashboardEditor = po.dashboardEditorVisual(tabPane);
					resourceContent = (dashboardEditor ? dashboardEditor.editedHtml() : "");
				}
				
				if(!resourceContent)
					resourceContent = po.getCodeText(codeEditor);
			}
			else
			{
				resourceContent = po.getCodeText(codeEditor);
			}
			
			data.resourceContent = resourceContent;
		}
		
		return data;
	};
	
	po.saveResourceEditorContent = function(tabPane)
	{
		if(po.checkDashboardUnSaved())
			return;
		
		var d = po.getSingleResourceEditorData(tabPane);
		
		$.post(
				po.url("saveResourceContent"),
				{
					"id": po.getDashboardId(),
					"resourceName": d.resourceName,
					"resourceContent": d.resourceContent,
					"isTemplate": d.isTemplate
				},
				function(response)
				{
					if(response.data.templatesChanged || !response.data.resourceExists)
					{
						po.templates = response.data.templates;
						po.refreshResourceListLocal();
					}
				});
	};
	
	po.newResourceEditorTab = function(name, content, isTemplate)
	{
		tabTemplate = "<li class='resource-editor-tab' style='vertical-align:middle;'><a href='"+'#'+"{href}'>"+'#'+"{label}</a>"
			+"<div class='tab-operation'>"
			+"<span class='ui-icon ui-icon-close' title='<@spring.message code='close' />'>close</span>"
			+"<div class='tabs-more-operation-button' title='<@spring.message code='moreOperation' />'><span class='ui-icon ui-icon-caret-1-e'></span></div>"
			+"</div>"
			+"</li>";
		
		var label = name;
		var labelMaxLen = 5 + 3 + 10;
		if(label.length > labelMaxLen)
			label = name.substr(0, 5) +"..." + name.substr(label.length - 10);
		
		var tabId = $.uid("resourceEditorTabPane");
    	var tab = $(tabTemplate.replace( /#\{href\}/g, "#" + tabId).replace(/#\{label\}/g, $.escapeHtml(label)))
    		.attr("id", $.uid("resourceEditorTab")).attr("resourceName", name).attr("title", name)
    		.appendTo(po.tabsGetNav(po.resourceEditorTabs()));
    	
    	var panePrevEle = $(".resource-editor-tab-pane", po.resourceEditorTabs()).last();
    	if(panePrevEle.length == 0)
    		panePrevEle = $(".resource-editor-tab-nav", po.resourceEditorTabs());
    	var tabPane = $("<div id='"+tabId+"' class='resource-editor-tab-pane' />").insertAfter(panePrevEle);
    	var resNameWrapper = $("<div class='resource-name-wrapper' />").appendTo(tabPane);
    	$("<label class='name-label'></label>").html("<@spring.message code='name' />").appendTo(resNameWrapper);
    	$("<input type='text' class='resourceName name-input ui-widget ui-widget-content' readonly='readonly' />").val(name).appendTo(resNameWrapper);
    	$("<input type='hidden' class='resourceIsTemplate' />").val(isTemplate).appendTo(resNameWrapper);
    	
		var editorOptWrapper = $("<div class='editor-operation-wrapper' />").appendTo(tabPane);
		var editorLeftOptWrapper = $("<div class='operation-left' />").appendTo(editorOptWrapper);
    	var editorWrapper = $("<div class='editor-wrapper ui-widget ui-widget-content' />").appendTo(tabPane);
		var editorDiv = $("<div class='resource-editor code-editor' />").attr("id", $.uid("resourceEditor")).appendTo(editorWrapper);
		
		var codeEditor;
		
		var codeEditorOptions =
		{
			value: content,
			matchBrackets: true,
			matchTags: true,
			autoCloseTags: true,
			readOnly: po.readonly,
			mode: po.evalCodeModeByName(name)
		};
		
		if(isTemplate && !codeEditorOptions.readOnly)
		{
			codeEditorOptions.hintOptions =
			{
				hint: po.codeEditorHintHandler
			};
		}
		
		codeEditor = po.createCodeEditor(editorDiv, codeEditorOptions);
		
		if(isTemplate && !codeEditorOptions.readOnly)
		{
			//光标移至"</body>"的上一行，便于用户直接输入内容
			var cursor = codeEditor.getSearchCursor("</body>");
			if(cursor.findNext())
			{
				var cursorFrom = cursor.from();
				codeEditor.getDoc().setCursor({ line: cursorFrom.line-1, ch: 0 });
			}
		}
		
		editorDiv.data("resourceEditorInstance", codeEditor);
		
		if(isTemplate)
		{
			var visualEditorDiv = $("<div class='tpl-visual-editor-wrapper' />").appendTo(editorWrapper);
			
			var visualEditorId = $.uid("visualEditor");
			var visualEditorIfm = $("<iframe class='tpl-visual-editor-ifm hide-editor ui-widget-shadow' />")
				.attr("name", visualEditorId).attr("id", visualEditorId).appendTo(visualEditorDiv);
			
			var topWindowSize = po.evalTopWindowSize();
			visualEditorIfm.css("width", topWindowSize.width);
			visualEditorIfm.css("height", topWindowSize.height);
			
			po.setVisualEditorIframeScale(visualEditorDiv, visualEditorIfm);
			
			var editorSwitchGroup = $("<div class='switch-resource-editor-group' />").appendTo(editorLeftOptWrapper);
			$("<button type='button' class='switchToCodeEditorBtn'></button>").text("<@spring.message code='dashboard.switchToCodeEditor' />")
			.appendTo(editorSwitchGroup).button().click(function()
			{
				po.switchToCodeEditor(tabPane);
			});
			$("<button type='button' class='switchToVisualEditorBtn'></button>").text("<@spring.message code='dashboard.switchToVisualEditor' />")
			.appendTo(editorSwitchGroup).button().click(function()
			{
				po.switchToVisualEditor(tabPane);
			});
			editorSwitchGroup.controlgroup();
			
			//默认打开源码模式，因为如果默认为可视模式，如果页面中有导致死循环的代码，将会导致永远无法再次打开看板编辑页面
			po.switchToCodeEditor(tabPane);
		}
		else
		{
			po.initCodeEditorOperationIfNon(tabPane);
			codeEditor.focus();
		}
		
   	    $(".tab-operation .ui-icon-close", tab).click(function()
   	    {
   	    	var tab = $(this).parent().parent();
   	    	po.tabsCloseTab(po.resourceEditorTabs(), tab);
   	    });
   	    
   	    $(".tab-operation .tabs-more-operation-button", tab).click(function()
   	    {
   	    	var tab = $(this).parent().parent();
   	    	po.tabsShowMoreOptMenu(po.resourceEditorTabs(), tab, $(this));
   	    });
		
	    po.resourceEditorTabs().tabs("refresh");
    	po.resourceEditorTabs().tabs( "option", "active",  tab.index());
    	po.tabsRefreshNavForHidden(po.resourceEditorTabs());
	};

	po.codeEditorHintHandler = function(codeEditor)
	{
		var doc = codeEditor.getDoc();
		var cursor = doc.getCursor();
		var mode = (codeEditor.getModeAt(cursor) || {});
		var token = (codeEditor.getTokenAt(cursor) || {});
		var tokenString = (token ? $.trim(token.string) : "");
		
		//"dg*"的HTML元素属性
		if("xml" == mode.name && "attribute" == token.type && /^dg/i.test(tokenString))
		{
			var myTagToken = po.findPrevTokenOfType(codeEditor, doc, cursor, token, "tag");
			var myCategory = (myTagToken ? myTagToken.string : null);
			
			var completions =
			{
				list: po.findCompletionList(po.codeEditorCompletionsTagAttr, tokenString, myCategory),
				from: CodeMirror.Pos(cursor.line, token.start),
				to: CodeMirror.Pos(cursor.line, token.end)
			};
			
			return completions;
		}
		//javascript函数
		else if("javascript" == mode.name && (tokenString == "." || "property" == token.type))
		{
			var myVarToken = po.findPrevTokenOfType(codeEditor, doc, cursor, token, "variable");
			var myCategory = (myVarToken ? myVarToken.string : "");
			
			//无法确定要补全的是看板还是图表对象，所以这里采用：完全匹配变量名，否则就全部提示
			// *dashboard*
			if(/dashboard/i.test(myCategory))
				myCategory = "dashboard";
			// *chart*
			else if(/chart/i.test(myCategory))
				myCategory = "chart";
			else
				myCategory = null;
			
			var completions =
			{
				list: po.findCompletionList(po.codeEditorCompletionsJsFunction, (tokenString == "." ? "" : tokenString), myCategory),
				from: CodeMirror.Pos(cursor.line, (tokenString == "." ? token.start + 1 : token.start)),
				to: CodeMirror.Pos(cursor.line, token.end)
			};
			
			return completions;
		}
	};
	
	//切换至源码编辑模式
	po.switchToCodeEditor = function(tabPane)
	{
		po.initCodeEditorOperationIfNon(tabPane);
		
		po.element(".switchToCodeEditorBtn", tabPane).addClass("ui-state-active");
		po.element(".switchToVisualEditorBtn", tabPane).removeClass("ui-state-active");
		po.element(".code-editor-operation", tabPane).show();
		po.element(".visual-editor-operation", tabPane).hide();
		
		var codeEditorDiv = po.element(".code-editor", tabPane);
		var codeEditor = codeEditorDiv.data("resourceEditorInstance");
		var visualEditorIfm = po.element(".tpl-visual-editor-ifm", tabPane);
		var changeFlag = codeEditorDiv.data("changeFlag");
		
		//初次由源码模式切换至可视编辑模式后，changeFlag会是1，
		//但此时是不需要同步的，所以这里手动设置为1
		if(changeFlag == null)
			changeFlag = 1;
		
		var dashboardEditor = po.dashboardEditorVisual(tabPane);
		
		//有修改
		if(dashboardEditor && dashboardEditor.isChanged(changeFlag))
		{
			po.setCodeText(codeEditor, dashboardEditor.editedHtml());

			visualEditorIfm.data("changeFlag", codeEditor.changeGeneration());
			codeEditorDiv.data("changeFlag", dashboardEditor.changeFlag());
		}
		
		visualEditorIfm.removeClass("show-editor").addClass("hide-editor");
		codeEditorDiv.removeClass("hide-editor").addClass("show-editor");
		
    	codeEditor.focus();
	};
	
	//切换至可视编辑模式
	po.switchToVisualEditor = function(tabPane)
	{
		po.initVisualEditorOperationIfNon(tabPane);
		
		po.element(".switchToCodeEditorBtn", tabPane).removeClass("ui-state-active");
		po.element(".switchToVisualEditorBtn", tabPane).addClass("ui-state-active");
		po.element(".code-editor-operation", tabPane).hide();
		po.element(".visual-editor-operation", tabPane).show();
		
		var codeEditorDiv = po.element(".code-editor", tabPane);
		var codeEditor = codeEditorDiv.data("resourceEditorInstance");
		var visualEditorIfm = po.element(".tpl-visual-editor-ifm", tabPane);
		var changeFlag = visualEditorIfm.data("changeFlag");
		
		//没有修改
		if(changeFlag != null && codeEditor.isClean(changeFlag))
		{
			codeEditorDiv.removeClass("show-editor").addClass("hide-editor");
			visualEditorIfm.removeClass("hide-editor").addClass("show-editor");
		}
		else
		{
			codeEditorDiv.removeClass("show-editor").addClass("hide-editor");
			//清空iframe后再显示，防止闪屏
			po.iframeDocument(visualEditorIfm).write("");
			visualEditorIfm.removeClass("hide-editor").addClass("show-editor");
			
			visualEditorIfm.data("changeFlag", codeEditor.changeGeneration());
			codeEditorDiv.data("changeFlag", null);
			
			var templateName = po.element(".resource-name-wrapper input.resourceName", tabPane).val();
			po.loadVisualEditorIframe(visualEditorIfm, templateName, (po.readonly ? "" : po.getCodeText(codeEditor)));
		}
	};
	
	po.loadVisualEditorIframe = function(visualEditorIfm, templateName, templateContent)
	{
		var dashboardId = po.getDashboardId();
		var form = po.element("#${pageId}-tplEditVisualForm");
		form.attr("action", po.showUrl(dashboardId, templateName));
		form.attr("target", visualEditorIfm.attr("name"));
		$("input[name='DG_EDIT_TEMPLATE']", form).val(po.readonly ? "false" : "true");
		$("textarea[name='DG_TEMPLATE_CONTENT']", form).val(templateContent);
		form.submit();
	};
	
	po.initCodeEditorOperationIfNon = function(tabPane)
	{
		var editorOptWrapper = po.element(".editor-operation-wrapper", tabPane);
		var editorRightOptWrapper = po.element(".code-editor-operation", editorOptWrapper);
		
		if(editorRightOptWrapper.length > 0)
			return false;
		
		editorRightOptWrapper = $("<div class='code-editor-operation operation-right' />").appendTo(editorOptWrapper)
		
		if(!po.readonly)
		{
			if(po.element(".resourceIsTemplate", tabPane).val() == "true")
			{
				var insertGroup = $("<div class='insert-group' auto-close-prevent='chart-list-panel' />").appendTo(editorRightOptWrapper);
				var insertChartBtn = $("<button type='button' class='insert-chart-button' />")
					.text("<@spring.message code='dashboard.insertChart' />").appendTo(insertGroup).button()
					.click(function()
					{
						po.toggleInsertChartListPannel(this);
					});
			}
			
			$("<button type='button' />").text("<@spring.message code='save' />").appendTo(editorRightOptWrapper).button()
			.click(function()
			{
				po.saveResourceEditorContent(tabPane);
			});
		}
		
		var searchGroup = $("<div class='search-group ui-widget ui-widget-content ui-corner-all' />").appendTo(editorRightOptWrapper);
		var searchInput = $("<input type='text' class='search-input ui-widget ui-widget-content' />").appendTo(searchGroup)
				.on("keydown", function(e)
				{
					if(e.keyCode == $.ui.keyCode.ENTER)
					{
						po.element(".search-button", tabPane).click();
						//防止提交表单
						return false;
					}
				});
		var searchButton = $("<button type='button' class='search-button ui-button ui-corner-all ui-widget ui-button-icon-only'>"
				+"<span class='ui-icon ui-icon-search'></span><span class='ui-button-icon-space'></span>Search</button>")
				.appendTo(searchGroup)
				.click(function()
				{
					var $this = $(this);
					
					var text = po.element(".search-input", tabPane).val();
					
					if(!text)
						return;
					
					var codeEditor = po.element(".code-editor", tabPane).data("resourceEditorInstance");
					
					var prevSearchText = $this.data("prevSearchText");
					var cursor = $this.data("prevSearchCursor");
					var doc = codeEditor.getDoc();
					
					if(!cursor || text != prevSearchText)
					{
						cursor = codeEditor.getSearchCursor(text);
						$this.data("prevSearchCursor", cursor);
						$this.data("prevSearchText", text)
					}
					
					codeEditor.focus();
					
					if(cursor.findNext())
						doc.setSelection(cursor.from(), cursor.to());
					else
					{
						//从头搜索
						$this.data("prevSearchCursor", null);
						$this.click();
					}
				});
	};
	
	po.defaultInsertChartEleStyle = "display:inline-block;width:300px;height:300px;";
	
	po.insertCodeEditorChart = function(tabPane, chartWidgets)
	{
		if(!chartWidgets || !chartWidgets.length)
			return;
		
		var codeEditor = po.element(".code-editor", tabPane).data("resourceEditorInstance");
		
		var doc = codeEditor.getDoc();
		var cursor = doc.getCursor();
		
		var dftSize = po.defaultInsertChartSize;
		
		var code = "";
		
		if(chartWidgets.length == 1)
		{
			var chartId = chartWidgets[0].id;
			var chartName = chartWidgets[0].name;
			
			var text = po.getTemplatePrevTagText(codeEditor, cursor);
			
			// =
			if(/=\s*$/g.test(text))
				code = "\"" + chartId + "\"";
			// =" 或 ='
			else if(/=\s*['"]$/g.test(text))
				code = chartId;
			// <...
			else if(/<[^>]*$/g.test(text))
				code = " dg-chart-widget=\""+chartId+"\"";
			else
			{
				code = "<div style=\""+po.defaultInsertChartEleStyle+"\" dg-chart-widget=\""+chartId+"\"><!--"+chartName+"--></div>\n";
			}
		}
		else
		{
			for(var i=0; i<chartWidgets.length; i++)
				code += "<div style=\""+po.defaultInsertChartEleStyle+"\" dg-chart-widget=\""+chartWidgets[i].id+"\"><!--"+chartWidgets[i].name+"--></div>\n";
		}
		
		po.insertCodeText(codeEditor, cursor, code);
		codeEditor.focus();
	};
	
	po.getLastTagText = function(text)
	{
		if(!text)
			return text;
		
		var idx = -1;
		for(var i=text.length-1;i>=0;i--)
		{
			var c = text.charAt(i);
			if(c == '>' || c == '<')
			{
				idx = i;
				break;
			}
		}
		
		return (idx < 0 ? text : text.substr(idx));
	};
	
	po.getTemplatePrevTagText = function(codeEditor, cursor)
	{
		var doc = codeEditor.getDoc();
		
		var text = doc.getLine(cursor.line).substring(0, cursor.ch);
		
		//反向查找直到'>'或'<'
		var prevRow = cursor.line;
		while((!text || !(/[<>]/g.test(text))) && (prevRow--) >= 0)
			text = doc.getLine(prevRow) + text;
		
		return po.getLastTagText(text);
	};
	
	po.initVisualEditorOperationIfNon = function(tabPane)
	{
		if(po.readonly)
			return false;
		
		var editorOptWrapper = po.element(".editor-operation-wrapper", tabPane);
		var editorRightOptWrapper = po.element(".visual-editor-operation", editorOptWrapper);
		
		if(editorRightOptWrapper.length > 0)
			return false;
		
		editorRightOptWrapper = $("<div class='visual-editor-operation operation-right' />").appendTo(editorOptWrapper);

		var selectGroup = $("<div class='select-group' />").appendTo(editorRightOptWrapper)
			.hover(
				function()
				{
					po.element(".select-menu", this).show()
						.position({ my : "right top", at : "right bottom", of : this});
				},
				function()
				{
					po.element(".select-menu", this).hide();
				});
		$("<button type='button' />").text("<@spring.message code='select' />").appendTo(selectGroup).button();
		
		var selectMenu = $("<ul class='select-menu operation-menu ui-widget ui-widget-content ui-corner-all ui-front ui-widget-shadow' />");
		$("<li selectOperation='next' />").html("<div><@spring.message code='dashboard.opt.select.next' /></div>").appendTo(selectMenu);
		$("<li selectOperation='prev' />").html("<div><@spring.message code='dashboard.opt.select.prev' /></div>").appendTo(selectMenu);
		$("<li selectOperation='firstChild' />").html("<div><@spring.message code='dashboard.opt.select.firstChild' /></div>").appendTo(selectMenu);
		$("<li selectOperation='parent' />").html("<div><@spring.message code='dashboard.opt.select.parent' /></div>").appendTo(selectMenu);
		$("<li class='ui-menu-divider' />").appendTo(selectMenu);
		$("<li selectOperation='deselect' />").html("<div><@spring.message code='dashboard.opt.select.deselect' /></div>").appendTo(selectMenu);
		selectMenu.appendTo(selectGroup).menu(
		{
			select: function(event, ui)
			{
				var item = ui.item;
				var selectOperation = item.attr("selectOperation");
				
				var dashboardEditor = po.dashboardEditorVisual(tabPane);
				
				if(!dashboardEditor)
					return;
				
				if(selectOperation == "next")
				{
					dashboardEditor.selectNextElement();
				}
				else if(selectOperation == "prev")
				{
					dashboardEditor.selectPrevElement();
				}
				else if(selectOperation == "firstChild")
				{
					dashboardEditor.selectFirstChildElement();
				}
				else if(selectOperation == "parent")
				{
					dashboardEditor.selectParentElement();
				}
				else if(selectOperation == "deselect")
				{
					dashboardEditor.deselectElement();
				}
			}
		});
		
		var insertGroup = $("<div class='insert-group' auto-close-prevent='chart-list-panel' />").appendTo(editorRightOptWrapper)
			.hover(
				function()
				{
					po.element(".insert-menu", this).show()
						.position({ my : "right top", at : "right bottom", of : this});
				},
				function()
				{
					po.element(".insert-menu", this).hide();
				});
		$("<button type='button' />").text("<@spring.message code='insert' />").appendTo(insertGroup).button();
		
		var insertMenu = $("<ul class='insert-menu operation-menu ui-widget ui-widget-content ui-corner-all ui-front ui-widget-shadow' />");
		var insertItemAfter = $("<li />").html("<div><@spring.message code='dashboard.opt.insert.after' /></div>").appendTo(insertMenu);
		po.buildVisualEditorInsertMenuItems(insertItemAfter, "after");
		var insertItemBefore = $("<li />").html("<div><@spring.message code='dashboard.opt.insert.before' /></div>").appendTo(insertMenu);
		po.buildVisualEditorInsertMenuItems(insertItemBefore, "before");
		var insertItemAppend = $("<li />").html("<div><@spring.message code='dashboard.opt.insert.append' /></div>").appendTo(insertMenu);
		po.buildVisualEditorInsertMenuItems(insertItemAppend, "append");
		var insertItemPrepend = $("<li />").html("<div><@spring.message code='dashboard.opt.insert.prepend' /></div>").appendTo(insertMenu);
		po.buildVisualEditorInsertMenuItems(insertItemPrepend, "prepend");
		$("<li class='ui-menu-divider' />").appendTo(insertMenu);
		$("<li insertOperation='bindChart' />").html("<div><@spring.message code='dashboard.opt.insert.bindOrReplaceChart' /></div>").appendTo(insertMenu);
		insertMenu.appendTo(insertGroup).menu(
		{
			select: function(event, ui)
			{
				var item = ui.item;
				var insertOperation = item.attr("insertOperation");
				var insertType = item.attr("insertType");
				
				po.insertOperationForVisualEdit = insertOperation;
				po.insertTypeForVisualEdit = insertType;
				
				var dashboardEditor = po.dashboardEditorVisual(tabPane);
				
				if(!dashboardEditor)
					return;
				
				if(insertOperation == "insertDiv")
				{
					if(!dashboardEditor.checkInsertDiv(insertType))
						return;
					
					dashboardEditor.insertDiv(insertType);
				}
				else if(insertOperation == "insertChart")
				{
					if(!dashboardEditor.checkInsertChart(insertType))
						return;
					
					po.toggleInsertChartListPannel(insertGroup);
				}
				else if(insertOperation == "bindChart")
				{
					if(!dashboardEditor.checkBindChart())
						return;
					
					po.toggleInsertChartListPannel(insertGroup);
				}
			}
		});
		
		var editGroup = $("<div class='edit-group' />").appendTo(editorRightOptWrapper)
			.hover(
				function()
				{
					po.element(".edit-menu", this).show().position({ my : "right top", at : "right bottom", of : this});
				},
				function()
				{
					po.element(".edit-menu", this).hide();
				});
		$("<button type='button' />").text("<@spring.message code='edit' />").appendTo(editGroup).button();
		
		var editMenu = $("<ul class='edit-menu operation-menu ui-widget ui-widget-content ui-corner-all ui-front ui-widget-shadow' />");
		$("<li editOperation='editGlobalStyle' auto-close-prevent='veditor-style-panel' />").html("<div><@spring.message code='dashboard.opt.edit.globalStyle' /></div>").appendTo(editMenu);
		$("<li editOperation='editGlobalChartTheme' auto-close-prevent='veditor-chartTheme-panel' />").html("<div><@spring.message code='dashboard.opt.edit.globalChartTheme' /></div>").appendTo(editMenu);
		$("<li class='ui-menu-divider' />").appendTo(editMenu);
		$("<li editOperation='editStyle' auto-close-prevent='veditor-style-panel' />").html("<div><@spring.message code='dashboard.opt.edit.style' /></div>").appendTo(editMenu);
		$("<li editOperation='editContent' auto-close-prevent='veditor-content-panel' />").html("<div><@spring.message code='dashboard.opt.edit.content' /></div>").appendTo(editMenu);
		$("<li editOperation='editChartTheme' auto-close-prevent='veditor-chartTheme-panel' />").html("<div><@spring.message code='dashboard.opt.edit.chartTheme' /></div>").appendTo(editMenu);
		editMenu.appendTo(editGroup).menu(
		{
			select: function(event, ui)
			{
				var item = ui.item;
				var editOperation = item.attr("editOperation");
				po.editOperationForVisualEdit = editOperation;
				
				var dashboardEditor = po.dashboardEditorVisual(tabPane);
				if(dashboardEditor)
				{
					if(editOperation == "editGlobalStyle")
					{
						var panel = po.element(".veditor-style-panel");
						po.element(".editStyleTitle", panel).hide();
						po.element(".editGlobalStyleTitle", panel).show();
						po.element(".form-item-syncChartTheme" ,panel).show();
						po.setVeditorStyleFormValue(po.element("form", panel), dashboardEditor.getGlobalStyle());
						panel.show().position({ my : "right top", at : "right bottom", of : editGroup});
						po.resizeVisualEditorStylePanel(panel);
					}
					else if(editOperation == "editGlobalChartTheme")
					{
						var panel = po.element(".veditor-chartTheme-panel");
						po.element(".editChartThemeTitle", panel).hide();
						po.element(".editGlobalChartThemeTitle", panel).show();
						po.setVeditorChartThemeFormValue(po.element("form", panel), dashboardEditor.getGlobalChartTheme());
						panel.show().position({ my : "right top", at : "right bottom", of : editGroup});
					}
					else if(editOperation == "editStyle")
					{
						if(!dashboardEditor.checkSetElementStyle())
							return;
						
						var panel = po.element(".veditor-style-panel");

						po.element(".editStyleTitle", panel).show();
						po.element(".editGlobalStyleTitle", panel).hide();
						if(dashboardEditor.isChartElement())
							po.element(".form-item-syncChartTheme" ,panel).show();
						else
							po.element(".form-item-syncChartTheme" ,panel).hide();
						
						po.setVeditorStyleFormValue(po.element("form", panel), dashboardEditor.getElementStyle());
						panel.show().position({ my : "right top", at : "right bottom", of : editGroup});
						po.resizeVisualEditorStylePanel(panel);
					}
					else if(editOperation == "editContent")
					{
						if(!dashboardEditor.checkSetElementText())
							return;
						
						var panel = po.element(".veditor-content-panel");
						panel.show().position({ my : "right top", at : "right bottom", of : editGroup});
						po.element("input[name='content']", panel).val(dashboardEditor.getElementText()).focus();
					}
					else if(editOperation == "editChartTheme")
					{
						if(!dashboardEditor.checkSetElementChartTheme())
							return;
						
						var panel = po.element(".veditor-chartTheme-panel");
						po.element(".editChartThemeTitle", panel).show();
						po.element(".editGlobalChartThemeTitle", panel).hide();
						po.setVeditorChartThemeFormValue(po.element("form", panel), dashboardEditor.getElementChartTheme());
						panel.show().position({ my : "right top", at : "right bottom", of : editGroup});
					}
				}
			}
		});
		
		var deleteGroup = $("<div class='delete-group' />").appendTo(editorRightOptWrapper)
			.hover(
				function()
				{
					po.element(".delete-menu", this).show().position({ my : "right top", at : "right bottom", of : this});
				},
				function()
				{
					po.element(".delete-menu", this).hide();
				});
		$("<button type='button' />").text("<@spring.message code='delete' />").appendTo(deleteGroup).button();
		
		var deleteMenu = $("<ul class='delete-menu operation-menu ui-widget ui-widget-content ui-corner-all ui-front ui-widget-shadow' />");
		$("<li deleteOperation='deleteElement' />").html("<div><@spring.message code='dashboard.opt.delete.element' /></div>").appendTo(deleteMenu);
		$("<li deleteOperation='unbindChart' />").html("<div><@spring.message code='dashboard.opt.delete.unbindChart' /></div>").appendTo(deleteMenu);
		deleteMenu.appendTo(deleteGroup).menu(
		{
			select: function(event, ui)
			{
				var item = ui.item;
				var deleteOperation = item.attr("deleteOperation");
				po.deleteOperationForVisualEdit = deleteOperation;
				
				var dashboardEditor = po.dashboardEditorVisual(tabPane);
				if(dashboardEditor)
				{
					if(deleteOperation == "deleteElement")
					{
						dashboardEditor.deleteElement();
					}
					else if(deleteOperation == "unbindChart")
					{
						dashboardEditor.unbindChart();
					}
				}
			}
		});
		
		$("<button type='button' />").text("<@spring.message code='refresh' />")
		.attr("title", "<@spring.message code='dashboard.opt.refresh.desc' />")
		.appendTo(editorRightOptWrapper).button()
		.click(function()
		{
			var dashboardEditor = po.dashboardEditorVisual(tabPane);
			if(dashboardEditor)
			{
				var visualEditorIfm = po.element(".tpl-visual-editor-ifm", tabPane);
				var templateName = po.element(".resource-name-wrapper input.resourceName", tabPane).val();
				po.loadVisualEditorIframe(visualEditorIfm, templateName, (po.readonly ? "" : dashboardEditor.editedHtml()));
			}
		});
		
		$("<button type='button' />").text("<@spring.message code='save' />").appendTo(editorRightOptWrapper).button()
		.click(function()
		{
			po.saveResourceEditorContent(tabPane);
		});
	};
	
	po.resizeVisualEditorStylePanel = function(panel)
	{
		var panelContent = po.element(".panel-content", panel);
		var syncChartThemeItem = po.element(".form-item-syncChartTheme", panelContent);
		
		var styleTabsHeight = panelContent.height();
		if(!syncChartThemeItem.is(":hidden"))
			styleTabsHeight = styleTabsHeight - syncChartThemeItem.outerHeight(true);
		po.element(".style-tabs", panelContent).css("height", styleTabsHeight);
	};
	
	po.setVeditorStyleFormValue = function($form, styleObj)
	{
		styleObj = $.extend({ syncChartTheme: true }, styleObj);
		$.jsonToForm($form, styleObj,
		{
			handlers:
			{
				"color": function(form, value)
				{
					po.element(".color-indicator", form).css("background-color", (value||""));
					return false;
				},
				"background-color": function(form, value)
				{
					po.element(".bgcolor-indicator", form).css("background-color", (value||""));
					return false;
				}
			}
		});
	};
	
	po.setVeditorChartThemeFormValue = function($form, chartTheme)
	{
		$.jsonToForm($form, chartTheme,
		{
			handlers:
			{
				"color": function(form, value)
				{
					po.element(".color-indicator", form).css("background-color", (value||""));
					return false;
				},
				"backgroundColor": function(form, value)
				{
					po.element(".bgcolor-indicator", form).css("background-color", (value||""));
					return false;
				},
				"actualBackgroundColor": function(form, value)
				{
					po.element(".actbgcolor-indicator", form).css("background-color", (value||""));
					return false;
				},
				"graphColors": function(form, value)
				{
					return $.jsonToFormArrayHandler(form, value, ".graphColorsInput", function(wrapper)
					{
						po.addChartThemeFormGraphColorsItem(wrapper);
					});
				},
				"graphRangeColors": function(form, value)
				{
					return $.jsonToFormArrayHandler(form, value, ".graphRangeColorsInput", function(wrapper)
					{
						po.addChartThemeFormGraphRangeColorsItem(wrapper);
					});
				}
			}
		});
	};
	
	po.addChartThemeFormGraphColorsItem = function(wrapper)
	{
		$("<div class='input-value-item'><input type='text' name='graphColors[]' class='ui-widget ui-widget-content' size='100' />"
			+"&nbsp;<button type='button' class='del-color-btn small-button ui-button ui-corner-all ui-widget ui-button-icon-only'><span class='ui-icon ui-icon-close'></span><span class='ui-button-icon-space'></span>&nbsp;</button>"
			+"</div>").appendTo(wrapper);
	};
	
	po.addChartThemeFormGraphRangeColorsItem = function(wrapper)
	{
		$("<div class='input-value-item'><input type='text' name='graphRangeColors[]' class='ui-widget ui-widget-content' size='100' />"
			+"&nbsp;<button type='button' class='del-color-btn small-button ui-button ui-corner-all ui-widget ui-button-icon-only'><span class='ui-icon ui-icon-close'></span><span class='ui-button-icon-space'></span>&nbsp;</button>"
			+"</div>").appendTo(wrapper);
	};
	
	po.buildVisualEditorInsertMenuItems = function($parent, insertType)
	{
		var ul = $("<ul class='ui-widget-shadow' />");
		
		$("<li insertOperation='insertDiv' insertType='"+insertType+"' />")
			.html("<div><@spring.message code='dashboard.opt.insertType.div' /></div>").appendTo(ul);
		
		$("<li insertOperation='insertChart' insertType='"+insertType+"' />")
			.html("<div><@spring.message code='dashboard.opt.insertType.chart' /></div>").appendTo(ul);
		
		ul.appendTo($parent);
	};
	
	po.insertVisualEditorChart = function(tabPane, chartWidgets)
	{
		var dashboardEditor = po.dashboardEditorVisual(tabPane);
		if(dashboardEditor)
		{
			if(po.insertOperationForVisualEdit == "insertChart")
			{
				dashboardEditor.insertChart(chartWidgets, po.insertTypeForVisualEdit);
			}
			else if(po.insertOperationForVisualEdit == "bindChart")
			{
				dashboardEditor.bindChart((chartWidgets ? chartWidgets[0] : null));
			}
		}
	};
	
	po.toggleInsertChartListPannel = function(insertChartButton)
	{
		var chartListPanel = po.element(".chart-list-panel");
		
		if(chartListPanel.is(":hidden"))
		{
			chartListPanel.show();
			chartListPanel.position({ my : "center top", at : "center bottom", of : insertChartButton});
			chartListPanel.css("left", "");
			chartListPanel.css("right", "1em");
			
			if(!chartListPanel.hasClass("chart-list-loaded"))
			{
				po.element(".panel-content", chartListPanel).empty();
				
				var options =
				{
					target: po.element(".panel-content", chartListPanel),
					asDialog: false,
					pageParam :
					{
						select : function(chartWidgets)
						{
							if(!$.isArray(chartWidgets))
								chartWidgets = [chartWidgets];
							
							po.insertEditorChart(chartWidgets);
							chartListPanel.hide();
							
							return false;
						}
					},
					success: function()
					{
						chartListPanel.addClass("chart-list-loaded");
					}
				};
				$.setGridPageHeightOption(options);
				po.open("${contextPath}/chart/select?multiple", options);
			}
			else
			{
				$.callPanelShowCallback(chartListPanel);
			}
		}
		else
		{
			chartListPanel.hide();
		}
	};
	
	po.insertEditorChart = function(chartWidgets)
	{
		var tabPane = po.getActiveResEditorTabPane();
		var codeEditorDiv = po.element(".code-editor", tabPane);
		var visualEditorIfm = po.element(".tpl-visual-editor-ifm", tabPane);
		
		if(codeEditorDiv.hasClass("show-editor"))
		{
			po.insertCodeEditorChart(tabPane, chartWidgets);
		}
		else if(visualEditorIfm.hasClass("show-editor"))
		{
			po.insertVisualEditorChart(tabPane, chartWidgets);
		}
	};
})
(${pageId});
</script>
</body>
</html>