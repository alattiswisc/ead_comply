# ead_comply

> now with support for digital objects!

This script uses sed to make several search and replace edits to finding aids exported from the ArchivesSpace browser interface and make them compliant with the requirements for uploading  to the Archival Resources in Wisconsin environment. 

## Installation

this script is designed to work in the Windows Subsystem for Linus (WSL). To install the subsystem follow these [instructions](https://docs.microsoft.com/en-us/windows/wsl/install). You can use any distribution with a posix compliant shell. If you don't know what that means, install the latest Ubuntu distribution. 

Once you have a working linux instance you can clone this repository with git:

`git clone https://github.com/alattiswisc/uwmadarchives` 

Then you must make sure the script has execution privileges, for most systems this is:

`chmod +x prep_ead.sh`

## Usage

### Short version:

To use prep_ead simply invoke the script with your ead file as the first argument:

`./prep_ead uac00_0000000_00000_UTC__ead.xml`

The script will create a backup of the input file (file_name.bak) and a new file named with the Archival Resources in Wisconsin style.

This output file can be directly uploaded to Archival Resources in Wisconsin via SecureFX, however it is a good idea to open up the file in the oxygen xml editor and check for errors against the ead2002 DTD file. 

### Detailed instructions:

The script currently works by editing a file in place in the same directory as the script. To use it, first create a copy of the xml file exported from ArchivesSpace. Any method will do, but to reliably do this from the command line you can issue a `cp` command. Files in the Windows file system can be accessed from the /mnt/c directory in the linux command line. If your current working directory is the location of the script then you can issue:

`cp /mnt/c/Users/YOUR_USER_NAME/Documents/NAME_OF_EXPORTED_FILE.xml .`  

In the above command `.` will be expanded by the shell to your current directory's name. To check that all has gone well you can issue the `ls` command. If you see both the script (`prep_ead.sh`) and your input file is the list of files returned you are ready to run. 

NOTE: Do not change the name of the file as exported from ArchivesSpace. The script uses the original name of the file to create the ead id.  

Once this is done you can now run the script as above:

`./prep_ead.sh uac00_0000000_00000_UTC__ead.xml`

If it runs successfully the script will display two messages, one with the name of the backup file and another with the name of the output file. You can then copy  the output file back to the Windows file system with `cp`. In this case you want to provide the location on the Windows side as the second argument:

`cp uac00.xml /mnt/c/Users/YOUR_USER_NAME/Documents/`

You can then delete the backup file if desired. To finish the upload process simply move the file to the UWDCC servers as normal. If desired you can open the output file in Oxygen to spot check accuracy. 

NB: WSL will automatically mount the local C:\ drive at `/mnt/c` this means that you can copy files from anywhere on the C:\ drive to the current directory in wsl with `cp /mnt/c/Users/user_name/path/to/ead .`
