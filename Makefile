# universal Makefile V 0.3
# Piotr Kolecki

CXX = g++
CXXFLAGS = -g -Wall
SRC = $(wildcard *.cpp)
OBJ = $(SRC:.cpp=.o)
HDR = $(wildcard *.h)

DAT=`date +'%d-%m_%H-%M'`
DIR=`basename \`pwd\``

all : output.exe

output.exe : $(OBJ)
	$(CXX) $(CXXFLAGS) $(OBJ) -o $@
%.o : %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

.PHONY : all release backup clear run
.SILENT : release

release : all
	mkdir ./release/
	cp output.exe ./release/
	cp $(SRC) ./release/
	cp $(HDR) ./release/
	cp Makefile ./release/
	cp Doxyfile ./release/
	rm output.exe
	rm *.o
	tar -czf $(DIR).tar.gz ./release/
backup : all
	mkdir ./backup$(DAT)/
	cp $(SRC) ./backup$(DAT)/
	cp $(HDR) ./backup$(DAT)/
	cp Makefile ./backup$(DAT)/
	cp Doxyfile ./backup$(DAT)/
clear : 
	rm output.exe
	rm *.o
run : output.exe
	./output.exe
