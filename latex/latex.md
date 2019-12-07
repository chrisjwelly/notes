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
All commands follow this structure: *\commandname{option}*. The first part indicates command name and second part sets an option for this command

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

The statements \title, \date and \author are not within the *document* environment. They are called the *preamble*. We use it to give values for \maketitle

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
In Linux/Mac, most packages installed by default. In case ofubuntu installing *texlive-full* would provide all packages available.

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
  - \int^a_b for integral symbol
  - \frac{u}{v} for fractions
  - \sqrt{x} for square roots
* Characters for the *greek alphabet* and other *mathematical symbols* such as \lambda
