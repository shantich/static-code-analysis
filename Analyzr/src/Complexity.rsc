module Complexity

import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import util::Math;
import Constants;
import String;

public str getComplexityForMethod(loc name, M3 model) {
	num complexity = 1; // default Complexity
	
	visit(getMethodASTEclipse(name, model = model)) {
		case \case(_): complexity += 1;
		case \if(_,_,_): complexity += 1;
   		case \if(_,_): complexity += 1;
   		case \for(_,_,_): complexity += 1;
	   	case \for(_,_,_,_): complexity += 1;
		case \foreach(_,_,_): complexity += 1;
		case \while(_,_): complexity += 1;
		case \catch(_,_): complexity += 1;
	}
	
	return getRiskLevel(complexity);
}

public Complexity getComplexityPercentages(Complexity complexity, num LOC) {
	Complexity result = (SIMPLE:0,MODERATE:0,HIGH:0,VERY_HIGH:0);
	result[SIMPLE] = round((complexity[SIMPLE] / LOC) * 100);
	result[MODERATE] = round((complexity[MODERATE] / LOC) * 100);
	result[HIGH] = round((complexity[HIGH] / LOC) * 100);
	result[VERY_HIGH] = round((complexity[VERY_HIGH] / LOC) * 100);
	
	return result;
}

public Rank getComplexityRank(Complexity complexity) {
	if (complexity[MODERATE] <= 25 && complexity[HIGH] == 0 
		&& complexity[VERY_HIGH] == 0) return FIVE;
	if (complexity[MODERATE] <= 30 && complexity[HIGH] <= 5 
		&& complexity[VERY_HIGH] == 0) return FOUR;
	if (complexity[MODERATE] <= 40 && complexity[HIGH] <= 10 
		&& complexity[VERY_HIGH] == 0) return THREE;
	if (complexity[MODERATE] <= 50 && complexity[HIGH] == 15 
		&& complexity[VERY_HIGH] == 5) return TWO;
	return ONE;
}

private str getRiskLevel(num level) {
	if (level >= 0 && level < 11) return SIMPLE;
	if (level >= 11 && level < 21) return MODERATE;
	if (level >= 21 && level < 51) return HIGH;
	return VERY_HIGH;
}