
# target binary
BIN := main

# compiler and flags
CXX := gcc
CXXFLAGS = -Wall -lm

# source paths (space separated)
SRC_DIRS = .
SRC_EXT := .c

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
# OBJS := $(patsubst $(SRC_DIRS)/%$(SRC_EXT), $(OBJ_DIR)/%, $(SRCS:$(SRC_EXT)=$(OBJ_EXT)))
OBJS := $(addprefix $(OBJ_DIR)/,$(SRCS:$(SRC_EXT)=$(OBJ_EXT)))


# will be called even if newest files exists
.PHONY: clean


$(info Compiler flags: $(CXXFLAGS))
$(info Includes: $(INCS))
$(info Libraries: $(LIBS))
$(info Objects: $(OBJS))


# compile sources to objects
all: main
	@echo "$(CXX) -o $(BIN) $(CXXFLAGS) $(INCS) $(LIBS)"

# link objects
main: $(OBJS)
	$(CXX) $^ -o $(BIN) $(CXXFLAGS) $(INCS) $(LIBS)

# create directory if does not exist
dir_guard=@mkdir -p $(@D)

# compile sources to objects	
$(OBJ_DIR)/%$(OBJ_EXT): %$(SRC_EXT)
	$(dir_guard)
	$(CXX) -c $< $(CXXFLAGS) -o $@

clean:
	rm $(BIN) $(OBJS) 

