module Output

import IO;
import String;
import util::Math;
import Constants;
import Complexity;
import UnitSize;
import CloneDetection;
import LOC;

public void printStats(Statistics stats) {
	Complexity complexityPercentages = 
		getComplexityPercentages(stats.complexity,stats.LOC);
	Complexity complexityPercentagesExcl =
		getComplexityPercentages(stats.complexity,stats.mLOC);
	UnitSize unitSizePercentages = 
		getUnitSizePercentages(stats.unitSize,stats.LOC);
	num clonePercentage = getClonePercentage(stats);
	Rank locRank = getLOCRank(stats.LOC);
	Rank unitSizeRank = getUnitSizeRank(unitSizePercentages);
	Rank complexityRank = getComplexityRank(complexityPercentages);
	Rank cloneRank = getCloneRank(clonePercentage);
	Rank analysabilityRank = computeAnalysability(cloneRank, unitSizeRank, locRank);
	Rank testabilityRank = computeTestability(complexityRank, unitSizeRank);
	Rank changeabilityRank = computeChangebility(complexityRank, cloneRank);
	
	println("------------------------------
			'|        MEASUREMENTS        |
			'------------------------------\n
			'Number of Files  | <stats.fileCount>\n
			'Volume (LOC)     | Rank: <locRank.rankStr> <getManYears(locRank)>
			'                 | <formatLOC(stats)>\n
			'Unit Size        | Rank: <unitSizeRank.rankStr>
			'                 | Risk: <formatPercentages(unitSizePercentages)>\n
			'Unit Complexity  | Rank: <complexityRank.rankStr> (Total LOC)
			'                 | Risk: <formatPercentages(complexityPercentages)> (Total LOC)
			'                 | Risk: <formatPercentages(complexityPercentagesExcl)> (Method LOC)\n
			'Duplicates       | Rank: <cloneRank.rankStr>
			'                 | <clonePercentage>% of LOC\n
			'------------------------------
			'|          RESULTS           |
			'------------------------------\n
			'Maintainability  | Rank: <computeMaintainability(testabilityRank, 
									changeabilityRank, analysabilityRank).rankStr> (Overall)\n
			'Analysability    | Rank: <analysabilityRank.rankStr> (Volume, Duplication, Unit Size)\n
			'Changeability    | Rank: <changeabilityRank.rankStr> (Unit Complexity, Duplication)\n
			'Testability      | Rank: <testabilityRank.rankStr> (Unit Complexity, Unit Size)");
}

private str formatPercentages(map[str,num] percentages) {
	return "<SIMPLE>: <percentages[SIMPLE]>%, "
		+ "<MODERATE>: <percentages[MODERATE]>%, "
		+ "<HIGH>: <percentages[HIGH]>%, "
		+ "<VERY_HIGH>: <percentages[VERY_HIGH]>%";
}

private str formatLOC(Statistics stats) {
	num noneMethodLOC = stats.LOC - stats.mLOC;
	num methodPercentage = round(stats.mLOC/stats.LOC*100);
	num noneMethodLOCPercentage = round(noneMethodLOC/stats.LOC*100); 
	return "<stats.LOC> lines "
		+ "(Division: Methods <stats.mLOC> lines "
		+ "(<methodPercentage>%), Other <noneMethodLOC> "
		+ "(<noneMethodLOCPercentage>%))";
}

private Rank computeTestability(Rank complexity, 
		Rank unitSize) {
	return getRank((complexity.rankValue + unitSize.rankValue) / 2);
}

private Rank computeChangebility(Rank complexity, 
		Rank duplication) {
	return getRank((complexity.rankValue + duplication.rankValue) / 2);
}

private Rank computeAnalysability(Rank duplication, 
		Rank unitSize, Rank volume) {
	return getRank((duplication.rankValue + 
			unitSize.rankValue + volume.rankValue) / 2);
}

private Rank computeMaintainability(Rank testability, 
		Rank changeability, Rank analysability) {
	return getRank((testability.rankValue + changeability.rankValue 
			+ analysability.rankValue) / 2);
}

public Rank getRank(num number) {
	if (floor(number) == 1) return ONE;
	if (floor(number) == 2) return TWO;
	if (floor(number) == 3) return THREE;
	if (floor(number) == 4) return FOUR;
	return FIVE;
}