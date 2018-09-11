/*
*定义Excel命名空间
*/
var Excel = {};

/*
*定义HtmlTableDesc类
*功能:描述需要导出到Excel文件中的Html Table对象的相关信息。
*/
Excel.HtmlTableDesc = function(htmlTable,sheetName,rowIndex,columnIndex)
{
	//Html Table对象 id属性
	if("string" == typeof(htmlTable))
	{
		this.htmlTable = document.getElementById(htmlTable);
	}
	else
	{
		this.htmlTable = htmlTable;
	}
	//Excel文件sheet名称
	this.sheetName = sheetName;
	//Html Table在sheet中的行位置
	this.rowIndex = rowIndex;
	//Html Table在sheet中的列位置
	this.columnIndex = columnIndex;
}

/*
*定义ExcelExporter类
*功能:描述需要导出到Excel文件中的Html Table对象的相关信息。
*/
Excel.ExcelExporter = function(htmlTableDescArray)
{
	this.htmlTableDescArray = htmlTableDescArray;
	
	/*
	*从html table中取出数据和样式
	*/
	this.convertHtmlTableToXml = function(htmlTableDesc)
	{
		var htmlTable =  htmlTableDesc.htmlTable;
		var xmlTable =
			'<table sheet=\"' + encodeURI(htmlTableDesc.sheetName) + '\" '+
				   'rowIndex=\"' + htmlTableDesc.rowIndex +'\" '+
				   'columnIndex=\"'+ htmlTableDesc.columnIndex + '\">';
				   
		for(var i =0;i<htmlTable.rows.length;i++ )
		{
			var row = htmlTable.rows[i];
			xmlTable += '<tr>';
			for(var j = 0;j<row.cells.length;j++)
			{
				var cell = row.cells[j];
				if("none" == cell.style.display)
					continue;
			
				var cellStyle = this.getCellStyle(cell);
				xmlTable +='<td'+ cellStyle +'>'+ this.getCellText(cell) + '</td>';
			}
			xmlTable += '</tr>';
		}
		xmlTable += '</table>';
	
		return xmlTable;
	};
	
	/*
	*获取单元格数据
	*/
	this.getCellText = function(cell)
	{
		var cellText = "";
		
		var selects = cell.getElementsByTagName("select");
		if(selects.length > 0)
		{
			var selectedOption =  selects[0].options[selects[0].selectedIndex];
			cellText = selectedOption.innerText;
		}
			
		if("" == cellText)
		{
			var inputs = cell.getElementsByTagName("input");
			if(inputs.length > 0)
				cellText = inputs[0].value;
		}
		
		if("" == cellText)
		{
			
			cellText = cell.innerText;	
		}
			
		cellText = encodeURI(cellText);
		return cellText;
	};
	
	/*
	*获取单元格样式
	*/
	this.getCellStyle = function(cell)
	{
		var cellStyle = '';

		var cellBGColor = this.getCellBGColor(cell);
		if(undefined != cellBGColor)
		{
			cellStyle += ' cellBGColor="'+ cellBGColor+'"';
		}
	
		var cellColor = this.getCellColor(cell);
		if(undefined != cellColor)
		{
			cellStyle += ' cellColor="'+ cellColor + '"';
		}
	
		var cellColSpan = this.getCellColSpan(cell);
		if(undefined != cellColSpan)
		{
			cellStyle += ' cellColSpan="'+ cellColSpan + '"';
		}
		
		var cellAlign = this.getCellAlign(cell);
		if(undefined != cellAlign)
		{
			cellStyle += ' cellAlign="'+ cellAlign + '"';
		}
	
		return cellStyle;
	};
	
	/*
	*获取单元格背景颜色
	*/
	this.getCellBGColor = function(cell)
	{
		var cellBGColor = cell.bgColor;
		if(this.isRGB(cellBGColor))
			return cellBGColor.toUpperCase();
		
		cellBGColor = cell.style.backgroundColor;
		if(this.isRGB(cellBGColor))
			return cellBGColor.toUpperCase();
			
		cellBGColor = cell.currentStyle.backgroundColor;
		if(this.isRGB(cellBGColor))
			return cellBGColor.toUpperCase();

		return undefined;
	};
	
	/*
	*获取单元格字体颜色
	*/
	this.getCellColor = function(cell)
	{
		var cellColor = cell.color;
		if(this.isRGB(cellColor))
			return cellColor.toUpperCase();
		
		cellColor = cell.style.color;
		if(this.isRGB(cellColor))
			return cellColor.toUpperCase();
			
		cellColor = cell.currentStyle.color;
		if(this.isRGB(cellColor))
			return cellColor.toUpperCase();

		return undefined;
	};
	
	/*
	*获取单元格合并列数
	*/
	this.getCellColSpan = function(cell)
	{
		var cellColSpan = cell.colSpan;
		return cellColSpan;
	};
	
	/*
	*判断color是否是RGB色彩,例:#ff0c21
	*/
	this.isRGB = function(color)
	{
		if('' == color || !color)
			return false;
		
		var regExp = new RegExp(/^#([0-9]|[a-f]|[A-F]){6}$/g);
		if(!regExp.test(color))
			return false;
		
		return true;
	};
	
	this.getCellAlign = function(cell)
	{
		var cellAlign = cell.align;
		if("" == cellAlign || !cellAlign)
			return undefined;
		return cellAlign.toUpperCase();
	};
	
	/*
	*导出Excel文件
	*/
	this.exportToExcel = function()
	{
		var xmlTables = '<tables>';
		var htmlTableDescNum = this.htmlTableDescArray.length;
		for(var i=0;i<htmlTableDescNum;i++)
		{
			var htmlTableDesc = this.htmlTableDescArray[i];
			xmlTables += this.convertHtmlTableToXml(htmlTableDesc);
		}
		xmlTables += '</tables>';
		
		var ajax=
			new Ajax('com.isc.eos.common.ExcelExport.excelExport.exportXmlTableToExcel.biz',false);
		ajax.addParam("tableData", xmlTables);
	
		var downloadWindow = null;
		ajax.onSuccess = function()
			{
				var excelFilePath= ajax.getValue('/root/data/excelFilePath');
			
				var url =
					"com.isc.eos.common.ExcelExport.downloadExcelFileflow..action" +
					"?excelFilePath=" + excelFilePath;
				var target = "_blank";
				var paras = "alwaysLowered=yes,toolbar=no,menubar=no,titlebar=no,scrollbars=no,width=0,height=0";
				downloadWindow = window.open(url ,target,paras);
			};
		ajax.submit();
	};
	
	/*
	*导出Excel文件
	*/
	this.exportToExcel2 = function(fileName)
	{
		var xmlTables = '<tables>';
		var htmlTableDescNum = this.htmlTableDescArray.length;
		for(var i=0;i<htmlTableDescNum;i++)
		{
			var htmlTableDesc = this.htmlTableDescArray[i];
			xmlTables += this.convertHtmlTableToXml(htmlTableDesc);
		}
		xmlTables += '</tables>';
		
		var ajax=
			new Ajax('com.intasect.eos.common.ExcelExport.excelExport.exportXmlTableToExcel.biz',false);
		ajax.addParam("tableData", xmlTables);
	    //alert(fileName);
		var downloadWindow = null;
		ajax.onSuccess = function()
			{
				var excelFilePath= ajax.getValue('/root/data/excelFilePath');
				var url =
					"com.intasect.eos.common.ExcelExport.DownloadExcelFileflow2..action" +
					"?excelFilePath=" + excelFilePath+"&dwf=" +encodeURI(fileName);
				var target = "_blank";
				var paras = "alwaysLowered=yes,toolbar=no,menubar=no,titlebar=no,scrollbars=no,width=0,height=0";
				downloadWindow = window.open(url ,target,paras);
			};
		ajax.submit();
	};
	
	/*
	*导出Excel文件
	*/
	this.createExcel = function(fileName)
	{
		var xmlTables = '<tables>';
		var htmlTableDescNum = this.htmlTableDescArray.length;
		for(var i=0;i<htmlTableDescNum;i++)
		{
			var htmlTableDesc = this.htmlTableDescArray[i];
			xmlTables += this.convertHtmlTableToXml(htmlTableDesc);
		}
		xmlTables += '</tables>';
		
		var ajax=
			new Ajax('com.intasect.eos.common.ExcelExport.excelExport.exportXmlTable2Excel.biz',false);
		ajax.addParam("tableData", xmlTables);
		ajax.addParam("fileName", fileName);//文件名
		ajax.submit();
	};
}