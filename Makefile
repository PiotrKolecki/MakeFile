# universal Makefile V 0.5.1
# Piotr Kolecki

CXX = g++
CXXFLAGS = -g -Wall
SRC = $(wildcard *.cpp)
OBJ = $(SRC:.cpp=.o)
HDR = $(wildcard *.h)
OUT = output.exe

DAT=`date +'_%H_%m_%s'`
DIR=`basename \`pwd\``

all : clear $(OUT)

$(OUT) : $(OBJ)
	$(CXX) $(CXXFLAGS) $(OBJ) -o $@
%.o : %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

.PHONY : all release backup clear run test class
.SILENT : release

release : all
	mkdir ./release/
	cp $(OUT) ./release/
	cp $(SRC) ./release/
	cp $(HDR) ./release/
	cp Makefile ./release/
	rm $(OUT)
	rm *.o
	tar -czf $(DIR).tar.gz ./release/
backup : all
	mkdir ./backup$(DAT)/
	cp $(SRC) ./backup$(DAT)/
	cp $(HDR) ./backup$(DAT)/
	cp Makefile ./backup$(DAT)/
clear : 
	rm -f $(OUT)
	rm -f *.o
run : $(OUT)
	./$(OUT)
test : $(OUT)
	valgrind --leak-check=full ./$(OUT)
class : 
	@echo "insert class name"
	@read -p "" CLS; \
	touch $$CLS.h $$CLS.cpp; \
	echo "#pragma once\n" > $$CLS.h; \
	echo "class $$CLS {\n	" >> $$CLS.h; \
	echo "	private :\n		" >> $$CLS.h; \
	echo "	public :\n		" >> $$CLS.h; \
	echo "};" >> $$CLS.h; \
	echo "#include \"$$CLS.h\"" > $$CLS.cpp; \
