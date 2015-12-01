%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FILE:    Latex_Planck_style.cls
% PURPOSE: A LaTeX2e document class for Planck DPC documents
% AUTHOR:  Andrea Moneti (IAP) and Jean-Francois Sygnet (IAS)
% VERSION: 1.0
% DATE:    2001-06-06
%
% This is essentially adopted from exam.cls in the standard TeX 
% distribution (at least in the RedHat 6.1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\fileversion{1.0}
\def\filedate{2001/06/01}

%---------------------------------------------------------------------
\usepackage{graphicx}
\DeclareGraphicsExtensions{.jpg,.pdf,.mps,.png} 
%--------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{Latex_Euclid_style}[\filedate\space Version 
  \fileversion\space by Andrea  Moneti and Jean-Francois Sygnet]

\RequirePackage{ifthen}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions
\LoadClass{article}


%--------------------------------------------------------------------
%         ** PAGE LAYOUT **


\setlength{\textwidth}{16cm}
\setlength{\textheight}{21.5cm}
%SP: was 21 cm

\setlength{\oddsidemargin}{0pt}
\setlength{\evensidemargin}{0pt}

\setlength{\headheight}{3.3cm}
\setlength{\headsep}{15pt}

\setlength{\topmargin}{0.0cm}
\addtolength{\topmargin}{-\headsep}

\setlength{\footskip}{29pt}

\setlength{\marginparwidth}{.5in}
\setlength{\marginparsep}{5pt}

\setlength{\unitlength}{1mm}

%--------------------------------------------------------------------
% This block is from the original exam.cls file - I removed 
% unnecessary items, otherwise not touched

%                          ** EXTRAWIDTH **

\newlength\@extrawidth

% We put the argument of \extrawidth into a length so that it will
% work correctly even if it's negative:

\def\extrawidth#1{%
  \@extrawidth=#1
  \advance \textwidth by \@extrawidth
  \divide\@extrawidth by 2
  \advance\oddsidemargin by -\@extrawidth
  \advance\evensidemargin by -\@extrawidth
}

%             Making room for large headers and footers

% The following are used to save the effect of any changes to
% \topmargin and \textheight caused by \extraheadheight or
% \extrafootheight commands.  They hold the value given in the most
% recent command.  We put them into a length so that it will work
% correctly even if the argument is negative: 

\newlength\@extrahead
\newlength\@extrafoot
\setlength{\@extrahead}{0in}
\setlength{\@extrafoot}{0in}

\def\extraheadheight{  \@ifnextchar[{\@doextraheads}%
               {\@setheadheight}%
}

\def\@doextraheads[#1]#2{  \@setheadheight{#1}%
  \@appendoutput{\ifnum\thepage=2\@setheadheight{#2}\fi}%
}


\def\extrafootheight{  \@ifnextchar[{\@doextrafeet}%
               {\@setfootheight}%
}

\def\@doextrafeet[#1]#2{  \@setfootheight{#1}%
  \@appendoutput{\ifnum\thepage=2\@setfootheight{#2}\fi}%
}

\def\@appendoutput#1{ \output=\expandafter{\the\output #1}%
}

\def\@setheadheight#1{%
  \begingroup % Avoid trouble from using \@temp and \@spaces
    % Reset the effect of the most recent change:
    \global\advance\topmargin by -\@extrahead
    \global\advance\textheight by \@extrahead
    % Save the newly set value:
    \def\@temp{#1}
    \def\@spaces{ }
    \ifx\@temp\@empty      \global\@extrahead=0in
    \else
      \ifx\@temp\@spaces   \global\@extrahead=0in
      \else
        \global\@extrahead=#1
      \fi
    \fi
    % Set the new values:
    \global\advance\topmargin by \@extrahead
    \global\advance\textheight by -\@extrahead
    % Make it take effect RIGHT NOW!:
    % (The following stuff isn't necessary if \@setheadheight is
    % executed only in the preamble or as we return from the output
    % routine, but we're leaving it in so that this will still work if
    % we use this at some random point in the middle of composing a
    % page). 
    \global\@colht=\textheight
    \global\@colroom=\textheight
    \global\vsize=\textheight
    \global\pagegoal=\textheight
  \endgroup
}

%---------------------------------------------------------------------
% This was one of the original page styles, and the only one that I
% kept.  

\def\ps@head{
  \def\@oddhead{\@fullhead} \let\@evenhead=\@oddhead
  \def\@oddfoot{}  \let\@evenfoot=\@oddfoot
}

\def\@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \rm{\parbox[b]{\textwidth}{\raggedright\@lhead\strut}}%
    }% hbox
  }% vbox
}

%---------------------------------------------------------------------
% keep the page counter

\AtEndDocument{\clearpage
   \if@filesw 
     {\advance\c@page-1 \immediate\write\@mainaux
       {\string\newlabel{@lastpage}{{}{\arabic{page}}}}%
       \advance\c@page+1 % In case some other package looks at \c@page
     }
   \fi
}

%==================================================================
% Here begin my definitions

%              ** BASIC DOCUMENT PARAMS **
% 
% These are the variables needed to build the header and the title
% page

\def\DocTitle#1{ \def\THETitle{#1}}
\def\DocAuths#1{ \def\THEAuths{#1}}
\def\DocRespb#1{ \def\THERespb{#1}}
\def\DocNumbr#1{ \def\THENumbr{#1}}
\def\DocIssue#1{ \def\THEIssue{#1}}
\def\DocAbstr#1{ \def\THEAbstr{#1}}
\def\DocDate#1{ \def\THEDate{#1}}
\def\DocChange#1{ \def\THEChange{#1}}
\def\DocApprov#1{ \def\THEApprov{#1}}
%\def\DocAgreed#1{ \def\THEAgreed{#1}}

% The following makes the HEADER using the inputs above. This required
% a lot of hand tailoring of the rule lengths of other offsets, thus
% it's best to NOT TOUCH them

\def\DocHeadr{
\rule{160mm}{0.06cm} \\		% top horiz. line
\rule[-1.3cm]{0.06cm}{2.93cm} 	% 1st vertical line
%
\begin{minipage}[t]{3cm}      % a minipage for the Planck icon
   \raisebox{-1.3cm}{\includegraphics[width=3cm]{logo.png}}
\end{minipage}  
%
\rule[-1.30cm]{0.06cm}{2.93cm} 	% 2nd vertical line
\hfill	
%		
\begin{minipage}[t]{5.0cm}	% a miniipage for the Title 
  \raisebox{0.06cm}{ \parbox{4.8cm}{
      \begin{center} 
      \LARGE  \THETitle  
      \end{center}
  }   }  % close parbox and raisebox
\end{minipage}
%
\hfill
\rule[-1.30cm]{0.06cm}{2.93cm}	% 3rd vertical line
%
  \raisebox{0.7cm}{		% a minipage for the document ID box
%     \parbox[t]{1.5cm}{\small \baselineskip .45cm
 \parbox[t]{0.7cm}{\small \baselineskip .45cm
    Doc.No.:\\ Issue:\\ Date:\\ Page:}\hspace{0.7cm}
%    \parbox[t]{4.3cm}{\small  \baselineskip .45cm
       \parbox[t]{2.8cm}{\small  \baselineskip .45cm
       \THENumbr \\ \THEIssue \\ \THEDate \\ \thepage\  of \numpages}
  }  % end raisebox
%
\rule[-1.3cm]{0.06cm}{2.93cm}	% last vertical line
\rule{160mm}{0.06cm} \\		% bottom horiz. line
}

%------------------------------------------------------------------
% Now make title page ....

% The title

\def\mktitlepage{
\vbox to 5cm{
 \vfill
 \begin{center}  {\bf\LARGE \THETitle } \end{center}
 \vfill
}

% Dc Number, authors, date, etc.

\parbox[t]{3.5cm}{\bf Document Num.:}
\parbox[t]{11.5cm}{\THENumbr} \medskip

\parbox[t]{3.5cm}{\bf Issue:}
\parbox[t]{11.5cm}{\THEIssue} \medskip

\parbox[t]{3.5cm}{\bf Date:}
\parbox[t]{11.5cm}{\THEDate} \medskip

\parbox[t]{3.5cm}{\bf Authors:}
\parbox[t]{11.5cm}{\THEAuths} \medskip

\parbox[t]{3.5cm}{\bf Authorised by:}
\parbox[t]{11.5cm}{\THERespb}

\vskip 2cm

% Abstract

\parbox[t]{2.5cm}{\bf ~Abstract:~~ }
\parbox[t]{12.5cm}{\sl \THEAbstr     }
\vfill
}% end mktitlepage

%--------------------------------------------------------------------
%
% Now make the second page, with the Doc change history and approval
% tables.  Table structure is defined here, contents are defined in
% the main document via \THEChange and \THEApproval

\def\mksecondpage{
{		% extra space in tables 
\renewcommand{\arraystretch}{2.}

%   Document Change History Table
\noindent{\bf\Large Document Change History} \\
\medskip
\begin{tabular}{|l|l|l|l|}
\hline
\multicolumn{4}{|l|}{\bf \large Title: \THETitle} \\ 
\hline
\parbox{2cm}{\bf Issue} & \parbox{1cm}{\bf Rev.} & 
\parbox{2cm}{\bf Date}  & \parbox{9.cm}{\bf Reason for Change} \\
\hline
\THEChange
\end{tabular}
\bigskip

%   Document approval Table
%\noindent{\bf\Large Agreed by:} \\
%\medskip
%\begin{tabular}{|l|l|l|l|}  \hline
%\parbox{3.0cm}{\bf NAME} & 
%\parbox{3.0cm}{\bf Organization} & 
%\parbox{2.5cm}{\bf Date} & 
%\parbox{5.5cm}{\bf Signature} \\    \hline
%\THEAgreed
%\end{tabular}
%\bigskip

\noindent{\bf\Large Approved by:} \\
\medskip
\begin{tabular}{|l|l|l|l|}  \hline
\parbox{3.0cm}{\bf NAME} & 
\parbox{3.0cm}{\bf Organization} & 
\parbox{2.5cm}{\bf Date} & 
\parbox{5.5cm}{\bf Signature} \\    \hline
\THEApprov
\end{tabular}

}   % end of special arraystretch value
}   % end of second page


%--------------------------------------------------------------------
% Now initialize

\pagestyle{head}
\def\header#1{ \def\@lhead{#1} }
\def\numpages{\pageref{@lastpage}}

%--------------------------------------------------------------------
\endinput
%--------------------------------------------------------------------



