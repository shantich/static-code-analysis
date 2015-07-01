# static-code-analysis

This project was a Lab assignment for the course Software Evolution at the University of Amsterdam during the Master Programm Software Engineering.

It is used to to measure code maintainability through static code analysis using the programming language Rascal (http://www.rascal-mpl.org/). The used metrics are based on the SIG Maintainability model invented by the Software Improvement Group (https://www.sig.eu/).

Reference: http://dx.doi.org/10.1109/QUATIC.2007.8


Usage:

1) Install Rascal
2) Start rascal console

Example:

```
rascal>import Analyzr;
ok

rascal>analyse(testPrj);
creating M3 model..done!
analysing..done!

------------------------------
|        MEASUREMENTS        |
------------------------------

Number of Files  | 107

Volume (LOC)     | Rank: ++ (0-8 MY)
                 | 5281 lines (Division: Methods 3826 lines (72%), Other 1455 (28%))

Unit Size        | Rank: --
                 | Risk: Low: 55%, Moderate: 8%, High: 6%, Very high: 4%

Unit Complexity  | Rank:  + (Total LOC)
                 | Risk: Low: 67%, Moderate: 0%, High: 5%, Very high: 0% (Total LOC)
                 | Risk: Low: 93%, Moderate: 0%, High: 7%, Very high: 0% (Method LOC)

Duplicates       | Rank:  +
                 | 4% of LOC

------------------------------
|          RESULTS           |
------------------------------

Maintainability  | Rank: ++ (Overall)

Analysability    | Rank: ++ (Volume, Duplication, Unit Size)

Changeability    | Rank:  + (Unit Complexity, Duplication)

Testability      | Rank:  - (Unit Complexity, Unit Size)
ok
```


