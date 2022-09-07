# ead_comply

> now with support for digital objects!

This script uses sed to make several search and replace edits to finding aids exported from the ArchivesSpace browser interface and make them compliant with the requirements for uploading  to the Archival Resources in Wisconsin environment. 

## Installation

this script is designed to work in the Windows Subsystem for Linus (WSL). To install the subsystem follow these [instructions](https://docs.microsoft.com/en-us/windows/wsl/install). You can use any distribution with a posix compliant shell. If you don't know what that means install the latest Ubuntu distribution. 

Once you have a working linux instance you can clone this repository with git:

`git clone https://github.com/alattiswisc/uwmadarchives` 

Then you must make sure the script has execution privileges, for most systems this is:

`chmod +x prep_ead.sh`

## Usage

To use prep_ead simply invoke the script with your ead file as the first argument:

`./prep_ead uac00_0000000_00000_UTC__ead.xml`

The script will create a backup of the input file (file_name.bak) and a new file named with the Archival Resources in Wisconsin style.

This output file can be directly uploaded to Archival Resources in Wisconsin via SecureFX, however it is a good idea to open up the file in the oxygen xml editor and check for errors against the ead2002 DTD file. 

For the moment, the script will simply write to new files in the current working directory. For this reason it is best to copy your exported file into the same directory as the script and then move the output file to its final destination. 
