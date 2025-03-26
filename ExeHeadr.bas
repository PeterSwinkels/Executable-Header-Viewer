DEFINT A-Z

TYPE HeaderStr
 Signature AS STRING * 2
 ImageLength AS INTEGER
 FileSize AS INTEGER
 Relocations AS INTEGER
 HeaderSize AS INTEGER
 MinParagraphs AS INTEGER
 MaxParagraphs AS INTEGER
 SS AS INTEGER
 SP AS INTEGER
 PGMChecksum AS INTEGER
 IP AS INTEGER
 CS AS INTEGER
 FirstRelocation AS INTEGER
 OverlayNumber AS INTEGER
END TYPE

DECLARE SUB DisplayHeader (ExeFile AS STRING)
DECLARE SUB DisplayRelocations (ExeFile AS STRING, FirstRelocation AS INTEGER, Count AS INTEGER)
DECLARE SUB GetHeader (ExeFile AS STRING, Header AS HeaderStr)

DIM ExeFile AS STRING

 ExeFile = COMMAND$

 IF LTRIM$(RTRIM$(ExeFile)) = "" THEN
  PRINT
  PRINT "EXE Header v1.01 - by: Peter Swinkels, ***2025***"
  PRINT
  PRINT "Specify an executable as a command line argument."
 ELSE
  DisplayHeader ExeFile
 END IF

SUB DisplayHeader (ExeFile AS STRING)
DIM Header AS HeaderStr

 GetHeader ExeFile, Header

 PRINT ExeFile; ":"
 PRINT "00 -             Signature: "; Header.Signature
 PRINT "02 -          Image length: "; HEX$(Header.ImageLength)
 PRINT "04 -             File size: "; HEX$(Header.FileSize)
 PRINT "06 -      Relocation count: "; HEX$(Header.Relocations)
 PRINT "08 -           Header size: "; HEX$(Header.HeaderSize)
 PRINT "0A -       Min. paragraphs: "; HEX$(Header.MinParagraphs)
 PRINT "0C -       Max. paragraphs: "; HEX$(Header.MaxParagraphs)
 PRINT "0E -         Stack segment: "; HEX$(Header.SS)
 PRINT "10 -         Stack pointer: "; HEX$(Header.SP)
 PRINT "12 -          PGM checksum: "; HEX$(Header.PGMChecksum)
 PRINT "14 -   Instruction pointer: "; HEX$(Header.IP)
 PRINT "16 -          Code segment: "; HEX$(Header.CS)
 PRINT "18 - First relocation item: "; HEX$(Header.FirstRelocation)
 PRINT "1A -        Overlay number: "; HEX$(Header.OverlayNumber)
 PRINT

 DisplayRelocations ExeFile, Header.FirstRelocation, Header.Relocations
END SUB

DEFLNG A-Z
SUB DisplayRelocations (ExeFile AS STRING, FirstRelocation AS INTEGER, Count AS INTEGER)
DIM Offset AS LONG
DIM Segment AS LONG

 FileH = FREEFILE
 OPEN ExeFile FOR INPUT LOCK READ WRITE AS FileH
 CLOSE FileH
 
 FileH = FREEFILE
 OPEN ExeFile FOR BINARY LOCK READ WRITE AS FileH
  IF Count > 0 THEN
   SEEK #FileH, FirstRelocation - &H1
   FOR Relocation = &H0 TO Count - &H1
    Offset = CVI(INPUT$(&H2, FileH))
    Segment = CVI(INPUT$(&H2, FileH))
    PRINT HEX$(Segment); ":"; HEX$(Offset)
   NEXT Relocation
  END IF
 CLOSE FileH
END SUB

SUB GetHeader (ExeFile AS STRING, Header AS HeaderStr)
 FileH = FREEFILE
 OPEN ExeFile FOR INPUT LOCK READ WRITE AS FileH
 CLOSE FileH

 FileH = FREEFILE
 OPEN ExeFile FOR BINARY LOCK READ WRITE AS FileH
  GET FileH, , Header
 CLOSE FileH
END SUB

