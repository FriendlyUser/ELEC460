 #! python3
   # combinePdfs.py - Combines all the PDFs in the current working directory into
   # into a single PDF.

# This script requires the user to change the filename and working directory, ideally I would be able to include this requirements as arguments, but that will be added later.
import PyPDF2, os,sys

# For natural sorting
import re

_nsre = re.compile('([0-9]+)')
location = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
print("Running the script called, ", sys.argv[0])
## Use a website like http://www.unit-conversion.info/texttools/replace-text/
# This will allow for the proper slashing
# var = "C:/Users/wu/Downloads/University Fun/School/Summer 2017/ECON/Course Material (NOT EXAMS)"
os.chdir(location);
#filename = 'epictest.pdf'

# Get all the PDF filenames.
pdfFiles = []
# gets the pdfs in the directory of combinePdfs.py
#for filename in os.listdir('.'): 
numOfMergedFiles = 0
for filename in os.listdir('.'): 
   if filename.endswith('.pdf'): #consider adding regular expressions
       pdfFiles.append(filename)


def natural_sort_key(s):
    return [int(text) if text.isdigit() else text.lower()
            for text in re.split(_nsre, s)]  
                
pdfFiles.sort(key=natural_sort_key)


pdfWriter = PyPDF2.PdfFileWriter()
# Loop through all the PDF files.
for filename in pdfFiles:
    pdfFileObj = open(filename, 'rb')
    pdfReader = PyPDF2.PdfFileReader(pdfFileObj)
    # Loop through all the pages (except the first) and add them.

    pageObj = pdfReader.getPage(0)
    pdfWriter.addPage(pageObj)
    fun = pdfWriter.getNumPages() -1
    parent = pdfWriter.addBookmark(filename,fun) # add parent bookmark
    numOfMergedFiles = numOfMergedFiles + 1
    #for pageNum in range(1, pdfReader.numPages):
    # Loop through all the pages (except the first) and add them.
    for pageNum in range(1, pdfReader.numPages):
        pageObj = pdfReader.getPage(pageNum)
        pdfWriter.addPage(pageObj)


from easygui import enterbox as enterBox
outputFileName = enterBox()
pdfOutput = open(outputFileName, 'wb')
pdfWriter.write(pdfOutput)
pdfOutput.close()

print('The script is complete by ', numOfMergedFiles, ' merged files.')
#sys.exit(0)