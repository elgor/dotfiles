
# target binary
BIN := main

# select compiler
CXX := gcc
CXXFLAGS = -Wall

# sources
SRC_EXT := .c
SRC_DIRS = .

# include paths (space separated)
INC_DIRS = . /usr/include

# library paths (space separated)
LIB_DIRS := . 

# where to store the objects
OBJ_DIR := .
OBJ_EXT := .o


# Do not etdit below this line
# ----------------------------------------------------

# find sources
SRCS := $(foreach sdir,$(SRC_DIRS),$(wildcard $(sdir)/*$(SRC_EXT)))

# collect includes
INCS += $(foreach idir,$(INC_DIRS),-I$(idir))

# collect libraries
LIBS += $(foreach ldir,$(LIB_DIRS),-L$(ldir))

# determine objects to build based on sources
OBJS := $(patsubst $(SRC_DIRS)/%$(SRC_EXT), $(OBJ_DIR)/%.o, $(SRCS))



# will be called even if newest files exists
.PHONY: clean

# compile sources to objects
all: main
	@echo "Searchpaths:"
	@echo "Includes: $(INCS)"
	@echo "Libraries: $(LIBS)"
	@echo "$(CXX) -o $(BIN) $(CXXFLAGS) $(INCS) $(LIBS)"


# link objects
main: $(OBJS)
	$(CXX) $^ -o $(BIN) $(CXXFLAGS) $(INCS) $(LIBS)

# compile sources to objects	
$(OBJ_DIR)/%$(OBJ_EXT):$(SRC_DIRS)/%$(SRC_EXT)
	$(CXX) -c $< $(CXXFLAGS) 
    
clean:
	rm $(BIN) $(OBJS) 
