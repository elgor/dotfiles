# coding: utf-8
'''-------------------------------------------------------------
' Progname – a small description	
' @encode: 	UTF-8, tabwidth = 4, newline = LF
' @author: 	Emanuel Regnath
'----------------------------------------------------------- ''' 


#############################################################################
# 					O W N    F U N C T I O N S								#
############################################################################# 

## my own function
# @param myValue a random value 
def myfunction( myValue ):
	if(myValue == 10):
		print "Hallo World"
		return True
	else:
		return False


# creates global log object
# @param name the name of the logger
# @param level level of logging e.g. logging.DEBUG
# @author Emanuel Regnath
def setupLogging(self, level):
    global log
    scriptName = sys.argv[0]
    log = logging.getLogger(scriptName)
    log.setLevel(level)

    formatter = logging.Formatter('[%(levelname)s] %(message)s')

    sh = logging.StreamHandler()
    sh.setLevel(level)
    sh.setFormatter(formatter)
    log.addHandler(sh)

    fh = logging.FileHandler(scriptName+".log")
    fh.setLevel(logging.DEBUG)
    fh.setFormatter(formatter)
    log.addHandler(fh)


#############################################################################
#					M A I N   P R O G R A M									#
#############################################################################

# imports
import sys
import time 
import logging


setupLogging(1, logging.DEBUG)

# types: int, long, float, complex, bool, str, tuple, list, dic
b = 20	# type does not need to be specified
c = "Dies ist ein String!"
singleType = (1, 4, 5)
severalTypes = [1, "four", 3.1]
mapping = {b:1, c:3}


# relations: >,  <,  <=,  >=,  !=,  == 
# boolean: not, and, or 
if (b < 10 and True):
    pass
elif (b > 2):
    pass
else: 
    pass

for i in xrange(1, 10):
	print i


# Main Loop
log.info("Entering Loop")
while(1):
	myfunction(10)
	time.sleep(1) 
