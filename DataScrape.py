import dropbox
import os

#access token that gives the application access to the dropbox files
accessToken = "-c8fF8YucnMAAAAAAAAAAQ0GsrjtcsqbFNaYbArMqrZjlZN02eZfpGzr-1BfU50C";

#pass of the token to Dropbox and then stored in a variable dbx for quick access
dbx = dropbox.Dropbox(accessToken)


#list of all the dropbox folder names that we wish to scrape
folderType = ['Fibres', 'Film', 'Foam', 'Fragments', 'Pellets', 'Rubber', 'Spheres']

#For each folder download it's contents to the given local path
for type in folderType:
    dbx.users_get_current_account()
    localPath = r'C:/Users/Justin/Documents/GitHub/CompoundConnectdb/'
    localPath += type #append current folder to the local path
    dropboxPath = '/CompoundConnect Data/'
    dropboxPath += type #append current folder to the dropbox path
    #traverse the individual dropbox folder
    for entry in  dbx.files_list_folder(dropboxPath).entries:
        #prints the metadata for the images in the file
        print(entry)
        # downloads all files that end with .jpg and are not empty
        if entry.path_lower.endswith('.jpg') and entry.size>0: 
            #splits the path to return the individual filename
            local_filename = os.path.split(entry.path_lower)[-1] 
            #joins the file name retrieved above and joins it to the local path
            local_filepath = os.path.join(localPath, local_filename) 
            #if the path already exists move to the next file otherwise download the file
            if os.path.exists(local_filepath):
                continue
            dbx.files_download_to_file(local_filepath, entry.path_lower)
