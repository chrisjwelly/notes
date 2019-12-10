With reference to [LaTeX-Tutorial](https://www.latex-tutorial.com/tutorials/).

# 00 - Installation
I learnt LaTeX on Ubuntu 19.10. So I installed the packages via:

```
sudo apt-get install texlive
```

To compile .tex files, use `pdflatex`.

# 01 - Your first LaTeX document

Page number is automatically added.
The backslash tells LaTeX that this is not actual text, but instead is an instruction or command for the LaTeX compiler.
All commands follow this structure: `\commandname{option}`. The first part indicates command name and second part sets an option for this command

The environment is simply an area of your document where certain typesetting rules apply. It is possible to have multiple environments in a document. BUT it is imperative that *document environment* is the topmost environment.

Examples for environment:

```tex
% Valid:
\begin{document}
  \begin{environment1}
    \begin{environment2}
    \end{environment2}
  \end{environment1}
\end{document}

% Invalid:
\begin{document}
  \begin{environment1}
    \begin{environment2}
  \end{environment1}
    \end{environment2}
\end{document}
```

To add title example:
```tex
\documentclass{article}

\title{My first LaTeX document}
\date{07-12-2019}
\author{Christian James Welly}

\begin{document}
  \maketitle
  \newpage

  Hello World!
\end{document}
```

The statements `\title`, `\date` and `\author` are not within the *document* environment. They are called the *preamble*. We use it to give values for `\maketitle`

Summary:
* A document has a *preamble* and *document* part
* The document environment *must* be defined
* Commands beginning with a *backslash* \, environments have a *begin* and *end* tag
* Useful setting for *pagenumbering*:
  - *gobble* - no numbers
  - *arabic* - arabic numbers
  - *roman* - roman numbers

# 02 - Sections

The *section* commands are numbered and WILL APPEAR in table of contents. *Paragraphs* aren't numbered and won't show.

You can define a hierarchy like this:
```tex
\documentclass{article}

\begin{document}

\section{Section}

Hello World!

\subsection{Subsection}

Structuring a document is easy!

\subsubsection{Subsubsection}

More text.

\paragraph{Paragraph}

Some more text.

\subparagraph{Subparagraph}

Even more text.

\section{Another section}

\end{document}
```

Summary:
* LaTeX uses the commands \section, \subsection and \subsubsection to define sections in your document
* The *sections* will have successive numbers and appear in the table of contents
* *Paragraphs* are not numbered and thus don't appear in the table of contents

# 03 - Packages

## Install a package
In Linux/Mac, most packages installed by default. In case of Ubuntu installing *texlive-full* would provide all packages available.

## Purpose of packages
Countless packages out there. To typeset math, LaTeX offers (among others) an *environment* called *equation*. Everything will be printed in *math mode* and it takes care of equation numbers for us. But however, it will show a (1) at the side for the first equation and suppose we don't want this to be included.

## Using package
LaTeX doesn't allow such removal by default. So we include a package that does:
```tex
\documentclass{article}

\usepackage{amsmath}

\begin{document}

\begin{equation*}
  f(x) = x ^ 2
\end{equation*}
```

The equation number will be removed in the above! Note that the asterisk is important here as if we do not include it, LaTeX will detect it as the normal *equation* environment.

Summary:
* *Packages* add new functions to LaTeX
* All *packages* must be included in the *preamble*
* Packages add features such as support for pictures links and bibliography

# 04 - Math
There is a lot of content here. Best to be linked to the [actual page](https://www.latex-tutorial.com/tutorials/amsmath/)

There is inline math (encapsulating formula in dollar signs) and also using a predefined math environment.

## Using inline math:
```tex
...
This formula $f(x) = x^2$ is an example.
...
```

## The equation and align enveironment
The most useful *math environments* are the *equation environment* for typesetting **single equations** and *align* environment for **multiple equations and automatic aligments**

```tex
\begin{equation*}
  1 + 2 = 3
\end{equation*}

\begin{align*}
  1 + 2 &= 3\\
  1 &= 3 - 2
\end{align*}
```

The *align* environment will align the equations at the *ampersand &*. Single equations have to be separated by a *linebreak \\*. There is aligntment when using the simple equation environment! Also not possible to enter two equations.

The asterisk * only indicates that I don't want the eqns to be numbered

## Fractions and more
```tex
\begin{align*}
  f(x) &= x^2\\
  g(x) &= \frac{1}{x}\\
  F(x) &= \int^a_b \frac{1}{3}x^3
\end{align*}
```

Also possible to combine various commands:
```tex
\frac{1}{\sqrt{x}}
```

More error prone! Take care of opening and closing braces {}. The *Lyx* program offers a great formula editor.

## Matrices and bracket scalings
We can display matrices BUT they have to be within math environments
```tex
\begin{equation*}
  \left[
  \begin{matrix}
    1 & 0\\
    0 & 1
  \end{matrix}
  \right]
\end{equation*}
```

The `\left[` and `\right]` serves as a scaled parenthesis for the matrix. It is also not limited to matrices:
```tex
\left(\frac{1}{\sqrt{x}}\right)
```

Summary:
* LaTeX is a powerfull tool to typeset math!
* Embed formulas in your text by surrounding them with dollar signs
* The *equation environment* is used to typeset *one* formula
* The *align environment* will align formulas at the ampersand symbol
* Single formulas MUST be separated with *two backslashes \\*
* Use the *matrix environment* to typeset matrices
* Scale parenthese with *\left(\right)* automatically
* All math expressions have a unique command with unique syntax
* Notable examples:
  - `\int^a_b` for integral symbol
  - `\frac{u}{v}` for fractions
  - `\sqrt{x}` for square roots
* Characters for the *greek alphabet* and other *mathematical symbols* such as \lambda

# 05 - Figures

## Captioned images in LaTeX
Use *figure environment* and the *graphicx package*, and LaTeX will automatically index and tag pictures automatically.

E.g:
```tex
\documentclass{article}

\usepackage{graphicx}

\begin{document}

\begin{figure}
  \includegraphics[width=\linewidth]{boat.jpg}
  \caption{A boat.}
  \label{fig:boat1}
\end{figure}

Figure \ref{fig:boat1} shows a boat.

\end{document}
```

To include a figure, use the `\includegraphics` command. The image width is option in brackets and the path to image file.
The `\linewidth` into brackets means picture will be scaled to fit the width of document: small pictures upscaled, large pictures downscaled.
In the example above, boat.jpg is stored in the same directory as the .tex file. You may want to put it in a separate folder and write *images/boat.jpg* if you want to store it into images directory for example.

We also set a `\caption` which is text shown below image and a `\label` which is invisible but useful to refer to it. Which we see in `\ref` command to refer to the figure. Note! We need to include the *graphicx* package in order to use this code.

## Image positioning / setting the float
Figures don't necessarily show up in the exact place as you put your code in the .tex file. To prevent this behaviour, set the *float* value for the figure environment.
```tex
%...
\begin{figure}[h!]
%...
```
This will force the figure to be shown at the location in the document. Possible values:
* h (here) - same location
* t (top) - top of page
* b (bottom) - bottom of page
* p (page) - on an extra page
* ! (override) will force the specified location 
The *float package* (`\usepckage{float}`) allows to set the option to [H] which is even stricter than [h!]

## Multiple images
Need to add the *subcaption package* to your preamble:
```tex
%...
\usepackage{graphicx}
\usepackage{subcaption}
%...
```
Then, add multiple subfigure environments within a figure environment:
```tex
%...

\begin{figure}[h!]
  \centering
  \begin{subfigure}[b]{0.4\linewidth}
    \includegraphics[width=\linewidth]{coffee.jpg}
    \caption{Coffee.}
  \end{subfigure}

  \begin{subfigure}[b]{0.4\linewidth}
    \includegraphics[width=\linewidth]{coffee.jpg}
    \caption{More coffee.}
  \end{subfigure}

  \caption{The same cup of coffee. Two times.}
  \label{fig:coffee}
\end{figure}

%...
```
We should see two pictures next to each other. And if you look closely, the width of the image is manually set. Even though the two images aligned next to each other, their width are both set to 0.4 yet they fill up the whole space. You should always set this value to 0.1 less than you expect! E.g. if you need to consecutively add three subfigures, each has `0.2\linewidth`

Summary:
* Use the *graphicx package* and *figure environment* to embed pictures
* Pictures will be numbered automatically
* Change the width of your image by using `\includegraphics[width=\linewidth]{}`
* Refer to pictures in your doc by setting a `\label` and using `\ref` tag
* Set the position of your image by adding a float option such as [h!]
* If you want to show multiple figures side-by-side, use *subcaption* package and *subfigure* environment.

# 06 - Table of contents

## Table of contents
LaTeX use section headings to create Table of Contents. There are commands to create a list of figures and a list of tables as well.
To create table of contents:
```tex
...
\begin{document}

\tableofcontents
\newpage

...
\end{document}
...
```

Note: you need to compile the .tex file **TWO** times

## List of figures/tables
Can be done similarly:
```tex
% some figures and tables here
...
\begin{appendix}
  \listoffigures
  \listoftables
\end{appendix}
```

## Depth
Maybe you want to show only a subset of headings. You can set *tocdepth* by using the command: `\setcounter{tocdepth}{X}`, where X is the desitred depth. The value is set in the **preamble** of your document and applies globally:

```tex
% ...

\setcounter{tocdepth}{1} % Show sections
%\setcounter{tocdepth}{2} % + subsections
%\setcounter{tocdepth}{3} % + subsubsections
%\setcounter{tocdepth}{4} % + paragraphs
%\setcounter{tocdepth}{5} % + subparagraphs

\begin{document}
%...
\tableofcontents
%...
\end{document}
```

But if you don't want to change globally, you can actually adjust it individually:
```tex
%...
\begin{document}
%...
\addtocontents{toc}{\setcounter{tocdepth}{1}} % Set depth to 1
\section{Another section}
\subsection{Subsection}
\subsubsection{Subsubsection}
%...
\addtocontents{toc}{\setcounter{tocdepth}{3}} % Reset to default (3)
\end{document}
```
Self-study note: the website seems to imply that the line of code is placed after the section that is desired to be changed. However, after playing around, it seems that it should be placed before the desired section (which tbh, makes sense)

## Spacing
The easiest way of changing spacing of table of contents (and documents) is by using the *setspace* package. Add `\usepackage{setspace}` to your preamble and set the spacings:
```tex
%...
\begin{document}
%...
\doublespacing % for table of contents
\tableofcontents
\singlespacing % set it back for the rest of the document
%...
```

Note that the `\singlespacing` command is to set the spacing back for the rest of the document. If you desire double spacing throughout the rest of the document, then it is not necessary.

Summary:
* Autogenerate a table of content using `\tableofcontents`
* Create lists of your figures and tables with `\listoffigures` and `\listoftables`
* Always compile *twice* to see the changes
* Globally change the depth with `\setcounter{tocdepth}{X}`; X = {1, 2, 3, 4, 5}
* For single sections use `\addtocontents{toc}{\setcounter{tocdepth}{X}}` instead
* Use the *setspace* package for spacing of table of contents
