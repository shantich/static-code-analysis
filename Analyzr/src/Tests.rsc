module Tests

import FileCleaner;
import LOC;
import String;

loc demofile = |project://Analysing/src/Main.java|;

test bool testRemoveComments(){
	str text = removeOverhead(demofile); 
	return  !contains(text,"/**") && !contains(text,"*/") && !contains(text,"/*");;
}

test bool testRemoveSingleLineComments(){
	str text = removeOverhead(demofile); 
	return  !contains(text,"//");
}

test bool testRemoveTabs(){
	str text = removeOverhead(demofile); 
	return  !contains(text,"\t");
}

test bool testRemoveBlankLines(){
	str text = removeOverhead(demofile); 
	return  !contains(text,"\n\n");
}

test bool testRemoveOverhead(){
	return computeLocForFile(demofile) == 57;
}