#!/bin/bash

# Redeclare these as needed in the main scripts

LOGFILE="./log.txt"     # Default logfile name

# Colors & Text attributes
LF="\n"; CR="\r"
INVT="\033[7m"; NORM="\033[0m"; BOLD="\033[1m"; BLINK="\033[5m"
UNDR="\033[4m"; EOL="\033[0K"; EOD="\033[0J"
SOD="\033[1;1f"; CUR_UP="\033[1A"; CUR_DN="\033[1B"; CUR_LEFT="\033[1D"
CUR_RIGHT="\033[1C"

#-- ANSI code
SCR_HOME="\033[0;0H" #-- Home of the display
BLACK_F="\033[30m"; BLACK_B="\033[40m"
RED_F="\033[31m"; RED_B="\033[41m"
GREEN_F="\033[32m"; GREEN_B="\033[42m"
YELLOW_F="\033[33m"; YELLOW_B="\033[43m"
BLUE_F="\033[34m"; BLUE_B="\033[44m"
MAGENTA_F="\033[35m"; MAGENTA_B="\033[45m"
CYAN_F="\033[36m"; CYAN_B="\033[46m"
WHITE_F="\033[37m"; WHITE_B="\033[47m"

