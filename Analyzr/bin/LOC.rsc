module LOC

import Constants;
import FileCleaner;
import util::Math;
import String;
import List;

public num computeLocForFile(loc src) {
	linesOfCodeFile = removeOverhead(src);
	return size(split("\n",linesOfCodeFile));
}

public Rank getLOCRank(num LOC) {
	num kloc = LOC/1000;
	if (kloc >= 0 && kloc < 66) return FIVE;
	if (kloc >= 66 && kloc < 246) return FOUR;
	if (kloc >= 246 && kloc < 665) return THREE;
	if (kloc >= 665 && kloc < 1310) return TWO;
	return ONE;
}

public str getManYears(Rank rank) {
	if (rank.rankValue == 5) return "(0-8 MY)";
	if (rank.rankValue == 4) return "(8-30 MY)";
	if (rank.rankValue == 3) return "(30-80 MY)";
	if (rank.rankValue == 2) return "(80-160 MY)";
	return "(\>160 MY)";
}