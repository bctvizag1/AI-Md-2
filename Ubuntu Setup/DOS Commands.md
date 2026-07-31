The dir command in Windows is a built-in Command Prompt (CMD) tool used to list the files and subfolders contained within a specific directory. Running it by itself displays the contents of your current working directory, along with metadata like file sizes, modification dates, and remaining disk space. [1, 2, 3, 4] 
## Basic Usage Syntax
The foundational syntax for the command is:

### DIR [drive:][path][filename] [switches] [5] 

* dir: Lists files in the current folder.
* dir C:\Users: Lists files inside a specific folder.
* dir *.txt: Lists only files matching a specific extension (e.g., text files). [6, 7] 

## Common Switches (Options)
You can modify how dir behaves by adding switches: [3, 8] 

| Switch  | Description | Example |
|---|---|---|
| /S | Lists all files in the current folder and all its subfolders. | dir /s |
| /B | Uses bare format (displays only file/folder names, no metadata). | dir /b |
| /A | Displays files with specific attributes (e.g., H for hidden files). | dir /a:h |
| /O | Sorts the output (e.g., N by name, D by date, S by size). | dir /o:d |
| /P | Pauses after each screen of data (useful for large directories). | dir /p |
| /W | Displays the listing in a wide format (multiple items per row). | dir /w |

-------------------------

------------------------------
## Quick Summary Reference

| Goal | Command Example |
|---|---|
| Make a new folder | MD NewFolder |
| Go into a folder | CD NewFolder |
| Go back/up a folder | CD .. |
| Go back to the very start (Root) | CD \ |
| Change both drive and folder | CD /D E:\Photos |


-----------------------------

In DOS and Windows Command Prompt, commands like more that accept input from a pipe, modify or filter the data, and send it to the output screen are called Filter Commands [1].
Here are the primary built-in filter commands available in DOS and Windows:
## 1. FIND
Searches for a specific string of text within the data stream and only outputs lines that contain that text [1].

* Example: dir | find ".mp4"
* Result: Lists only the files that have the .mp4 video extension.

## 2. SORT
Alphabetically or numerically rearranges the text lines it receives from the pipe [1].

* Example: dir /b | sort
* Result: Displays a bare list of files sorted strictly in alphabetical order.
* Reverse Option: dir /b | sort /r sorts the list in reverse order (Z to A).

## 3. FINDSTR
An advanced version of find that allows you to search using complex patterns and Regular Expressions (Regex).

* Example: tasklist | findstr /i "chrome.exe discord.exe"
* Result: Checks running system processes and filters for only Chrome or Discord, ignoring upper/lowercase differences.

## 4. CLIP
Redirects the command line output away from the screen and places it directly onto your Windows clipboard instead.

* Example: dir | clip
* Result: The entire file directory listing is copied. You can immediately press Ctrl + V to paste it into Notepad, an email, or Word.

------------------------------
## Related Redirection Operators
While not commands themselves, these operators work alongside filters to handle text stream routing:

* `>` (Overwrite Redirect): Sends the output of a command to a file, deleting previous content in that file.   
(e.g., `dir > list.txt`)   
* `>>` (Append Redirect): Sends the output to a file but adds it to the very bottom, keeping your existing text safe    
(e.g., `dir >> list.txt`)  








