#!/bin/bash
# j rodriguez medina
# github: rodriguezmDNA
# twitter: @rodriguezmDNA
####################################
## Filter a FASTA file
# given a list (in txt format)
# Created 2019.02.26
# Last modified 2019.02.26



## Functions
#################
display_help() {
    echo "Usage: $0 [option...] " >&2
    echo
    echo "   -h            this helpful help"
    echo "   -i            Input single-lined FASTA file (.fa|.fasta extension)"
 echo -e "   -l            A list with names of genes of interest to filter the FASTA file:
                 Single column file (with no header)"
    echo "   -o            [optional] output file name"
    echo
    echo " if -o is not submitted, the program generates a new file with extension _SL.fa"
    echo -e "\n Don't panic!"
    # echo some stuff here for the -a or --add-options 
    exit 1
}

# If no argument send help
if [ $# -eq 0 ]
  then
    display_help
fi

verbose=false

while getopts ':h l:i:o: v' option; do
  case "$option" in
    h) display_help
       exit
       ;;
    i) inputFASTA=$OPTARG     ;;
    l) inputGOI=$OPTARG       ;;
    o) outputFASTA=$OPTARG    ;;
    v) verbose=true           ;; #Flag
    :) printf "missing value for -%s\n" "$OPTARG" >&2
       display_help
       exit 1
                              ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       display_help
       exit 1
                              ;;
  esac
done
shift $((OPTIND - 1))

## Check that the parameters aren't empty.
if [[  -z  $inputFASTA ]] ; then
	echo -e "\nNeed a FASTA file\n" >&2
	display_help
fi

if [[  -z  $inputGOI ]] ; then
  echo -e "\nNeed a list of genes to filter\n" >&2
  display_help
fi

if [[  -z  $outputFASTA ]] ; then
  outputFASTA="${inputFASTA%.fa*}_filtered.fa"
  echo "No output given, saving as $outputFASTA"
fi


if  ($verbose); then
  echo
  echo "Using $inputGOI, to filter $inputFASTA"
  echo "Saving to: $outputFASTA"
fi


echo `grep -A 1 -w -f  $inputGOI $inputFASTA |sed '/^--$/d' > $outputFASTA`


################################################################################################
####################################


## Record time
start_time=`date +%s`
## Get absolute path
#Get the full path of the current script: Go back one folder (from scripts to main)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

## Keep track of errors and outputs in a log.
logDir=$DIR/logs #Create log folder if it doesn't exist
if [ ! -d $logDir ]; then echo `mkdir -p $logDir`; fi

# A file for logs
logPath=$DIR/logs/$(basename $BASH_SOURCE .sh).log #Keeps the name of the script, use .log instead of scripts extension
##

echo `touch $logPath` #Create file to fill with log data
##
echo -e "-----------\nStarted on `date`" 2>&1 | tee $logPath #Start filling 
######



############ Here be functions
#############################################
#Functions help keep code minimal, avoid repeating lines, and just doing the same with diff values. 

#songOftheLonelyFunction () {
  #Write functions like this;
  #Do something with a $variable
  #}

#songOftheLonelyFunction variable1 #Call functions like this
#songOftheLonelyFunction variable2 

############ Code here 
#############################################







########################################################################################################################
########################################################################################################################

## Record time
end_time=`date +%s`

#echo -e "\nParameters used: $bwtParams"  2>&1 | tee -a $logPath
echo -e "\n execution time was `expr $end_time - $start_time` s."  2>&1 | tee -a $logPath
echo -e "\nDone `date` \n-----------"  2>&1 | tee -a $logPath
##Done