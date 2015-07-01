module Analyzr

import IO;
import String;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import util::Math;
import Complexity;
import UnitSize;
import CloneDetection;
import LOC;
import Constants;
import Output;

public loc testPrj = |project://playground/src|;
public loc smallsql = |project://smallsql0.21_src|;
public loc hsql = |project://hsqldb-2.3.1/hsqldb/src|;

public void analyse(loc project) {	
	Statistics stats = getEmptyStatistics();
	M3 model = getModel(project);

	print("analysing..");
	for ( <name,src> <- model@declarations) {
		if(isCompilationUnit(name)) {
			stats.LOC += computeLocForFile(src);
			stats.fileCount += 1;
		}
		
		if(isMethod(name)) {
			num locCurrentMethod = computeLocForFile(src);
			str riskLevelComplexity = getComplexityForMethod(name, model);
			str riskLevelUnitSize = getUnitSize(locCurrentMethod);
			stats.unitSize[riskLevelUnitSize] += locCurrentMethod;
			stats.complexity[riskLevelComplexity] += locCurrentMethod;
			stats.clones = detectClones(name,src,stats.clones);
			stats.mLOC += locCurrentMethod;			
		}
	}
	
	println("done!\n");
	printStats(stats);
}

private M3 getModel(loc project) {
	print("creating M3 model..");
	M3 model = createM3FromEclipseProject(project);
	println("done!");
	
	return model;
}

private Statistics getEmptyStatistics() {
	UnitSize emptyUnitSize = (SIMPLE:0,MODERATE:0,HIGH:0,VERY_HIGH:0);
	Complexity emptyComplexity = (SIMPLE:0,MODERATE:0,HIGH:0,VERY_HIGH:0);
	Clones emptyClone = <(),()>;
	Statistics stats = <0,0,emptyComplexity,emptyUnitSize,0,emptyClone>;
	return stats;
}