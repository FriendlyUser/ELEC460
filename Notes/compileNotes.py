# -*- coding: utf-8 -*-
"""
Created on Sun Dec 31 09:50:49 2017

@author: David Li
Helper script to create lwarpnotes, latex file should be set to \nonstopmode
"""

import subprocess,os,sys
# consider using command line arguments to prompt the user for input if being run from command line or hardcoded value if any arguements are passed through.
if len(sys.argv) > 1:
    input_tex_file = 'ELEC460Notes.tex'
else:
    input_tex_file = input("Enter the tex name. ")
input_name, input_extension = os.path.splitext(input_tex_file)
if os.path.isfile(input_tex_file):
    print('Proceeding to produce: %s.pdf and %s_html \n' % (input_tex_file, input_tex_file))
else:
    print('Check the file name again \n')
    
cmd_str1 = ' '.join(['pdflatex',
                    input_tex_file])   
## Consider adding a loop until continueNextStage = True
#continueNextStage = False
#trials = 0
#while continueNextStage == False and trials < 3:
try:
    subprocess.check_call(cmd_str1)
    print('Calling: ' + cmd_str1)
    continueNextStage = True
except subprocess.CalledProcessError:
    print('Error occured trying to call pdflatex %s' % input_tex_file)
    #trials = trials +1 
    pass # handle errors in the called executable
except OSError:
    print('Executable not found')
    pass # executable not found

lwarpHTMLFile = input_name +'_html' +  input_extension
cmd_str2 = ' '.join(['pdflatex',
                    lwarpHTMLFile])

### Consider calling lwarpmk limages and lwarpmk htmlglossary at this point and then compiling
if len(sys.argv) > 2:
    try:
        cmd_images = ' '.join(['lwarpmk',
                    'limages'])
        cmd_htmlglossary = ' '.join(['lwarpmk',
                    'htmlglossary'])
        subprocess.check_call(cmd_images)
        subprocess.check_call(cmd_htmlglossary)
        subprocess.check_call(cmd_str1)
        print('Creating glossary and images again for HTML.')
    except subprocess.CalledProcessError:
        print('Error occured, check the command')
        pass # handle errors in the called executable
    except OSError:
        print('Executable not found')
        pass # executable not found

# Try using latexmk to create html files
latexmk_cmd = ' '.join(['latexmk',
                       '-pdf',
                       '-time',
                    lwarpHTMLFile])
try:
    #subprocess.check_call(cmd_str2)
    #print('Calling: ' + cmd_str2)
    subprocess.check_call(latexmk_cmd)
    print('Calling: %s' % latexmk_cmd)
except subprocess.CalledProcessError:
    print('Error occured, check the command')
    pass # handle errors in the called executable
except OSError:
    print('Executable not found')
    pass # executable not found

cmd_str3 = ' '.join(['lwarpmk',
                    'pdftohtml'])
try:
    subprocess.check_call(cmd_str3)
    print('Calling: %s' % cmd_str3)
except subprocess.CalledProcessError:
    print('Error occured, check the command')
    pass # handle errors in the called executable
except OSError:
    print('Executable not found')
    pass # executable not found
print('Script is done producing the documents')

print('Cleaning up some auxillary files')
lwarpmk_clean = ' '.join(['lwarpmk',
                    'clean',
                    input_name])
latexmk_clean = ' '.join(['latexmk',
                          '-C'
                        ])
try:
    subprocess.check_call(lwarpmk_clean)
    print('Calling: %s' % lwarpmk_clean)
    subprocess.check_call(latexmk_clean)
    print('Calling: %s' % latexmk_clean)
except subprocess.CalledProcessError:
    print('Error occured, check the command')
    pass # handle errors in the called executable
except OSError:
    print('Executable not found')
    pass # executable not found
print('Now it will use prism.js and prism.css to highlight listings')

### Dump files into finalNotes directory
### Outputting results to latex file and then using pandoc

####################################################################################
####### Assuming that the user is already in the folder contain the tex files #######
# Change directory to where this script is
#os.chdir(os.path.dirname(sys.argv[0]))
#timestr = time.strftime("%Y%m%d-%H%M%S")
###################################################################################

directory = 'finalNotes'
if not os.path.exists(directory):
    os.makedirs(directory)
    # go to that new directory
    os.chdir(directory)
# Find the </title> end tag and add in my prism.css and prism.js
### open up tempalte file and do some editing, get syntax highlighting
# Assume their are not other html files in my directory and if they do, they shouldn't have  the lwarp <pre class="programlisting" >
lwarpFiles = []
dir_list =  os.listdir()
for full_file_name in dir_list:
    base_nameTemp, extensionTemp = os.path.splitext(full_file_name)
    if extensionTemp == '.html': # then .pdf file --> convert to image!
        lwarpFiles.append(full_file_name)

import re
for outputFile in lwarpFiles:      
    try:
        base_nameTemp, extensionTemp = os.path.splitext(outputFile)
        finalOutputName = base_nameTemp + extensionTemp
        htmlFile = open(outputFile ,'r',encoding='utf-8')
        htmlSyntaxFile = open(directory + r'/' +finalOutputName  ,'w',encoding='utf-8')
    except OSError:
        print('Cannot open files, probably because they are being used. \n')
        pass
    # include prismCss and prismjs in the final html final, consider merging the existing css file with prism.css
    prismCss = r'<link rel="stylesheet" href="prism.css" type="text/css">'
    prismJs  = r'<script src="prism.js" type="text/javascript"> </script>'
    
    # Replace the lwarp <pre class="programlisting" >
    # with something that works for prism
    lwarpCodeSyn = r'<pre class="programlisting" >' 
    lwarpCodeVerb = r'<pre class="verbatim" >'
    matlab ="language-matlab"
    latex = "language-latex"
    python = "language-python"
    bash = "language-bash"
    # Go through each even entry in replacements and then check if a replacement should happen
    replacementTerms = ["Latex Commands", latex, "Python Script", python, "Bash Script", bash]
    prismVerbCodeSyn = r'<pre><code class = "' + latex + r'">'
    prismCodeSyn = r'<pre><code class = "' + matlab + r'">'
    
    # Determines if the next pre tag should be changed
    changeNextPre = False
    #replacementLine = ""
    for line in htmlFile:
        # Include prism.js and prism.css after the title in the html document 
        newline = re.sub(r'</title>',r'</title>' + '\n' + prismCss + '\n' + prismJs, line)
        
        # CHange if the next pre tag should be changed, if it is not true already.
        if changeNextPre == False:
            for i in range (0, int(len(replacementTerms)/2)):
                # match only matches from the beginning of the string. Your code works fine if you do pct_re.search(line) instead. See https://stackoverflow.com/questions/17680631/python-regular-expression-not-matching
                pattern = re.compile(replacementTerms[i*2])
                changeNextPre = bool(re.search(pattern,newline))
                #print(r'<p>'+replacementTerms[i*2])
                if changeNextPre:
                    #print("Match Found")
                    replacementLine = r'<pre><code class = "' + replacementTerms[2*i+1] + r'">'
                    #print(replacementTerms)
                    break
        
        ## get code syntax highlighting
        if changeNextPre == False:
            # Assume matlab is being used
            newline = re.sub(lwarpCodeSyn, prismCodeSyn, newline)
        else:
            templine = re.subn(lwarpCodeSyn, replacementLine,newline)
            newline = templine[0]
            # if a match occurs reset changeNextPre to false
            if templine[1] > 0:
                changeNextPre = False
        ## since a new code tag is introduced it must be closed
        newline = re.sub(r'</pre>',r'</code>' + '\n' + r'</pre>' + '\n', newline)
        # account for new problem of <pre class="verbatim" > 
        #newline = re.sub( lwarpCodeVerb,  prismVerbCodeSyn, newline)
        htmlSyntaxFile.write(str(newline))
        #print(newline)
    
    htmlFile.close()
    htmlSyntaxFile.close()
print('Script is Done creating files')


### Note comand line prompt language is
#==============================================================================
# <pre class="command-line" data-prompt="PS C:\Users\Chris>" data-output="2-19"><code class="language-powershell">dir
# 
# 
#     Directory: C:\Users\Chris
# 
# 
# Mode                LastWriteTime     Length Name
# ----                -------------     ------ ----
# d-r--        10/14/2015   5:06 PM            Contacts
# d-r--        12/12/2015   1:47 PM            Desktop
# d-r--         11/4/2015   7:59 PM            Documents
# d-r--        10/14/2015   5:06 PM            Downloads
# d-r--        10/14/2015   5:06 PM            Favorites
# d-r--        10/14/2015   5:06 PM            Links
# d-r--        10/14/2015   5:06 PM            Music
# d-r--        10/14/2015   5:06 PM            Pictures
# d-r--        10/14/2015   5:06 PM            Saved Games
# d-r--        10/14/2015   5:06 PM            Searches
# d-r--        10/14/2015   5:06 PM            Videos</code></pre>
#==============================================================================
