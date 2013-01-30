# GIS Classes

Small Sinatra application to serve static files for Scholars' Lab
GIS classes. 

## Adding Courses

To create a new course, simply create a directory in the
`public/courses` directory. The program will generate links for the
course and readable titles for the course by replacing the "_" character
with a space and then using an algorithm for capitalizing each word.

## Special Files
You can add additional context to a course by including a file named
'index.md' the an individual course directory. This file will enable you
to generate HTML snips using [Markdown syntax][md]. If this file exists,
the software wil render that content directly on the page.

[md]: http://daringfireball.net/projects/markdown/syntax "Markdown
Syntax"
