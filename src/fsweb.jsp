<%@ page language="java" import="java.util.*,java.io.*,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
File logs = null;
String plogs = "/";
String filepath = request.getParameter("path");
if (filepath == null){
	filepath = "";
}
if("/".equals(filepath)){
	filepath = "";
}
if (filepath.isEmpty() ){
	logs = new File(System.getProperty("fsweb.dir")) ;
}else{
	logs = new File(new File(System.getProperty("fsweb.dir")),filepath);
	if(filepath.indexOf("/",1) > 1){
		plogs = filepath.substring(0,filepath.lastIndexOf("/"));
	}else{
		plogs = "/";
	}
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>fsweb</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
<style type="text/css">
table.gridtable {
	font-family: verdana,arial,sans-serif;
	font-size:11px;
	color:#333333;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}
table.gridtable th {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #dedede;
}
table.gridtable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}
</style>  
  <body>

<table width="100%" class="gridtable" >
	<tr>
		<th width="100%" nowrap="nowrap">上级目录：<a href="<%=basePath%>fsweb.jsp?path=<%=plogs%>" ><%=plogs%></a></th>
	</tr>
</table>    
  
<table width="100%" class="gridtable" >
<tr>
	<th width="65%">名称</th>
	<th width="10%" nowrap="nowrap">大小</th>
	<th width="15%" nowrap="nowrap">修改日期</th>
	<th width="10%">下载</th>
</tr>
<%
File[] files = logs.listFiles();
for(File file:files){
	String strDate = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date(file.lastModified()));
	if(file.isDirectory()){
%>    
<tr>
	<td width="65%"><a href="<%=basePath%>fsweb.jsp?path=<%=filepath+"/"+file.getName()%>" ><%=file.getName() %></a></td>
	<td width="10%" nowrap="nowrap"></td>	
	<td width="15%" nowrap="nowrap"><%=strDate %></td>
	<td width="10%"></td>
</tr>
<%
	}else{
		long fileSize = file.length();
		String displayFileSize = null;
		if (fileSize < 1024) {
			displayFileSize = fileSize + " byte";
		} else if (fileSize < 1024 * 1024) {
			displayFileSize = Math.round(fileSize / 1024.0f) + " KB";
		} else if (fileSize < 1024 * 1024 * 1024) {
			displayFileSize = Math.round(fileSize / (1024 * 1024.0f)) + " MB";
		} else {
			displayFileSize = Math.round(fileSize / (1024 * 1024 * 1024.0f)) + " GB";
		}
%>    
<tr>
	<td width="65%"><%=file.getName() %></td>
	<td width="10%" nowrap="nowrap"><%=displayFileSize %></td>	
	<td width="15%" nowrap="nowrap"><%=strDate %></td>
	<td width="10%"><a href="<%=basePath%>fsdown.jsp?file=<%=filepath+"/"+file.getName()%>" >下载</a></td>
</tr>
<%
}
}
%>   
</table>    
   
  </body>
</html>
