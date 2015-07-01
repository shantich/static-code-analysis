module CloneDetection

import IO;
import Set;
import Map;
import List;
import String;
import util::Math;
import Constants;
import FileCleaner;

public Clones detectClones(loc name, loc src, Clones clones) {
	list[str] lines = split("\n",removeOverhead(src));
	num offset = 1;
	
	while(size(lines) >= 6) {
		set[str] chunkLines = { x | x <- take(6,lines)};
		str chunkStr = intercalate("\n",take(6,lines));
		
		if (chunkStr in clones.chunks) {
			clones.chunks[chunkStr] += [<name,offset,offset+5>];
			
			for (<location,begin,end> <- clones.chunks[chunkStr]) {
				set[int] emptySet = {};
				clones.duplicates[location] ? emptySet += { x | x <- [begin..end]};
			}
		} else {
			clones.chunks[chunkStr] = [<name,offset,offset+5>];
		}
		
		lines = drop(1,lines);
		offset += 1;
	}
	
	return clones;
}

public num getClonePercentage(Statistics stats) {
	num duplicateLines = 0;
	
	for (key <- stats.clones.duplicates) {
		duplicateLines += size(stats.clones.duplicates[key]);
	} 
	
	return round(duplicateLines/stats.LOC*100);
}

public Rank getCloneRank(num percentage) {
	if (percentage >= 0 && percentage < 3) return FIVE;
	if (percentage >= 3 && percentage < 5) return FOUR;
	if (percentage >= 5 && percentage < 10) return THREE;
	if (percentage >= 10 && percentage < 20) return TWO;
	return ONE;
}