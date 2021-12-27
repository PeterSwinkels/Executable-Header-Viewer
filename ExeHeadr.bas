DEFLNG A-Z


ExeFile$ = "\gp\gp.exe"

CLS
OPEN ExeFile$ FOR INPUT AS 1: CLOSE 1
OPEN ExeFile$ FOR BINARY AS 1
 MZ$ = INPUT$(2, 1)
 ImageLength = CVI(INPUT$(2, 1))
 FileSize = CVI(INPUT$(2, 1))
 Relocations = CVI(INPUT$(2, 1))
 HeaderSize = CVI(INPUT$(2, 1))
 MinParagraphs = CVI(INPUT$(2, 1))
 MaxParagraphs = CVI(INPUT$(2, 1))
 SSOffset = CVI(INPUT$(2, 1))
 SP = CVI(INPUT$(2, 1))
 PGMChecksum = CVI(INPUT$(2, 1))
 EntryPoint = CVI(INPUT$(2, 1))
 CSOffset = CVI(INPUT$(2, 1))
 FirstRelocation = CVI(INPUT$(2, 1))
 OverlayNumber = CVI(INPUT$(2, 1))
CLOSE 1

PRINT "00 "; MZ$
PRINT "02 "; ImageLength
PRINT "04 "; FileSize
PRINT "06 "; Relocations
PRINT "08 "; HeaderSize
PRINT "0A "; MinParagraphs
PRINT "0C "; MaxParagraphs
PRINT "0E "; SSOffset
PRINT "10 "; SP
PRINT "12 "; PGMChecksum
PRINT "14 "; EntryPoint
PRINT "16 "; CSOffset
PRINT "18 "; FirstRelocation
PRINT "1A "; OverlayNumber

