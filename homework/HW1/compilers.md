# compilers

PB17071401 吴舜钰

## 1. GNU Compiler Collection

指一套编程语言编译器，以GPL及LGPL许可证所发行的自由软件，也是GNU计划的关键部分，也是GNU工具链主要组成部分之一。

#### 适用语言

- C（GCC, 带GNU扩展）
- C++ (G++, 带GNU扩展)
- Ada （GNAT)
- Fortran (Fortran 77: G77, Fortran 90: GFORTRAN)
- JAVA (编译器：GCJ; 解释器：GIJ)
- Objective-C (GOBJC)
- Go
- 前端
  - Modula-2
  - Modula-3
  - Pascal
  - PL/I
  - D语言
  - Mercury
  - VHDL
- 内嵌OpenMP支持——跨语言的对称多处理机多线程并行程序编程工具

#### 出现时间

初始版本：1987年5月23日

#### 代表人物

- Richard Stallman
- Len Tower

#### 发展历史

GCC是由Richard Stallman在在1985年开始的。他首先扩增一个旧有的编译器，使它能编译C，这个编译器一开始是以Pastel语言所写的。Pastel是一个不可移植的Pascal语言特殊版，这个编译器也只能编译Pastel语言。为了让自由软体有一个编译器，后来此编译器由斯托曼和Len Tower在1987年以C语言重写并成为GNU专案的编译器。GCC的建立者由自由软体基金会直接管理。

在1997年，一群不满GCC缓慢且封闭的创作环境者，组织了一个名为EGCS (Experimental / 
Enhanced GNU Compiler System)的专案，此专案汇整了数项实验性的分支进入某个GCC专案的分支中。EGCS比起GCC的建构环境更有活力，且EGCS最终也在1999年四月成为GCC的官方版本。

GCC目前由世界各地不同的数个程式设计师小组维护。它是移植到最多中央处理器架构以及最多操作系统的编译器。

#### 其他

1. 操作系统: 跨平台
2. 许可协议：GNU通用公共许可证
3. 网站：gcc.gnu.org
4. 对比： 见后

## 2. LLVM

LLVM是一个自由软体专案，它是一种编译器基础设施，以C++写成，包含一系列模块化的编译器组件和工具链，用来开发编译器前端和后端。它是为了任意一种程式语言而写成的程式，利用虚拟技术创造出编译时期、链结时期、执行时期以及“闲置时期”的最佳化。

#### 适用语言

最早以C/C++为实作对象，而目前它已支援包括ActionScript、Ada、D语言、Fortran、GLSL、Haskell、Java字节码、Objective-C、Swift、Python、Ruby、Rust、Scala以及C#等语言。

####  出现时间

初始版本：2003年

#### 代表人物

- Chris Lattner： 2000年，本科毕业的Chris Lattner像中国多数大学生一样，按部就班地考了GRE，最终前往UIUC（伊利诺伊大学厄巴纳香槟分校），开始了艰苦读计算机硕士和博士的生涯。在这阶段，他不仅周游美国各大景点，更是努力学习科学文化知识，翻烂了“龙书”（《Compilers: Principles, Techniques, and Tools》），成了GPA牛人【注：最终学分积4.0满分】，以及不断地研究探索关于编译器的未知领域，发表了一篇又一篇的论文，是中国传统观念里的“三好学生”。他的硕士毕业论文提出了一套完整的在编译时、链接时、运行时甚至是在闲置时优化程序的编译思想，直接奠定了LLVM的基础。LLVM在他念博士时更加成熟，使用GCC作为前端来对用户程序进行语义分析产生IF（Intermidiate Format），然后LLVM使用分析结果完成代码优化和生成。这项研究让他在2005年毕业时，成为小有名气的编译器专家，他也因此早早地被Apple相中，成为其编译器项目的骨干
- Vikram Adve

#### 发展历史

LLVM专案的发展起源于2000年伊利诺伊大学厄巴纳-香槟分校维克拉姆·艾夫（Vikram Adve）与克里斯·拉特纳（Chris Lattner）的研究，他们想要为所有静态及动态语言创造出动态的编译技术。LLVM是以BSD授权来发展的开源软体。2005年，苹果电脑雇用了克里斯·拉特纳及他的团队为苹果电脑开发应用程式系统，LLVM为现今Mac OS X及iOS开发工具的一部分。

Apple已经将它用在OpenCL的流水线优化，Xcode已经能使用llvm-gcc编译代码。

2011-12-02 LLVM3.0发布，LLVM包括了一系列子项目，它们也同步发布了新版本，如C/C++/Objective-C前端Clang 3.0改进了C++程序编译支持；改进C++ 2011标准支持；实现支持即将发布的C1x标准的某些特性；更快的生成代码，更快的编译，等等。

LLVM荣获2012年ACM软件系统奖

#### 其他

1. 操作系统: 跨平台
2. 许可协议： 伊利诺伊大学厄巴纳-香槟分校开源代码许可
3. 网站：llvm.org
4. 对比：见后

## 3. Clang

Clang是一个C、C++、Objective-C和Objective C++程序设计语言的编译器前端。它採用了LLVM作为其后端，而且由LLVM2.6开始，一起放出新版本。它的目标是提供一个GNU编译器套装（GCC）的替代品，支援了GNU编译器大多数的编译设定以及非官方语言的扩充功能。作者是克里斯·拉特纳（Chris Lattner），在苹果公司的赞助支持下进行开发，而原始码授权是使用类BSD的伊利诺伊大学厄巴纳-香槟分校开源码许可。

Clang专案包括Clang前端和Clang静态分析器等。

#### 适用语言

只支持C-like languages， 如C, C++, Objective-C, Objective-C++, OpenCL, 和CUDA.

#### 出现时间

初始版本：2007年9月26日

#### 代表人物

不明，苹果公司赞助开发

#### 发展历史

Apple吸收Chris Lattner的目的要比改进GCC代码优化宏大得多——GCC系统庞大而笨重，而Apple大量使用的Objective-C在GCC中优先级很低。此外GCC作为一个纯粹的编译系统，与IDE配合得很差。加之许可证方面的要求，Apple无法使用LLVM 继续改进GCC的代码质量。于是，Apple决定从零开始写 C、C++、Objective-C语言的前端 Clang，完全替代掉GCC。

正像名字所写的那样，Clang只支持C，C++和Objective-C三种C家族语言。2007年开始开发，C编译器最早完成，而由于Objective-C相对简单，只是C语言的一个简单扩展，很多情况下甚至可以等价地改写为C语言对Objective-C运行库的函数调用，因此在2009年时，已经完全可以用于生产环境。C++的支持也热火朝天地进行着。

#### 其他

1. 操作系统: Unix-like
2. 许可协议： 伊利诺伊大学厄巴纳-香槟分校开源代码许可
3. 网站：https://clang.llvm.org
4. 对比：见后

## GCC/LLVM/Clang 编译器对比

- GCC **VS** LLVM
  - GCC(GNU Compiler Collection，GNU编译器集合)是一个优秀的编译器 ,但是它跟IDE之间的互操作性不够好，编译器分为编译器前端和编译器后端，前端主要负责展开预处理器宏定义并将原代码转换成中间代码，而后端编译器主要负责生成和优化机器代码，GCC严格来说是一个后端编译器，GCC采用的是GPL许可协议，这使得苹果不能直接使用GCC代码，所以有时会导致解析的代码与GCC代码不一致，由于这种种原因促使了LLVM(Low Level Virtual Machine)的诞生
  - 虽然LLVM的代码生成效率不如GCC，但是LLVM有着更好的模块化和可扩展性，编译的速度是GCC的两倍，有许多为LLVM而开发的编译器前端，其中一个就是Clang，Clang支持增量编译，可以近乎实时的提示编译错误，对于开发者而言好处不言而喻

![gcc-llvm](https://img2018.cnblogs.com/blog/737711/201902/737711-20190219162739930-1535808132.png)

​									（GCC、LLVM-GCC、LLVM Compiler编译器选项不同点）

- GCC **VS** Clang
  - 与gcc相比clang具有如下优势
    - 编译速度更快：在某些平台上，clang 的编译速度要明显快于gcc。
    - 占用内存更小：clang生成的AST所占用的内存通常是gcc的五分之一左右。
    - 模块化的设计：clang采用基于库的模块化设计，更易于IDE的集成及其他用途的重用。
    - 诊断信息可读性强：在编译过程中，clang会创建并保留大量详细的元数据 (metadata)，这将更有利于调试和错误报告。
    - 设计更清晰简单，容易理解，易于扩展加强。与代码基础较为古老的gcc相比，学习曲线会显得更为平缓。
  - 与gcc相比clang的不足
    - 需要支持更多语言：gcc除了支持 C/C++/Objective-C, 还支持Fortran/Pascal/Java/Ada/Go等其他语言。clang目前基本上只支持C/C++/Objective-C/Objective-C++这四种语言。
    - 需要加强对C++的支持：clang对C++的支持依然落后于gcc，clang还需要加强对C++ 提供全方位支持。
    - 需要支持更多平台：由于gcc流行的时间比较长，已经被广泛使用，对各种平台的支持也很完备。clang目前支持的平台有 Linux/Windows/Mac OS。

## 4.  GCJ

GCJ是一款Java编程语言的自由软件编译器，它也是GNU编译器套件的一部分。

GCJ可以将Java源代码编译成Java虚拟机字节码或直接编译成多种CPU体系结构上的机器码。它还能将包含字节码的Java class文件或包含多个Java class文件的JAR归档文件编译成机器码。

#### 适用语言

JAVA

#### 出现时间

1998年9月6日

#### 发展历史

GCJ运行时库原始源来自GNU Classpath项目，但libgcj库之间存在代码差异。 GCJ 4.3使用Eclipse Compiler for Java作为前端。

2007年，在GNU Classpath：AWT和Swing中实现了对Java两个图形API的支持，已经做了很多工作。 AWT的软件支持仍在开发中。 “一旦AWT支持正在运行，就可以考虑Swing支持。至少有一个可用的Swing自由软件部分实现。”。GNU CLASSPATH从未完成甚至Java 1.2状态，现在似乎已完全放弃。

截至2015年，GCJ没有宣布新的开发项目，产品处于维护模式。 GCJ于2016年9月30日从GCC主干中删除。随着海湾合作委员会第7.1条的发布而撤销该公告，该公告不包含该公告。[12] GCJ仍然是GCC 6的一部分。

#### 其他

1. 操作系统： Unix-like
2. 许可协议：GNU GPL
3. 网站：gcc.gnu.org

## 5. javac

The Java Programming Language Compiler

**javac**是收录于JDK中的Java语言编译器。该工具可以将后缀名为.java的源文件编译为后缀名为.class的可以运行于Java虚拟机的字节码。

#### 适用语言

java

#### 出现时间

2006年11月13日、

#### 开发者

Sun Microsystems，创建于1982年2月24日，后于2009年被甲骨文公司收购。

#### 发展历史

2006年11月13日，Sun的HotSpot Java虚拟机（JVM）和Java开发工具包（JDK）根据GPL许可证提供。从版本0.95开始，GNU Classpath（Java类库的免费实现）支持使用Classpath运行时编译和运行javac  -  GNU Interpreter for Java（GIJ） - 和编译器 -  GNU Compiler for Java（GCJ） - 并且还允许一个使用javac本身编译GNU Classpath类库，工具和示例。

#### 其他

1. 操作系统： 跨平台
2. 许可协议： GPL
3. 网站： www.oracle.com/technetwork/java/javase/downloads/index.html

## 6.  Free Pascal

Free Pascal（全称 FPK Pascal）是一个32位和64位专业Pascal编译器。它可以在多个处理器架构中运行：Intel x86，AMD64/x86-64，PowerPC32/64， SPARC和 ARM。它支持的操作系统有Linux，FreeBSD，Haiku，Mac OS X/ iOS/Darwin，DOS，Windows32/64/CE，OS/2，MorphOS，Nintendo GBA，Nintendo DS和 Nintendo Wii。另外，在JVM，MIPS 和 Motorola 68k处理器架构或操作系统中使用的Free Pascal正在研发开发版本。

#### 适用语言

Pascal

#### 出现时间

1997年

#### 代表人物

-  Florian Paul Klämpfl
-  Michael van Canneyt
- Daniël Mantione

#### 发展历史

- Early years
  Free Pascal是在Borland明确表示用于DOS的Borland Pascal开发将停止使用版本7时被创建的，而后者将被一个仅限Windows的产品取代，该产品后来成为Delphi。学生FlorianPaulKlämpfl开始开发自己用Turbo Pascal方言编写的编译器，并为GO32v1 DOS扩展器生成32位代码，该扩展器由当时DJ的GNU编程平台（DJGPP）项目使用和开发。最初，编译器是由Turbo Pascal编译的16位DOS可执行文件。两年后，编译器能够自行编译并成为32位可执行文件。

- 扩张
  最初的32位编译器已在Internet上发布，第一批贡献者加入了该项目。后来，一个Linux端口由Michael van Canneyt创建，距离Borland Kylix编译器可用的五年前。DOS端口适用于OS / 2，使用Eberhard Mattes eXtender（EMX），使OS / 2成为第二个支持的编译目标。与原作者FlorianKlämpfl一样，DaniëlMantione也为实现这一目标做出了重大贡献，为OS / 2和EMX提供了运行时库的原始端口。编译器逐渐改进，DOS版本迁移到GO32v2扩展器。最终发布的版本为0.99.5，比以前的版本使用得更广泛，并且是最后一个版本，仅针对Turbo Pascal合规性;后来的版本增加了Delphi兼容模式。此版本还移植到使用Motorola 68000系列（m68k）处理器的系统。随着版本0.99.8的推出，Win32目标被添加，并开始结合一些Delphi功能。开始稳定非beta版本，并且版本1.0于2000年7月发布.1.0.x系列广泛用于商业和教育。对于1.0.x版本，重做了68k CPU的端口，编译器为几个68k类Unix和AmigaOS操作系统生成了稳定的代码。
- 后续逐渐推出了Version 2/2.2.x/2.4.x/2.6.x/3.0.x, 最近的版本是2017年11月28日发布的Version3.0.4

#### 其他

1. 操作系统: 跨平台
2. 许可协议：GPL
3. 网址：www.freepascal.org



## 7. Turbo Pascal

Turbo Pascal是一个软件开发系统，包括编译器和用于在CP / M，CP / M-86和DOS上运行的Pascal编程语言的集成开发环境（IDE）。 它最初由Anders Hejlsberg在Borland开发，并以其极快的编译时间而着称。 Turbo Pascal和后来类似的Turbo C使Borland成为基于PC的开发领域的领导者。

#### 适用语言

Pascal

#### 出现时间

1983

#### 代表人物

​	Anders Hejlsberg 

#### 发展历史

Turbo Pascal编译器基于最初由Anders Hejlsberg于1981年为Nascom微机的NasSys盒式操作系统生成的Blue Label Pascal编译器。 Borland授权Hejlsberg的“PolyPascal”编译器核心（Poly Data是Hejlsberg在丹麦的公司名称），并添加了用户界面和编辑器。 Anders Hejlsberg作为一名员工加入公司，是所有版本的Turbo Pascal编译器和Borland Delphi的前三个版本的架构师。

编译器最初作为CP / M的Compas Pascal发布，然后于1983年11月20日发布为CP / M的Turbo Pascal（包括配备Z-80 SoftCard的Apple II计算机，有效地转换基于6502的Apple进入CP / M机器，带有CP / M墨盒的Commodore 64，以及后来的DEC Rainbow），CP / M-86和DOS机器。在美国市场推出时，Turbo Pascal零售价为49.99美元，当时编译器价格非常低廉。与当时其他Pascal产品相比，集成的Pascal编译器质量很好。

#### 其他

1. 操作系统：CP/M, CP/M-86, DOS, Windows 3.x, Macintosh
2. 平台：8080/Z80, 8085,x86

## Free Pascal VS Turbo Pascal

虽然Free Pascal尽量设计得和Turbo Pascal接近，但是Free Pascal是一个32位的编译器，而Turbo Pascal只是16位编译器。Free Pascal是一个跨平台的编译器，而Turbo Pascal只在windows和DOS上使用。

如果你的代码遵守ANSI Pascal标准，那么将代码从Turbo Pascal移植到Free Pascal是没有问题的。下面是在Turbo Pascal上可以使用，但是在Free Pascal就不能使用的一些语言特性：

1. 函数和过程在使用时，参数的类型必须和定义时完全一致。原因是在Free Pascal中添加了函数重载功能（可以用完全相同的多个标识符定义多个函数，只要它们的参数不同，就是不同的函数；在没有此功能时，非整实型的实在参数可以与整形的形式参数赋值相容）；
2. Protected、Public、Published、Try、Finally、Except、Raise成了关键字，不能作为标识符的名字；

3. Far、Near不再是关键字了，原因是Free Pascal是32位系统，不再需要这些关键字； 

4. 布尔表达式不一定要全部进行计算。只要最终结果已经能够确定，就不再计算其它还没有计算的部分了——比如布尔表达式exp1 and exp2 and exp3，如果已知exp1的结果是false，那么怎么表达式的结果肯定是false，exp2和exp3就不用进行计算了；

5. 在Free Pascal中，集合中的元素都是4个字节长的；

6. 表达式执行的顺序是不确定的。比如对于表达式a:=g(2)+f(3); 不保证g(2)一定在f(3)之前执行；

7. 如果用Rewrite打开文件，那么文件就只能被写入了。如果需要读取这个文件，要对文件执行Reset；

8. Free Pascal在程序结束之前一定要关闭输出文件，否则输出文件可能不能被正确的写入；

9. Free Pascal理论上可以使用4GB的内存，因此实际上几乎可以使用系统中的所有剩余内存（除非系统中有内存限制），这是由于Free Pascal是32位的编译器。但是对于Turbo Pascal来说，由于是16位的编译器，因此不能定义大小超过64KB的数据类型和变量，并且在DOS实模式下可以使用的内存总数只有640KB。

## 8.  Psyco

Psyco是一个专门的Python即时编译器，最初由Armin Rigo开发，由Christian Tismer进一步维护和开发。 发展于2011年12月停止.

#### 适用语言

Python

#### 出现时间

2007年12月16日

#### 代表人物

- Armin Rigo
- Christian Tismer

#### 发展历史

最初由Armin Rigo开发，由Christian Tismer进一步维护和开发。 发展于2011年12月停止。

虽然Tismer于2009年7月17日宣布该项工作正在Psyco的第二版上完成，另一项声明宣布该项目于2012年3月12日“未维护且已死亡”，并将参观者指向PyPy。与Psyco不同，PyPy包含一个解释器和一个可以生成C的编译器，从而提高了它与Psyco的跨平台兼容性。

#### 其他

1. 操作系统： 跨平台
2. 平台：32-bit和x86
3. 许可协议: MIT License
4. 网站：psyco.sourceforge.net

## 9. PyPy

PyPy是CPython的Python编程语言的另一种实现，它是Python的标准实现。 PyPy通常比CPython运行得更快，因为PyPy是一个即时编译器，而CPython是一个解释器。 大多数Python代码在PyPy上运行良好，除了依赖于CPython扩展的代码，这些扩展在PyPy中运行时不起作用或产生一些开销。 从功能上讲，PyPy是围绕称为元跟踪的技术设计的，它将解释器转换为跟踪即时编译器。 由于解释器通常比编译器更容易编写，但运行速度较慢，因此这种技术可以更容易地生成编程语言的高效实现。 PyPy的元跟踪工具链称为RPython。

#### 适用语言

Python

#### 出现时间

mid 2007

#### 发展历史

PyPy是Psyco项目的后续项目，该项目是由Armin Rigo在2002年至2010年间开发的即时专用Python编译器.PyPy的目标是拥有一个即时专业编译器，其范围不适用于Psyco。最初，RPython也可以编译成Java字节码，CIL和JavaScript，但由于缺乏兴趣，这些后端被删除了。

PyPy最初是一个面向研究和开发的项目。在2007年中期达到成熟的开发状态和官方1.0版本，其下一个重点是发布具有更多CPython兼容性的生产就绪版本。 PyPy的许多变化都是在编码冲刺期间进行的。

- 2008年8月，PyPy能够运行一些流行的Python库，如Pylons，Pyglet，Nevow和Django
- 2010年3月12日，PyPy 1.2发布，重点关注速度。它包括一个工作但不稳定的即时编译器。
- 2011年4月30日，PyPy 1.5版本发布，与CPython 2.7兼容。
- 2013年5月9日，PyPy 2.0发布，它为ARMv6和ARMv7 JIT上的JIT编译引入了alpha质量支持，并在标准库中包含了CFFI。
- 2014年6月20日，PyPy3被宣布稳定并引入了与更现代的Python 3的兼容性。它与PyPy 2.3.1一起发布并具有相同的版本号。
- 2017年3月21日，PyPy项目发布了PyPy和PyPy3的5.7版，后者为Python 3.5引入了beta版质量的支持。
- 2018年4月26日，6.0版本发布。

#### 其他

1. 操作系统： 跨平台
2. 许可协议: MIT License
3. 网站：pypy.org

## 10. Open64

Open64是一套针对Itanium 及 x86-64架构最佳化的编译器，它以GNU自由文档许可证所发行。Open64源自于一套SGI为MIPS R10000处理器所开发的编译器MIPSPro，它于2000年首次发行并命名为Pro64，隔年特拉华大学将其改名为Open64并为其把关。目前Open64经常作为编译器以及计算机系统结构研究领域的研究平台。Open64支援的语言包括C语言、C++及Fortran 77/95以及OpenMP，它可以进行高品质的跨行程最佳化及分析(interprocedural analysis)、数据流分析、资料相依性分析以及阵列区域分析；而支援的操作系统包括Linux及类Unix系统；Open64支援的处理器架构包括IA-32（x86）与x86-64、IA-64、龙芯（MIPS）及PowerPC。

#### 适用语言

C、C++、Fortran、OpenMP

#### 出现时间

2002

#### 开发者

硅谷图形公司,中国科学院计算技术研究所, 惠普公司, 特拉华大学

#### 发展历史

早在1980-1990年代，在美国就出现了多种优化图形计算（OpenGL）的程序运行效率的需求，在这种背景下，编译器技术获得了SGI等公司的重视，之后的许多年时间中，Pro64成为了这样一种生成高效率代码的编译工具。其针对新型芯片、新型计算模式、着力多核心优化、并行计算等领域的特点，使得Pro64在当时成为了高效计算的标杆。这也为后来Pro64的源代码开放造成了重大影响。 
1999年，SGI公布了他们的一个工业化的并行化优化编译器Pro64（TM）的源代码，后被全世界多个编译器研究小组用来做研究平台进行改进，并命名为Open64。Open64是一个拥有GNU通用公共许可证（GPL）的开源编译器，设计结构好，分析优化全面，是编译器高级研究的理想平台，被用在许多公司和大学的科研项目中。
Open64是一个Linux下的C/C++/Fortran90/95编译器，最初起源于SGI的MIPSpro编译器。SGI做了最初的移植工作，使之能够支持Itanium。2000年夏，SGI将MIPSpro编译的源代码公开，并命名为Pro64编译器。Pro64编译器基于GNU的C, C++前端，Cray-FORTRAN的F95前端，是Open64编译器的前身。
后来，由德拉华大学（UDel）负责Pro64编译器的维护工作，新版本的Pro64被重命名为Open64编译器，为各种机型作了移植。
2001年，Intel与中国科学院计算技术研究所（CAS-ICT）合作，对Open64编译器的CG部分进行了功能增强，使之对够针对Itanium进行高级并行优化。针对Itanium增强的Open64编译器称为ORC（Open Research Compiler），推动了学术界对Itanium及其相关领域的研究。后来ORC被合并到Open64的新版本中。
Pathscale实现了Open64编译器到x86-64的移植，并组建了开源编译器开发团队以进行进一步开发工作。Open64的新版本（4.0以上）支持IA32、IA64、X86-64等平台。
2012年初，Sourceforge 上的 Open64 已经停止更新，停止更新前最后的版本为5.0。

#### 其他

1. 最终版本： 2011年11月10日，5.0
2. 操作系统: 跨平台，linux
3. 许可协议：GNU GPL
4. 网站： sourceforge.net/projects/open64/

## 其他一些常见编译器对比（C/C++）

- ICC，没有自己专门的前端（传说中的外包），而且是针对Intel体系结构上专门优化，兼容性不好。
- MSVC，WIndows平台上最常用的编译器，在C++编译器圣战中的胜利者，一个常被人诟病的是对标准的支持不够新不够快（最近开始逐步加快了）。随着微软发布基于Clang / C2，这一条路以后若成功，MSVC与Clang / C2并行，甚至逐步逐步退出舞台，都是有可能的事情。
- BCC，Borland C++，曾经非常流行的C++编译器，然而在C++编译器圣战中失败了，后面也被Borland卖掉了，现在，还活着？
- IBM XL C++，前身是VisualAge C++，在IBM特定硬件与平台上表现非常牛逼，Benchmark性能测试非常优秀，其最初的设计思想就是为了性能，其最高优化级别可以达到O5，带来的反噬则是在编译时间上往往过长。而另外一个常被人诟病的是对C++标准的支持、开源软件的支持、错误信息的提示上都不够友好，然而从13.2开始，随着IBM采用Clang融合方案，目前这几项都得到有效改良，然而融合的道路也必定是漫长的，以前的历史包袱等也需要背上。
- 古董c++编译器：cint, watcom c++, visualage, symate c++, cfront...
- 开发首选
  - Windows： MSVC
  - linux：GCC/G++
  - macOS: Clang





