All: milesToKPH celsToFahr inchesToFeet
LIB=libConversions.o
CC=gcc

Feet2Inches: Feet2Inches.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

F2C: F2C.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

ScaledInt: ScaledInt.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

KilosToMiles: KilosToMiles.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

MilesToHour: MilesToHour.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

KilosToMPH: KilosToMPH.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

milesToKPH: milesToKPH.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@
	
celsToFahr: celsToFahr.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

inchesToFeet: inchesToFeet.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
