module UnitSize

import util::Math;
import Constants;
import String;

public str getUnitSize(num LOC) {
	return getRiskLevel(LOC);
}

public UnitSize getUnitSizePercentages(UnitSize unitSize, num LOC) {
	UnitSize result = (SIMPLE:0,MODERATE:0,HIGH:0,VERY_HIGH:0);
	result[SIMPLE] = round((unitSize[SIMPLE] / LOC) * 100);
	result[MODERATE] = round((unitSize[MODERATE] / LOC) * 100);
	result[HIGH] = round((unitSize[HIGH] / LOC) * 100);
	result[VERY_HIGH] = round((unitSize[VERY_HIGH] / LOC) * 100);
	
	return result;
}

public Rank getUnitSizeRank(UnitSize unitSize) {
	if (unitSize[MODERATE] <= 25 && unitSize[HIGH] == 0 
		&& unitSize[VERY_HIGH] == 0) return FIVE;
	if (unitSize[MODERATE] <= 30 && unitSize[HIGH] <= 5 
		&& unitSize[VERY_HIGH] == 0) return FOUR;
	if (unitSize[MODERATE] <= 40 && unitSize[HIGH] <= 10 
		&& unitSize[VERY_HIGH] == 0) return THREE;
	if (unitSize[MODERATE] <= 50 && unitSize[HIGH] == 15 
		&& unitSize[VERY_HIGH] == 5) return TWO;
	return ONE;
}

private str getRiskLevel(num level) {
	if (level >= 0 && level < 21) return SIMPLE;
	if (level >= 21 && level < 51) return MODERATE;
	if (level >= 51 && level < 101) return HIGH;
	return VERY_HIGH;
}