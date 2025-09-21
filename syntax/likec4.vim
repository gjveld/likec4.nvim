" syntax/likec4.vim
" Vim syntax file for likec4

if exists('b:current_syntax')
  finish
endif

scriptencoding utf-8
syn case match

" ------------------------------------------------------------
" (Optional) Include Markdown for triple-quoted block contents
" ------------------------------------------------------------
silent! syntax include @Markdown syntax/markdown.vim

syn region likec4Block start=/{/ end=/}/ transparent keepend " contains=TOP,likec4Block
" ------------------------------------------------------------
" Comments
" ------------------------------------------------------------
syn region likec4BlockComment start=/\/\*/ end=/\*\// contains=@Spell keepend
syn match  likec4LineComment  /\/\/.*/ contains=@Spell

" ------------------------------------------------------------
" Strings & escapes
" ------------------------------------------------------------
" Triple-quoted strings (""" ... """), (''' ... ''') only when quotes are on their own lines
syn region likec4TripleDString start=/"""\s*$/ end=/^\s*"""\s*$/ keepend contains=@Markdown,@Spell,likec4LineComment,likec4BlockComment
syn region likec4TripleSString start=/'''\s*$/ end=/^\s*'''\s*$/ keepend contains=@Markdown,@Spell,likec4LineComment,likec4BlockComment

" Regular strings with escapes
syn region likec4DString start=/"/ skip=/\\./ end=/"/ contains=likec4Escape keepend
syn region likec4SString start=/'/ skip=/\\./ end=/'/ contains=likec4Escape keepend

" Escape sequences (ported from your TM grammar)
syn match likec4Escape /\\\(x[0-9A-Fa-f]\{2}\|u[0-9A-Fa-f]\{4}\|u{[0-9A-Fa-f]\+}\|[0-2][0-7]\{0,2}\|3[0-6][0-7]\?\|37[0-7]\?\|[4-7][0-7]\?\|.\|$\)/ contained
" ------------------------------------------------------------
" Declarations & identifiers
" element|tag|relationship <IDENT>
" ------------------------------------------------------------
syn keyword likec4Decl element tag relationship nextgroup=likec4TypeIdent skipwhite skipnl
syn match   likec4TypeIdent /\S\+/ contained

" ------------------------------------------------------------
" Properties and property→value pairs
" link|icon : <bare>
" shape|head|tail|line|border : <enum>
" other property names
" ------------------------------------------------------------
"syn keyword likec4Property link icon              nextgroup=likec4BareValue skipwhite skipnl
syn match   likec4BareValue /\S+/ contained
"syn keyword likec4Property shape head tail line border nextgroup=likec4EnumValue skipwhite skipnl
syn match   likec4EnumValue /[\-A-Za-z0-9_]+/ contained

syn keyword likec4Keyword title style color description technology navigateTo notation multiple size padding textSize opacity

" ------------------------------------------------------------
" Keywords (control / reserved words)
" ------------------------------------------------------------
syn keyword likec4Keyword specification model views
syn match   likec4Keyword /\v<(tag|kind)>\s+is/
" Big list from your grammar
syn keyword likec4Keyword and as autoLayout border browser color crow cylinder dashed description deployment deploymentNode
syn keyword likec4Keyword diamond dot dotted dynamic from global group element exclude extend extends head icon icons import include
syn keyword likec4Keyword instance instanceOf it kind line likec4lib link metadata mobile model navigateTo node none not normal
syn keyword likec4Keyword odiamond odot of onormal opacity open or parallel par person predicateGroup predicate queue rectangle
syn keyword likec4Keyword relationship shape solid specification storage styleGroup style tag tail technology this title vee view views
syn keyword likec4Keyword where source target with

" Booleans
syn keyword likec4Boolean true false
" ------------------------------------------------------------
" Hash-prefixed tokens
" - Colors: #[A-Fa-f0-9]+
" - Generic hash identifiers: #[A-Za-z0-9]+  (prefer those starting with a letter to avoid clashing with colors)
" ------------------------------------------------------------
syn match likec4Color     /#[0-9A-Fa-f]\+/           display
syn match likec4HashIdent /#[A-Za-z][A-Za-z0-9]*/    display

" ------------------------------------------------------------
" Special arrow block: -[ ... ]-> (also allow HTML-escaped end)
" Start / End are operators; content is highlighted as a function-ish name/text
" ------------------------------------------------------------
syn region likec4Arrow matchgroup=likec4Operator start=/-\[/ end=/\]-\>/ keepend contains=likec4ArrowText,likec4DString,likec4SString,likec4TripleDString,likec4TripleSString,likec4LineComment,likec4BlockComment
syn region likec4ArrowHtml matchgroup=likec4Operator start=/-\[/ end=/\]-&gt;/ keepend contains=likec4ArrowText,likec4DString,likec4SString,likec4TripleDString,likec4TripleSString,likec4LineComment,likec4BlockComment
syn match  likec4ArrowText /[^]]\+/ contained

" ------------------------------------------------------------
" Provider namespace enums: (aws|azure|gcp|tech):<value>
" ------------------------------------------------------------
syn match likec4Enum /\v<(aws|azure|gcp|tech)>:([-A-Za-z0-9_]+)/

" ------------------------------------------------------------
" Dot variables: . *   or   . _
" ------------------------------------------------------------
syn match likec4Variable /\v\.(\*|_)/
" ------------------------------------------------------------
" Enumerations (direction, sizes, named colors/etc.)
" ------------------------------------------------------------
syn keyword likec4Enum TopBottom LeftRight BottomTop RightLeft xsmall xs small sm medium md large lg xl xlarge
syn keyword likec4Enum amber blue gray green indigo muted primary secondary red sky slate none

" ------------------------------------------------------------
" Operators & symbols
" ------------------------------------------------------------
" Literal forms
syn match likec4Operator /\]\-\>/ display
syn match likec4Operator /-\[/   display
syn match likec4Operator /<\-\>/ display
syn match likec4Operator /<\-/   display
syn match likec4Operator /\-\>/  display

" HTML-escaped forms (for safety if sources contain them)
syn match likec4Operator /&lt;-\&gt;\|&lt;-\|-\&gt;/ display

" Punctuation
" syn match likec4Symbol /[{}():,;!]/ display
syn match likec4Equals /=\+/      display

" ------------------------------------------------------------
" Functions & numbers
" ------------------------------------------------------------
syn keyword likec4Function rgba rgb
syn match   likec4Number /\v\<\d+(\.\d+|\%)?/

" ------------------------------------------------------------
" Highlight links
" ------------------------------------------------------------
hi def link likec4LineComment     Comment
hi def link likec4BlockComment    Comment
hi def link likec4DString         String
hi def link likec4SString         String
hi def link likec4TripleDString   String
hi def link likec4TripleSString   String
hi def link likec4Escape          SpecialChar

hi def link likec4Decl            Keyword
hi def link likec4TypeIdent       Type

hi def link likec4Property        Identifier
hi def link likec4BareValue       String
hi def link likec4EnumValue       Type

hi def link likec4Keyword         Keyword
hi def link likec4Boolean         Boolean

hi def link likec4Color           Constant
hi def link likec4HashIdent       Type

hi def link likec4ArrowText       Function
hi def link likec4Operator        Operator

hi def link likec4Enum            Type
hi def link likec4Variable        Identifier

hi def link likec4Symbol          Delimiter
hi def link likec4Equals          Operator

hi def link likec4Function        Function
hi def link likec4Number          Number

" ------------------------------------------------------------
" Sync & end
" ------------------------------------------------------------
"syn sync minlines=200
let b:current_syntax = 'likec4'
