<?xml version="1.0" encoding="utf-8"?>

<!--
This is an XSL stylesheet which converts mscript XML files into XSLT.
Use the XSLT command to perform the conversion.

Based on: Ned Gulley and Matthew Simoneau, September 2003
Adjusted by Valery Khamenya 2013

Copyright 1984-2007 The MathWorks, Inc. 

-->

<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#160;"> ]>
<xsl:stylesheet
  version="1.0"
  exclude-result-prefixes="xalan str"	
  xmlns:xalan="http://xml.apache.org/xalan"
  xmlns:str="xalan://java.lang.String"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:escape="http://www.mathworks.com/namespace/latex/escape"
  xmlns:mwsh="http://www.mathworks.com/namespace/mcode/v1/syntaxhighlight.dtd">

  <xsl:output method="text" indent="no"/>



<xsl:template match="mscript">
%% Creator David Li
% Modified matlab xsl latex template file to suit needs
% Use find and replace 
%		\ensuremath with ''
%		<!-- \& with & -->
%	    \{ with { and \} with }
% This LaTeX was auto-generated from an M-file by MATLAB.
% To make changes, update the M-file and republish this document.

\documentclass{article}
\usepackage[
HomeHTMLFilename=index,     % Filename of the homepage.
%HTMLFilename={node-},       % Filename prefix of other pages.
IndexLanguage=english,      % Language for xindy index, glossary.
latexmk,                    % Use latexmk to compile.
%   OSWindows,                  % Force Windows. (Usually automatic.)
mathjax,                    % Use MathJax to display math.
]{lwarp}

\title{Assigment Uno}
\usepackage[utf8]{inputenc}
\usepackage{graphicx}
\usepackage{epstopdf}
\usepackage{color}
\usepackage{xcolor}
\usepackage{amsmath}
\usepackage[ocgcolorlinks]{hyperref}
\usepackage{bookmark}
\usepackage[hmargin=2cm,vmargin=2.5cm]{geometry}
\usepackage{fancyhdr}
\usepackage{booktabs}
\sloppy
\definecolor{lightgray}{gray}{0.5}
% \definecolor{myText}{HTML}{2B2B2B}
\definecolor{fontColor}{HTML}{171717}
\setlength{\parindent}{0pt}

\makeindex

\usepackage{listings}
\definecolor{mygreen}{RGB}{28,172,0} % color values Red, Green, Blue
\definecolor{mylilas}{RGB}{170,55,241}
\lstset{language=Matlab,%
	%basicstyle=\color{red},
	breaklines=true,%
	morekeywords={matlab2tikz},
	keywordstyle=\color{blue},%
	morekeywords=[2]{1}, keywordstyle=[2]{\color{black}},
	identifierstyle=\color{black},%
	stringstyle=\color{mylilas},
	commentstyle=\color{mygreen},%
	showstringspaces=false,%without this there will be a symbol in the places where there is a space
	%numbers=left,%
	%numberstyle={\tiny \color{black}},% size of the numbers
	%numbersep=9pt, % this defines how far the numbers are from the text
	emph=[1]{for,end,break},emphstyle=[1]\color{red}, %some words to emphasise
	%emph=[2]{word1,word2}, emphstyle=[2]{style},  
    captionpos=b,
    caption={Matlab Code Snippet:},
}
\usepackage{tcolorbox}
\tcbuselibrary{listings}
\tcbuselibrary{breakable}

<!-- Working Version  -->
<!-- \newtcblisting[auto counter,number within=section]{matlaboutput}[2][]{sharp corners, breakable,
    fonttitle=\bfseries, colframe=gray, listing only, 
    listing options={basicstyle=\ttfamily,language=Matlab, showstringspaces=false, breakatwhitespace=true, breaklines=true, tabsize=4}, 
    title=Code Snippet Output \thetcbcounter: #2, #1} -->

<!-- updated for printing paper document -->
\newtcblisting[auto counter,number within=section*]{matlaboutput}[2][]{sharp corners, breakable,
    fonttitle=\bfseries,colback=white, colframe=black!90, listing only, 
    listing options={language=Matlab, showstringspaces=false, breakatwhitespace=true, breaklines=true, tabsize=4}, 
    title=Matlab Output \thetcbcounter: #1} 
\begin{document}
<!-- Personal Names and Course Name and so on -->
\noindent \large{\textbf{ELEC 460 --- Assignment 1}\hfill Name: \textbf{David Li}, \hfill  Student Number: \textbf{V00818631}} \hrule
%\textbf{Due Date:} \today \hfill Student Number: \textbf{V00818631}

    <!-- Determine if the there should be an introduction section. -->
    <xsl:variable name="hasIntro" select="count(cell[@style = 'overview'])"/>
    <xsl:if test = "$hasIntro">
      <xsl:variable name="hasSteptitle" select="count(cell[1]/steptitle)"/>
      <xsl:if test = "$hasSteptitle">
\section*{<xsl:apply-templates select="cell[1]/steptitle"/>}
      </xsl:if>
<xsl:apply-templates select="cell[1]/text"/>
</xsl:if>
    
    <xsl:variable name="body-cells" select="cell[not(@style = 'overview')]"/>

    <!-- Include contents if there are titles for any subsections. -->
    <xsl:if test="count(cell/steptitle[not(@style = 'document')])">
      <xsl:call-template name="contents">
        <xsl:with-param name="body-cells" select="$body-cells"/>
      </xsl:call-template>
    </xsl:if>
    
    <!-- Loop over each cell -->
    <xsl:for-each select="$body-cells">
        <!-- Title of cell -->
        <xsl:if test="steptitle">
          <xsl:variable name="headinglevel">
            <xsl:choose>
              <xsl:when test="steptitle[@style = 'document']">section</xsl:when>
              <xsl:otherwise>subsection</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

\<xsl:value-of select="$headinglevel"/>*{<xsl:apply-templates select="steptitle"/>}
\addcontentsline{toc}{subsection}{<xsl:apply-templates select="steptitle"/>}
\phantomsection


        </xsl:if>

        <!-- Contents of each cell 
        <xsl:apply-templates select="text"/>
        <xsl:apply-templates select="mcode"/>
        <xsl:apply-templates select="mcodeoutput"/>
        <xsl:apply-templates select="img"/> 
-->

<xsl:apply-templates select="text|mcode|img|mcodeoutput"/>

    </xsl:for-each>


<xsl:if test="copyright">
\begin{par} \footnotesize \color{lightgray} \begin{flushright}
\emph{<xsl:apply-templates select="copyright"/>}
\end{flushright} \color{black} \normalsize \end{par}
</xsl:if>


\end{document}
    
</xsl:template>



<xsl:template name="contents">
  <xsl:param name="body-cells"/>
\tableofcontents
\newpage
</xsl:template>




<!-- HTML Tags in text sections -->
<xsl:template match="p">\begin{par}
<xsl:apply-templates/><xsl:text>
\end{par} \vspace{1em}
</xsl:text>
</xsl:template>

<xsl:template match="ul">\begin{itemize}
\setlength{\itemsep}{-1ex}
<xsl:apply-templates/>\end{itemize}
</xsl:template>
<xsl:template match="ol">\begin{enumerate}
\setlength{\itemsep}{-1ex}
<xsl:apply-templates/>\end{enumerate}
</xsl:template>
<xsl:template match="li">   \item <xsl:apply-templates/><xsl:text>
</xsl:text></xsl:template>

<xsl:template match="pre">
  <xsl:choose>
    <xsl:when test="@class='error'">
\begin{verbatim}<xsl:value-of select="."/>\end{verbatim}
    </xsl:when>
    <xsl:otherwise>
\begin{verbatim}<xsl:value-of select="."/>\end{verbatim}
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="b">\textbf{<xsl:apply-templates/>}</xsl:template>
<xsl:template match="tt">\texttt{<xsl:apply-templates/>}</xsl:template>
<xsl:template match="i">\textit{<xsl:apply-templates/>}</xsl:template>
<!--
<xsl:template match="a">\begin{verbatim}<xsl:value-of select="."/>\end{verbatim}</xsl:template>
-->
<xsl:template match="a">\href{<xsl:value-of select="@href"/>}{<xsl:value-of select="."/>}</xsl:template>



<xsl:template match="text()">
  <!-- Escape special characters in text -->
  <xsl:call-template name="replace">
    <xsl:with-param name="string" select="."/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="equation">
<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="latex">
    <xsl:value-of select="@text" disable-output-escaping="yes"/>
</xsl:template>
<xsl:template match="html"/>


<!-- Code input and output -->

<xsl:template match="mcode">\begin{lstlisting}[language = Matlab,frame=single,caption={}]
<xsl:value-of select="."/>
\end{lstlisting}
</xsl:template>


<xsl:template match="mcodeoutput">
  <xsl:choose>

    <xsl:when test="substring(.,0,8)='&lt;latex&gt;'">
<!-- 
The consequent commands are chained up into one mcodeoutput nodedle of the mcodeoutput after two consequent disp(['<latex></latex>']) injections
and that's why this hack with str:replaceAll , 
thats why one could get unwanted "</latex> <latex>" in the mid
-->
      <xsl:value-of select="str:replaceAll(str:new(str:replaceAll(str:new(substring(.,8,string-length(.)-16)), '&lt;latex&gt;' ,'')), '&lt;/latex&gt;' ,'')" 
                    disable-output-escaping="yes"/>
    </xsl:when>

    <!-- Old code
    <xsl:otherwise>
        \color{lightgray} \begin{verbatim}<xsl:value-of select="."/>\end{verbatim} \color{black}
    </xsl:otherwise>
    -->
    
    <xsl:otherwise>
         <!--\begin{tcblisting}{colback=green!5!white,colframe=green!10!black,listing only,hbox,breakable,before=\begin{center},after=\end{center}}<xsl:value-of select="."/>\end{tcblisting}
 \color{black} -->
 \begin{matlaboutput}{}<xsl:value-of select="."/>\end{matlaboutput}
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- Figure and model snapshots -->

<xsl:template match="img">
\begin{figure}
	\centering
	\includegraphics [width=0.7\linewidth]{<xsl:value-of select="@src"/>}
	\caption{$<xsl:value-of select="@src"/>$}
	%\caption{}
	% Alternative is to typeset the caption myself, which makes more sense to me.
	% \label{$fig:<xsl:value-of select="@src"/>$}
\end{figure}
</xsl:template>

<!-- Colors for syntax-highlighted input code -->

<xsl:template match="mwsh:code">\begin{verbatim}<xsl:apply-templates/>\end{verbatim}
</xsl:template>
<xsl:template match="mwsh:keywords">
  <span class="keyword"><xsl:value-of select="."/></span>
</xsl:template>
<xsl:template match="mwsh:strings">
  <span class="string"><xsl:value-of select="."/></span>
</xsl:template>
<xsl:template match="mwsh:comments">
  <span class="comment"><xsl:value-of select="."/></span>
</xsl:template>
<xsl:template match="mwsh:unterminated_strings">
  <span class="untermstring"><xsl:value-of select="."/></span>
</xsl:template>
<xsl:template match="mwsh:system_commands">
  <span class="syscmd"><xsl:value-of select="."/></span>
</xsl:template>


<!-- Used to escape special characters in the LaTeX output. -->

<escape:replacements>
  <!-- special TeX characters -->
  <replace><from>$</from><to>\$</to></replace>
  <replace><from>&amp;</from><to>\&amp;</to></replace>
  <replace><from>%</from><to>\%</to></replace>
  <replace><from>#</from><to>\#</to></replace>
  <replace><from>_</from><to>\_</to></replace>
  <!--<replace><from>{</from><to>\{</to></replace>
  <replace><from>}</from><to>\}</to></replace> -->
  <!-- mainly in code -->
  <replace><from>~</from><to>\ensuremath{\tilde{\;}}</to></replace>
  <replace><from>^</from><to>\^{}</to></replace>
  <!-- <replace><from>\</from><to>\ensuremath{\backslash}</to></replace> -->
  <!-- mainly in math -->
  <replace><from>|</from><to>\ensuremath{|}</to></replace>
  <!--<replace><from>&lt;</from><to>\ensuremath{&lt;}</to></replace> -->
  <replace><from>&gt;</from><to>\ensuremath{&gt;}</to></replace>
</escape:replacements>

<xsl:variable name="replacements" select="document('')/xsl:stylesheet/escape:replacements/replace"/>

<xsl:template name="replace">
  <xsl:param name="string"/>
  <xsl:param name="next" select="1"/>

  <xsl:variable name="count" select="count($replacements)"/>
  <xsl:variable name="first" select="$replacements[$next]"/>
  <xsl:choose>
    <xsl:when test="$next > $count">
      <xsl:value-of select="$string"/>
    </xsl:when>
    <xsl:when test="contains($string, $first/from)">      
      <xsl:call-template name="replace">
        <xsl:with-param name="string"
                        select="substring-before($string, $first/from)"/>
        <xsl:with-param name="next" select="$next+1" />
      </xsl:call-template>
      <xsl:copy-of select="$first/to" />
      <xsl:call-template name="replace">
        <xsl:with-param name="string"
                        select="substring-after($string, $first/from)"/>
        <xsl:with-param name="next" select="$next"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="replace">
        <xsl:with-param name="string" select="$string"/>
        <xsl:with-param name="next" select="$next+1"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
