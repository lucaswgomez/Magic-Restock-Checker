# Magic Restock Checker
Amazon Restock script in Powershell

Script designed to send an email & auditory alert when a restock happens.
The current process is to check Amazon by launching & refreshing a IE browser window until the seller "Amazon.com" is available to purchase throuh. This is to avoid buying from 3rd party resellers at a premium. Ideally this would be all done within a command line however Amazon does block site requests when sent through a command line such as Powershell in this case.

# Features
    - Email messaging system
    - Sound Alert

# Settings
Currently the time increments for checks are hard coded to:
	- 10 seconds when waiting
	- 5 seconds when currently in stock
Currently the product hard coded is for: Time Spiral: Remastered

# TODO
	-Add GUI
	- Refactor code to work entirely within a command line window.
	- Add automatic purchasing

