SYSTEM_ARCH=linux64
#or linux for 32 bit machines
SYSTEMC_HOME=/usr/local/systemc-2.3.1/
LIB_DIRS= $(SYSTEMC_HOME)/lib-linux64 

#include directories
INCLUDE_DIRS= -I. -I$(SYSTEMC_HOME)/include

DEPENDENCIES= Makefile $(HEADERS) $(SOURCES)

LIBS= -lsystemc -lstdc++ -lm 

#CXXFLAGS	:= -std=c++11 -O3 -Wall -Wextra -Wno-unused-parameter

SOURCES = main.cpp tb_driver.h tb_driver.cpp macro.h conv.h conv.cpp max_pooling.h max_pooling.cpp dense.h dense.cpp weights.hpp weights.cpp

DEPENDENCIES = \
		Makefile \
		$(HEADERS) \
		$(SOURCES)

LIBS= -lsystemc -lm

LDFLAGS= -Wl,-rpath=$(SYSTEMC_HOME)/lib-$(SYSTEM_ARCH)

#LDFLAGS		:= -lpng

TESTS= main

all: $(TESTS)
		./$(TESTS)
		 

$(TESTS): $(DEPENDENCIES)
		g++ $(CXXFLAGS) -o $@ $(SOURCES) $(INCLUDE_DIRS) -L$(LIB_DIRS) $(LIBS) $(LDFLAGS)
#HINT: tokens, following the ":" on the same line as the target are dependencies of that target. The command must be on the NEXT LINE, preceded by a TAB!!!
