<%@ page language="java" import="java.util.*,java.io.*"  pageEncoding="UTF-8"%>
<%
String file = request.getParameter("file");
OutputStream o = response.getOutputStream();
File fileLoad = new File(System.getProperty("fsweb.dir"),file);
response.reset();
response.setContentType("application/x-msdownload;charset=utf-8;");
response.setHeader("content-disposition","attachment;filename="+file);
long fileLength = fileLoad.length();
String length1 = String.valueOf(fileLength);
response.setHeader("Content_Length", length1);
FileInputStream in = new FileInputStream(fileLoad);
int n;
byte[] b = new byte[(int)fileLength];
while ((n = in.read(b)) != -1)
{
	o.write(b, 0, n);
}
in.close();
o.close();
%>