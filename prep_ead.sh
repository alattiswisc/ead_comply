#! /usr/bin/bash

#==========================================================#
# prep_ead.sh                                              #
#                                                          #
# sed script to make ArchivesSpace EAD exports compliant   #
# with Archival Resources in Wisconsin formatting          #
# requirements                                             #
#                                                          #
# The script will create a backup with the name            #
# INPUT_FILE.bak and then edit the input file in place.    #
# Once the edits are made the input file will be renamed.  #
#                                                          #
# @author "Tony Lattis"                                    #
# @email "alattis@wisc.edu"                                #
# UW-Archives                                              #
# September 2022                                           #
#==========================================================#

#==========================================================#
# Configuration                                            #
#==========================================================#

useage() {
    echo "Useage:  prep_ead.sh /path/to/file"
    exit 1
}

# hard-coded VARS go here
EAD_PREFIX='uw-ua-'

#==========================================================#
# Main                                                     #
#==========================================================#

# machine VARS go here
INPUT_FILE_NAME=$1
stringZ=$(grep -oP ">uw-ua-.+</eadid>" $1)
stringY=${stringZ:7}
EAD_ID=${stringY::-8}
DATE_NORMAL=$(date +%Y-%m)

# make a backup file
echo "creating backup file: ${1}.bak"
cp $1 ${1}.bak

# drop xml name spaces and insert ID attribute
sed -i "s/<ead xmlns.*><eadheader/<ead id=\"${EAD_PREFIX}${EAD_ID}\"><eadheader/" $1

# edit mainagencycode
sed -i "s/US-wimauma/wimauma/" $1

# drop type="simple"
sed -i "s/ xlink:type=\"simple\"\/><\/addressline>/\/><\/addressline>/" $1

# drop all xlink:
sed -i "s/xlink://g" $1

# add attrs to date statement
sed -i "s/<creation>This finding aid was produced using ArchivesSpace on <date>/<creation>This finding aid was produced using ArchivesSpace on <date era=\"ce\" calendar=\"gregorian\" type=\"publication\" normal=\"${DATE_NORMAL}\">/" $1

# edit <repository> for logo text
sed -i "s/<corpname>.*<\/corpname>/<extptr entityref=\"uwliblogo\" show=\"embed\" actuate=\"onload\" altrender=\"center\" title=\"University of Wisconsinâ€”Madison Libraries logo\" role=\"logoimage\"\/><extref linktype=\"simple\" href=\"https:\/\/www.library.wisc.edu\/archives\/\" role=\"handle\">University of Wisconsin-Madison. University Archives and Records Management<\/extref>/" $1

# edit Library of Congress Subject Headings
sed -i "s/source=\"Library of Congress Subject Headings\"/source=\"lcsh\"/g" $1

# change all onRequest to onrequest
sed -i "s/onRequest/onrequest/g" $1

# change all type="simple" to linktype="simple"
sed -i "s/ type=\"simple\"/ linktype=\"simple\"/g" $1

# rename file 
echo "edits complete renaming file: ${EAD_ID}.xml"
mv $1 ${EAD_ID}.xml
