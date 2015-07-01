module FileCleaner

import IO;
import String;
import List;

public num linesOfComments = 0;

public str removeOverhead(loc file) {
	linesOfComments = 0;
	str content = standardFormat(readFile(file));
	
	return removeLeadingLine(
		removeNewLines(
		removeTabs(
		removeComments(
		content))));
}

private str standardFormat(str content) {
	content = replaceAll(content,"\r\n","\n");
	for (/<newLine:[ ]{2,}>/ := content){
		content = replaceFirst(content,newLine,"");
	}
	
	return content;
}

private str removeTabs(str content){
	return replaceAll(content,"\t","");
}

private str removeNewLines(str content){
	for (/<newLine:\n{2,}>/ := content){
		content = replaceFirst(content,newLine,"\n");
	}
	
	return content;
}

private str removeLeadingLine(str content) {
	if (/<leadingLine:^[^a-zA-Z]+>/ := content)
    	content = replaceFirst(content,leadingLine,"");
  
  return content;
}

private str removeComments(str content) {
	return removeSingleLineComments(removeJavaDoc(content));
}

private str removeSingleLineComments(str content) {
	for (/<comment:\/\/[\s\S].*>/ := content) {
		content = replaceFirst(content,comment,"");
		linesOfComments += 1;
	}
	
	return content;
}

private str removeJavaDoc(str content) {
	for (/<jdoc:\/\*[\s\S]*?\*\/>/ := content) {
		content = replaceFirst(content,jdoc,"\n");
		linesOfComments = size(split("\n",jdoc));
	 }
	
	return content;
}