%% texlive2016のdvipdfmx.def v4.12へ対応
%% \DeclarePaperFormat -> \kb@DeclarePaperFormatへ変更
%% \DeclareFontSizeBaseline -> \kb@DeclareFontSizeBaselineへ変更
%% \curentpageformat -> \kb@curentpageformatへ変更
%% \IFemptyを追加
%% クラスオプションにkeval形式を追加．
%%                [textwidth=30]
%% トンボ領域に通しノンブルを印字させるようにした．
%%                      [lastpage]で印字．
%% xkeyvalパッケージでピリオド付のファイル名を使うと
%% エラーになるので，ピリオド付をやめて枝varsionをアルファベットに変更
%% [usehyperref] hyperrefを使う場合に指定
%%			 ※その場合は，\section[TOC](HEADER){NAME}は使えない．
%% [rml] カンマとピリオドを太ミンにしたリュウミンライトを基底フォントにする
%% 		ただし，これを使うためには
%% 		A-OTF-RyuminPr6N-Light.otf
%% 		A-OTF-GothicBBBPr6N-Medium.otf
%% 		A-OTF-FutoMinA101Pr5-Bold.otf
%% 		の実体フォントが必要
%% 			※[rml]指定時において
%% 				[jis2004] 字体をjis2004字体にする．
%%		 		[jis2000] 字体をjis2000字体にする．([rml]指定時のデフォルト)
%%		これらは，[rml] を指定していないときは無効
%% [uplatex] uplatexで処理をする．


\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{kbdbook6}[2017/01/25]
\RequirePackage{keyval}
\DeclareRobustCommand\pTeX{p\kern-.05em\TeX}
\DeclareRobustCommand\pLaTeX{p\kern-.05em\LaTeX}
\DeclareRobustCommand\pLaTeXe{p\kern-.05em\LaTeXe}
\edef\KB@Class@Name          {\@currname}
\edef\KB@Class@Name@Full     {\@currname.\@currext}
\edef\KB@Class@ver   {\expandafter\csname ver@\@currname.\@currext\endcsname}
 \def\KB@class@error         {\ClassError{\KB@Class@Name}}
 \def\KB@class@warning       {\ClassWarning{\KB@Class@Name}}
 \def\KB@class@warningnoline {\ClassWarningNoLine{\KB@Class@Name}}
 \def\KB@class@info          {\ClassInfo{\KB@Class@Name}}


\@ifundefined{kchar}{\def\KB@use@platex{}}{\def\KB@use@platex{u}}
\@ifundefined{ppatch@level}{\def\KB@use@platex{}}{}

\def\KB@pltx@vertion{\KB@use@platex\pfmtname<\pfmtversion>+\ppatch@level\space
          (based on \fmtname<\fmtversion>+\patch@level)}

% \maketitleの\publisherで引数なしの場合に印字されます．
\def\@publisher{}

% min10.tfm由来(jis系tfmも含んだ)の和文フォントサイズを補正しています．
% pTeXではcmフォントに大きさを合わせるために，和文サイズを
% 約0.961倍程度に縮小して出力します．
% そのため，\fontsizeコマンドで13Qを出力させたくても13*0.961=12.493Qという
% 中途半端な大きさになってしまいます．
% ここでこれを補正して13Qと指定すれば実サイズで13Qが出力されるように
% しています．1.0392676はその拡大率で，以後これを\@jqscaleとして定義します．
% \@jescaleは和文フォントのサイズ補正に合わせてのcomputer moden fontの
% サイズ補正です．数値の客観的な根拠はなくさまざまなパターンを実際に紙に印字させて決定したものです．
% 本来ならばPostScript系のtype1フォントなども考慮すべきですが，
% この方針ではその都度fdファイルの再設定が必要になり際限がなくなるのでここまでの設定にとどめています．


\def\@jqscale{1.0392676}
\def\@jescale{1.056}

% オリジナルの定義の保存
\let\s@vpt\@vpt
\let\s@ivpt\@vipt
\let\s@viipt\@viipt
\let\s@viiipt\@viiipt
\let\s@ixpt\@ixpt
\let\s@xpt\@xpt
\let\s@xipt\@xipt
\let\s@xiipt\@xiipt
\let\s@xivpt\@xivpt
\let\s@xviipt\@xviipt
\let\s@xxpt\@xxpt
\let\s@xxvpt\@xxvpt

% 文字サイズと行送り用の変数の宣言です．
\newdimen\@@tiny
\newdimen\@@scriptsize
\newdimen\@@footnotesize
\newdimen\@@small
\newdimen\@@normalsize
\newdimen\@@large
\newdimen\@@Large
\newdimen\@@LARGE
\newdimen\@@huge
\newdimen\@@Huge
\newdimen\@@HUGE
\newskip\@@tiny@@baseline
\newskip\@@scriptsize@@baseline
\newskip\@@footnotesize@@baseline
\newskip\@@small@@baseline
\newskip\@@normalsize@@baseline
\newskip\@@large@@baseline
\newskip\@@Large@@baseline
\newskip\@@LARGE@@baseline
\newskip\@@huge@@baseline
\newskip\@@Huge@@baseline
\newskip\@@HUGE@@baseline

% \kb@DeclarePaperFormatで使う目的で作った引数をチェックするマクロで，
% 引数が数値だけなのかか，単位つきかを判断します．
% 与えられた文字列に数字以外が含まれているかをカテゴリーコードで判断を
% 行っているので\@tempdimaのような文字列変数は使えません．
\newif\ifunit@cnt@
\unit@cnt@false
\def\kb@unit@check#1{%	\ifunit@cnt@が切り替わる
% 			num+unit -> \unit@cnt@false
% 			num      -> \unit@cnt@true
	\@tfor\@@unit@@check :=#1\do{%
		\ifcat\@@unit@@check1\unit@cnt@true
			\else \unit@cnt@false
		\fi}}%
% このマクロでクラスオプションの名称，用紙サイズ，判面を設定します．
% 判面左右は文字の倍数もしくは寸法，天地はそれぞれ行数，もしくは寸法で
% 指定します．文字数や行数の場合は`zw'や`\baselineskip'は指定しないで，単位なしの数値のみで指定します．
% 寸法指定（mmやptをつけての指定）も可能ですが，数値指定が基本です．
\def\kb@DeclarePaperFormat#1#2#3#4#5{%
% #1=<dsoption> #2=\paperwidth #3=\paperheight #4=\textwidth #5=\textheight
% \DeclareOption{#1}{%
\def\kb@curentpageformat{#1}
	\paperwidth=#2\relax%
	\paperheight=#3\relax%
\kb@unit@check{#4}%
\ifunit@cnt@%
	\textwidth\@@normalsize
	\multiply\textwidth #4\relax
\else
\textwidth#4\relax
\fi
\kb@unit@check{#5}%
\ifunit@cnt@%
	\textheight=#5\@@normalsize@@baseline
	\advance\textheight-\@@normalsize@@baseline
		\if@keepfline@@
			\topskip=\@@normalsize@@baseline
		\else
			\setbox0\hbox{\char\euc"A1A1}%
			\topskip=\ht0\relax
			\topskip=\@jqscale\topskip
		\fi
	\advance\textheight by\topskip
\else
\textheight=#5\relax
\fi
}

% :use \newcommand{\aaa}[1][]{\IFempty{#1}{Yes}{No}}
% eplain.texより
\newcommand{\@emptymarkA}{\@emptymarkB} 
\newcommand{\IFempty}[3]{\kb@IFempty{#1}#2\else#3\fi}%
\newcommand{\kb@IFempty}[1]{\kb@@IFempty #1\@emptymarkA\@emptymarkB}%
\def\kb@@IFempty#1#2\@emptymarkB{\ifx #1\@emptymarkA}%

% \kb@DeclarePaperFormatに小口と天の空きを追加したものが
% \kb@DeclarePaperFormatsです．（2011/12/23よりこちらを採用）
% 第6が小口，第7引数が天のアキになります．
% この場合「天」とは，上部仕上がりから第1行目の際です．
\def\kb@DeclarePaperFormats#1#2#3#4#5#6#7{%
% #1=<dsoption> #2=\paperwidth #3=\paperheight #4=\textwidth #5=\textheight
% #6=\evensidemargin #7=\topmargin-(\headsep+\headheight)
% \DeclareOption{#1}{%
\def\kb@curentpageformat{#1}
	\paperwidth=#2\relax%
	\paperheight=#3\relax%
\kb@unit@check{#4}%
\ifunit@cnt@%
	\textwidth\@@normalsize
	\multiply\textwidth #4\relax
\else
\textwidth#4\relax
\fi
\kb@unit@check{#5}%
\ifunit@cnt@%
	\textheight=#5\@@normalsize@@baseline
	\advance\textheight-\@@normalsize@@baseline
		\if@keepfline@@
			\topskip=\@@normalsize@@baseline
		\else
			\setbox0\hbox{\char\euc"A1A1}%
			\topskip=\ht0\relax
			\topskip=\@jqscale\topskip
		\fi
	\advance\textheight by\topskip
\else
\textheight=#5\relax
\fi
\def\tmp@ca{#6\relax}
\def\tmp@cb{#7\relax}
\def\tmp@cc{\relax}
  \ifx\tmp@ca\tmp@cc
      \t@@centertrue\dimen0=\z@
    \else\t@@centerfalse\topmargin#6%
  \fi
  \ifx\tmp@cb\tmp@cc
      \y@@centertrue\dimen1=\z@
    \else\y@@centerfalse\evensidemargin#7%
  \fi
}
\newif\ift@@center
\t@@centerfalse
\newif\ify@@center
\y@@centerfalse

% \kb@DeclareFontSizeBaselinenなるコマンドを新設して標準的なLaTeXのサイズコマンド
% を比較的容易に変更できるようにしています．
% 併せて，新規のサイズコマンドを新設できるようにしています．
% (標準的なLaTeXサイズコマンドの変更の場合，このマクロでは決して本質的な変更を行っているわけではありません．このマクロでは単に数値の保存を行っているだけです．)
% 引数で既成のサイズコマンドを指定し#1で文字サイズ，#2でbaselineskipを設定します．
% 新規のサイズコマンドの場合，#1を（定義可能な）適当な名称で設定可能です．
% LaTeX標準のサイズコマンドの設定はプリアンブルなどでの変更はできません．本来ならば\documentclass[b5]などと指定した場合，b5サイズに連動させて行間を調整したり修正したりすべきでしょうが，\kb@DeclarePaperFormatで設定した内容と特に連動はさせていません．


\def\kb@DeclareFontSizeBaseline#1#2#3{\@ifundefined{@@#1}{%
\expandafter\def\csname #1\endcsname{%
\@nomath{#1}%
    \ifx\protect\@typeset@protect
%     \def\@@@currsize{\csname #1\endcsname}%
%      \let\@currsize\@@@currsize
     \expandafter\def\expandafter\@currsize\expandafter{\csname #1\endcsname}%
    \fi
\fontsize{#2}{#3}\selectfont
}}{%
\csname @@#1\endcsname=#2\relax%
\csname @@#1@@baseline\endcsname=#3\relax%
}}

% 宣言型にして\textbf{和文}欧文などでの4分アキを確保．
% 行頭で使われても\leavevmodeを置いて\everypar内での展開を防いでます．
\DeclareRobustCommand\textbf[1]{%
	\relax\ifmmode\hbox\else\leavevmode\fi{\bfseries #1}}
\DeclareRobustCommand\textmc[1]{%
	\relax\ifmmode\hbox\else\leavevmode\fi{\mcfamily #1}}
\DeclareRobustCommand\textgt[1]{%
	\relax\ifmmode\hbox\else\leavevmode\fi{\gtfamily #1}}

% \bfsなる書体切り替えコマンドを新設しています．
% この\bfsは各パーツの\bfseries に置き換えるように定義してます．
% クラスオプション[gtsf]でこれは\sffamily+\gtfamilyに置き換わります．
% 例： \documentclass[gtsf,tombow]{ttcalss}
% これにより，見出しやキャプションなど主要なパーツは\sffamily+\gtfamily
% になります．
% 	この場合は，\renewcommand{\sfdefault}{phv}としてhelveticaを使った
% 	方が見栄えが良いかもしれません．
% \bf や\textbfでは従来通り\rmfamily/\bfseries+\gtfamilyです．
% この点について当初\bf と\textbfでも\sffamily+\gtfamilyの組合せにしようと
% 思いましたがとりあえず止めにしています．
% \sffamilyに\gtfamilyを連動させていますので，
% 本文中でこの組合せにしたい場合は\sf, \textsfとします．
% 
% \DeclareRobustCommand*{\bfs}{\kanjifamily\gtdefault\romanfamily\sfdefault\selectfont}
 \DeclareRobustCommand*\bfs{\kanjifamily\gtdefault\rmfamily\bfseries}
% \renewcommand{\sfdefault}{phv}

% 各パーツにフォントとサイズをセットします．
 \DeclareRobustCommand*\KBcaptionfont{\reset@font\small}
 \DeclareRobustCommand*\KBpagenumfont{\reset@font\small}
 \DeclareRobustCommand*\KBheaderfont{\reset@font\small}
 \DeclareRobustCommand*\KBmarginparfont{\reset@font\footnotesize}
% 見出し
% 命名規則変更 KB+parts+font
 \DeclareRobustCommand*\KBpartfont{\reset@font\huge\bfs}
 \DeclareRobustCommand*\KBpartnumfont{\reset@font\huge\bfs}
 \DeclareRobustCommand*\KBchapterfont{\reset@font\huge\bfs}
 \DeclareRobustCommand*\KBchapternumfont{\reset@font\huge\bfs}
 \DeclareRobustCommand*\KBindextitlefont{\reset@font\huge\bfs}%
 \DeclareRobustCommand*\KBsectionfont{\reset@font\Large\bfs}
 \DeclareRobustCommand*\KBsectionnumfont{\reset@font\Large\bfs}
 \DeclareRobustCommand*\KBsubsectionfont{\reset@font\large\bfs}
 \DeclareRobustCommand*\KBsubsectionnumfont{\reset@font\large\bfs}
 \DeclareRobustCommand*\KBsubsubsectionfont{\reset@font\normalsize\bfs}
 \DeclareRobustCommand*\KBsubsubsectionnumfont{\reset@font\normalsize\bfs}
 \DeclareRobustCommand*\KBparagraphfont{\reset@font\normalsize\bfs}
 \DeclareRobustCommand*\KBparagraphnumfont{\reset@font\normalsize\bfs}
 \DeclareRobustCommand*\KBsubparagraphfont{\reset@font\normalsize\bfs}
% 目次
 \DeclareRobustCommand*\KBtocpartfont{\reset@font\Large\bfs}
 \DeclareRobustCommand*\KBtocnumpartfont{\reset@font\Large\bfs}
 \DeclareRobustCommand*\KBtocchapterfont{\reset@font\large\bfs}
 \DeclareRobustCommand*\KBtocnumchapterfont{\reset@font\large\bfs}
 \DeclareRobustCommand*\KBtocsectionfont{\reset@font\rmfamily\normalcolor}
 \DeclareRobustCommand*\KBtocsubsectionfont{\reset@font\rmfamily\normalcolor}
 \DeclareRobustCommand*\KBtocsubsubsectionfont{\reset@font\rmfamily\normalcolor}
 \DeclareRobustCommand*\KBtocnumsectionfont{\reset@font\rmfamily\normalcolor}
 \DeclareRobustCommand*\KBtocnumsubsectionfont{\reset@font\rmfamily\normalcolor}
 \DeclareRobustCommand*\KBtocnumsubsubsectionFont{\reset@font\rmfamily\normalcolor}


\DeclareRobustCommand{\cmttorg}[1]{\bgroup\renewcommand{\ttdefault}{kcmtt}#1\egroup}

% 既定サイズフォント以外の中間サイズでの数式の添字の大きさの補正を
% 行っています．親文字が11Q以下の場合は\scriptfontは親文字に対し0.75倍，
% \scriptscriptfontは0.55倍にし，20Q以上の場合は0.83倍，0.67倍にします．
% 続く\selectfontの再定義でこれを有効にしています．
% その他のサイズはデフォルトのとおり0.7と0.5倍です．
% ^*latex.ltxにおける\defaultscriptratioは0.7
%   \defaultscriptscriptratioは0.5になっている．

\def\defaultscriptratio{.7}
\def\defaultscriptscriptratio{.5}
\let\save@defaultscriptratio\defaultscriptratio
\let\save@defaultscriptscriptratio\defaultscriptscriptratio
% 小さな親文字に対する添え字サイズの比率
\def\default@tiny@scriptratio{.75}
\def\default@tiny@scriptscriptratio{.55}
% \def\default@tiny@scriptratio{.9}
% \def\default@tiny@scriptscriptratio{.85}
% 大きな親文字に対する添え字サイズの比率
\def\default@Huge@scriptratio{0.83}
\def\default@Huge@scriptscriptratio{0.67}
% 添え字の大きさ設定を切り替える下限
\def\script@script@tiny@limit{11Q}
% 添え字の大きさ設定を切り替える上限
\def\script@script@Huge@limit{20Q}
% デフォルトの\tabcolsep（相対的な2分アキ）
\def\defaulttabcolsep{.5zw}
\def\@set@indent@update@{%
\ifdim\parindent>\z@\parindent=1zw\fi
\kanjiskip=0zw plus .1zw minus .01zw%
\ifdim\xkanjiskip>\z@\xkanjiskip0.2zw plus 0.1zw minus 0.06zw\fi
 \ifdim\f@size\p@ <\script@script@tiny@limit
    \def\defaultscriptratio{\default@tiny@scriptratio}%
    \def\defaultscriptscriptratio{\default@tiny@scriptscriptratio}%
   \else
     \ifdim\f@size\p@ >\script@script@Huge@limit
        \def\defaultscriptratio{\default@Huge@scriptratio}%
        \def\defaultscriptscriptratio{\default@Huge@scriptscriptratio}%
     \else
        \let\defaultscriptratio\save@defaultscriptratio
        \let\defaultscriptscriptratio\save@defaultscriptscriptratio
     \fi
 \fi
\tabcolsep\defaulttabcolsep
%\EncChake
}

%%% テスト中
\iffalse
\def\kb@Enc@t{T1}
\def\kb@Enc@ot{OT1}
\def\kb@Enc@oms{OMS}
\def\kb@Fam@cmtt{cmtt}
\def\EncChake{%
\xspcode64=3\relax%% @
\xspcode61=3\relax%% =
\xspcode37=3\relax%% %
\xspcode38=3\relax%% &
\xspcode58=3\relax%% :
\xspcode63=2\relax%% ?
\xspcode92=1\relax%% \
\ifx\f@encoding\kb@Enc@t%% T1
	\xspcode123=1\xspcode125=2%% \{, \}
	\else
%%	\ifx\f@encoding\kb@Enc@ot%% OT1
		\xspcode123=0\xspcode125=0%% --, $''$
%%	\fi
\fi}
%	\let\saveselectfont\selectfont
%	\def\selectfont{\saveselectfont\EncChake}
\fi
%%%%%%

% \selectfontに\parindentと\xkanjiskipの設定，および
%（\defaultscript(script)ratioにおける）数式の添字に対するサイズ
% 補正を追加しています．
% 文字サイズが変更されても，文字の大きさに応じて各パラメータが追従するような
% 動作を期待しています．ここで言う各パラメータは\parindent, \scriptfont, \scriptscriptfont, \xkanjiskip，変更された文字サイズの2分とするようにした\tabcolsepです．
% *2012/03/27の更新で\tabcolsepを各サイズの半角分となるようにしました．
% \xkanjiskipなどが反映されるのはその数値が有効な状態で\parが発行された段階，もしくは\hbox内での完結状態なので，単に{\footnotesize }としたままでは出力結果に反映されません．{\footnotesize \par}や\hbox{\footnotesize }のような指定が必要です．（{\footnotesize }\parではダメです）

\def\KBfontinfoupdate{\size@update\@set@indent@update@}
\g@addto@macro\selectfont{\KBfontinfoupdate}

%% \DeclareRobustCommand\selectfont{%
%%   \let\tmp@error@fontshape\error@fontshape
%%   \let\error@fontshape\error@kfontshape
%%   \edef\tmp@item{{\k@encoding}}%
%%   \expandafter\expandafter\expandafter
%%   \inlist@\expandafter\tmp@item\expandafter{\kyenc@list}%
%%   \ifin@
%%     \let\cy@encoding\k@encoding
%%     \edef\ct@encoding{\csname t@enc@\k@encoding\endcsname}%
%%   \else
%%     \expandafter\expandafter\expandafter
%%     \inlist@\expandafter\tmp@item\expandafter{\ktenc@list}%
%%     \ifin@
%%       \let\ct@encoding\k@encoding
%%       \edef\cy@encoding{\csname y@enc@\k@encoding\endcsname}%
%%     \else
%%       \@latex@error{KANJI Encoding scheme `\k@encoding' unknown}\@eha
%%     \fi
%%   \fi
%%   \let\font\tfont
%%   \let\k@encoding\ct@encoding
%%   \xdef\font@name{\csname\curr@kfontshape/\f@size\endcsname}%
%%   \pickup@font
%%   \font@name
%%   \let\font\jfont
%%   \let\k@encoding\cy@encoding
%%   \xdef\font@name{\csname\curr@kfontshape/\f@size\endcsname}%
%%   \pickup@font
%%   \font@name
%%   \expandafter\def\expandafter\k@encoding\tmp@item
%%   \kenc@update
%%   \let\error@fontshape\tmp@error@fontshape
%%   \if@knjcmd \@knjcmdfalse
%%     \expandafter\ifx
%%     \csname rel@\k@encoding/\k@family/\k@series/\k@shape\endcsname\relax
%%       \expandafter\ifx
%%          \csname rel@\k@encoding/\k@family/\k@series/all\endcsname\relax
%%       \else
%%          \csname rel@\k@encoding/\k@family/\k@series/all\endcsname
%%       \fi
%%     \else
%%        \csname rel@\k@encoding/\k@family/\k@series/\k@shape\endcsname
%%     \fi
%%   \fi
%%   \let\font\afont
%%   \xdef\font@name{\csname\curr@fontshape/\f@size\endcsname}%
%%   \pickup@font
%%   \font@name
%%   \enc@update
%%   \ifx\f@linespread\baselinestretch \else
%%     \set@fontsize\baselinestretch\f@size\f@baselineskip
%%   \fi
%%   \size@update\@set@indent@update@}

% pTeXの\inhibitglueのbug由来で起こる強制改行後約物不揃いに対するTeX FAQで
% 公開されたjsシリーズ用の八登氏によるパッチです．jsシリーズとほぼ同じプロセスを
% 使っているので本クラスファイルでも適用させてます．
% ## 強制改行後の処理を\ignorespacesでなく\futureletで空白トークンを
% ## 読み飛ばしてから\@inhibitglue．
\def\@gnewline #1{%
  \ifvmode
    \@nolnerr
  \else
    \unskip \reserved@e {\reserved@f#1}\nobreak \hfil \break \null
    \expandafter\kb@afternewline
  \fi}
\def\kb@afternewline{%
  \protect\kb@afternl@a}
\def\kb@afternl@a{%
  \futurelet\@let@tokan\kb@afternl@b}
\def\kb@afternl@b{%
  \ifx\@let@token\@sptoken
    \expandafter\kb@afternl@a
  \else
    \expandafter\@inhibitglue
  \fi}

% 各条件分岐の宣言です．
% 見出しが頁上部に来たときにアキを設けるか否か
\newif\ifsectiontopmargin
\sectiontopmarginfalse
\newif\ifseccntfixHead
% 柱に\seccnt@prefix@sectionを入れる．
\seccntfixHeadtrue
% 	\seccntfixHeadfalse
\newif\ifseccntfixToc
% 目次に\seccnt@postfix@sectionを入れる．
\seccntfixToctrue
% 	\seccntfixTocfalse
\newif\if@Koguchi\@Koguchifalse
\newif\if@gtsf\@gtsffalse
\newif\if@JIStfm\@JIStfmtrue
\newif\ifS@ection\S@ectionfalse
\newif\ifsubS@ection\subS@ectionfalse
\newif\ifsubsubS@ection\subsubS@ectionfalse
\newif\if@outputpaperset\@outputpapersetfalse
\newif\if@keepfline@@\@keepfline@@false
\newif\if@kb@rml\@kb@rmlfalse
\newif\if@kb@jisx@glyph\@kb@jisx@glyphfalse
% \@keepfline@@true
% どの見出しレベルの\@dottedtoclineが実行されたかを
% 判断して目次の文字サイズをセットします．
\newcommand{\@TocSectionSlectFont}{%
\ifS@ection
  \KBtocsectionfont
\else
   \ifsubS@ection
     \KBtocsubsectionfont
   \else
     \ifsubsubS@ection
       \KBtocsubsubsectionfont
     \else
         \reset@font\rmfamily \normalcolor
     \fi
    \fi
\fi
}
% 同じです．これは目次で引かれるページ番号
\newcommand{\@TocSectionNumSlectFont}{%
\ifS@ection%
  \KBtocnumsectionfont%
\else%
   \ifsubS@ection%
     \KBtocnumsubsectionfont%
   \else%
     \ifsubsubS@ection%
      \KBtocnumsubsubsectionFont%
     \else%
        \reset@font\rmfamily \normalcolor%
      \fi%
     \fi%
\fi%
}

% 禁則penaltyの補正です．
\prebreakpenalty\jis"2147=10000
\postbreakpenalty\jis"2148=10000
\prebreakpenalty\jis"2149=10000

% \xpcodeと\inhibitxspcodeの追加です．
% メモ：
% 連続する漢字（2バイトコード）と英字（1バイトコード）の間に
% 自動的に挿入する スペースについて、どの英字と漢字の間で挿入
% するかしないかを指定します。 この指定は0～3のいずれかを設定
% することで、つぎの動作を選択します。
%  0  英字と前後の漢字の間の処理を禁止する。
%  1  直前の漢字との間にだけスペースの挿入を許可する。
%  2  直後の漢字との間にだけスペースの挿入を許可する。
%  3  前後の漢字との間に対して、スペースの挿入を許可する。
\xspcode37=3% \%
\xspcode`:=2% :
\xspcode`!=2% !
\xspcode`+=3% +
\xspcode`,=2% ,
%\xspcode`^^7b=1
%\xspcode`^^7d=2
% for T1 Encoding
\xspcode`^^80=3
\xspcode`^^81=3
\xspcode`^^82=3
\xspcode`^^83=3
\xspcode`^^84=3
\xspcode`^^85=3
\xspcode`^^86=3
\xspcode`^^87=3
\xspcode`^^88=3
\xspcode`^^89=3
\xspcode`^^8a=3
\xspcode`^^8b=3
\xspcode`^^8c=3
\xspcode`^^8d=3
\xspcode`^^8e=3
\xspcode`^^8f=3
\xspcode`^^90=3
\xspcode`^^91=3
\xspcode`^^92=3
\xspcode`^^93=3
\xspcode`^^94=3
\xspcode`^^95=3
\xspcode`^^96=3
\xspcode`^^97=3
\xspcode`^^98=3
\xspcode`^^99=3
\xspcode`^^9a=3
\xspcode`^^9b=3
\xspcode`^^9c=3
\xspcode`^^9d=3
\xspcode`^^9e=3
\xspcode`^^9f=3
\xspcode`^^a0=3
\xspcode`^^a1=3
\xspcode`^^a2=3
\xspcode`^^a3=3
\xspcode`^^a4=3
\xspcode`^^a5=3
\xspcode`^^a6=3
\xspcode`^^a7=3
\xspcode`^^a8=3
\xspcode`^^a9=3
\xspcode`^^aa=3
\xspcode`^^ab=3
\xspcode`^^ac=3
\xspcode`^^ad=3
\xspcode`^^ae=3
\xspcode`^^af=3
\xspcode`^^b0=3
\xspcode`^^b1=3
\xspcode`^^b2=3
\xspcode`^^b3=3
\xspcode`^^b4=3
\xspcode`^^b5=3
\xspcode`^^b6=3
\xspcode`^^b7=3
\xspcode`^^b8=3
\xspcode`^^b9=3
\xspcode`^^ba=3
\xspcode`^^bb=3
\xspcode`^^bc=3
\xspcode`^^bd=3
\xspcode`^^be=3
\xspcode`^^bf=3
\xspcode`^^c0=3
\xspcode`^^c1=3
\xspcode`^^c2=3
\xspcode`^^c3=3
\xspcode`^^c4=3
\xspcode`^^c5=3
\xspcode`^^c6=3
\xspcode`^^c7=3
\xspcode`^^c8=3
\xspcode`^^c9=3
\xspcode`^^ca=3
\xspcode`^^cb=3
\xspcode`^^cc=3
\xspcode`^^cd=3
\xspcode`^^ce=3
\xspcode`^^cf=3
\xspcode`^^d0=3
\xspcode`^^d1=3
\xspcode`^^d2=3
\xspcode`^^d3=3
\xspcode`^^d4=3
\xspcode`^^d5=3
\xspcode`^^d6=3
\xspcode`^^d7=3
\xspcode`^^d8=3
\xspcode`^^d9=3
\xspcode`^^da=3
\xspcode`^^db=3
\xspcode`^^dc=3
\xspcode`^^dd=3
\xspcode`^^de=3
\xspcode`^^df=3
\xspcode`^^e0=3
\xspcode`^^e1=3
\xspcode`^^e2=3
\xspcode`^^e3=3
\xspcode`^^e4=3
\xspcode`^^e5=3
\xspcode`^^e6=3
\xspcode`^^e7=3
\xspcode`^^e8=3
\xspcode`^^e9=3
\xspcode`^^ea=3
\xspcode`^^eb=3
\xspcode`^^ec=3
\xspcode`^^ed=3
\xspcode`^^ee=3
\xspcode`^^ef=3
\xspcode`^^f0=3
\xspcode`^^f1=3
\xspcode`^^f2=3
\xspcode`^^f3=3
\xspcode`^^f4=3
\xspcode`^^f5=3
\xspcode`^^f6=3
\xspcode`^^f7=3
\xspcode`^^f8=3
\xspcode`^^f9=3
\xspcode`^^fa=3
\xspcode`^^fb=3
\xspcode`^^fc=3
\xspcode`^^fd=3
\xspcode`^^fe=3
\xspcode`^^ff=3

% メモ：
% 連続する漢字（2バイトコード）と英字（1バイトコード）の間に
% 自動的に挿入する スペースについて、どの漢字と英字の間で挿入
% するかしないかを指定します。
% この指定は0～3のいずれかを設定することで、つぎの動作を選択
% します。
%    0  漢字と英字間の処理を禁止する。
%    1  直前の英字との間にだけスペースの挿入を禁止する。
%    2  直後の英字との間にだけスペースの挿入を禁止する。
%    3  前後の英字との間に対して、スペースの挿入を許可する。
\inhibitxspcode`〒=2
\inhibitxspcode`℃=1
\inhibitxspcode`％=1
\inhibitxspcode`＆=0
\inhibitxspcode`！=0
\inhibitxspcode`°=0
\inhibitxspcode`￥=2

\newif\if@landscape \@landscapefalse
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\newif\if@mainmatter \@mainmattertrue
\hour\time \divide\hour by 60\relax
\@tempcnta\hour \multiply\@tempcnta 60\relax
\minute\time \advance\minute-\@tempcnta
\newif\if@enablejfam \@enablejfamtrue
\newif\if@KB@hyperref \@KB@hyperreffalse
\newif\if@KB@lastpage \@KB@lastpagefalse

\newtoks\@bannertokenI
\@bannertokenI{}

\font\@bannerfont=cmtt8
\DeclareOption{tombow}{%
  \tombowtrue \tombowdatetrue
  \setlength{\@tombowwidth}{.1\p@}%
  \@bannertoken{%
	\jobname:<\number\year/\number\month/\number\day>(\number\hour:\number\minute)}
  \@bannertokenI{%
	\KB@Class@Name<\KB@Class@ver>:\space\KB@pltx@vertion:\space\KB@@booktitle
	}
  \maketombowbox}
\DeclareOption{lastpage}{\@KB@lastpagetrue}
\DeclareOption{usehyperref}{\@KB@hyperreftrue}
\DeclareOption{notombow}{%
  \tombowfalse \tombowdatefalse}
\DeclareOption{tombo}{%
  \tombowtrue \tombowdatefalse
  \setlength{\@tombowwidth}{.1\p@}%
  \maketombowbox}
\DeclareOption{mentuke}{%
  \tombowtrue\tombowdatefalse
  \setlength{\@tombowwidth}{\z@}%
  \@bannertoken{\@empty}
  \maketombowbox}
\DeclareOption{tate}{%
  \AtBeginDocument{\tate\message{《縦組モード》}% 縦組モードは動作未確認.
                   \adjustbaseline}%
}


% optionのgtsfなどを追加しています．
% gtsfは\bsfをボールドからサンセリフにします．

% 各仕上がりサイズに応じて版面や文字サイズなどを個別に指定します．
% 版面は仕上がりサイズとの比率で設定しようかと考えましたが絶対値を指定されると
% 面倒なので，やや冗長ではありますが，このようにしたほうが指定も楽になるので
% このようにしました．
% 想定している仕上がりサイズは現在A5正寸，B5正寸，B5変形(210mm×182mm)の三つです．
% \kb@DeclareFontSizeBaseline{#1}{#2}{#3}
% #1 <sizecommand>
% #2 <文字サイズ>
% #3 <行間(baselineskip)>
% b5，b5変形，a5判でのデフォルト設定
% \kb@DeclarePaperFormat{#1}{#2}{#3}{#4}{#5}
% #1 <クラスオプションで指定する文字列>
% #2 <用紙サイズの左右>
% #3 <用紙サイズの天地>
% #4 <判面左右（文字数の倍数の場合単位なし）>
% #5 <判面天地（行数の倍数の場合単位なし）>
% \kb@DeclarePaperFormats{#1}{#2}{#3}{#4}{#5}{#6}{#7}
% #1 <クラスオプションで指定する文字列>
% #2 <用紙サイズの左右>
% #3 <用紙サイズの天地>
% #4 <判面左右（文字数の倍数の場合単位なし）>
% #5 <判面天地（行数の倍数の場合単位なし）>
% #6 <小口幅>（空で左右中央）
% #7 <天幅>（空で左右中央）
\DeclareOption{a4}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{16H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{14Q}{24H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{a4}{210mm}{297mm}{42}{39}{}{}
}
\DeclareOption{a5}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{16H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{13Q}{22H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{a5}{148mm}{210mm}{34}{31}{}{}
}
\DeclareOption{a5/12Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{9Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{10Q}{16H}
	\kb@DeclareFontSizeBaseline{small}{11Q}{17H}
	\kb@DeclareFontSizeBaseline{normalsize}{12Q}{22H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{a5}{148mm}{210mm}{34}{31}{}{}
}
\DeclareOption{a5/12.5Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{16H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{12.5Q}{22H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{a5}{148mm}{210mm}{34}{31}{}{}
}
\DeclareOption{a5/13Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{16H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{13Q}{22H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{a5}{148mm}{210mm}{34}{31}{}{}
}
\DeclareOption{a5/13.5Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{16H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{13.5Q}{22H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{a5}{148mm}{210mm}{34}{31}{}{}
}
\DeclareOption{a5/14Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{16H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{14Q}{23H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{a5}{148mm}{210mm}{34}{31}{}{}
}
\DeclareOption{kiku}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{16H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{13Q}{22H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{kiku}{153mm}{220mm}{35}{35}{}{}
}
\DeclareOption{b5}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{17H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{13Q}{25H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{b5}{182mm}{257mm}{44}{33}{}{}
}
\DeclareOption{b5/12Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{17H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{12Q}{25H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{b5}{182mm}{257mm}{45}{33}{}{}
}
\DeclareOption{b5/13Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{17H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{13Q}{25H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{b5}{182mm}{257mm}{44}{33}{}{}
}
\DeclareOption{b5/13.5Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{17H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{13.5Q}{25H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{b5}{182mm}{257mm}{44}{33}{}{}
}
\DeclareOption{b5/14Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{17H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{14Q}{25H}
	\kb@DeclareFontSizeBaseline{large}{15Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{16Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{17Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{b5}{182mm}{257mm}{44}{33}{}{}
}
\DeclareOption{b5ver/13Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{17H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{13Q}{25H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
\kb@DeclarePaperFormats{b5var}{183mm}{235mm}{44}{33}{}{}
}
\DeclareOption{b5ver/13.5Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{17H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{13.5Q}{23H}
	\kb@DeclareFontSizeBaseline{large}{14Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{15Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{16Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
\kb@DeclarePaperFormats{b5var}{183mm}{235mm}{43}{33}{}{}
}
\DeclareOption{b5ver/14Q}{%
	\kb@DeclareFontSizeBaseline{tiny}{7Q}{9H}
	\kb@DeclareFontSizeBaseline{scriptsize}{10Q}{12H}
	\kb@DeclareFontSizeBaseline{footnotesize}{11Q}{17H}
	\kb@DeclareFontSizeBaseline{small}{12Q}{18H}
	\kb@DeclareFontSizeBaseline{normalsize}{14Q}{25H}
	\kb@DeclareFontSizeBaseline{large}{15Q}{20H}
	\kb@DeclareFontSizeBaseline{Large}{16Q}{21H}
	\kb@DeclareFontSizeBaseline{LARGE}{17Q}{24H}
	\kb@DeclareFontSizeBaseline{huge}{20Q}{29H}
	\kb@DeclareFontSizeBaseline{Huge}{25Q}{31H}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
\kb@DeclarePaperFormats{b5var}{183mm}{235mm}{42}{33}{}{}
}
\DeclareOption{a5/10pt}{%
	\kb@DeclareFontSizeBaseline{tiny}{\s@vpt pt}{6pt}
	\kb@DeclareFontSizeBaseline{scriptsize}{\s@viipt pt}{8pt}
	\kb@DeclareFontSizeBaseline{footnotesize}{\s@viiipt pt}{9.5pt}
	\kb@DeclareFontSizeBaseline{small}{\@ixpt pt}{11pt}
	\kb@DeclareFontSizeBaseline{normalsize}{\s@xpt pt}{15pt}
	\kb@DeclareFontSizeBaseline{large}{\s@xiipt pt}{17pt}
	\kb@DeclareFontSizeBaseline{Large}{\s@xivpt pt}{21pt}
	\kb@DeclareFontSizeBaseline{LARGE}{\s@xviipt pt}{25pt}
	\kb@DeclareFontSizeBaseline{huge}{\s@xxpt pt}{28pt}
	\kb@DeclareFontSizeBaseline{Huge}{\s@xxvpt pt}{33pt}
	\kb@DeclareFontSizeBaseline{HUGE}{45Q}{61H}
	\kb@DeclareFontSizeBaseline{tabfont}{12Q}{14H}
	\kb@DeclarePaperFormats{a5}{148mm}{210mm}{34}{31}{}{}
}
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{twoside}{\@twosidetrue}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{titlepage}{\@titlepagetrue}
\DeclareOption{notitlepage}{\@titlepagefalse}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{gtsf}{\@gtsftrue}
\DeclareOption{pdfa4}{\@outputpapersettrue}
\DeclareOption{keepfline}{\@keepfline@@true}
% 上はページの第一行目に背の高い文字が来ても極力一行目が下にずれないための処置です．ただし，大きな文字を使った\sectionなどでも天をはみ出してしまう副作用があるのでデフォルトはfalseにしてます．せっかく設定したのでオプション扱いで残します．
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}}
\DeclareOption{disablejfam}{\@enablejfamfalse}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{uplatex}{\@JIStfmfalse}
\DeclareOption{rml}{\@kb@rmltrue}
\DeclareOption{jis2004}{\@kb@jisx@glyphtrue}
\DeclareOption{jis2000}{\@kb@jisx@glyphfalse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{dviout}{}
\DeclareOption{dvips}{}
\DeclareOption{dvipdfm}{}
\DeclareOption{dvipdfmx}{}
\def\KB@setkey{%
  \expandafter\KB@setkey@a\expandafter{\CurrentOption}}
\def\KB@setkey@a{\setkeys{KB}}
%%\define@key{KB}{sectionfontsize}{\DeclareRobustCommand*\KBsectionfont{\reset@font\csname #1\endcsname}}
\def\KB@@booktitle{}
\define@key{KB}{booktitle}{\def\KB@@booktitle{\fontsize{4pt}{\z@}\selectfont\textsf{#1}}}%
\define@key{KB}{paperwidth}{\paperwidth=#1}%
\define@key{KB}{paperheight}{\paperheight=#1}%
\define@key{KB}{normalsize}{\@@normalsize=#1}
\define@key{KB}{nomalbaselineskip}{\@@normalsize@@baseline=#1}
\define@key{KB}{smallsize}{\@@small=#1}
\define@key{KB}{smallbaselineskip}{\@@small@@baseline=#1}
\define@key{KB}{footnotesize}{\@@foornote=#1}
\define@key{KB}{footnotebaselineskip}{\@@footnote@@baseline=#1}
\define@key{KB}{cmscaled}[1.0]{\def\@jescale{#1}}
\define@key{KB}{textwidth}{%
	\kb@unit@check{#1}%  倍数を指定したい場合は単位なし
	\ifunit@cnt@%
		\setlength{\textwidth}{\@@normalsize}%
		\multiply\textwidth #1\relax
	\else
	\setlength{\@tempdima}{\@@normalsize}
	\setlength{\@tempdima}{\@jqscale\@tempdima}
	\fontsize{\@tempdima}{\z@}\selectfont
		\setlength{\textwidth}{#1}%
	\fi
}
\define@key{KB}{textheight}{%%  行数で指定したい場合は単位なし
\kb@unit@check{#1}%
\ifunit@cnt@%
	\textheight=#1\@@normalsize@@baseline
	\advance\textheight-\@@normalsize@@baseline
		\if@keepfline@@
			\topskip=\@@normalsize@@baseline
		\else%%\showthe\@@normalsize
			\setbox0\hbox{\fontsize{\@@normalsize}{\z@}\selectfont\char\euc"A1A1}%
			\topskip=\ht0\relax
			\topskip=\@jqscale\topskip
		\fi
	\advance\textheight by\topskip
\else
\textheight=#1\relax
\fi
}
\define@key{KB}{outsidemargin}{\AtEndOfClass{\Koguchi{#1}}}
\define@key{KB}{upmargin}{\AtEndOfClass{\TenAki{#1}}}

\DeclareOption*{\KB@setkey}
%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@KB@tt@face@
\@KB@tt@face@true
\DeclareOption{nottscale}{\@KB@tt@face@false}

\ExecuteOptions{a5/13Q,tombow,twoside,onecolumn,final,openright}
\ProcessOptions\relax

\renewcommand*\KB@class@error[2]{\ClassWarningNoLine{kbdbook}{#1}}%2025/10/24追記

\if@JIStfm
\@ifundefined{kchar}{}{%
	\KB@class@error{Please specify a `uplatex' option, if you are going to use upLaTeX
}{}}
\else
\@ifundefined{kchar}{%
	\KB@class@error{Please do not specify the `uplatex' option, when you use pLaTeX
}{}}
\fi
\if@kb@jisx@glyph
	\if@kb@rml\relax
	\else
	\KB@class@error{If you want to use to JIS2004 font, you please specify the `rml 'option.}
	\fi
\fi


\if@KB@lastpage
	\iftombowdate
	\newcount\KB@totalpage
	\def\KB@lastoftotalpage{--}
    \AtEndDocument{%
	\clearpage
	\immediate\write\@auxout{%
	\gdef\string\KB@lastoftotalpage{\the\KB@totalpage}}%
    }%
	\def\KB@put@totalpage{\global\advance\KB@totalpage\@ne
	    \raise4pt\hbox to\z@{\hss
	        \@bannerfont\the\KB@totalpage/\KB@lastoftotalpage\hskip5mm}}
	        
\AtBeginDocument{%
    \let\@@TR\@TR
    \def\@TR{\@@TR\KB@put@totalpage}%
    }%
	\fi
\fi

\iftombow
	\iftombowdate
	\font\@bannerfontI=cmtt10 at 5pt
		\def\KB@put@Banner{%
		\raise-8pt\hbox to\z@{\hskip5mm\@bannerfontI\the\@bannertokenI\hss}%
	}
	\AtBeginDocument{%
		\let\@@BL\@BL
		\def\@BL{\@@BL\KB@put@Banner}%
	}
	\fi
\fi

\if@KB@tt@face@
% verbatin環境の和欧文のアキを0へ
% cmttの拡大率を変更
   \def\tt@face@scale{0.9523836}%
   \def\verbatim@font{\normalfont\ttfamily\selectfont\xkanjiskip\z@}%
\else
   \def\tt@face@scale{\@jescale}%
\fi

\begingroup
\nfss@catcodes
% T1 encodingを追加
% OMXの指定間違いを修正
% 和文とCMフォントとのバランス調整 Beta版
% 
% OT1/cmr/m/n/10とOMX/cmex/m/n/10 を初期化
\DeclarePreloadSizes{OT1}{cmr}{m}{n}{10}
\DeclarePreloadSizes{OMX}{cmex}{m}{n}{10}
% ot1cmr.fd
% \DeclareFontFamily{OT1}{cmr}{\hyphenchar\font45 }
\DeclareFontShape{OT1}{cmr}{m}{n}%
	{<-12> s* [\@jescale]cmr10
	<12-17> s*  [\@jescale]cmr12%
	<17-> s*  [\@jescale]cmr17}{}%
\DeclareFontShape{OT1}{cmr}{m}{sl}%
	{<-> s* [\@jescale]cmsl10}{}
\DeclareFontShape{OT1}{cmr}{m}{it}%
	{<-> s* [\@jescale]cmti10}{}
\DeclareFontShape{OT1}{cmr}{m}{sc}%
	{<-> s* [\@jescale]cmcsc10}{}%
\DeclareFontShape{OT1}{cmr}{m}{ui}%
	{<-> s* [\@jescale]cmu10}{}%
\DeclareFontShape{OT1}{cmr}{b}{n}{%
	<-> s* [\@jescale]cmb10}{}%
\DeclareFontShape{OT1}{cmr}{bx}{n}{%
	<-12> s* [\@jescale]cmbx10%
	<12-> s*  [1.12]cmbx12}{}
\DeclareFontShape{OT1}{cmr}{bx}{sl}%
	{<-> s* [\@jescale]cmbxsl10}{}
\DeclareFontShape{OT1}{cmr}{bx}{it}
	{<-> s* [\@jescale]cmbxti10}{}
\DeclareFontShape{OT1}{cmr}{bx}{ui}
	{<-> s* [\@jescale]ssub*cmr/m/ui}{}
% omscmsy.fd
% \DeclareFontFamily{OMS}{cmsy}{\skewchar\font48 }
\DeclareFontShape{OMS}{cmsy}{m}{n}{%
   <-6> s* [\@jescale]cmsy5%
   <6-7> s* [\@jescale]cmsy6%
   <7-8> s* [\@jescale]cmsy7%
   <8-9> s* [\@jescale]cmsy8%
   <9-10> s* [\@jescale]cmsy9%
   <10-> s* [\@jescale]cmsy10}{}
\DeclareFontShape{OMS}{cmsy}{b}{n}{%
   <-6> s* [\@jescale]cmbsy5%
   <6-7> s* [\@jescale]cmbsy6%
   <7-8> s* [\@jescale]cmbsy7%
   <8-9> s* [\@jescale]cmbsy8%
   <9-10> s* [\@jescale]cmbsy9%
   <10-> s* [\@jescale]cmbsy10}{}
% omxcmex.fd
\DeclareFontFamily{OMX}{cmex}{}{}
% \DeclareFontShape{OMX}{cmex}{m}{n}{<->sfixed*[\@jescale]cmex10}{}
\DeclareFontShape{OMX}{cmex}{m}{n}{<->s*[\@jescale]cmex10}{}
% ucmr.fd
% \DeclareFontFamily{U}{cmr}{\hyphenchar\font45 }
\DeclareFontShape{U}{cmr}{m}{n}{%
	<-> s* [\@jescale]cmr10}{}%
\DeclareFontShape{U}{cmr}{m}{sl}{%
	<-> s* [\@jescale]cmsl10}{}
\DeclareFontShape{U}{cmr}{m}{it}{%
	<-> s* [\@jescale]cmti10}{}
\DeclareFontShape{U}{cmr}{m}{sc}{%
	<-> s* [\@jescale]cmcsc10}{}
\DeclareFontShape{U}{cmr}{m}{ui}{%
	<-> s* [\@jescale]cmu10}{}
\DeclareFontShape{U}{cmr}{b}{n}{%
	<-> s* [\@jescale]cmb10}{}
\DeclareFontShape{U}{cmr}{bx}{n}{%
	<-12> s* [\@jescale]cmbx10%
	<12-> s* [\@jescale]cmbx12}{}
\DeclareFontShape{U}{cmr}{bx}{sl}{%
	<-> s* [\@jescale]cmbxsl10}{}
\DeclareFontShape{U}{cmr}{bx}{it}{%
	<-> s* [\@jescale]cmbxti10}{}
\DeclareFontShape{U}{cmr}{bx}{ui}{%
	<->ssub*[\@jescale]cmr/m/ui}{}
% ot1cmss.fd
\DeclareFontShape{OT1}{cmss}{m}{n}{%
	<-> s* [\@jescale]cmss10}{}
\DeclareFontShape{OT1}{cmss}{m}{it}{%
	<->sub*cmss/m/sl}{}
\DeclareFontShape{OT1}{cmss}{m}{sl}{%
	<-> s* [\@jescale]cmssi10}{}
\DeclareFontShape{OT1}{cmss}{m}{sc}{%
	<->sub*cmr/m/sc}{}
\DeclareFontShape{OT1}{cmss}{m}{ui}{%
	<->sub*cmr/m/ui}{}
\DeclareFontShape{OT1}{cmss}{sbc}{n}{%
%	<-6> s* [\@jescale]cmssdc5%
%	<6-7> s* [\@jescale]cmssdc6%
%	<7-8> s* [\@jescale]cmssdc7%
%	<8-9> s* [\@jescale]cmssdc8%
%	<8-10> s* [\@jescale]cmssdc10}{}
	<-> s* [\@jescale]cmssdc10}{}
\DeclareFontShape{OT1}{cmss}{bx}{n}{%
%	<-6> s* [\@jescale]cmssbx5%
%	<6-7> s* [\@jescale]cmssbx6%
%	<7-8> s* [\@jescale]cmssbx7%
%	<8-9> s* [\@jescale]cmssbx8%
%	<9-> s* [\@jescale]cmssbx10}{}
	<-> s* [\@jescale]cmssbx10}{}
\DeclareFontShape{OT1}{cmss}{bx}{ui}{%
	<->sub*cmr/bx/ui}{}
% ot1cmtt.fd
%\DeclareFontShape{OT1}{cmtt}{m}{n}{%
%	<-> s* [\@jescale]cmtt10}{}
%\DeclareFontShape{OT1}{cmtt}{m}{it}{%
%	<-> s* [\@jescale]cmitt10}{}
%\DeclareFontShape{OT1}{cmtt}{m}{sl}{%
%	<-> s* [\@jescale]cmsltt10}{}
%\DeclareFontShape{OT1}{cmtt}{m}{sc}{%
%	<-> s* [\@jescale]cmtcsc10}{}

\DeclareFontShape{OT1}{cmtt}{m}{n}{%
	<-> s* [\tt@face@scale]cmtt10}{}
\DeclareFontShape{OT1}{cmtt}{m}{it}{%
	<-> s* [\tt@face@scale]cmitt10}{}
\DeclareFontShape{OT1}{cmtt}{m}{sl}{%
	<-> s* [\tt@face@scale]cmsltt10}{}
\DeclareFontShape{OT1}{cmtt}{m}{sc}{%
	<-> s* [\tt@face@scale]cmtcsc10}{}

\DeclareFontFamily{OT1}{kcmtt}{\hyphenchar \font\m@ne}
\DeclareFontShape{OT1}{kcmtt}{m}{n}{%
	<-> s* [\@jescale]cmtt10}{}
\DeclareFontShape{OT1}{kcmtt}{m}{it}{%
	<-> s* [\@jescale]cmitt10}{}
\DeclareFontShape{OT1}{kcmtt}{m}{sl}{%
	<-> s* [\@jescale]cmsltt10}{}
\DeclareFontShape{OT1}{kcmtt}{m}{sc}{%
	<-> s* [\@jescale]cmtcsc10}{}

% \ProvidesFile{omlcmm.fd}[1998/03/27 v2.5g Standard LaTeX font definitions]
% \DeclareFontFamily{OML}{cmm}{\skewchar\font127 }
\DeclareFontShape{OML}{cmm}{m}{it}%
     {%
    <-6> s*  [\@jescale]cmmi5%
    <6-7> s*  [\@jescale]cmmi6%
    <7-8> s*  [\@jescale]cmmi7%
    <8-9> s*  [\@jescale]cmmi8%
    <9-10> s*  [\@jescale]cmmi9%
    <10-12> s*  [\@jescale]cmmi10%
    <12-> s*  [\@jescale]cmmi12%
      }{}
\DeclareFontShape{OML}{cmm}{b}{it}{%
    <-6> s*  [\@jescale]cmmib5%
    <6-7> s*  [\@jescale]cmmib6%
    <7-8> s*  [\@jescale]cmmib8%
    <8-9> s*  [\@jescale]cmmib9%
    <9-10> s*  [\@jescale]cmmib9%
    <10-> s*  [\@jescale]cmmib10%
}{}
\DeclareFontShape{OML}{cmm}{bx}{it}%
   {<->ssub*cmm/b/it}{}
% T1 encoding cm-super
\providecommand{\EC@family}[5]{%
  \DeclareFontShape{#1}{#2}{#3}{#4}%
  {<-12>  [\@jescale] #51000%
  <12-17>  [\@jescale] #51200%
  <17->  [\@jescale] #51700%
}{}}
\DeclareFontFamily{T1}{cmr}{}
\EC@family{T1}{cmr}{m}{n}{ecrm}
\EC@family{T1}{cmr}{m}{sl}{ecsl}
\EC@family{T1}{cmr}{m}{it}{ecti}
\EC@family{T1}{cmr}{m}{sc}{eccc}
\EC@family{T1}{cmr}{bx}{n}{ecbx}
\EC@family{T1}{cmr}{b}{n}{ecrb}
\EC@family{T1}{cmr}{bx}{it}{ecbi}
\EC@family{T1}{cmr}{bx}{sl}{ecbl}
\EC@family{T1}{cmr}{bx}{sc}{ecxc}
\EC@family{T1}{cmr}{m}{ui}{ecui}
\DeclareFontFamily{T1}{cmss}{}
\EC@family{T1}{cmss}{m}{n}{ecss}
\EC@family{T1}{cmss}{m}{sl}{ecsi}
\EC@family{T1}{cmss}{m}{it}{ecsi}
\EC@family{T1}{cmss}{bx}{n}{ecsx}
\EC@family{T1}{cmss}{bx}{it}{ecso}
\EC@family{T1}{cmss}{bx}{sl}{ecso}

\providecommand{\EC@ttfamily}[5]{%
  \DeclareFontShape{#1}{#2}{#3}{#4}%
  {<-8>[\tt@face@scale]#50800%
  <8->[\tt@face@scale]#51000}{}}
\DeclareFontFamily{T1}{cmtt}{\hyphenchar \font\m@ne}
\EC@ttfamily{T1}{cmtt}{m}{n}{ectt}
\EC@ttfamily{T1}{cmtt}{m}{sl}{ecst}
\EC@ttfamily{T1}{cmtt}{m}{it}{ecit}
\EC@ttfamily{T1}{cmtt}{m}{sc}{ectc}
\DeclareFontShape{T1}{cmtt}{bx}{n}%
  {<->ssub*cmtt/m/n}{}
\DeclareFontShape{T1}{cmtt}{bx}{it}%
  {<->ssub*cmtt/m/it}{}

\providecommand{\EC@k@ttfamily}[5]{%
  \DeclareFontShape{#1}{#2}{#3}{#4}%
  {<-8>[\@jescale]#50800%
  <8->[\@jescale]#51000}{}}
\DeclareFontFamily{T1}{kcmtt}{\hyphenchar \font\m@ne}
\EC@k@ttfamily{T1}{kcmtt}{m}{n}{ectt}
\EC@k@ttfamily{T1}{kcmtt}{m}{sl}{ecst}
\EC@k@ttfamily{T1}{kcmtt}{m}{it}{ecit}
\EC@k@ttfamily{T1}{kcmtt}{m}{sc}{ectc}
\DeclareFontShape{T1}{kcmtt}{bx}{n}%
  {<->ssub*cmtt/m/n}{}
\DeclareFontShape{T1}{kcmtt}{bx}{it}%
  {<->ssub*cmtt/m/it}{}

\endgroup



% \@@marginparwidthというのが\marginparwidthに代入されますが，同時に
% \marginparwidthの手動指定のフラグになってます．この値が0pt以上になっていると
% それが\marginparwidthの長さになります．初期値は0ptにして，
% 変更はsimplesetting.styで行います．
% simplesetting.sty側でも0pt（もしくは無指定）にしていると\marginparwidthは
% \evensidemarginの長さの0.8倍になるようにしました．
\newdimen\@@marginparwidth
\@@marginparwidth\z@

% LaTeX2.09時代のフォント指定の定義です．
\DeclareOldFontCommand{\mc}{\normalfont\mcfamily}{\mathmc}
\DeclareOldFontCommand{\gt}{\normalfont\gtfamily}{\mathgt}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*{\cal}{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*{\mit}{\@fontswitch\relax\mathnormal}

% \sffamilyとttfamilyで従属和文をゴシックにするようにしています．
% \textsfと\textttも後続文字に欧文が来た場合にアキができるようにしています．
\DeclareRobustCommand\sffamily
        {\not@math@alphabet\sffamily\mathsf
         \romanfamily\sfdefault\kanjifamily\gtdefault\selectfont}
\DeclareRobustCommand\ttfamily
        {\not@math@alphabet\ttfamily\mathtt
         \romanfamily\ttdefault\kanjifamily\gtdefault\selectfont}
\DeclareRobustCommand\textsf[1]{%
	\relax\ifmmode\hbox\else\leavevmode\fi{\sffamily #1}}
\DeclareRobustCommand\texttt[1]{%
	\relax\ifmmode\hbox\else\leavevmode\fi{\ttfamily #1}}


\if@gtsf
     \DeclareRobustCommand*{\bfs}
        {\not@math@alphabet\bfs\relax
	\kanjifamily\gtdefault\romanfamily\sfdefault\selectfont}
% デフォルトではrmfamily/bfseries + gtfamilyにしていますが，
% クラスオプションgtsfを指定すると\sectionや\captionなどLaTeXが自動出力する箇所についてはsffamily/gtfamily になります．
% \textbf, \bfではrmfamily/bfseries+gtfamilyのままです．
% (\sffamilyを再定義して和文ゴシックと連動させるようにしています)
% -------
% *下の行をアクティブにすれば，\textbf, \bfでsffamily/gtfamilyになります．
% 数式環境下では\textbfや\bfを用いると\sffamilyなり，\mathbfではrmfamily/bfseriesが出力されます．
%     \DeclareRobustCommand\bfseries
%        {\not@math@alphabet\bfseries\mathbf
%        \kanjifamily\gtdefault\romanfamily\sfdefault\selectfont}
%     \DeclareOldFontCommand{\bf}{\normalfont\sffamily}{\mathbf}
\fi

% あらかじめ\DeclareOptionでロードされてる\kb@DeclareFontSizeBaselineで
% 記録した数値をのちに使われる\@xptなどに設定します．
% オリジナルの定義を保存した後，設定した文字サイズと
% それぞれの行送りを\strip@ptし，文字サイズ数値として定義します．
% これにより，\@xpt=10ptなどといったローマ数字でポイントを表す
% 表記は形骸化します．
\edef\@vpt{\strip@pt\@@tiny}
\edef\@viipt{\strip@pt\@@scriptsize}
\edef\@viiipt{\strip@pt\@@footnotesize}
\edef\@ixpt{\strip@pt\@@small}
\edef\@xpt{\strip@pt\@@normalsize}
\edef\@xipt{\strip@pt\@@large}
\edef\@xiipt{\strip@pt\@@Large}
\edef\@xivpt{\strip@pt\@@LARGE}
\edef\@xviipt{\strip@pt\@@huge}
\edef\@xxpt{\strip@pt\@@Huge}
\edef\@xxvpt{\strip@pt\@@HUGE}
\edef\@tiny@@base@@line{\strip@pt\@@tiny@@baseline}
\edef\@scriptsize@@base@@line{\strip@pt\@@scriptsize@@baseline}
\edef\@footnotesize@@base@@line{\strip@pt\@@footnotesize@@baseline}
\edef\@small@@base@@line{\strip@pt\@@small@@baseline}
\edef\@normalsize@@base@@line{\strip@pt\@@normalsize@@baseline}
\edef\@large@@base@@line{\strip@pt\@@large@@baseline}
\edef\@Large@@base@@line{\strip@pt\@@Large@@baseline}
\edef\@LARGE@@base@@line{\strip@pt\@@LARGE@@baseline}
\edef\@huge@@base@@line{\strip@pt\@@huge@@baseline}
\edef\@Huge@@base@@line{\strip@pt\@@Huge@@baseline}
\edef\@HUGE@@base@@line{\strip@pt\@@HUGE@@baseline}


% 数式の添字サイズの再設定です．\sMathSizesというマクロで親文字に対しての縮小値を計算して，\DeclareMathSizesに渡します．なので引数には縮小率を指定します．

% メモ：
% fontmath.ltxでのオリジナル定義
% \DeclareMathSizes{5}{5}{5}{5}
% \DeclareMathSizes{6}{6}{5}{5}
% \DeclareMathSizes{7}{7}{5}{5}
% \DeclareMathSizes{8}{8}{6}{5}
% \DeclareMathSizes{9}{9}{6}{5}
% \DeclareMathSizes{\@xpt}{\@xpt}{7}{5}
% \DeclareMathSizes{\@xipt}{\@xipt}{8}{6}
% \DeclareMathSizes{\@xiipt}{\@xiipt}{8}{6}
% \DeclareMathSizes{\@xivpt}{\@xivpt}{\@xpt}{7}
% \DeclareMathSizes{\@xviipt}{\@xviipt}{\@xiipt}{\@xpt}
% \DeclareMathSizes{\@xxpt}{\@xxpt}{\@xivpt}{\@xiipt}
% \DeclareMathSizes{\@xxvpt}{\@xxvpt}{\@xxpt}{\@xviipt}

\def\sMathSizes#1#2#3#4{\dimen@ #2\p@
\@tempdima #3\dimen@
\@tempdimb #4\dimen@
\expandafter\edef\csname sc#1\endcsname{\strip@pt\@tempdima}
\expandafter\edef\csname scsc#1\endcsname{\strip@pt\@tempdimb}
\DeclareMathSizes{#1}{#2}{\csname sc#1\endcsname}{\csname scsc#1\endcsname}
}
% まずは既存定義の再設定．\s@...の定義はオリジナルのコピーです．
\def\MathSizeUpdate{%
 \sMathSizes{\s@vpt}{\s@vpt}
	{\default@tiny@scriptratio}{\default@tiny@scriptscriptratio}
 \sMathSizes{\s@ivpt}{\s@ivpt}
	{\default@tiny@scriptratio}{\default@tiny@scriptscriptratio}
 \sMathSizes{\s@viipt}{\s@viipt}
	{\default@tiny@scriptratio}{\default@tiny@scriptscriptratio}
 \sMathSizes{\s@viiipt}{\s@viiipt}
	{\default@tiny@scriptratio}{\default@tiny@scriptscriptratio}
 \sMathSizes{\s@ixpt}{\s@ixpt}{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\s@xpt}{\s@xpt}{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\s@xipt}{\s@xipt}{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\s@xiipt}{\s@xiipt}{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\s@xivpt}{\s@xivpt}{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\s@xviipt}{\s@xviipt}{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\s@xxpt}{\s@xxpt}
	{\default@Huge@scriptratio}{\default@Huge@scriptscriptratio}

% ここで\@@normalsizeなどへの設定
 \sMathSizes{\@vpt}{\@vpt}
	{\default@tiny@scriptratio}{\default@tiny@scriptscriptratio}
 \sMathSizes{\@viipt}{\@viipt}
	{\default@tiny@scriptratio}{\default@tiny@scriptscriptratio}
 \sMathSizes{\@viiipt}{\@viiipt}
	{\default@tiny@scriptratio}{\default@tiny@scriptscriptratio}
 \sMathSizes{\@ixpt}{\@ixpt}
	{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\@xpt}{\@xpt}
	{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\@xipt}{\@xipt}
	{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\@xiipt}{\@xiipt}
	{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\@xivpt}{\@xivpt}
	{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\@xviipt}{\@xviipt}
	{\defaultscriptratio}{\defaultscriptscriptratio}
 \sMathSizes{\@xxpt}{\@xxpt}
	{\default@Huge@scriptratio}{\default@Huge@scriptscriptratio}
}
% ここで既存サイズコマンドへの設定を実行しています．
\MathSizeUpdate

% 使用するjtfmをjis系にします．
% 現在では使うことは極めて稀であろうとは思いますが
% クラスオプションmin10で旧来のmin10.tfmが使えます．（4.5で廃止）
% uplatexに変更

\if@JIStfm
	\def\Y@enc{JY1}
	\def\T@enc{JT1}
	\if@kb@rml
		\def\kb@jfm@m@h   {k-jis}   \def\kb@jfm@g@h{jisg}
		\def\kb@jfm@m@sl{k-jis-s}   \def\kb@jfm@g@sl{k-jisg-s}
		\def\kb@jfm@m@v   {tmin10} \def\kb@jfm@g@v{tgoth10}
		\if@kb@jisx@glyph
			%2004字形
			\AtBeginDvi{%
			\special{pdf: mapline k-rml 2004-H A-OTF-RyuminPr6N-Light.otf}
			\special{pdf: mapline k-rml-s 2004-H A-OTF-RyuminPr6N-Light.otf -s .167}
			\special{pdf: mapline k-gbm-s 2004-H A-OTF-GothicBBBPr6N-Medium.otf -s .167}
			\special{pdf: mapline gbm 2004-H A-OTF-GothicBBBPr6N-Medium.otf}
			\special{pdf: mapline k-futogo-rml 2004-H A-OTF-FutoMinA101Pr5-Bold.otf}}
		\else
			%%2000字形
			\AtBeginDvi{%
			\special{pdf: mapline k-rml H A-OTF-RyuminPr6-Light.otf}
			\special{pdf: mapline k-rml-s H A-OTF-RyuminPr6-Light.otf -s .167}
			\special{pdf: mapline k-gbm-s H A-OTF-GothicBBBPr6N-Medium.otf -s .167}
			\special{pdf: mapline gbm H A-OTF-GothicBBBPr6N-Medium.otf}
			\special{pdf: mapline k-futogo-rml H A-OTF-FutoMinA101Pr5-Bold.otf}}
		\fi
	\else
	\def\kb@jfm@m@h   {jis}   \def\kb@jfm@g@h{jisg}
	\def\kb@jfm@m@sl{jis}   \def\kb@jfm@g@sl{jisg}
	\def\kb@jfm@m@v   {tmin10} \def\kb@jfm@g@v{tgoth10}
	\fi
\else
	\def\@jqscale{1}
	\def\Y@enc{JY2}
	\def\T@enc{JT2}
		\if@kb@rml
		\def\kb@jfm@m@h  {k-rml-upjisr-h} \def\kb@jfm@g@h{upjisg-h}
		\def\kb@jfm@m@sl {k-rml-upjisr-s-h} \def\kb@jfm@g@sl{k-jisg-upjisg-s-h}
		\def\kb@jfm@m@v  {upjisr-v} \def\kb@jfm@g@v{upjisg-v}
			\if@kb@jisx@glyph
			%% 2004字形
			\special{pdf: mapline uprml-hq UniJIS-UCS2-H A-OTF-RyuminPr6N-Light.otf}
			\special{pdf: mapline k-futomin-uprml-h UniJIS2004-UTF16-H A-OTF-FutoMinA101Pr5-Bold.otf}
			\special{pdf: mapline k-rml-uprml-h UniJIS2004-UTF16-H A-OTF-RyuminPr6N-Light.otf}
			\special{pdf: mapline k-rml-uprml-s-h UniJIS2004-UTF16-H A-OTF-RyuminPr6N-Light.otf -s .167}
			\special{pdf: mapline k-gbm-upgbm-s-h UniJIS2004-UTF16-H A-OTF-GothicBBBPr6N-Medium.otf -s .167}
			\else
			\AtBeginDvi{%
			\special{pdf: mapline uprml-hq UniJIS-UCS2-H A-OTF-RyuminPr6-Light.otf}
			\special{pdf: mapline k-futomin-uprml-h UniJIS-UTF16-H A-OTF-FutoMinA101Pr5-Bold.otf}
			\special{pdf: mapline k-rml-uprml-h UniJIS-UTF16-H A-OTF-RyuminPr6-Light.otf}
			\special{pdf: mapline k-rml-uprml-s-h UniJIS-UTF16-H A-OTF-RyuminPr6-Light.otf -s .167}
			\special{pdf: mapline k-gbm-upgbm-s-h UniJIS-UTF16-H A-OTF-GothicBBBPr6-Medium.otf -s .167}}
			\fi
		\else
		\def\kb@jfm@m@h  {upjisr-h} \def\kb@jfm@g@h{upjisg-h}
		\def\kb@jfm@m@sl {upjisr-h} \def\kb@jfm@g@sl{upjisg-h}
		\def\kb@jfm@m@v  {upjisr-v} \def\kb@jfm@g@v{upjisg-v}
		\fi
\fi
\DeclareFontShape{\Y@enc}{mc}{m}{n}{  <-> s * [\@jqscale] \kb@jfm@m@h}{}
\DeclareFontShape{\Y@enc}{mc}{m}{sl}{ <-> s * [\@jqscale] \kb@jfm@m@sl}{}
\DeclareFontShape{\T@enc}{mc}{m}{n}{  <-> s * [\@jqscale] \kb@jfm@m@v}{}
%
\DeclareFontShape{\Y@enc}{gt}{m}{n}{  <-> s * [\@jqscale] \kb@jfm@g@h}{}
\DeclareFontShape{\Y@enc}{gt}{m}{sl}{ <-> s * [\@jqscale] \kb@jfm@g@sl}{}
\DeclareFontShape{\T@enc}{gt}{m}{n}{  <-> s * [\@jqscale] \kb@jfm@g@v}{}
%
\DeclareFontShape{\Y@enc}{mc}{m}{it}{ <-> ssub*mc/m/n}{}
\DeclareFontShape{\Y@enc}{mc}{m}{sc}{ <-> ssub*mc/m/n}{}
\DeclareFontShape{\Y@enc}{gt}{m}{it}{ <-> ssub*gt/m/n}{}
\DeclareFontShape{\Y@enc}{mc}{bx}{it}{<-> ssub*gt/m/n}{}
\DeclareFontShape{\Y@enc}{mc}{bx}{sl}{<-> ssub*gt/m/sl}{}
%
\DeclareFontShape{\T@enc}{mc}{m}{it}{ <-> ssub*mc/m/n}{}
\DeclareFontShape{\T@enc}{mc}{m}{sl}{ <-> ssub*mc/m/n}{}
\DeclareFontShape{\T@enc}{mc}{m}{sc}{ <-> ssub*mc/m/n}{}
\DeclareFontShape{\T@enc}{gt}{m}{it}{ <-> ssub*gt/m/n}{}
\DeclareFontShape{\T@enc}{gt}{m}{sl}{ <-> ssub*gt/m/n}{}
\DeclareFontShape{\T@enc}{mc}{bx}{it}{<-> ssub*gt/m/n}{}
\DeclareFontShape{\T@enc}{mc}{bx}{sl}{<-> ssub*gt/m/n}{}


% \DeclareMathSizes{\@xpt}{\@xpt}{6}{5}


% \def\xDeclareMathSizes#1#2#3#4{%
%   \let\@tempa\@empty
%   \@tfor\@tempb:={#1}{#2}{#3}{#4}\do{%
%      \@defaultunits\dimen@\@tempb pt\relax\@nnil
%      \edef\@tempa{\@tempa{\strip@pt\dimen@}}}%
%   \expandafter\DeclareMathSizes\@tempa}

% \scriptscale\dimen@

% \xDeclareMathSizes{\@viipt}{\@viipt}{\@viipt}{\@viipt}
% \xDeclareMathSizes{\@viiipt}{\@viiipt}{\@scriptscale}{\@scriptscale}
% \DeclareMathSizes{\@ixpt}{{\@ixpt}{}{}
% \DeclareMathSizes{\@xpt}{\@xpt}{}{}
% \DeclareMathSizes{\@xipt}{\@xipt}{}{}
% \DeclareMathSizes{\@xiipt}{{\@xiipt}{}{}
% \DeclareMathSizes{\@xivpt}{\@xivpt}{}{}
% \DeclareMathSizes{\@xviipt}{{\@xviipt}{}{}
% \DeclareMathSizes{\@xxpt}{\@xxpt}{}{}

% 各サイズコマンドの設定です．
% たとえば\normalsizeの場合，\@xptと\@normalsize@@base@@lineは事前に
% \strip@ptされたものをここで使います．
\DeclareRobustCommand{\normalsize}{%
\@setfontsize\normalsize\@xpt{\@normalsize@@base@@line}%
\abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@%
\abovedisplayshortskip \z@ \@plus3\p@%
\belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@%
\belowdisplayskip \abovedisplayskip%
% 
\let\@listi\@listI
}

\normalfont\normalsize
\setbox0\hbox{\char\euc"A1A1}%
\setlength\Cht{\ht0}
\setlength\Cdp{\dp0}
\setlength\Cwd{\wd0}
\setlength\Cvs{\baselineskip}
\setlength\Chs{\wd0}
\setlength\parindent{1\Cwd}
\kanjiskip=0zw plus .1zw minus .01zw
\xkanjiskip0.2zw plus 0.1zw minus 0.06zw
\DeclareRobustCommand{\small}{%
  \@setfontsize\small\@ixpt{\@small@@base@@line}%
\abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
\abovedisplayshortskip \z@ \@plus2\p@
\belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
\def\@listi{\leftmargin\leftmargini\labelwidth\leftmargini\advance\labelwidth-\labelsep\topsep.5\baselineskip\parsep\z@\itemsep\parsep}%
\belowdisplayskip \abovedisplayskip}

\DeclareRobustCommand{\footnotesize}{%
\@setfontsize\footnotesize\@viiipt{\@footnotesize@@base@@line}%
\abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
\abovedisplayshortskip \z@ \@plus\p@
\belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
\def\@listi{\leftmargin\leftmargini\labelwidth\leftmargini\advance\labelwidth-\labelsep\topsep.5\baselineskip\parsep\z@\itemsep\parsep}%
\belowdisplayskip \abovedisplayskip}
\DeclareRobustCommand{\scriptsize}{\@setfontsize\scriptsize\@viipt\@scriptsize@@base@@line}
\DeclareRobustCommand{\tiny}{\@setfontsize\tiny\@vpt\@tiny@@base@@line}
\DeclareRobustCommand{\large}{\@setfontsize\large\@xipt{\@large@@base@@line}}
\DeclareRobustCommand{\Large}{\@setfontsize\Large\@xiipt{\@Large@@base@@line}}
\DeclareRobustCommand{\LARGE}{\@setfontsize\LARGE\@xivpt{\@LARGE@@base@@line}}
\DeclareRobustCommand{\huge}{\@setfontsize\huge\@xviipt{\@huge@@base@@line}}
\DeclareRobustCommand{\Huge}{\@setfontsize\Huge\@xxpt{\@Huge@@base@@line}}
\DeclareRobustCommand{\HUGE}{\@setfontsize\HUGE\@xxvpt{\@HUGE@@base@@line}}

% \headheightの高さを算出します．
% ノンブルと柱で違う文字サイズが設定されることもあるので，
% 大きいほうの高さを\headheightとして設定します．
\setbox\z@\hbox{\KBheaderfont\char\euc"A1A1}%
\setbox\tw@\hbox{\KBpagenumfont1}%
\ifdim\ht\z@>\ht\tw@\@tempdima\ht\z@\else\@tempdima\ht\tw@\fi
\headheight\@tempdima
\headsep5mm
% (たとえば\displatystyle\fracなど)ページの第一行目に背の高い文字が来ても行が出来るだけ下にずれないための処置です．そのままでは判面天地位置がおかしくなるので，\headsepで補正しつつ，\topmarginの算出方法を変えました．<- 試験的に設定しましたが，\sectionなどでも版面を天方向に飛び出してしまうので止めています．せっかくなのでクラスオプション[keepfline]で\@keepfline@@trueが有効になる設定は残しています．
\if@keepfline@@
	\setlength\topskip{\baselineskip}
	\advance\headsep by-\topskip
	\advance\headsep by\Cht
\else
	\setlength\topskip{\Cht}
\fi
% 
\setlength\footskip{.35in}
\setlength\maxdepth{.5\topskip}
\setlength\marginparsep{.5zw}

% 
% \marginparwidthは\marginparsepを引いた\evensidemarginの0.8倍にしてます．
\setlength\columnsep{2zw}
\columnseprule\z@
\ify@@center
  \setlength\oddsidemargin{\paperwidth}\advance\oddsidemargin-\textwidth
  \setlength\evensidemargin{.5\oddsidemargin}
  \setlength\oddsidemargin{\evensidemargin}
  \setlength\dimen@{\evensidemargin}
\else
  \oddsidemargin\paperwidth
  \advance\oddsidemargin by-\textwidth
  \advance\oddsidemargin by-\evensidemargin
  \setlength\dimen@{\evensidemargin}
\fi
\advance\dimen@ by-\marginparsep
\marginparwidth.8\dimen@
\ift@@center
  \setlength{\topmargin}{\paperheight}
  \advance\topmargin by-\textheight
  \setlength{\topmargin}{.5\topmargin}
  \advance\topmargin by-\headsep
  \advance\topmargin by-\headheight
\else
  \advance\topmargin by-\headsep
  \advance\topmargin by-\headheight
%  \advance\topmargin by-\topskip
%  \advance\topmargin by\Cht
\fi
\advance\topmargin-1in
\advance\oddsidemargin-1in
\advance\evensidemargin-1in


% 
\setlength\footnotesep{6.65\p@}
% \setlength{\skip\footins}{9\p@ \@plus 4\p@ \@minus 2\p@}
\setlength{\skip\footins}{12\p@ \@plus 4\p@ \@minus 2\p@}
\setlength\floatsep    {12pt \@plus2pt \@minus2pt}%  209版 ky_a5.sty 準拠
%\setlength\textfloatsep{15.5pt \@plus0pt \@minus2pt}% 209版 ky_a5.sty 準拠
\setlength\textfloatsep{12pt \@plus2pt \@minus2pt}% 209版 ky_a5.sty 準拠
\setlength\intextsep   {8pt \@plus2pt \@minus2pt}%
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
% \setlength\partopsep{2\p@ \@plus 1\p@ \@minus 1\p@}
\setlength\partopsep{\z@}%% ここを.5\baselineskipなどとするとlist系の直前で空行の有り無しでアキをコントロールできます．

% 一番外側のlistだけ本文とのアキを.5\baselineskip空けます．二段目以降のlistは親のlistに対してアキは設けません．
\def\@listi{\leftmargin\leftmargini\labelwidth\leftmargini\advance\labelwidth-\labelsep\parsep\z@\topsep.5\normalbaselineskip\itemsep\z@}
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii\labelwidth\leftmarginii\advance\labelwidth-\labelsep\topsep\z@\parsep\z@\itemsep\parsep}
\def\@listiii{\leftmargin\leftmarginiii
   \labelwidth\leftmarginiii \advance\labelwidth-\labelsep\topsep\z@\parsep\z@
   \partopsep\z@\itemsep\topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}
\lineskip1\p@
\setlength\normallineskip{1\p@}
\setlength\lineskiplimit{1\p@}
\setlength\normallineskiplimit{1\p@}
% 
\lineskiplimit2.5pt\lineskip5pt%% ★

\renewcommand{\baselinestretch}{}
\setlength\parskip{\z@}
\setlength\parindent{1\Cwd}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{1}
\setcounter{totalnumber}{3}
\setcounter{dbltopnumber}{2}
\renewcommand{\topfraction}{.7}
\renewcommand{\bottomfraction}{.3}
\renewcommand{\textfraction}{.2}
\renewcommand{\floatpagefraction}{.5}
\renewcommand{\dbltopfraction}{.7}
\renewcommand{\dblfloatpagefraction}{.5}


% 単一頁内での複数\sectionの最後を常に柱へ反映させる．
% \firstmark -> \botmark
\def\rightmark{\expandafter\@rightmark\botmark\@empty\@empty}

\def\ps@plain{\let\@mkboth\@gobbletwo
   \let\ps@jpl@in\ps@plain
   \def\@oddhead{\KBpagenumfont\hfil\thepage}
   \let\@oddfoot\@empty%
   \def\@evenhead{\KBpagenumfont{\thepage}\hfil}
   \let\@evenfoot\@empty}

\let\ps@jpl@in\ps@plain

\def\ps@headnombre{\let\@mkboth\@gobbletwo
    \let\ps@jpl@in\ps@headnombre
  \def\@evenhead{\KBpagenumfont\thepage\hfil}%
  \def\@oddhead{\hfil\KBpagenumfont\thepage}%
  \let\@oddfoot\@empty\let\@evenfoot\@empty}

% \def\ps@footnombre{\let\@mkboth\@gobbletwo
%    \let\ps@jpl@in\ps@footnombre
%  \def\@evenfoot{\KBpagenumfont\thepage\hfil}%
%  \def\@oddfoot{\hfil\KBpagenumfont\thepage}%
%  \let\@oddhead\@empty\let\@evenhead\@empty}

% 各headerに約物の行頭パターン処理を追加しました．
  \def\ps@footnombre{\let\ps@jpl@in\ps@footnombre
    \let\@evenhead\@empty
    \let\@oddhead\@empty
    \def\@oddfoot{\KBpagenumfont\thepage\hskip1.5zw\KBheaderfont\rightmark\hfil}%
    \def\@evenfoot{\KBheaderfont\hfil{\leftmark}\KBpagenumfont\hskip1.5zw\thepage}%
    \def\@evenfoot{\KBpagenumfont\thepage\hskip1.5zw\KBheaderfont\leftmark\hfill}%
    \def\@oddfoot{\hfill\KBheaderfont{\rightmark}\KBpagenumfont\hskip1.5zw\thepage}%
    \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{%
     \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
         \@chapapp\thechapter\@chappos\hskip1zw%
         \fi
     \fi
     ##1}{}}%
  \def\sectionmark##1{\markright{%
     \ifnum \c@secnumdepth >\z@
           \ifseccntfixHead\@seccnt@prefix@section\fi%
              \thesection%
           \ifseccntfixHead\@seccnt@postfix@section\fi%
\hskip1zw%
\fi
     \protect\@inhibitglue##1}}%
  }\if@twoside
  \def\ps@headings{\let\ps@jpl@in\ps@headnombre
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\KBpagenumfont\thepage\hskip1.5zw\KBheaderfont\leftmark\hfil}%
    \def\@oddhead{\KBheaderfont\hfil{\rightmark}\KBpagenumfont\hskip1.5zw\thepage}%
    \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{%
     \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
         \@chapapp\thechapter\@chappos\hskip1zw
         \fi
     \fi
     \protect\@inhibitglue##1}{}}%
  \def\sectionmark##1{\markright{%
% 柱に\@seccnt@prefix@sectionを入れたい★
     \ifnum \c@secnumdepth >\z@
           \ifseccntfixHead\@seccnt@prefix@section\fi%
              \thesection%
           \ifseccntfixHead\@seccnt@postfix@section\fi%
\hskip1zw%
\fi
     \protect\@inhibitglue##1}}%
  }
\else % if not twoside
  \def\ps@headings{\let\ps@jpl@in\ps@headnombre
    \let\@oddfoot\@empty
    \def\@oddhead{\KBpagenumfont\thepage\hskip1.5zw\rightmark\hfil}%
    \let\@mkboth\markboth
\def\chaptermark##1{\markright{%
   \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
       \@chapapp\thechapter\@chappos\hskip1zw
         \fi
   \fi
   \protect\@inhibitglue##1}}%
  }
\fi
\if@twoside
  \def\ps@ruleheadings{\let\ps@jpl@in\ps@headnombre
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\underline{\hbox to\textwidth{\KBpagenumfont\thepage\hskip1.5zw\KBheaderfont\leftmark\hfil}}}%
    \def\@oddhead{\underline{\hbox to\textwidth{\KBheaderfont\hfil{\rightmark}\KBpagenumfont\hskip1.5zw\thepage}}}%
    \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{%
     \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
         \@chapapp\thechapter\@chappos\hskip1zw
         \fi
     \fi
     \protect\@inhibitglue##1}{}}%
  \def\sectionmark##1{\markright{%
% 柱に\@seccnt@prefix@sectionを入れたい★
     \ifnum \c@secnumdepth >\z@
           \ifseccntfixHead\@seccnt@prefix@section\fi%
              \thesection%
           \ifseccntfixHead\@seccnt@postfix@section\fi%
\hskip1zw%
\fi
     \protect\@inhibitglue##1}}%
  }
\else
  \def\ps@ruleheadings{\let\ps@jpl@in\ps@headnombre
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\underline{\hbox to\textwidth{\hbox to\z@{\KBpagenumfont\thepage\hss}\hfill\KBheaderfont\leftmark\hfill}}}%
    \def\@oddhead{\underline{\hbox to\textwidth{\KBheaderfont\hfil{\rightmark}\KBpagenumfont\hskip1.5zw\thepage}}}%
    \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{%
     \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
         \@chapapp\thechapter\@chappos\hskip1zw
         \fi
     \fi
     \protect\@inhibitglue##1}{}}%
  \def\sectionmark##1{\markright{%
% 柱に\@seccnt@prefix@sectionを入れたい★
     \ifnum \c@secnumdepth >\z@
           \ifseccntfixHead\@seccnt@prefix@section\fi%
              \thesection%
           \ifseccntfixHead\@seccnt@postfix@section\fi%
\hskip1zw%
\fi
     \protect\@inhibitglue##1}}%
  }\fi
\if@twoside
  \def\ps@bothstyle{\let\ps@jpl@in\ps@footnombre
    \def\@evenhead{\KBheaderfont\leftmark\hfil}% right page
    \def\@evenfoot{\KBpagenumfont\thepage\hfil}% right page
    \def\@oddhead{\KBheaderfont\hfil\rightmark}% left page
    \def\@oddfoot{\KBpagenumfont\hfil\thepage}% left page
  \let\@mkboth\markboth
\def\chaptermark##1{\markboth{%
     \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
         \@chapapp\thechapter\@chappos\hskip1zw
         \fi
     \fi
     \protect\@inhibitglue##1}{}}%
  \def\sectionmark##1{\markright{%
     \ifnum \c@secnumdepth >\z@
           \ifseccntfixHead\@seccnt@prefix@section\fi%
              \thesection%
           \ifseccntfixHead\@seccnt@postfix@section\fi%
\hskip1zw%
\fi
     \protect\@inhibitglue##1}}%
  }
\else % if one column
  \def\ps@bothstyle{\let\ps@jpl@in\ps@footnombre
    \def\@oddhead{\KBheaderfont\hfil\rightmark}%
    \def\@oddfoot{\KBpagenumfont\hfil\thepage}%
    \let\@mkboth\markboth
  \def\chaptermark##1{\markright{%
     \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
         \@chapapp\thechapter\@chappos\hskip1zw
         \fi
     \fi
     \protect\@inhibitglue##1}}%
  }
\fi
\def\ps@myheadings{\let\ps@jpl@in\ps@plain%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\KBpagenumfont\thepage\hskip1.5zw\KBheaderfont\leftmark\hfil}%
    \def\@oddhead{\KBheaderfont\hfil{\rightmark}\KBpagenumfont\hskip1.5zw\thepage}%
  \let\@mkboth\@gobbletwo
  \let\chaptermark\@gobble
  \let\sectionmark\@gobble
}
\newenvironment{titlepage}
    {%
      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }

% \maketitleでの出力に`Publisher'が入るようにしました．
% \publisherで指定されていれば，それが優先されて出力されます．
% `Publisher'を印字させたくなければ，\publisher{}と引数を空にします．
% \authorで使われる\andも`中黒'で区切るようにしています．
% また，\titleに[]オプションで副題を入れられるようにしました．
% \title[副題]{タイトル}となります．

\def\title{\@ifnextchar[{\title@}{\title@[\hbox{}]}}
\def\title@[#1]#2{\gdef\@title{\begin{tabular}{c}#2\\
\Large#1\end{tabular}}}
\def\publisher#1{\gdef\@publisher{#1}}
\def\p@thanks#1{\footnotemark
  \protected@xdef\@thanks{\@thanks
    \protect{\noindent$\m@th^\thefootnote$~#1\protect\par}}}
\def\and{%                  % \begin{tabular}
  \end{tabular}%
  ・
  \begin{tabular}[t]{@{}c@{}}\normalsize}%   % \end{tabular}
\if@titlepage
  \newcommand{\maketitle}{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let\footnote\thanks
  \null\vfil
  \vskip 150\p@
  \begin{center}%
    {\huge \@title \par}%
    \vskip 4em%
    {\Large
     \lineskip .75em%
      \begin{tabular}[t]{@{}c@{}}%
        \@author
      \end{tabular}\par}%
      \vskip 4\baselineskip%
    {\large \@date} \par%       % Set date in \large size.
\vfill
{\bfs\@publisher}
  \end{center}\par
  \@thanks\vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\p@thanks\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\@publisher\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \global\let\publisher\relax
  }%
\else
  \newcommand{\maketitle}{\par
  \begingroup
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
    \def\@makefnmark{\null\hbox{\ifydir $\m@th^{\@thefnmark}$
      \else\hbox{\yoko$\m@th^{\@thefnmark}$}\fi}}%
     \long\def\@makefntext##1{\parindent 1em\noindent
       \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne \@maketitle
      \else \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
     \thispagestyle{jpl@in}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\p@thanks\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  }
  \def\@maketitle{%
  \newpage\null
  \vskip 2em%
  \begin{center}%
  \let\footnote\thanks
    {\huge\@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par\vskip 1.5em}
\fi
\newcommand*{\chaptermark}[1]{}
\setcounter{secnumdepth}{2}
\newcounter{part}
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\renewcommand{\thepart}{\@Roman\c@part}
\renewcommand{\thechapter}{\@arabic\c@chapter}
\renewcommand{\thesection}{\thechapter.\@arabic\c@section}
\renewcommand{\thesubsection}{\thesection.\@arabic\c@subsection}
\renewcommand{\thesubsubsection}{%
   \thesubsection.\@arabic\c@subsubsection}
\renewcommand{\theparagraph}{%
   \thesubsubsection.\@arabic\c@paragraph}
\renewcommand{\thesubparagraph}{%
   \theparagraph.\@arabic\c@subparagraph}
\newcommand{\@chapapp}{\prechaptername}
\newcommand{\@chappos}{\postchaptername}
\newcommand\frontmatter{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \@mainmatterfalse\pagenumbering{roman}}
\newcommand{\mainmatter}{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \@mainmattertrue\pagenumbering{arabic}}
\newcommand{\backmatter}{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \@mainmatterfalse}
\newcommand{\part}{%
  \if@openright \cleardoublepage \else \clearpage \fi
%  \cleardoublepage
  \thispagestyle{empty}%
  \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi
  \null\vfil
  \secdef\@part\@spart}
\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \addcontentsline{toc}{part}{%
       \protect\numberline{\prepartname\thepart\postpartname}#1}%
  \else
    \addcontentsline{toc}{part}{#1}%
  \fi
  \markboth{}{}%
  {\centering
   \interlinepenalty\@M\reset@font
   \ifnum \c@secnumdepth >-2\relax
     \KBpartnumfont\prepartname\thepart\postpartname
     \par\vskip20\p@
   \fi
   \KBpartfont#2\par}%
   \@endpart}
\def\@spart#1{{%
  \centering
  \interlinepenalty\@M\reset@font
  \Huge\bfs#1\par}%
  \@endpart}
\def\@endpart{\vfil\newpage
   \if@twoside\null\thispagestyle{empty}\newpage\fi
   \if@tempswa\twocolumn\fi}
% \chapterに約物の行頭処理を追加しました．

\newcount\@chapterid

\newif\if@table@of@contents@@
	\@table@of@contents@@false
\newif\if@the@bibliography@@
	\@the@bibliography@@false
\newif\if@appendix@@
	\@appendix@@false

\newcommand{\chapter}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{empty}%
  \global\@topnum\z@
%  \@afterindentfalse
\global\advance\@chapterid\@ne% for multicite.sty
\xdef\@ref@prefix{\the\@chapterid::}
  \@afterindenttrue
  \secdef\@chapter\@schapter}
% multicite.styで使う\@ref@prefixを追加しています．
\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter\space\@chappos}%
    \addcontentsline{toc}{chapter}%
      {\protect\numberline{\@chapapp\thechapter\@chappos}#1}%
    \else\addcontentsline{toc}{chapter}{#1}\fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
\if@appendix@@
  \@make@appendix@chapterhead{#2}\@appendix@@false\else
  \@makechapterhead{#2}\fi
\@afterheading}
% 
% 再定義の場合は，\@make@appendix@chapterheadに\letしなおすこと．
%---------
\def\@makechapterhead#1{{\parindent\z@%
\toplinebox{10}{\vskip2\normalbaselineskip% 10行取りにしています．
   \KBchapternumfont
   \ifnum \c@secnumdepth >\m@ne
     \setlength\@tempdima{\linewidth}%
    \if@mainmatter
      \@chapapp\thechapter\@chappos
     \else
      \hbox{}
    \fi
     \vspace{.9\Cvs}\par
     \KBchapterfont\@inhibitglue#1\par\vfill\fi}}%
}
\let\@make@appendix@chapterhead\@makechapterhead
%---------

% 目次，索引，参考文献の見出しはデフォルトでは，\chapter*と
% 同義にしたいので，\@makeschapterheadから\letしている．
% \@makeschapterhead自体の再定義を行う場合は\letをしなおす．
%---------
\def\@makeschapterhead#1{{\parindent\z@
\toplinebox{10}{\vskip2\normalbaselineskip
     \centering\KBchapterfont\@inhibitglue#1\par\vfill}%
   }}
\let\@make@toc@chapterhead\@makeschapterhead
\let\@make@bib@chapterhead\@makeschapterhead
\let\@make@index@chapterhead\@makeschapterhead
%---------

% 個別体裁用
% デフォルトは\chapter*と同じ
% 個別に体裁を変えたければ，それぞれを後方で定義する．
% 
\def\@schapter#1{%
\if@table@of@contents@@
   \@make@toc@chapterhead{#1}\@table@of@contents@@false\else
      \if@the@bibliography@@
         \@make@bib@chapterhead{#1}\@the@bibliography@@false\else
                   \@makeschapterhead{#1}\fi\fi
\@afterheading
}




% 吉永徹美氏例示マクロを元に作成
% \section以下の節番号の前後に文字やマクロを置けるようにします．
\def\@seccntformat#1{% #1: <counter name>
\csname KB#1numfont\endcsname% 節番号の書体指定を入れています．
\csname @seccnt@prefix@#1\endcsname%
\csname the#1\endcsname%
\csname @seccnt@postfix@#1\endcsname%
\csname @seccnt@afterskip@#1\endcsname}
\def\@seccnt@post@skip{\hskip1zw}
\def\@seccnt@afterskip@section{\@seccnt@post@skip}
\def\@seccnt@afterskip@subsection{\@seccnt@post@skip}
\def\@seccnt@afterskip@subsubsection{\@seccnt@post@skip}
\def\@seccnt@afterskip@paragraph{\@seccnt@post@skip}
\def\@seccnt@afterskip@subparagraph{\@seccnt@post@skip}
\def\PreSecCntName#1#2{\@namedef{@seccnt@prefix@#1}{#2}}
\def\PostSecCntName#1#2{\@namedef{@seccnt@postfix@#1}{#2}}


% \PreSecCntNameがseccntの前
% \PostSecCntNameがseccntの後
% 第一引数に見出しの名称，第二引数に置きたい文字
% \PreSecCntName{section}{第}
% \PostSecCntName{section}{節}
% \PreSecCntName{subsection}{第}
% \PostSecCntName{subsection}{項}
% \PreSecCntName{subsubsection}{第}
% \PostSecCntName{subparagraph}{目}
% \PreSecCntName{paragraph}{}
% \PostSecCntName{paragraph}{}
% \PreSecCntName{subparagraph}{}
% \PostSecCntName{subparagraph}{}
%         \seccntfixHeadfalse%で柱に反映しない
%         \seccntfixTocfalse%で目次に反映しない．

\PreSecCntName{section}{}
\PostSecCntName{section}{}
\PreSecCntName{subsection}{}
\PostSecCntName{subsection}{}
\PreSecCntName{subsubsection}{}
\PostSecCntName{subparagraph}{}
\PreSecCntName{paragraph}{}
\PostSecCntName{paragraph}{}
\PreSecCntName{subparagraph}{}
\PostSecCntName{subparagraph}{}
% 
% \sectionでの目次,柱の個別指定
% \section[TOC]{NAME}		デフォルトと同じ（目次，柱共用）
% \section[TOC](HEAD){NAME}	"[]"に目次，"()"に柱用の語句を設定
% \section(HEAD){NAME}		目次には"{NAME}"の内容，"()"で柱用の語句を設定

% 
\long\def\@triplearg#1{%
     \kernel@ifnextchar[{\@xtriplearg{#1}}%
     {\@xxxtriplearg{#1}}%
}

\long\def\@triplearg#1{%
     \kernel@ifnextchar[{\@xtriplearg{#1}}%
     {\kernel@ifnextchar({\@xxxxtriplearg{#1}}%
     {\@xxxtriplearg{#1}}}%
}

\long\def\@triplearg#1{%
     \kernel@ifnextchar[{\@xtriplearg{#1}}%
     {\kernel@ifnextchar({\@xxxxtriplearg{#1}}%
     {\@xxxtriplearg{#1}}}%
}
\long\def\@xtriplearg#1[#2]{%
     \kernel@ifnextchar({#1[{#2}]}%
     {\@xxtriplearg{#1}{#2}}
}

\long\def\@xxxxtriplearg#1(#2)#3{%
     #1[#3]({#2}){#3}%
}

\long\def\@xxtriplearg#1#2#3{%
     #1[{#2}]({#2}){#3}%
}%
\long\def\@xxxtriplearg#1#2{#1[{#2}]({#2}){#2}}


%% for hyperref package
% \@dblargを\@tripleargへ変更．
\if@KB@hyperref
	\let\KB@larg\@dblarg
\else
	\let\KB@larg\@triplearg
\fi

\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
	\ifsectiontopmargin%% 
		\vskip-\prevdepth \prevdepth\z@\vskip\baselineskip
		\vspace*{-\baselineskip}\vskip\@tempskipa
	\else
                \addpenalty\@secpenalty\addvspace\@tempskipa
        \fi
  \fi
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}%
    {%
%	\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}%
	\KB@larg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}%

% 目次に`\@seccnt@prefix@section'と\@seccnt@postfix@sectionを付ける
% \@seccnt@postfix@<HEAD NAME>と\@seccnt@prefix@<HEAD NAME>を定義すれば他の見出しにも付加可能．
\def\pre@section@mark@toc@out{\ifseccntfixToc\@seccnt@prefix@section\fi}
\def\post@section@mark@toc@out{\ifseccntfixToc\@seccnt@postfix@section\fi}
% 例えば\subsectionの目次に\@seccnt@prefix@subsectionと
% \@seccnt@postfix@subsectionを付加の場合
\def\pre@subsection@mark@toc@out{\ifseccntfixToc\@seccnt@prefix@subsection\fi}
\def\post@subsection@mark@toc@out{\ifseccntfixToc\@seccnt@postfix@subsection\fi}
% #1: ``section'' などの文字列（LaTeX カウンタ名）
% #2: 見出しの ``レベル''（番号を出力するか否かに関係します）
% #3: 見出しの字下げ量
% #4: 見出しの上側の空白量と見出しの後の字下げの有無に関係する寸法
% #5: 見出しの下側の空白量または，本文を追い込む際の見出しの後の空白量に
%     関係する寸法
% #6: 見出しの書体などの設定
% [#7]: 目次用タイトル
% <#8>: ヘッダ用タイトル
% #9: 本文用見出しタイトル
% \make<SECTION>headが定義されていればその体裁で処理．未定義ならばデフォルトの体裁で処理されます．
% \def\@sect#1#2#3#4#5#6[#7]#8{% optionの組み合わせを変更
\if@KB@hyperref
\def\@sect#1#2#3#4#5#6[#7]#8{%
\@ifundefined{pre@#1@mark@toc@out}{\csname pre@#1@mark@toc@out\endcsname}{}
\@ifundefined{post@#1@mark@toc@out}{\csname post@#1@mark@toc@out\endcsname}{}
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
\@ifundefined{@make#1head}{%
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax{\@svsec}}%
%        \@hangfrom{\hskip #3\relax{\@svsec}}%
          \interlinepenalty\@M\@inhibitglue#8\@@par}%
    \endgroup}{\csname @make#1head\endcsname{#3}{#6}{#8}}
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{%
		\csname pre@#1@mark@toc@out\endcsname%
		\csname the#1\endcsname%
		\csname post@#1@mark@toc@out\endcsname%
}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\else
\def\@sect#1#2#3#4#5#6[#7](#8)#9{%
\@ifundefined{pre@#1@mark@toc@out}{\csname pre@#1@mark@toc@out\endcsname}{}%
\@ifundefined{post@#1@mark@toc@out}{\csname post@#1@mark@toc@out\endcsname}{}%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
\@ifundefined{@make@#1@head}{%
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax{\@svsec}}%
          \interlinepenalty\@M\@inhibitglue#9\normalsize\@@par}%% #8 => #9 added \normalsize
    \endgroup}{\csname @make@#1@head\endcsname{#3}{#6}{#9}}%% #8 => #9
   \csname #1mark\endcsname{#8}%% #7 => #8
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{%
\csname pre@#1@mark@toc@out\endcsname%
\csname the#1\endcsname%
\csname post@#1@mark@toc@out\endcsname%
}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #9}%% #8 => #9
      \csname #1mark\endcsname{#8}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
         \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\fi  
 %%%%%%%%%%%%%%%%%%%%%

% sectionなどを指定した行数の天地中央に置く
% 
\newskip\pre@head@skip
\newskip\after@head@skip
\newskip\@pre@section@skip
\newskip\@after@section@skip
\newskip\@pre@subsection@skip
\newskip\@after@subsection@skip
\newskip\@pre@subsubsection@skip
\newskip\@after@subsubsection@skip
\def\KBheadinggap{\@ifnextchar[{\KB@headinggap}{\KB@headinggap[\z@]}}
\def\KB@headinggap[#1]#2#3{\pre@head@skip=\normalbaselineskip\relax
	\multiply\pre@head@skip by#3\relax
	\advance\pre@head@skip -\normalbaselineskip
	\after@head@skip\pre@head@skip
	\advance\pre@head@skip 1\Cht
	\divide \pre@head@skip 2\relax
	\setbox\z@=\hbox{\csname KB#2font\endcsname\char\euc"A1A1}
	\@tempdima\ht\z@
	\divide\@tempdima by2\relax
	\advance\@tempdima -1\Cht
	\advance\pre@head@skip \@tempdima
	\advance\pre@head@skip #1\relax
	\advance\after@head@skip -\pre@head@skip
\ifdim\after@head@skip<\z@\after@head@skip1sp\fi
	\csname @pre@#2@skip\endcsname=\pre@head@skip
	\csname @after@#2@skip\endcsname=\after@head@skip
}
% \KBheadinggapは{heading name}のLEVEに{行取数}で指定した行数の天地左右に
% 配置するように，\@pre@section@skip，\@after@section@skipの数値を決定する，
% これらふたつは，\@startsectionのpreskipとatterskipに割り当てられる．

% \KBheadinggap[上下shift量]{heading name}{行取数}
% \KBheadinggap[.5\normalbaselineskip]{section}{3}
\KBheadinggap[.5\normalbaselineskip]{section}{3}
\KBheadinggap[.2\normalbaselineskip]{subsection}{2}
\KBheadinggap[.2\normalbaselineskip]{subsubsection}{2}
% --------------------------------------------------
\newcommand{\section}{%
   \@startsection{section}{1}{\z@}%
    {\@pre@section@skip}
    {\@after@section@skip}
   {\KBsectionfont}}%
\newcommand{\subsection}{%
   \@startsection{subsection}{2}{\z@}%
    {\@pre@subsection@skip}
    {\@after@subsection@skip}
   {\KBsubsectionfont}}%
\newcommand{\subsubsection}{%
   \@startsection{subsubsection}{3}{\z@}%
%    {\@pre@subsubsection@skip}
%    {\@after@subsubsection@skip}
    {\normalbaselineskip}
    {1sp}
   {\KBsubsubsectionfont}}%
\newcommand{\paragraph}{%
    \@startsection{paragraph}{4}{\z@}%
   {3.25ex \@plus 1ex \@minus .2ex}%
   {-1em}%
   {\KBparagraphfont}}
\newcommand{\subparagraph}{%
   \@startsection{subparagraph}{5}{\z@}%
   {3.25ex \@plus 1ex \@minus .2ex}%
   {-1em}%
   {\KBsubparagraphfont}}
\newcommand{\appendix}{\par
\@appendix@@true
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand{\@chapapp}{\appendixname}%
  \renewcommand{\@chappos}\space%
  \renewcommand{\thechapter}{\@Alph\c@chapter}}
\if@twocolumn
  \setlength\leftmargini {3zw}
\else
  \setlength\leftmargini {2zw}%% 3zw -> 2zw
\fi
\setlength\leftmarginii  {2zw}
\setlength\leftmarginiii {2zw}
\setlength\leftmarginiv  {2zw}
\if@twocolumn
  \setlength\leftmarginv {1zw}
  \setlength\leftmarginvi{1zw}
\else
  \setlength\leftmarginv {1zw}
  \setlength\leftmarginvi{1zw}
\fi
\labelsep1zw
\labelwidth\leftmargini
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
\newcommand{\labelenumi}{\theenumi.}
\newcommand{\labelenumii}{(\theenumii)}
\newcommand{\labelenumiii}{\theenumiii.}
\newcommand{\labelenumiv}{\theenumiv.}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\theenumi(\theenumii)}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}

% 
%\renewenvironment{enumerate}
%  {\ifnum \@enumdepth >3\relax\@toodeep\else
%   \advance\@enumdepth\@ne
%   \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
%   \list{\csname label\@enumctr\endcsname}{%
%         \parskip\z@\itemsep\z@ \parsep\z@
%         \labelsep.5zw
%         \ifnum \@enumdepth=\@ne \leftmargin1zw\relax
%           \else\leftmargin\leftskip\fi
%         \advance\leftmargin 1zw
%	 \labelwidth\leftmargin \advance\labelwidth -\labelsep
%         \usecounter{\@enumctr}%
%         \def\makelabel##1{\hss\llap{##1}}}%
%   \fi}{\endlist}
%
\let\senumerate\enumerate
\let\endsenumerate\endenumerate
% enumerateのlabelの位置を補正
% \labelenumi(\@arabic\c@enumi.)のlabelを版面左寄せにしたい．
% しかし一桁に合わせると二桁目からは左にはみ出す形になる．
% それを\leftmarginの左寄に統一し，
% 二桁に及ぶときは一桁は二桁幅中の右寄せに切り替わるように，
% かつ各階層でも行うようにもしたい．
% これをauxファイル経由で\labelwidthを取得する手法で試す．
% （そのため二度の処理が必要）
% label幅をすべて計測して各階層の最後のlabel幅を取得するようになっている．
% 標準の第3階層の\labelenumiii(\@roman\c@enumiii)の場合は必ずしも適切な
% 定義方法ではないが，第2階層以下で左にはみ出すのは標準でもそうなのでそのままとする．
%
\newbox\enu@@label@@box@@
% 第1層のenumerateを数える
\newcounter{enume@cnt@id}
\setcounter{enume@cnt@id}{0}
% enumerateの階層カウント(\@enumdepthとは独立)
\newcounter{enume@depth@id}
\setcounter{enume@depth@id}{0}
% 
% 各enumerate（階層も含めて）に固有のIDを振って特定に使う．
\def\theenume@cnt@id{%
kbenulbl:%
\theenume@depth@id:%%第1層のenumerateの通し番号
%\@arabic\@tempcnta:%%
\@arabic\c@enume@cnt@id% enumerateの階層
}
\def\theenume@depth@id{\@arabic\c@enume@depth@id}
\def\enucntID#1#2{\expandafter\gdef\csname kbEnu#2\endcsname{\setbox\enu@@label@@box@@\hbox{#1}}}%% \enu@@label@@box@@に\labelenum(x)を入れる
\renewenvironment{enumerate}
  {\advance\c@enume@cnt@id\@ne%%\@tempcnta\@enumdepth
\ifnum\@enumdepth=\z@\global\advance\c@enume@depth@id\@ne\fi
   \ifnum \@enumdepth >3\relax\@toodeep\else
   \advance\@enumdepth\@ne
   \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
   \list{\csname label\@enumctr\endcsname}{%
        \expandafter\csname kbEnu\theenume@cnt@id\endcsname
% \labelenum(x)の幅を取得
        \labelwidth\wd\enu@@label@@box@@
         \parskip\z@\itemsep\z@ \parsep\z@
%         \ifnum \@enumdepth=\@ne %\leftmargin2zw
%           \else\leftmargin\leftskip\advance\leftmargin 2zw\fi
	 \labelsep\leftmargin \advance\labelsep -\labelwidth
% \labelenum(x)が変更される可能性を考えてlabelが本文に食い込むのを補正
\ifdim\labelsep<1pt \labelsep.25zw\fi
         \usecounter{\@enumctr}%
         \def\makelabel##1{%
         \protected@write\@auxout{}{%
         \protect\enucntID{##1}{\theenume@cnt@id}}\hss\llap{##1}}}%
\fi}{\advance\c@enume@cnt@id-\@ne\endlist}

\newcommand{\labelitemi}{\textbullet}
\newcommand{\labelitemii}{{\normalfont\bfs\textendash}}
\newcommand{\labelitemiii}{\textasteriskcentered}
\newcommand{\labelitemiv}{\textperiodcentered}
\renewenvironment{itemize}
  {\ifnum \@itemdepth >3\relax\@toodeep\else
   \advance\@itemdepth\@ne
   \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
   \expandafter
   \list{\csname \@itemitem\endcsname}{%
   \labelsep.5zw\labelwidth\leftmargin \advance\labelwidth -\labelsep
         \def\makelabel##1{\hss\llap{##1}}
         \def\makelabel##1{\hbox to\labelwidth{\hfil##1\hfil}}
	}%
   \fi}{\endlist}
%
\renewenvironment{itemize}
  {\ifnum \@itemdepth >3\relax\@toodeep\else
   \advance\@itemdepth\@ne
   \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
   \expandafter
   \list{\csname \@itemitem\endcsname}{%
   \labelsep\z@\labelwidth\leftmargin \advance\labelwidth -\labelsep
         \def\makelabel##1{\hbox to\labelwidth{\hfil##1\hfil}}}%
   \fi}{\endlist}
%
\newenvironment{description}
  {\list{}{\labelwidth\z@ \itemindent-\leftmargin
   \iftdir
     \leftmargin\leftskip \advance\leftmargin3\Cwd
     \rightmargin\rightskip
     \labelsep=1zw \itemsep\z@
     \listparindent\z@ \topskip\z@ \parskip\z@ \partopsep\z@
   \fi
           \let\makelabel\descriptionlabel}}{\endlist}
\newcommand{\descriptionlabel}[1]{%
   \hspace\labelsep\normalfont\bfs #1}

\renewenvironment{description}
  {\list{}{\labelwidth=\leftmargin
\labelsep=1zw
\advance\labelwidth by-\labelsep
   \iftdir
     \leftmargin\leftskip \advance\leftmargin3\Cwd
     \rightmargin\rightskip
     \labelsep=1zw \itemsep\z@
     \listparindent\z@ \topskip\z@ \parskip\z@ \partopsep\z@
   \fi
           \let\makelabel\descriptionlabel}}{\endlist}
\renewcommand{\descriptionlabel}[1]{%
   \normalfont\bfs #1\hfil}
% 
\newenvironment{verse}
  {\let\\\@centercr
   \list{}{\itemsep\z@ \itemindent -1.5em%
           \listparindent\itemindent
           \rightmargin\leftmargin \advance\leftmargin 1.5em}%
           \item\relax}{\endlist}
\newenvironment{quotation}
  {\list{}{\listparindent 1zw%
           \itemindent\listparindent
           \rightmargin\p@
           \parsep\z@ \@plus\p@}%
           \item\relax}{\endlist}
\newenvironment{quote}
  {\list{}{\rightmargin\leftmargin}%
           \item\relax}{\endlist}
\newcounter{figure}[chapter]
\renewcommand{\thefigure}{%
  \ifnum\c@chapter>\z@\thechapter.\fi\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\thefigure}
\newenvironment{figure}
               {\let\center\Center\let\endcenter\endCenter
               \@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\let\center\Center\let\endcenter\endCenter
               \@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand{\thetable}{\thechapter.\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
%   一般的に`図表'のcaptionは`図'の下，`表'はcaptionはその表の上に配置します．
%   このクラスファイルでは図を配置する目的で使われるfigure環境において
%   ``図の下にcaptionを置く前提'' で\abovecaptionskipはfigure環境内での
%   図とcaptionとのアキであるという想定で定義してます．
%   \belowcaptionskipはtable環境内で`表'の上にcaptionが配置されたとき
%   のアキということになります．
%   よってfigure環境でobjectを上に配置，もしくはtable環境でobjectの下に
%   captionを配置すると少しおかしな事になるかも知れません．
% # 2009/11/06に吉永徹美氏のマクロを参考に
% # \makecaptionの定義を全面的に書き直しました．
\abovecaptionskip2mm% 図とcaption とのアキとして想定
\belowcaptionskip2mm% 表とcaption とのアキとして想定
\def\@@float@type@figure{figure}
\def\@@float@type@table{table}
% 
\newdimen\thecaptionskip
\long\def\@makecaption#1#2{\thecaptionskip1zw%
\setbox0\hbox{#2}\ifdim\wd0=\z@\thecaptionskip\z@\fi
 \ifx\@captype\@@float@type@figure\belowcaptionskip\z@\fi
 \ifx\@captype\@@float@type@table\abovecaptionskip\z@\fi
	\nointerlineskip\vskip\abovecaptionskip
	\setbox\z@\hbox{\KBcaptionfont\bfs#1\hskip\thecaptionskip}%
	\dimen@\hsize \advance\dimen@-\wd\z@
	\setbox\tw@\vbox{\hsize\dimen@\@parboxrestore\KBcaptionfont#2}%
	\global\setbox\@ne\vtop{}%
	\setbox\tw@\vbox{%
	\dimen@\z@\unvcopy\tw@%%%%%
	\@makecaption@get@boxsize%%
		\unvbox\tw@
		\@makecaption@reconstruct@box}%
	\hbox to\hsize{\hss\box\z@\box\@ne\hss}%
	\@minipagefalse\nointerlineskip
	\vskip\belowcaptionskip}
\def\@makecaption@reconstruct@box{%
	\@tempdima\lastskip\unskip
	\unpenalty
	\setbox\tw@\lastbox
	\ifvoid\tw@\else
		\global\setbox\@ne\vtop{%
	\hbox to\dimen@{\unhbox\tw@}%%%%%
% \hbox{\unhbox\tw@}%
		\vskip\@tempdima%
		\unvbox\@ne}%
	\expandafter\@makecaption@reconstruct@box
	\fi
}
\def\@makecaption@get@boxsize{%
	\unskip \unpenalty \unskip \unpenalty
	\setbox4\lastbox
	\ifvoid4\else
		\setbox4\hbox{\unhbox4}%
		\ifdim\dimen@<\wd4 \dimen@\wd4\fi
		\expandafter\@makecaption@get@boxsize
	\fi}
% 
\setlength\arraycolsep{2\p@}
%	\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.12mm}%% 表罫
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.12mm}
\@addtoreset{equation}{chapter}
\renewcommand{\theequation}{%
  \ifnum\c@chapter>\z@\thechapter.\fi \@arabic\c@equation}
\if@enablejfam
  \DeclareSymbolFont{mincho}{\Y@enc}{\mcdefault}{m}{n}
  \DeclareSymbolFontAlphabet{\mathmc}{mincho}
  \SetSymbolFont{mincho}{bold}{\Y@enc}{\gtdefault}{m}{n}
  \DeclareMathAlphabet{\mathgt}{\Y@enc}{\gtdefault}{m}{n}
  \reDeclareMathAlphabet{\mathrm}{\@mathrm}{\@mathmc}
  \reDeclareMathAlphabet{\mathbf}{\@mathbf}{\@mathgt}
% \mathsfでも和文はゴシックになるようにしました．
  \reDeclareMathAlphabet{\mathsf}{\@mathsf}{\@mathgt}
  \jfam\symmincho
\else
  \DeclareRobustCommand{\mathmc}{%
    \@latex@error{Command \noexpand\mathmc invalid with\space
       `disablejfam' class option.}\@eha
  }
  \DeclareRobustCommand{\mathgt}{%
    \@latex@error{Command \noexpand\mathgt invalid with\space
       `disablejfam' class option.}\@eha
  }
\fi
\setcounter{tocdepth}{2}
\newcommand{\@pnumwidth}{1.5zw}
\newcommand{\@tocrmarg}{2.55em}
\newcommand{\@dotsep}{1.5}
\newdimen\toclineskip
\setlength\toclineskip{\z@}
\newdimen\@lnumwidth
% 目次で約物が行頭に来たとき\inhibitglueするように変更しました．
% \def\numberline#1{\hbox to\@lnumwidth{#1\hfil}\@inhibitglue}

\def\numberline#1{%
   \setbox\z@\hbox{#1\hskip1zw}%
   \ifdim\wd\z@<\@lnumwidth \hbox to\@lnumwidth{\unhbox\z@\hfil}%
   \else
   \box\z@
   \fi\@inhibitglue}

% 目次のリーダー罫を和文中黒にしました．
\def\@dottedtocline#1#2#3#4#5{\ifnum #1>\c@tocdepth \else
  \vskip\toclineskip \@plus.2\p@
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode
   \@lnumwidth #3\relax
   \advance\leftskip \@lnumwidth \hbox{}\hskip -\leftskip
    {\@TocSectionSlectFont#4}
    \nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{・}\mkern \@dotsep
       mu$}\hfill \nobreak\hbox to\@pnumwidth{%
         \hss\@TocSectionNumSlectFont#5}\par}\fi}
\def\addcontentsline#1#2#3{%
  \protected@write\@auxout
    {\let\label\@gobble \let\index\@gobble \let\glossary\@gobble
\@temptokena{\thepage}}%
    {\string\@writefile{#1}%
       {\protect\contentsline{#2}{#3}{\the\@temptokena}}}%
}
\newcommand{\tableofcontents}{%
\@table@of@contents@@true
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\@restonecolfalse\fi
  \chapter*{\contentsname}%
    \@mkboth{\contentsname}{\contentsname}\vspace{\l@chapter@@skip}%
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi
}
\newcommand*{\l@part}[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
    \parindent\z@\rightskip\@pnumwidth
    \parfillskip-\@pnumwidth
    {\leavevmode\KBtocpartfont
     \setlength\@lnumwidth{3.9zw}%
     #1\hfil\nobreak
     {\KBtocnumpartfont\hbox to\@pnumwidth{\hss#2}}}\par
    \nobreak
    \global\@nobreaktrue
    \everypar{\global\@nobreakfalse\everypar{}}%
     \endgroup
  \fi}

\newskip\l@chapter@@skip
\l@chapter@@skip=1.0em \@plus\p@
\newcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{\l@chapter@@skip}%
    \begingroup
      \parindent\z@ \rightskip\@pnumwidth \parfillskip-\rightskip
      \leavevmode\KBtocchapterfont
      \setlength\@lnumwidth{4zw}%
      \advance\leftskip\@lnumwidth \hskip-\leftskip
      #1\nobreak\hfil\nobreak\KBtocnumchapterfont\hbox to\@pnumwidth{\hss#2}\par
      \penalty\@M%%\@highpenalty
    \endgroup
  \fi}

\newcommand{\IfSecFontChange}{\S@ectionfalse\subS@ectionfalse\subsubS@ectionfalse}

\newcommand*{\l@section}{\IfSecFontChange%
\S@ectiontrue\@dottedtocline{1}{1.5em}{2.7em}}
\newcommand*{\l@subsection}   {\IfSecFontChange
\subS@ectiontrue\@dottedtocline{2}{4.2em}{3.25em}}
\newcommand*{\l@subsubsection}{\IfSecFontChange%
\subsubS@ectiontrue\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*{\l@paragraph}    {\@dottedtocline{4}{10em}{5em}}
\newcommand*{\l@subparagraph} {\@dottedtocline{5}{12em}{6em}}
\newcommand{\listoffigures}{%
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\@restonecolfalse\fi
  \chapter*{\listfigurename}
  \@mkboth{\listfigurename}{\listfigurename}%
  \@starttoc{lof}%
  \if@restonecol\twocolumn\fi
}
\newcommand*{\l@figure}{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand{\listoftables}{%
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\@restonecolfalse\fi
  \chapter*{\listtablename}
  \@mkboth{\listtablename}{\listtablename}%
  \@starttoc{lot}%
  \if@restonecol\twocolumn\fi
}
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newcommand{\newblock}{\hskip .11em\@plus.33em\@minus.07em}
\newenvironment{thebibliography}[1]
{\@the@bibliography@@true
\chapter*{\bibname}
\@mkboth{\bibname}{\bibname}
\addcontentsline{toc}{chapter}{\bibname}
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}\small}%
   \sloppy
   \clubpenalty4000
   \@clubpenalty\clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m
\lefthyphenmin=2\righthyphenmin=2%% ハイフネーションの条件を少し緩和
\frenchspacing% 全体のspaceを均等に
}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
\endlist}
\let\@openbib@code\@empty

\newenvironment{theindex}
  {\if@openright\cleardoublepage\else\clearpage\fi%
   \if@twocolumn\@restonecolfalse\else\@restonecoltrue\fi
   \columnseprule\z@ \columnsep 35\p@
\@ifundefined{multicols}{\twocolumn[\@make@index@chapterhead{\indexname}]}{\begin{multicols}{2}[\@make@index@chapterhead{\indexname}]}
   \@mkboth{\indexname}{\indexname}%
\addcontentsline{toc}{chapter}{\indexname}
   \thispagestyle{empty}\parindent\z@
   \parskip\z@ \@plus .3\p@\relax
   \let\item\@idxitem\small}
  {\if@restonecol
\@ifundefined{multicols}{\onecolumn}{\end{multicols}}\else\clearpage\fi}

\newcommand{\@idxitem}{\par\hangindent 4zw}
\newcommand{\subitem}{\@idxitem \hspace*{2zw}}
\newcommand{\subsubitem}{\@idxitem \hspace*{3zw}}
\newcommand{\indexspace}{\par \vskip.5\baselineskip\relax}
\def\@makefnmark{\null\hbox{\@textsuperscript{\normalfont\@thefnmark)}}}
\renewcommand{\footnoterule}{%
  \kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{\setbox\z@\hbox{\@makefnmark\hskip.25zw}
\leftskip\wd\z@
\advance\leftskip.25zw\parindent1zw
  \noindent\hbox to0pt{\hss\box\z@}\inhibitglue#1}

% \renewcommand\@makefntext[1]{%
%  \advance\leftskip 3zw
%  \parindent 1zw
%  \noindent
%  \llap{\@makefnmark\hskip0.3zw}#1}


\newif\if西暦 \西暦false
\def\西暦{\西暦true}
\def\和暦{\西暦false}
\newcount\heisei \heisei\year \advance\heisei-1988\relax
\def\today{{%
  \iftdir
    \if西暦
      \kansuji\number\year 年
      \kansuji\number\month 月
      \kansuji\number\day 日
    \else
      平成\ifnum\heisei=1 元年\else\kansuji\number\heisei 年\fi
      \kansuji\number\month 月
      \kansuji\number\day 日
    \fi
  \else
    \if西暦
      \number\year~年
      \number\month~月
      \number\day~日
    \else
      平成\ifnum\heisei=1 元年\else\number\heisei~年\fi
      \number\month~月
      \number\day~日
    \fi
  \fi}}
\newcommand{\prepartname}{第}
\newcommand{\postpartname}{部}
\newcommand{\prechaptername}{第}
\newcommand{\postchaptername}{章}
\newcommand{\contentsname}{目\hskip1zw次}
\newcommand{\listfigurename}{図 目 次}
\newcommand{\listtablename}{表 目 次}
\newcommand{\bibname}{参考文献}
\newcommand{\indexname}{索\hskip1zw引}
\newcommand{\figurename}{図}
\newcommand{\tablename}{表}
\newcommand{\appendixname}{付録}
\pagestyle{headings}
\pagenumbering{arabic}
\raggedbottom
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\if@twoside
  \@mparswitchtrue
\else
  \@mparswitchfalse
\fi

% newtheorem環境で作られる環境での()を全角へ変更．および\itをキャンセル
\def\@begintheorem#1#2{\trivlist
   \item[\hskip \labelsep{\bfseries #1\ #2}]}
\def\@opargbegintheorem#1#2#3{\trivlist
      \item[\hskip \labelsep{\bfs #1\ #2（#3）\<}]}

% 小口を調整するマクロ．
\def\Koguchi#1{%
\evensidemargin=#1\relax
\oddsidemargin\paperwidth
\advance\oddsidemargin by-\textwidth
\advance\oddsidemargin by-\evensidemargin
\setlength{\@tempdima}{\evensidemargin}
\advance\@tempdima by-\marginparsep
\marginparwidth.8\@tempdima
\advance\oddsidemargin by-1in
\advance\evensidemargin by-1in
% \topmargin\paperheight
% \advance\topmargin by-\textheight
% \topmargin.5\topmargin
% \advance\topmargin by-\headsep
% \advance\topmargin by-\headheight
% \advance\topmargin-1in
}

\def\TenAki#1{%
\topmargin=#1\relax
\advance\topmargin by-\headsep
\advance\topmargin by-\headheight
\advance\topmargin by-\topskip
\advance\topmargin by\Cht
\advance\topmargin-1in
}

% \if@KB@ten@@
% \KB@ten@@aki{\@Top@Margin@@}
% \fi


% 

% 頁先頭に来た場合の行取り用のマクロ．
\newdimen\line@gap
   \line@gap\normalbaselineskip
    \advance\line@gap-\Cht
    \advance\line@gap-\Cdp
\newdimen\header@@height

\def\linegapskip{\vskip\z@\nointerlineskip\vskip\line@gap}
%\def\linegapskip{\addvspace{\line@gap}}

\def\pushprevdepth{\xdef\@tempprevdepth{\the\prevdepth}}%
\def\popprevdepth{\prevdepth=\@tempprevdepth\relax} 


\long\def\toplinebox#1#2{\bgroup%
  \parindent\z@%
  \header@@height=\normalbaselineskip%
  \multiply\header@@height by#1%
  \advance\header@@height by-\normalbaselineskip%
  \advance\header@@height by\Cht%
  \advance\header@@height by\Cdp%
\hrule height\topskip depth-\topskip
    \parbox[t][\header@@height]{\textwidth}{#2\pushprevdepth}\par\popprevdepth
\egroup}


\def\Center{%
      \topsep\z@
      \partopsep\z@
      \parsep\z@
      \parskip\z@
\trivlist \centering\item[]}
\let\endCenter=\endtrivlist

% 独立数式を頁先頭におけるようにする．
\predisplaypenalty100

\long\def\@savemarbox#1#2{%
   \global\setbox#1%
      \color@vbox
      \normalcolor%% \textcolor実行時に\marginparに`color'が及ばないように．
      \vtop{%
         \hsize\marginparwidth
         \@parboxrestore
         \@marginparreset\KBmarginparfont
         #2%
         \@minipagefalse
         \outer@nobreak}%
    \color@endbox}

% \sectionなどの見出しに対して行頭約物の処理を追加しました．
\def\@xsect#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa<\z@
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{\everyparhook}%
      \fi\everyparhook}%
  \else
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \fi
  \par  % 2000-12-18
  \ignorespaces}
\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa<\z@
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \else
    \begingroup
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M\@inhibitglue#5\@@par}%
    \endgroup
  \fi
  \@xsect{#3}}

% 約物の行頭処理とfootnoteでの後続文字の判定で使います．
% 基本的な処理はjsbookを参考にしました．
% 対象約物を追加してます．
\def\@inhibitglue{%
  \futurelet\@let@token\@@inhibitglue}
\def\@@inhibitglue{%
  \ifx\@let@token「
    \inhibitglue
  \else
    \ifx\@let@token（
      \inhibitglue
    \else
      \ifx\@let@token『
        \inhibitglue
      \else
        \ifx\@let@token［
          \inhibitglue
        \else
          \ifx\@let@token《
           \inhibitglue
          \else
            \ifx\@let@token【
             \inhibitglue
            \else
              \ifx\@let@token〈
               \inhibitglue
              \else
               \ifx\@let@token“
                \inhibitglue
               \else
                 \ifx\@let@token〔
                  \inhibitglue
                 \else
                   \ifx\@let@token＜
                    \inhibitglue
                   \else
% 
                     \ifx\@let@token．
                      \unskip
                     \else
                       \ifx\@let@token，
                        \unskip
                       \else
                        \ifx\@let@token．
                          \unskip
                         \else
                           \ifx\@let@token。
                            \unskip
                           \else
                            \ifx\@let@token、
                              \unskip
                            \else
                              \ifx\@let@token。
                               \unskip
                              \else
                                \ifx\@let@token・
                                  \unskip
                                \else%% added 2012/03/27
                                   \ifx\@let@token）
                                     \unskip
                                   \else
                                      \ifx\@let@token」
                                        \unskip
                                      \else
                                         \ifx\@let@token』
                                           \unskip
                                         \else
                                            \ifx\@let@token］
                                              \unskip
                                            \else
                                               \ifx\@let@token”
                                                 \unskip
                                               \else
                                                  \ifx\@let@token】
                                                    \unskip
                                                  \else
                                                     \ifx\@let@token)
                                                       \@killglue
                                                     \else
                                                        \ifx\@let@token]
                                                          \@killglue
                                                        \else
                                                            \ifx\@let@token.
                                                              \@killglue
                                                             \else
                                                                \ifx\@let@token,
                                                                  \@killglue
                                                                 \else\ignorespaces
% 
\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi}
\let\everyparhook=\@inhibitglue
\AtBeginDocument{\everypar{\everyparhook}}
\def\@doendpe{%
  \@endpetrue
  \def\par{%
    \@restorepar\everypar{\everyparhook}\par\@endpefalse}%
  \everypar{{\setbox\z@\lastbox}\everypar{\everyparhook}\@endpefalse\everyparhook}}
% \@item内と\@afterheadingでの\clubpenaltyの増加を無効にしています．
% 伝統的な欧文組版ではページの最下段において"見出し＋1行"という状態を
% 好まない傾向があるといいます．
% (頁下段に見出しだけが残るいわゆる首吊りは論外ですが)日本語組版では
% 特にこのような拘りはなく，それよりも素の流れが好まれる傾向があります．
% オリジナルのLaTeXではこのようなことを抑制する目的で見出し直後の
% \clubpenaltyを変更していますが，日本語組版では先に挙げた理由により時
% として不自然に映る流れになるのでここで無効にしています．
% # \clubpenalty(\@clubpenalty)や\widowpenalty自体をglobalに0にしても
% # 差し支えないような気もしているのですが，確信が持てていないのでデフォルト
% # の150の設定には手をつけません．
\def\@item[#1]{%
  \if@noparitem
    \@donoparitem
  \else
    \if@inlabel
      \indent \par
    \fi
    \ifhmode
      \unskip\unskip \par
    \fi
    \if@newlist
      \if@nobreak
        \@nbitem
      \else
        \addpenalty\@beginparpenalty
        \addvspace\@topsep
        \addvspace{-\parskip}%
      \fi
    \else
      \addpenalty\@itempenalty
      \addvspace\itemsep
    \fi
    \global\@inlabeltrue
  \fi
  \everypar{%
    \@minipagefalse
    \global\@newlistfalse
    \if@inlabel
      \global\@inlabelfalse
      {\setbox\z@\lastbox
       \ifvoid\z@
         \kern-\itemindent
       \fi}%
      \box\@labels
      \penalty\z@
    \fi
    \if@nobreak
      \@nobreakfalse
%      \clubpenalty \@M
    \else
%      \clubpenalty \@clubpenalty
      \everypar{\everyparhook}%
    \fi\everyparhook}%
  \if@noitemarg
    \@noitemargfalse
    \if@nmbrlist
    % for emath
      \@ifundefined{enumstepcounter}{}{\let\stepcounter\enumstepcounter}%
      \refstepcounter\@listctr
    % for emath
      \@ifundefined{enumstepcounter}{}{\let\stepcounter\ltxstepcounter}%
    \fi
  \fi
  \sbox\@tempboxa{\makelabel{#1}}%
  \global\setbox\@labels\hbox{%
    \unhbox\@labels
    \hskip \itemindent
    \hskip -\labelwidth
    \hskip -\labelsep
    \ifdim \wd\@tempboxa >\labelwidth
      \box\@tempboxa
    \else
      \hbox to\labelwidth {\unhbox\@tempboxa}%
    \fi
    \hskip \labelsep}%
  \ignorespaces}%
  
\def\@afterheading{%
  \@nobreaktrue
  \everypar{%
    \if@nobreak
      \@nobreakfalse
%      \clubpenalty \@M
      \if@afterindent \else
        {\setbox\z@\lastbox}%
      \fi
    \else
%      \clubpenalty \@clubpenalty
      \everypar{\everyparhook}%
    \fi\everyparhook}}


\newdimen\stockwidth \newdimen\stockheight
\setlength{\stockwidth}{\paperwidth}
\setlength{\stockheight}{\paperheight}
  \iftombow
    \advance \stockwidth 1in
    \advance \stockheight 1in
  \voffset -.5in
  \hoffset -.5in
  \fi
\AtBeginDvi{\special{papersize=\the\stockwidth,\the\stockheight}}

% 
\let\@@PartFont\KBpartfont
\let\@@PartNumFont\KBpartnumfont
\let\@@ChapterFont\KBchapterfont
\let\@@ChapterNumFont\KBchapternumfont
\let\@@Indexheadfont\KBindextitlefont
\let\@@SectionFont\KBsectionfont
\let\@@SectionNumFont\KBsectionnumfont
\let\@@subSectionFont\KBsubsectionfont
\let\@@subSectionNumFont\KBsubsectionfont
\let\@@subsubSectionFont\KBsubsubsectionfont
\let\@@subsubSectionNumFont\KBsubsubsectionnumfont
\let\@@ParagraphFont\KBparagraphfont
\let\@@subParagraphFont\KBsubparagraphfont
\let\@@CaptionFont\KBcaptionfont
\let\@@PageNumFont\KBpagenumfont
\let\@@HeaderFont\KBheaderfon
\let\@@MarginparFont\KBmarginparfont
\let\@@TocPartFont\KBtocpartfont
\let\@@TocNumPartFont\KBtocnumpartfont
\let\@@TocChapterFont\KBtocchapterfont
\let\@@TocNumChapterFont\KBtocnumchapterfont
\let\@@TocSectionFontt\KBtocsectionfont
\let\@@TocsubSectionFont\KBtocsubsectionfont
\let\@@TocsubsubSectionFont\KBtocsubsubsectionfont
\let\@@TocNumSectionFont\KBtocnumsectionfont
\let\@@TocNumsubSectionFont\KBtocnumsubsectionfont
\let\@@TocNumsubsubSectionFont\KBtocnumsubsubsectionFont


% \footnoteで\verbを使えるように（jsbookより転用）
\long\def\@footnotetext{%
  \insert\footins\bgroup
    \normalfont\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
       \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces}%
      \futurelet\next\fo@t}
\def\fo@t{\ifcat\bgroup\noexpand\next \let\next\f@@t
                                \else \let\next\f@t\fi \next}
\def\f@@t{\bgroup\aftergroup\@foot\let\next}
\def\f@t#1{#1\@foot}
\def\@foot{\@finalstrut\strutbox\color@endgroup\egroup}



% 八登氏による\footnoteでの添字に関係するアキの調整
% \textbf{（和文）}\footnote のような場合でも，閉じ）の右側の
% アキを\unskipで吸収させます．
% また，添字と後続文字のアキを原則として0.25zwに固定します．
% ただし，後続文字が "\footnote{}．" "\footnote{}「" のように約物の場合は
% \@inhibitglueでアキを吸収するようにしています．
\def\pxfn@pkgname{pxftnote}
\def\pxfn@error{\PackageError\pxfn@pkgname}
\def\pxfn@warn{\PackageWarning\pxfn@pkgname}
\newif\ifpxfn@hooked
% ------
% save original definitions
% \ifx\footnotes@ve\@undefined
\let\kb@org@@footnote=\footnote
\let\kb@org@@footnotemark=\footnotemark
% \else % jsclasses loaded
% \let\kb@org@@footnote=\footnotes@ve
% \let\kb@org@@footnotemark=\footnotemarks@ve
% \fi
\let\pxfn@org@@footnotetext=\@footnotetext

% <*> \jfootnote / \jfootnotemark
\def\jfootnote{\pxfn@prehook\kb@org@@footnote}
\def\jfootnotemark{\pxfn@prehook\@ifnextchar[%
  {\pxfn@jfootnotemark@a}{\kb@org@@footnotemark\pxfn@posthook}}
\def\pxfn@jfootnotemark@a[#1]{\kb@org@@footnotemark[#1]\pxfn@posthook}

% \pxfn@prehook, \pxfn@posthook
\def\pxfn@prehook{\pxPreJFootnoteHook\pxfn@hookedtrue}
\def\pxfn@posthook{%
  \ifpxfn@hooked \pxfn@hookedfalse
    \expandafter\pxPostJFootnoteHook \fi}

% \pxfn@ifstartwith\CS{<prefix>}{<yes>}
% If the expansion of \CS starts with <prefix> then do <yes>.
\def\pxfn@ifstartwith#1#2{%
  \def\pxfn@tmpa{#2}\pxfn@detokenize\pxfn@tmpa\pxfn@pfx
  \expandafter\pxfn@ifstartwith@a\pxfn@pfx\@nil
  \pxfn@detokenize#1\pxfn@tmpa
  \edef\pxfn@tmpa{\pxfn@tmpa\pxfn@pfx}%
  \expandafter\pxfn@checker\pxfn@tmpa\@nil}
\AtBeginDocument{\let\pxfn@tmpa\relax\let\pxfn@pfx\relax}
\def\pxfn@ifstartwith@a#1\@nil{%
  \def\pxfn@checker##1#1##2\@nil{%
    \ifcat_##1_\expandafter\@firstofone
    \else \expandafter\@gobble\fi}}
\def\pxfn@detokenize#1#2{%
  \expandafter\pxfn@detokenize@a\expandafter#2\meaning#1\@nil}
\def\pxfn@detokenize@a#1#2->#3\@nil{\def#1{#3}}

% \pxfn@inserthook@i, etc.
% Inserts \pxfn@posthook immediately after \insert operation.
\def\pxfn@inserthook@ii{\afterassignment\pxfn@inserthook@i}
\def\pxfn@inserthook@i{\afterassignment\pxfn@inserthook@a}
\def\pxfn@inserthook@a{\aftergroup\pxfn@posthook}

% enable the postprocess hook
\let\pxfn@inserthook\relax
\pxfn@ifstartwith\@footnotetext{\insert\footins}%
  {\let\pxfn@inserthook\pxfn@inserthook@i}
\pxfn@ifstartwith\@footnotetext{\ifydir\def\@tempa}%
  {\let\pxfn@inserthook\pxfn@inserthook@ii}
\ifx\pxfn@inserthook\relax
  \pxfn@warn{Cannot enable postprocess hook}\@ehc
\else \def\@footnotetext{\pxfn@inserthook\pxfn@org@@footnotetext}%
\fi

\let\footnote\jfootnote
\let\footnotemark\jfootnotemark

% ------ Initial settings

% These settings basically obey the folloiwng W3C WG Note:
%   Requirements for Japanese Text Layout
%   http://www.w3.org/TR/2009/NOTE-jlreq-20090604/
% 
\def\pxPreJFootnoteHook{\relax
  {\skip@\lastskip\@tempswatrue
   \ifdim\skip@>.225zw \ifdim\skip@<.275zw \@tempswafalse \fi\fi
%   \ifdim\skip@<.275zw \@tempswafalse \fi
   \if@tempswa \unskip \fi
}}
\def\pxPostJFootnoteHook{\hskip.25zw\@inhibitglue}
% \def\pxPostJFootnoteHook{}
% ------ all done


% \AtBeginDocument{\@ifpackageloaded{type1cm}{\PackageWarning{kbdbook}{}}{\relax}}
% \iffalse
\AtBeginDocument{%
%  amsmath使用時に\allowdisplaybreaksを使う．
\@ifundefined{allowdisplaybreaks}{}{%
	\KB@class@info{I use the allowdisplaybreaks amsmath package that we have used.}%
	\allowdisplaybreaks}%
%  amsthm使用時にオプションの()に全角を使う．
% とりあえずplainのみ．
% \@ifpackageloaded{amsthm}%
% {%
% \def\thmhead@plain#1#2#3{%
%  \thmname{#1}\thmnumber{\@ifnotempty{#1}{ }\@upn{#2}}%
%  \thmnote{ {\the\thm@notefont\bfseries{}\inhibitglue （#3）\inhibitglue}}}
% \let\thmhead\thmhead@plain
% \def\swappedhead#1#2#3{%
%  \thmnumber{#2}%
%  \thmname{\@ifnotempty{#2}{~}#1}%
%  \thmnote{ {\the\thm@notefont\bfseries{}\inhibitglue （#3）\inhibitglue}}}%
% }{\relax}%
% \@ifundefined{th@plain}{%
% \bgroup
% \gdef\th@plain{\normalfont%%\itshape
%  \def\@begintheorem##1##2{%
%        \item[\hskip\labelsep \theorem@headerfont ##1\ ##2]}%
% \def\@opargbegintheorem##1##2##3{%
%   \item[\hskip\labelsep \theorem@headerfont ##1\ ##2\inhibitglue （##3）\inhibitglue]}}
% {}\egroup}
}
% \fi

% minipage環境とparboxでの行頭処理．
% \everyparに\everyparhookを追加しています．
\def\@arrayparboxrestore{%
  \let\if@nobreak\iffalse
  \let\if@noskipsec\iffalse
  \let\par\@@par
  \let\-\@dischyph
  \let\'\@acci\let\`\@accii\let\=\@acciii
  \parindent\z@ \parskip\z@skip
  \everypar{\everyparhook}%
  \linewidth\hsize
  \@totalleftmargin\z@
  \leftskip\z@skip \rightskip\z@skip \@rightskip\z@skip
  \parfillskip\@flushglue \lineskip\normallineskip
  \baselineskip\normalbaselineskip
  \sloppy}
\def \@setminipage{%
  \@minipagetrue
  \everypar{\@minipagefalse\everypar{\everyparhook}\everyparhook}%
}


% float環境[h]指定での前後のアキの補正(前後は\intextsep+行間のグル―になる．)
% TeXWiKi53958
\def \@addtocurcol {%
   \@insertfalse
   \@setfloattypecounts
   \ifnum \@fpstype=8
   \else
     \ifnum \@fpstype=24
     \else
       \@flsettextmin
       \advance \@textmin \@textfloatsheight
       \@reqcolroom \@pageht
       \ifdim \@textmin>\@reqcolroom
         \@reqcolroom \@textmin
       \fi
       \advance \@reqcolroom \ht\@currbox
       \ifdim \@colroom>\@reqcolroom
         \@flsetnum \@colnum
         \ifnum \@colnum>\z@
           \@bitor\@currtype\@deferlist
           \if@test
           \else
             \@bitor\@currtype\@botlist
             \if@test
               \@addtobot
             \else
               \ifodd \count\@currbox
                 \advance \@reqcolroom \intextsep
                 %%% added
                 %%% 図版の直前の行の後に「標準的な」高さの行が続く場合に入る
                 %%% 行間のグル―の大きさを割り出し，その大きさだけ補正
                 \dimen@\baselineskip
                 \advance\dimen@-\@pagedp \advance\dimen@-\Cht
                 \ifdim\dimen@<\lineskiplimit \dimen@\lineskip \fi
                 \advance \@reqcolroom \dimen@
                 %%% end of added part
                 \ifdim \@colroom>\@reqcolroom
                   \global \advance \@colnum \m@ne
                   \global \advance \@textfloatsheight \ht\@currbox
                   \global \advance \@textfloatsheight 2\intextsep
                   \@cons \@midlist \@currbox
                   \if@nobreak
                     \nobreak
                     \@nobreakfalse
                     \everypar{}%
                   \else
                     \addpenalty \interlinepenalty
                   \fi
                   \vskip\dimen@%%% added
                   \vskip \intextsep
                   \box\@currbox
                   \penalty\interlinepenalty
                   \vskip\intextsep
                   \ifnum\outputpenalty <-\@Mii \vskip -\parskip\fi
                   \outputpenalty \z@
                   \@inserttrue
                 \fi
               \fi
               \if@insert
               \else
                 \@addtotoporbot
               \fi
             \fi
           \fi
         \fi
       \fi
     \fi
   \fi
   \if@insert
   \else
     \@resethfps
     \@cons\@deferlist\@currbox
   \fi
}

% TOOLS

\DeclareRobustCommand\HI{\makebox[.75zw][c]{\rule[.35zh]{.5zw}{.1mm}}}
\DeclareRobustCommand\HO{\makebox[1zw][c]{\rule[.35zh]{.75zw}{.1mm}}}
\DeclareRobustCommand\tutu{\makebox[2zw][c]{\rule[.35zh]{1.75zw}{.1mm}}}


\def\sujiPath{./num/}
% 丸数字を使う．1～29までに対応．
\def\marusuji#1{%
\protect\makebox[1zw][c]{\protect\raisebox{-.15zh}{\protect\includegraphics[width=1zw]{\sujiPath%
#1.eps}}%
}}%

% 表組み
\RequirePackage{array}
\RequirePackage{multirow}%% multirowもいちおう読んでおく．
%\arrayrulewidth.12mm% 表罫
\newdimen\save@arrayrulewidth
\newdimen\Med@arrayrulewidth
\save@arrayrulewidth\arrayrulewidth
\Med@arrayrulewidth.25mm%% 中太罫
\newcolumntype{v}{!{\vrule width\Med@arrayrulewidth}}
\def\Hline{\noalign{\global\arrayrulewidth\Med@arrayrulewidth}\hline\noalign{\global\arrayrulewidth\save@arrayrulewidth}}
\def\Cline#1{\noalign{\global\arrayrulewidth\Med@arrayrulewidth}\cline{#1}\noalign{\global\arrayrulewidth\save@arrayrulewidth}}


\DeclareRobustCommand{\Fbox}[1]{{%
\setbox0\hbox{\char\euc"A4A2}\setbox2\hbox{#1}%
\ifdim 1.001\ht0>\ht2
	\dimen0=\dp0\dimen1=\ht0\advance\dimen1 by\dimen0
	\else
	\advance\dimen0 by0.1zw\advance\dimen1 by.1zw
\fi\fboxsep\z@\fbox{\kern.25zw\vrule width\z@ height\dimen1 depth\dimen0
\ifdim\dp0<\dp2\lower-.45\dp2\hbox{#1}\else#1\fi
%#1%
\kern.25zw}}}


\def\Cs#1{\mbox{\texttt{\symbol{92}#1}}}

\def\rensuji#1{\hskip\xkanjiskip\hbox to1zw{\yoko\hss#1\hss}\hskip\xkanjiskip\relax}


\newdimen\dmath@height
\newcount\dmath@cunt
\newbox\dmath@box

% display数式を近似の整数倍の行取りに収める
\def\intlinemath{%
 \line@gap\baselineskip
 \setbox\z@\hbox{\char\euc"A1A1}%
    \advance\line@gap-\ht\z@
    \advance\line@gap-\dp\z@
      \setbox\dmath@box\vbox\bgroup
      \abovedisplayskip\z@
      \abovedisplayshortskip\abovedisplayskip
      \belowdisplayshortskip\abovedisplayskip
      \belowdisplayskip\abovedisplayskip
}
\def\endintlinemath{\egroup
    \dmath@height\ht\dmath@box
    \advance\dmath@height\dp\dmath@box
    \divide\dmath@height \baselineskip
    \dmath@cunt\dmath@height
    \dmath@height \dmath@cunt\baselineskip
    \advance\dmath@height \Cht
    \advance\dmath@height \Cdp
    \parindent\z@
    \vskip\line@gap\prevdepth-10000pt%
    \vbox to\dmath@height{\hsize=\linewidth%
    \vss\box\dmath@box\vss}
    \vskip\line@gap\prevdepth-10000pt%\noindent
}

% 字下げ幅を適時調整できるリスト
% 環境の前に空行を入れると半行分アキをつくる．
% \begin{Description}[2zw]で字下げ2倍のリストする．
\newcommand{\Descriptionfont}{\normalfont}
\newenvironment{Description}[1]%
  {\list{}{\partopsep.5\baselineskip\topsep\z@\leftmargin#1\labelwidth\leftmargin
\labelsep\z@
\advance\labelwidth by-\labelsep
   \iftdir
     \leftmargin\leftskip \advance\leftmargin3\Cwd
     \rightmargin\rightskip
     \labelsep=1zw \itemsep\z@
     \listparindent\z@ \topskip\z@ \parskip\z@ \partopsep\z@
   \fi
           \let\makelabel\Descriptionlabel}}{\endlist}
\newcommand{\Descriptionlabel}[1]{%
   \Descriptionfont#1\hfil}

% 字取りマクロ／\jidori{長さ}{TEXT}
%\def\jidori#1#2{\leavevmode\hbox to #1{\kanjiskip\fill\xkanjiskip\kanjiskip#2}

% 設定した長さに伸縮するタイプへ再定義．
% ただし欧文単語間と数式のspacecingには手をつけない．2012/03/28
\def\jidori#1#2{\leavevmode\hbox to#1{\hss\@jidori{#2}\hss}}
\def\@jidori#1{%
\kanjiskip\z@ plus 1fill minus 1fill
\xkanjiskip\z@ plus 1fill %%\spaceskip\z@ plus 1fill minus 1fill
\autospacing\autoxspacing#1}


% 図版アタリケイ引く／#1=幅, #2=高さ.
\def\Fig#1#2{%
\parbox[b]{#1}{%
\hbox to#1{\vtop to#2{\hsize#1\hrule\vss
\hbox to#1{\vrule height#2\hss\vrule height#2}%
\vss\hrule}}}}


% \displaystyle の省略形
\let\dis\displaystyle



\iffalse
% これらは見出しの再定義を行うときに用いる雛形です．
% \section以下の体裁の設定です．\@make<HEADING NAME>headが定義されてると
% それが<HEADING NAME>に対応する見出しの体裁として使われます．
% 対応する<HEADING NAME>の中を適時作成しプリアンブルなどで設定するか，
% この箇所だけ別ファイルにして好みの体裁をパターン化しておき
% \usepackageで切り替えるようなことをしてもよいです．
% #1: 見出しの字下げ量
% #2: 見出しの書体などの設定
% #3: 本文用見出しタイトル
% 以下は定義の見本です．デフォルトでは未定義としています．
% 必要に応じてプリアンブルなどで定義します．
\def\@make@section@head#1#2#3{%
\bgroup
       \noindent#2\hskip#1\relax
       \setbox\z@\hbox{\@svsec}%
       \@tempdima\linewidth\advance\@tempdima-\wd\z@
       \advance\@tempdima-#1\relax
       \setbox\tw@\hbox{#3}%
       \dp\z@\z@\copy\z@% ここが\thesectionの出力
          \ifdim\wd\tw@>\@tempdima%% タイトルが折り返す場合
               \vtop{\hsize=\@tempdima\@parboxrestore\unhbox\tw@\@@par}
               \par\noindent
          \else%% タイトルが折り返さない場合．
               \@inhibitglue\unhbox\tw@
          \fi
       \advance\@tempdima\wd\z@
\egroup
}
\def\@make@subsection@head#1#2#3{%
\bgroup
       \noindent#2\hskip#1\relax
       \setbox\z@\hbox{\@svsec}%
       \@tempdima\linewidth\advance\@tempdima-\wd\z@
       \advance\@tempdima-#1\relax
       \setbox\tw@\hbox{#3}%
       \dp\z@\z@\copy\z@%
          \ifdim\wd\tw@>\@tempdima
               \vtop{\hsize=\@tempdima\@parboxrestore\unhbox\tw@\@@par}
               \par\noindent
          \else
               \@inhibitglue\unhbox\tw@
          \fi
       \advance\@tempdima\wd\z@
\egroup
}
\def\@make@subsubsection@head#1#2#3{%
\bgroup
       \noindent#2\hskip#1\relax
       \setbox\z@\hbox{\@svsec}%
       \@tempdima\linewidth\advance\@tempdima-\wd\z@
       \advance\@tempdima-#1\relax
       \setbox\tw@\hbox{#3}%
       \dp\z@\z@\copy\z@%
          \ifdim\wd\tw@>\@tempdima
               \vtop{\hsize=\@tempdima\@parboxrestore\unhbox\tw@\@@par}
               \par\noindent
          \else
               \@inhibitglue\unhbox\tw@
          \fi
       \advance\@tempdima\wd\z@
\egroup
}
\def\@make@paragraph@head#1#2#3{%
\bgroup
       \noindent#2\hskip#1\relax
       \setbox\z@\hbox{\@svsec}%
       \@tempdima\linewidth\advance\@tempdima-\wd\z@
       \advance\@tempdima-#1\relax
       \setbox\tw@\hbox{#3}%
       \dp\z@\z@\copy\z@%
          \ifdim\wd\tw@>\@tempdima
               \vtop{\hsize=\@tempdima\@parboxrestore\unhbox\tw@\@@par}
               \par\noindent
          \else
               \@inhibitglue\unhbox\tw@
          \fi
       \advance\@tempdima\wd\z@
\egroup
}
% Chapter Headの再定義用
% デフォルトは各定義を\makeschapterheadを\letしている．
% 索引
\def\@make@index@chapterhead#1{{\parindent\z@
\toplinebox{10}{\vskip2\normalbaselineskip
     \centering\KBchapterfont\@inhibitglue#1\par\vfill}%
   }}
% 目次
\def\@make@toc@chapterhead#1{{\parindent\z@
\toplinebox{10}{\vskip2\normalbaselineskip
     \centering\KBchapterfont\@inhibitglue#1\par\vfill}%
   }}
% 参考文献
\def\@make@bib@chapterhead#1{{\parindent\z@
\toplinebox{10}{\vskip2\normalbaselineskip
     \centering\KBchapterfont\@inhibitglue#1\par\vfill}%
   }}
% 付録
% デフォルトは\makechapterheadを\letしている．
\def\@make@appendix@chapterhead#1{{\parindent\z@%
\toplinebox{10}{\vskip2\normalbaselineskip% 10行取りにしています．
   \KBchapternumfont
   \ifnum \c@secnumdepth >\m@ne
     \setlength\@tempdima{\linewidth}%
    \if@mainmatter
      \@chapapp\thechapter\@chappos
     \else
      \hbox{}
    \fi
     \vspace{.9\Cvs}\par
     \KBchapterfont\@inhibitglue#1\par\vfill\fi}}%
}
\fi

% ``の禁則追加
\def\KB@T@enc{T1}
\def\KB@OT@enc{OT1}
\AtBeginDocument{\ifx\f@encoding\KB@T@enc
	\postbreakpenalty16=10000 %%% for T1
	\fi\ifx\f@encoding\KB@OT@enc
	\postbreakpenalty92=10000 %%% for OT1
\fi}


% デバッグ用設定
%\errorcontextlines=9
%\tracingoutput=2
%\showboxdepth=100
%\showboxbreadth=100
% EOF


%%%%%%%%%%%%%%%%%
%% OT1/cmss/sbc/nを
%% <->[\@jescale]cmssdc10，
%% OT/cmss/bx/nを
%% <->[\@jescale]cmssbx10としてまとめた
%
%% 2014/07/17 emathパッケージを使った場合list内で行頭処理がうまく行かない
%% ため，\@itemの定義を修正して，これを\AtBeginDocumentとした．
%% 2014/01/07 トンボ領域に通しノンブル．[lastpage]で印字
%% 2013/12/16 kbdbook5.1
%% hyerrefが通らないことが判明したため対応．
%% hyperrefパッケージを使う場合はクラスオプションでusehyperrefを指定する．
%% その場合
%   \section[TOC](HEADER){NAME}
%% の形式との併用は困難なため，usehyperref指定時は使えなくした．
%% 2013/10/17 kbdbook5
% newtheorem環境で作られる環境での\itをキャンセルのため
% \@begintheoremを再定義	
%
% platex 2013.1.4での改定に伴い
% \@makefnmarkの定義の先頭に\nullを追加した
% フロートのパラメータを変更．全体的に少し詰めた
% ``の禁則処理追加
% クラスオプションに2004, uplatex, rimを追加
% 2004 = 2000 <--> 2004字体へ切り替え
% uplatex へ対応
% rml = 本文割当て \mcfamily= リュウミンライト（，と．を太ミンに割当て）
%                  \gtfamily= 中ゴシックBBB 
% 2013/07/01
% 試験的に\lineskiplimit2.5pt\lineskip5ptとしてみている．
% 2012/08/16
% \captionが空でも図番号が左右中央になるようにした．
% 2012/07/24
% verbatim環境で和欧文の４分アキが起こらないように修正．
% \ttfamily(cmtt)のサイズをだいたい和文の半分のサイズになるように修正．
% あわせて，verbatim環境での和欧文間のアキを0とした．ただし，和文約物処理はそのまま．クラスオプションでnottscaleとすると通常設定になる．
% 2012/03/26
% \rubysepを設ける（ルビ文字と親文字のアキ用のskipレジスタ：初期値は0）
% \footnoteの後続文字判定対象に半角の"."と","を追加
% プリアンブルでの\PreSecCntNameと\PostSecCntNameが目次に反映されないbugを修正
% 再定義用Chapter Head
%	\@make@index@chapterhead
%	\@make@toc@chapterhead
%	\@make@bib@chapterhead
%	\@make@appendix@chapterhead
%	を導入
% \@enablejfamtrueでの数式中の和文ファミリをmc，gtから
%	\mcdefaultと\gtdefaultに変更．
% 本文側脚注マークの後続文字が閉じの約物の場合unskipする処理対象を追加
% 表組み関連で大幅な改編を行う．
%	arrayパッケージとmultirowパッケージをデフォルトで読むようにした．
%	よって，指定子mとb，<{}，>{}，!{}と，\multirowが使える．
% 	\arrayrulewidthのデフォルトを表罫（0.12mm）とした．
% 	中太罫（0.25mm罫）の縦罫指定子に v を追加した．
%	中太罫の横罫線指定に\Hlineと\Cline{}を追加した．
% 	表の列間隔（\tabcolsep）をそのフォントサイズ時点での2分となるようにした．
% \fboxruleを.12mmへ変更
% \sMathSizesでの添字の指定の一部で数値だったものを
% 	\defaultscriptratioと\defaultscriptscriptratioへ指定変更
% 	\@sectの#9の\@@parの直前に\normalsize追加
% enumerate環境を改造．
% \Descriptionfontを追加
% 	Description環境の引数をオプション付に変更
% 	引数は[]形式に、初期値を2zwとした。
% float環境[h]指定での前後のアキ補正. TeX Wiki 53958
% emathBkパッケージのEMbreakbox環境使用時独立数式行のアミが
% 	おかしくなるための暫定補正をクラスファイル側でする．
%	本質的な補正が必要．
% \headsepの値を変更4->5mm
% 各版面の設定を詰める！！【TODO】
% amsthmとtheremパッケージの補正が途中【TODO】
% \sec@top@gapをfalseへ！ sectionで不具合のため-> \ifsectiontopmarginへ変更
% 本文側脚注マークの後続文字とのアキが反映されていなかったバグを修正
% 以下の\xpcodeと\inhibitxspcodeを追加. 
% 	またT1Encoding用の\xpscodeを設定．
% 	\xspcode37=3% \%
% 	\xspcode`:=2% :
% 	\xspcode`!=2% !
% 	\inhibitxspcode`℃=1
% 	\inhibitxspcode`°=0
%  amsmath使用時に\allowdisplaybreaksを使う．
% 	\@ifundefined{allowdisplaybreaks}{}{\allowdisplaybreaks}
% T1encodingのcmフォントをサイズ補正
% この版から添え字の大きさを変更しているので注意．
% 	\def\default@tiny@scriptratio{.9}
% 	\def\default@tiny@scriptscriptratio{.85}
% 	から
% 	\def\default@tiny@scriptratio{.75}
% 	\def\default@tiny@scriptscriptratio{.55}
% 	へ変更している．
% ルビマクロを\AtBeginDocumentで定義した．
%%%%%%%%%
% jbook.clsを元に作成したが，最近のjsbook.clsでのコード，各文献，TeX Wikiなどで示された有益なコードを使わせていただいている．これにより和文横組に関してjbook.clsより洗練されたものになっている．
% 
% ＊本クラスファイルは縦組での使用は想定していない．よって縦組み時に対する措置は一切施していない．
% 
% 文字組関係
% ・"\textbf{漢字}abc""などのような場合でも和欧文間でアキをつくるようにした．
%  \textsfと\textttも和文がゴシックになるので後続文字に欧文が来た場合も同様
% ・全角括弧の閉じ`）'と\footnoteでのアキを補正
%  例："（全角括弧）\footnote" や"\textbf{（全角括弧）}\footnote"での
%  	`）'の後に余計なアキができないようした．
% ・jsシリーズを模倣し，約物の行頭処理を追加してる．
% 節見出し関係
% ・\section以下が頁上部に来たときにアキを設けるようにした．
%       普通にしたければ\sec@top@gapfalseとする．-> コマンド名を\ifsectiontopmarginへ変更
% ・同一頁に2つ以上の\sectionがある場合，最後のものが柱へ反映されるようにした．
% ・「LaTeX2eポケットリファレンス」の\sectionや\subsectionなど
%    \make<SECTION NAME>headでの見出し体裁変更方法を導入した．
%    (\section以下，\paraguraphまでの体裁を調整できる．
%    ファイル最後に定義のサンプルを置いた)
%      # このサンプルを参考に手を加えた後，別ファイルにでもして，
%      # \usepackageで読ませて運用しても良い．
% ・\sectionなどの節番号に前置きと後置き指定するマクロ，
%   \PreSecCntNameと\PostSecCntNameを新設(吉永徹美氏例示マクロを参考)
%     第一引数に見出しの名称，第二引数に置きたい文字を指定するようになっている
%     \PreSecCntNameが`seccnt'の前
%     \PostSecCntNameが`seccnt'の後
%   例：
%     \PreSecCntName{section}{第}
%     \PostSecCntName{section}{節}
%     \PreSecCntName{subsection}{第}
%     \PostSecCntName{subsection}{項}
%     \PreSecCntName{subsubsection}{第}
%     \PostSecCntName{subparagraph}{目}
%   上記の変更を`目次'，`柱'に個別反映させるために分岐を設置．
%        * \seccntfixHeadfalseで柱に反映しない
%        * \seccntfixTocfalseで目次に反映しない．
%    とした．（デフォルトでは反映する）
% ・見出し語句を目次，柱に抜き出す際に異なる指定ができるように
%   \section[TOC]<HEADER>{NAME}
% 	\sectionでの目次,柱の個別指定
% 	\section[TOC]{NAME}		デフォルトと同じ（目次，柱共用）
% 	\section[TOC]<HEAD>{NAME}	"[]"に目次，"<>"に柱用の語句を設定
% 	\section<HEAD>{NAME}		目次は"{NAME}"の内容，"<>"で柱用の語句
%                                       を設定（本田知亮氏例示を参考）
% ・行取りと前後のアキを制御するために，\KBheadinggapを新設
%   \KBheadinggap[上下shift量]{heading name}{行取数}
% その他
% ・type1cm.styを読み込んだ場合，Warningを表示するようにした．
% ・版面と本文サイズなど基本体裁をoptionで指定できるようにした．
% ・multicol.styが使われていれば索引でmulticols環境が使われるようにした．
% ・\@inhibitglueと\@footnotetextをjsbookより転用．
%   \@inhibitglueで「本文」「柱」「footnote」「見出し」，
%   \parbox，minipage環境での約物行頭処理を追加
%   \footnote内で\verbが使えるようにした．
% ・intlinemath環境＝独立行数式を行の整数倍の高さのボックスに入れなおして行取の高さを揃える．ただしページは跨げない．
% ・Description環境＝\itemの字下げ幅を指定するリスト環境
% ・\begin{Description}{2zw}\item[]TEXT\end{Description}
% 表組み関係
% arrayパッケージを標準で読むようにした．
% デフォルトの罫線を0.12mmに変更し，\Hlineと\Clineで0.25mm（中太罫）が指定可能
% 列間隔はその時点での0.5zwとなる．これは\selectfontの発行で有効になる．
% オプション
% notombow=用紙の四隅に仕上がりを示す罫線（トンボ）を印字させません．
%         *初期値は印字
% mentuke=トンボの罫幅を0にします．面付け位置をたもったままにすることが目的
% openright=章を奇数ページにします．
% openany=章を偶数ページからでも起こせるようにします．
% leqno=数式番号を左端に置きます．
% fleqn=独立数式を本文左右中央ではなく左端の決まった位置から始めます．
% gtsf=基本的なパーツが\sffamily+\gtfamilyになります．
% outputpaperset=PDF用の用紙設定の\specialを埋め込みます．
% min10=和文tfmにmin10.tfmをロードします．デフォルトはjis.tfm  4.4で廃止
% a5 = 判型をA5判にし，normalsizeを13Qにします．
% a5/12Q=判型をA5判にし，normalsizeを12Qにします．
% a5/13.5Q=判型をA5判にし，normalsizeを13.5Qにします．
% b5=判型をB5判にし，normalsizeを13Qにします．
% b5/13.5Q=判型をB5判にし，normalsizeを13.5Qにします．
% b5/12Q=判型をB5判にし，normalsizeを12Qにします．
% b5var/13Q=判型をB5判にし，normalsizeを13Qにします．
% b5var/13.5Q=判型をB5変形にします．
% b5var/12Q=判型をB5変形にします．
% 
% \ExecuteOptions{a5,twoside,onecolumn,final,openright}
% \fi
