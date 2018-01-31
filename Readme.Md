#### ELEC 460
<details><summary>Course	Objectives</summary>
• To	apply	software	requirement	and	design	processes	in	the	implementation	of	software	
components	in	electrical	and	computer	engineering	systems	 <br>
• To	apply	engineering	system	software	concepts	to	portable	devices,	embedded	systems,	realtime
systems,	and	multi-processor	systems	<br>
</details>

<br>

<details><summary>Learning	Outcomes</summary>
• Able	to	understand	the	role	of	system	software,	security	and	privacy	issues,	and	their	synergy	
with	hardware	and	applications	in	engineering	systems	 <br>
• Able	to	use	and	extend	fundamental	system	software	concepts	in	embedded	and	real-time	
engineering	applications	 <br>
• Able	to	identify	potential	hazards	and	apply	system	software	principles	to	solve	unique	electrical	
and	computer	engineering	problems	in	various	domains	(e.g.,	mechatronics,	signal	processing)	  <br>
• Able	to	follow	proper	and	rigorous	system	software	development	process	in	general	and	unique	
engineering	systems	and	situations	<br>
</details>

### Useful Links

* (http://www.engr.usask.ca/classes/EE/480/)

For example the textbook [@book:129711] is used.

* [@book:129711]
* [@textbook:niseSolution]

```latex
pandoc Readme.Md --template=OtherFiles/poole/poole.html5 -c OtherFiles/poole/poole.css  --mathjax --toc --highlight-style zenburn --csl=ieee.csl  --bibliography=textbooks.bib  -o Readme.html 
```

```bash
pandoc Readme.Md --template=OtherFiles/bootswatch.html5 -c   --mathjax --csl=ieee.csl  --bibliography=textbooks.bib  -o Readme.html
```

###### Interesting Note
Some of my work involves creating figures:

!(samplerTesting.png)
```latex
\documentclass{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning}
\usetikzlibrary{shapes,arrows,calc} 
\usetikzlibrary{decorations.text}
\tikzset{add/.style n args={4}{
		minimum width=6mm,
		path picture={
			\draw[black] 
			(path picture bounding box.south east) -- (path picture bounding box.north west)
			(path picture bounding box.south west) -- (path picture bounding box.north east);
			\node at ($(path picture bounding box.south)+(0,0.13)$)     {\tiny #1};
			\node at ($(path picture bounding box.west)+(0.13,0)$)      {\tiny #2};
			\node at ($(path picture bounding box.north)+(0,-0.13)$)        {\tiny #3};
			\node at ($(path picture bounding box.east)+(-0.13,0)$)     {\tiny #4};
		}
	}
}
\begin{document}
	
%\begin{figure}
%\centering
	\tikzstyle{block} = [draw, fill=blue!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{controller} = [draw, fill=red!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{sum} = [draw, fill=blue!20, circle, node distance=1cm]
	\tikzstyle{input} = [coordinate]
	\tikzstyle{output} = [coordinate]
	\tikzstyle{sampleSP} = [coordinate]
	\tikzstyle{sampleEP} = [coordinate]
	\tikzstyle{otherPoint} = [coordinate]
	\begin{tikzpicture}[auto, >=latex']
	% Nodes
	\node [input] (input) {};
	%\node [sum, right = 1cm of input] (sum) {};
	\node[draw,circle,add={--}{+}{}{},right of= input](sum){}; 
	\node [sampleSP, right = 1cm of sum] (sumSP) {};
	\node [sampleEP, right = 1cm of sumSP] (sumEP) {};
	\node [sampleEP, above = 1cm of sumEP] (sumEPTOP) {};
	\node [controller, right = 2cm of sumEP] (system) {$G(s)$};
	\node [otherPoint,right = 1cm of system] (branchPoint) {};
	\node [otherPoint,below = 1 cm of system] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 2cm of branchPoint] (output) {};
	%\node [input, below = 0.5cm of system] (m) {};
	\node [block, right = 0.75 of belowsystem] (systemH) {$H_1(s)$};
	
	% Second Sampler Point
	\node [sampleSP, left = 1cm of systemH] (sysHSP2) {};
	\node [sampleEP, left = 1cm of sysHSP2] (sysHEP2) {};
	\node [sampleEP, above = 1cm of sysHEP2] (sumEPTOP2) {};
	
	% Second block 
	\node [block, left = 1.5cm of sysHEP2] (systemH2) {$H_2(s)$};
	% Arrows
	\draw [draw,->] (input) -- node {$R$} (sum);
	% Arrows for first sampler
	\draw [-] (sum) -- node {$E(s)$} (sumSP);
	\draw [o-,thick] (sumEPTOP) -- node {$\delta_\tau$} (sumSP);
	\draw [->] (sumEP) -- node {$E^\ast(s)$} (system);
	%Arrows for second sampler (bottom)
	\draw [-]  (sysHSP2)-- node {$M(s)$} (systemH);  
	\draw [-o,thick] (sysHSP2) -- node {$\delta_\tau$} (sumEPTOP2);
	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
	% \draw [->] (system) --  (system2);
	\draw [-] (system) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(s)$}(output);
	\draw [-] (y) |- (systemH) {};
	%\draw [-] (y) |- (m) {} ;
	\draw [<-] (systemH2) -- node {$M^\ast(s)$} (sysHEP2);
	\draw [->] (systemH2) -| (sum); %{$-$}  node [near end] {} (sum);
	%\draw [->] (m) -| node[pos=0.99] {} node [near end] {} (sum); %{$-$}  node [near end] {} (sum);
	\end{tikzpicture}
	
%\end{figure}
\end{document}
```
<br>

<blockquote class ="info">Some questions from software engineering, and the assigments, also the textbook operating system contains a lot of question that were on the exam.</blockquote>

<blockquote class="warning">The test was hard, if you didn't know the concepts, but the best references are the assignments and textbook questions foccusing on file systems, cpu utiliization, memory, what is a free list anyway.</blockquote>


### List of Terms 
Software Engineering
: is the process of designing, developing and delivering software systems that meet a client’s requirements in an efficient and cost effective manner

Validation 
  :   determines if the product provides the necessary solution for the
intended real-world problem.

Verification 
  : determines if the product accurately represents and meets the specifications.

**Starvation**
  : The scheduling algorithm prevents a process from ever completing

**Convoy Effect** 
: is phenomenon associated with the First Come First Serve (FCFS) algorithm, in which the whole Operating System slows down due to few slow processes.

**Waterfall Model**  
: uses a linear sequential life-cycle approach. Each phase must be completed entirety before the next
phase can begin.

Thrashing 
: occurs when a computer's virtual memory subsystem is in a constant state of paging, rapidly exchanging data in memory for data on disk, to the exclusion of most application-level processing

Kernel space 
: which is the location where the code of the kernel is stored, and executes under.

User space
 : set of locations where normal user processes run (i.e everything other than the kernel). The role of the kernel is to manage applications running in this space from messing with each other, and the machine.
 

<aside>Note that holes were on the test as well as a kernel question as well as other things. Software engineering was worth more than I thought despite having less questions. Learn about CPU utilization as well.</aside>


| VPN | Page Offset |
| --- | --- |
| 31  12 |  11  0 |


| PFN| Page Offset |
| --- | --- |
| 23  12 |  11  0 |

```java
// Fragment A 
for (int j = 0; j < 64; j++) 
  for (int i = 0; i < 64; i++) 
  X[i][j] = 0; 
```

```java
// Fragment B
for (int i = 0; i < 64; j++) 
  for (int j = 0; j < 64; j++) 
  X[i][j] = 0; 
```

<mark>Hello</mark>

Seems that I can put html, for exmaple i could use tags with a specific classes for links or for paragraph text.

<blockquote class ="alert">
Answer, find good unicorn symbol for answer and get alert boxes, question boxes and answer boxes, checkmark, question mark and exclaimation mark and info symbol
</blockquote>


<aside>
  <h4>Epcot Center</h4>
  <p>The Epcot Center is a theme park in Disney World, Florida.</p>
</aside>

![Image title](https://boostnote.io/assets/img/logo.png)
