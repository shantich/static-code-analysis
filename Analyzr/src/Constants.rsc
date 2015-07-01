module Constants

import Set;
import List;
import String;
import util::Math;

public str SIMPLE = "Low";
public str MODERATE = "Moderate";
public str HIGH = "High";
public str VERY_HIGH = "Very high";

public Rank FIVE = <"++",5>;
public Rank FOUR = <" +",4>;
public Rank THREE = <" 0",3>;
public Rank TWO = <" -",2>;
public Rank ONE = <"--",1>;

alias Statistics = tuple[num LOC, num mLOC, Complexity complexity, UnitSize unitSize, num fileCount, Clones clones];

alias Clones = tuple[map[str,list[tuple[loc src,num begin, num end]]] chunks, map[loc,set[int]] duplicates];

alias Complexity = map[str,num];

alias UnitSize = map[str,num];

alias Rank = tuple[str rankStr,num rankValue];