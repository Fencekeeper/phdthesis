%% Implemented by Martin Helso (martibhe@math.uio.no)


\NeedsTeXFormat{LaTeX2e}


\ProvidesClass{phduio}[2017/11/21 Class for PhD theses at UiO]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CLASS OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Language
\DeclareOption{american} { \def \phduio@thesis{Dissertation} }
\DeclareOption{USenglish}{ \def \phduio@thesis{Dissertation} }
\DeclareOption{english}  { \def \phduio@thesis{Thesis} }
\DeclareOption{UKenglish}{ \def \phduio@thesis{Thesis} }


%% Colophon
\DeclareOption{colophon}  { \def \phduio@colophon{true}  }
\DeclareOption{nocolophon}{ \def \phduio@colophon{false} }


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}


\ExecuteOptions{UKenglish}
\ExecuteOptions{nocolophon}
\ProcessOptions
\relax


\LoadClass[oldfontcommands, extrafontsizes]{memoir}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PACKAGES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\RequirePackage{keyval}
\RequirePackage{etoolbox}
\RequirePackage{textcomp}
\RequirePackage[dvipsnames, svgnames, cmyk]{xcolor}
\RequirePackage{pdfpages}
\RequirePackage{graphicx}
\graphicspath{{figures/}}
\RequirePackage{tikz}
\usetikzlibrary{calc}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LAYOUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Paper size
\setstocksize{240mm}{170mm}
\settrimmedsize{240mm}{170mm}{*}
\settrims{0mm}{0mm}
\setlrmarginsandblock{20mm}{28.7mm}{*}
\setulmarginsandblock{25mm}{25mm}{*}
\checkandfixthelayout


%% Custom title page
\newcommand{\uiotitle}
{
    \begin{titlingpage}

        \renewcommand{\and}{\vskip1mm}
        \newcommand{\AND}{\vskip9mm}

        \calccentering{\unitlength}
        \begin{adjustwidth*}{\unitlength}{-\unitlength}

            \raggedright

            \vspace*{-5mm}
            \includegraphics[width = 0.6\textwidth]{figures/phduio-logo}
            \vskip18mm

            \resizebox
            {
                \ifdim \width > \textwidth
                \textwidth
                \else
                \width
                \fi
            }{!}
            {%
                \LARGE
                \sffamily
                \theauthor
            }

            \vskip1.5\onelineskip

            {
                \Huge
                \bfseries
                \sffamily
                \thetitle
            }

            \vskip17mm

            \resizebox{\textwidth}{!}
            {%
                \bfseries
                \sffamily
                \phduio@thesis\
                submitted for the degree of Philosophiae Doctor
            }

            \AND

            {
                \Large
                \sffamily
                \phduio@dept\
                \and
                \phduio@faculty\
                \AND
                \phduio@affiliation\
            }

            \vfill

            \begin{minipage}[c][26mm]{27.3mm}
                \hspace*{1.3mm}
                \includegraphics[width = 26mm]{figures/phduio-apollon}
            \end{minipage}%
            \begin{minipage}[c]{\textwidth - 27.3mm}
                \hfill
                \LARGE
                \bfseries
                \sffamily
                \the\year
            \end{minipage}

            \vspace{2mm}

        \end{adjustwidth*}

        \null
        \clearpage
        \ifdefstring{\phduio@colophon}{true}{\phduio@print@colophon}{}

    \end{titlingpage}
}


%% Ordinary title page
\pretitle{\begin{center}\huge\sffamily\bfseries}


%% Book
\renewcommand*{\printbooktitle}[1]{\raggedright\booktitlefont #1}
\renewcommand*{\afterbookskip}{\par}
\renewcommand*{\booktitlefont}{\HUGE\bfseries\sffamily}
\renewcommand*{\booknamefont}{\raggedright\Huge\normalfont\sffamily}
\renewcommand*{\booknumfont}{\Huge\normalfont\sffamily}


%% Part
\renewcommand*{\printparttitle}[1]{\raggedright\parttitlefont #1}
\renewcommand*{\afterpartskip}{\par}
\renewcommand*{\parttitlefont}{\HUGE\bfseries\sffamily}
\renewcommand*{\partnamefont}{\raggedright\Huge\normalfont\sffamily}
\renewcommand*{\partnumfont}{\Huge\normalfont\sffamily}


%% Chapter
\newcommand{\authorsfont}{}
\newcommand{\metadatafont}{}
\newlength{\afterauthorsskip}
\newlength{\aftermetadataskip}

\makechapterstyle{phduio}
{
    \renewcommand*{\chapnamefont}{\huge\sffamily}
    \renewcommand*{\chapnumfont}{\huge\sffamily}
    \renewcommand*{\chaptitlefont}{\Huge\bfseries\sffamily\raggedright}
    \renewcommand*{\authorsfont}{\Large\bfseries\sffamily}
    \renewcommand*{\metadatafont}{\normalfont\normalsize\sffamily}

    \setlength{\beforechapskip}{-1.35\baselineskip}
    \setlength{\midchapskip}{10pt}
    \setlength{\afterchapskip}{20pt}
    \setlength{\afterauthorsskip}{6pt}
    \setlength{\aftermetadataskip}{15pt}

    \renewcommand*{\afterchaptertitle}
    {
        \vskip\afterchapskip
        \ifboolexpr
        {
            test{ \ifcsempty{phduio@authors} }
            and
            test{ \ifcsempty{phduio@metadata} }
        }
        {}
        {
        \begin{minipage}[t]{\textwidth}
            \authorsfont
            \phduio@authors
            \vskip\afterauthorsskip
            \metadatafont
            \phduio@metadata
            \gdef \phduio@authors{}
            \gdef \phduio@metadata{}
        \end{minipage}
        \vskip\aftermetadataskip
        }
    }

    \renewcommand*{\printchapternonum}
    {
        \vphantom{\chapnumfont Chapter}
        \afterchapternum
        \vskip\topskip
    }
}

\chapterstyle{phduio}


%% Lower level sections
\setsecnumdepth{subsubsection}
\setsecheadstyle{\Large\bfseries\sffamily\raggedright}
\setsubsecheadstyle{\large\bfseries\sffamily\raggedright}
\setsubsubsecheadstyle{\normalsize\bfseries\sffamily\raggedright}
\setparaheadstyle{\normalsize\bfseries\sffamily\raggedright}
\setsubparaheadstyle{\normalsize\bfseries\sffamily\raggedright}


%% Subappendices
\namedsubappendices


%% Abstract
\renewcommand{\abstractnamefont}{\sffamily\bfseries}
\renewcommand{\abstracttextfont}{\normalfont\small\noindent\ignorespaces}


%% Table of contents, list of figures and list of tables
%% Roman numerals take up more space than Arabic numerals,
%% so we compensate with extra space.
%% Remove these settings if you do not use the \paper macro.
\addtolength{\cftchapternumwidth}{1em}
\addtolength{\cftsectionindent}{1em}
\addtolength{\cftsubsectionindent}{1em}
\addtolength{\cftsubsubsectionindent}{1em}
\addtolength{\cftparagraphindent}{1em}
\addtolength{\cftsubparagraphindent}{1em}
\addtolength{\cftfigurenumwidth}{1em}
\addtolength{\cfttablenumwidth}{1em}
\addtolength{\cftpartnumwidth}{1em}



%% Running header and footer
\makepagestyle{phduio}
\makeheadrule{phduio}{\textwidth}{\normalrulethickness}
\makeevenhead{phduio}{\sffamily\leftmark}{}{}
\makeoddhead {phduio}{}{}{\sffamily\rightmark}
\makeevenfoot{phduio}{\sffamily\thepage}{}{}
\makeoddfoot {phduio}{}{}{\sffamily\thepage}
\makepsmarks{phduio}
{
    \nouppercaseheads
    \createmark{chapter}{left}{shownumber}{}{. \space}
    \createmark{section}{right}{nonumber}{}{}
    \createplainmark{toc}{both}{\contentsname}
    \createplainmark{lof}{both}{\listfigurename}
    \createplainmark{lot}{both}{\listtablename}
    \createplainmark{bib}{both}{\bibname}
    \createplainmark{index}{both}{\indexname}
    \createplainmark{glossary}{both}{\glossaryname}
}
\pagestyle{phduio}

\makepagestyle{chapter}
\makeevenfoot{chapter}{\sffamily\thepage}{}{}
\makeoddfoot {chapter}{}{}{\sffamily\thepage}


%% Trim marks
\trimLmarks


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INCLUDE PAPERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Specify authors for separate paper
\newcommand{\paperauthors}[1]
{
    \renewcommand{\and}{\leavevmode\unskip,\space}
    \def \phduio@authors{#1}
}
\paperauthors{}


%% Specify metadata for separate paper
\newcommand{\metadata}[1]{ \def \phduio@metadata{#1} }
\metadata{}


%% Rename 'Chapter' to 'Paper'
\newcommand*{\paper}
{
    \setcounter{chapter}{0}
    \setcounter{section}{0}
    \ifdef{\theHchapter}
    {
        \renewcommand{\theHchapter}{papter.\arabic{chapter}}
    }
    {}
    \def \@chapapp{Paper}
    \let \c@paper \c@chapter
    \def \thechapter{\@Roman\c@chapter}
    \let \thepaper \thechapter
    \ifdef{\memendofchapterhook}
    {
        \renewcommand{\memendofchapterhook}
        {
            \addtocounter{paper}{-1}
            \refstepcounter{paper}
        }
    }
    {}
}
\newcounter{paper}


%% Print 'Papers'
\newcommand{\paperpage}
{
    \part*{Papers}
    \addcontentsline{toc}{chapter}{Papers}
    \cleartorecto
}


%% Specify number of papers
\newcommand{\numberofpapers}[1]{ \setcounter{totpapernum}{#1} }


%% Thumb index to separate papers
\newcommand{\paperthumb}
{
    \cleartorecto
    \thispagestyle{empty}
    
    \ifnum \value{thumbpos} = \value{totpapernum}
    \setcounter{thumbpos}{0}
    \fi
    
    \stepcounter{thumbnum}
    \stepcounter{thumbpos}
    
    \pgfmathsetlength{\thumbheight}{\paperheight / \value{totpapernum}}
    
    \begin{tikzpicture}[remember picture, overlay]
    \node [thumb, align = right, anchor = north east]
    at
    ($(current page.north east) - (0,{(\value{thumbpos}-1)*\thumbheight})$)
    {\Roman{thumbnum}};
    \end{tikzpicture}
    
    \clearpage
}

\newcounter{thumbnum}
\newcounter{thumbpos}
\newcounter{totpapernum}
\setcounter{totpapernum}{2}

\newlength{\thumbwidth}
\newlength{\thumbheight}
\setlength{\thumbwidth}{1cm}

\tikzset
{
    thumb/.style =
    {
        fill           = uioblack,
        text           = uiowhite,
        font           = \sffamily\bfseries\Huge,
        text width     = \thumbwidth,
        minimum height = \thumbheight,
        outer sep      = 0pt,
        inner xsep     = 1.5em
    }
}


%% Include PDFs containing separate papers
%% Based on code by Dag Langmyhr
\newcommand{\includearticle}[2][]
{
    \cleartorecto

    \def \ps@default
    {
        \let \@mkboth\@gobbletwo
        \let \@oddhead\@empty
        \def \@oddfoot{\hfil\sffamily\thepage}
        \let \@evenhead\@empty
        \def \@evenfoot{\sffamily\thepage\hfil}
    }

    \def \phduio@ps{default}

    \def \ps@low
    {
        \let\@mkboth\@gobbletwo
        \let\@oddhead\@empty
        \def\@oddfoot{\hfil\raisebox{-7.5mm}{\sffamily\thepage}}
        \let\@evenhead\@empty
        \def\@evenfoot{\raisebox{-7.5mm}{\sffamily\thepage}\hfil}
    }

    \let \ps@none = \ps@empty

    \setkeys{phduio@keys}{#1}

    \includepdf[pages = {-}, pagecommand = {\thispagestyle{\phduio@ps}}]{#2}
}

\define@key{phduio@keys}{numbers}{ \def \phduio@ps{#1} }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UTILITIES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Offical colours
\definecolor{uiored}  {cmyk}{0, 1, 1, 0}
\definecolor{uiogrey} {cmyk}{0, 0.05, 0.1, 0.29}
\definecolor{uiowhite}{cmyk}{0, 0, 0, 0}
\definecolor{uioblack}{cmyk}{0, 0, 0, 1}


%% Print official logo colon
\newcommand{\uiocolon}
{
    \includegraphics[height = 1.5ex]{figures/phduio-colon}\,%
}


%% Specify affiliation
\newcommand{\department}[1]{ \def \phduio@dept{#1} }
\newcommand{\faculty}[1]{ \def \phduio@faculty{#1} }
\newcommand{\affiliation}[1]{ \def \phduio@affiliation{#1} }
\department{}
\faculty{}
\affiliation{}


%% Specify International Standard Serial/Book Number
\newcommand{\ISSN}[1]{ \def \phduio@ISN{ISSN\space#1}}
\newcommand{\ISBN}[1]{ \def \phduio@ISN{ISBN\space#1}}
\ISSN{ISSN}


%% Specify dissertation series number
\newcommand{\dissertationseries}[1]{ \def \phduio@dissertationseries{#1} }
\dissertationseries{}


%% Specify production credits
\newcommand{\cover}[1]{ \def \phduio@cover{#1} }
\newcommand{\printinghouse}[1]{ \def \phduio@printinghouse{#1} }
\cover{Hanne Baadsgaard Utigard}
\printinghouse{Reprosentralen, University of Oslo}


%% Print colophon
\newcommand{\phduio@print@colophon}
{
    \thispagestyle{empty}
    \vspace*{\stretch{3}}
        \begin{flushleft}
            \textbf{\sffamily\textcopyright\space\theauthor,\space\the\year}
            \vskip2\baselineskip
            \textit{Series of dissertations submitted to the}
            \par
            \textit{\phduio@faculty, University of Oslo}
            \par
            \ifcsempty{phduio@dissertationseries}
            {}
            {\textit{No.}\space\phduio@dissertationseries}
            \vskip\baselineskip
            \phduio@ISN
            \vskip2\baselineskip
            \small
            All rights reserved.
            No part of this publication may be
            \par
            reproduced or transmitted,
            in any form or by any means,
            without permission.
            \vskip7\baselineskip
            Cover: \phduio@cover.
            \par
            Print production: \phduio@printinghouse.
    \end{flushleft}
    \vspace*{\stretch{1}}
    \null
    \newpage
}


%% Print current month
\newcommand{\MONTH}
{%
    \leavevmode\unskip\space
    \ifcase\the\month
    \or January
    \or February
    \or March
    \or April
    \or May
    \or June
    \or July
    \or August
    \or September
    \or October
    \or November
    \or December
    \fi
    \ignorespaces
}


\endinput