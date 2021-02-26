# lab1

## 1 design

- **标识符**

```
letter      [a-zA-Z]
ID          {letter}+
```

- **整型常量**

```
digit       [0-9]
NUM         {digit}+
```

- **letter**

  没有必要匹配letter，所有能匹配letter的输入都能匹配ID.
  
- **注释**

  最初参考了习题集2.6的思路，虽然可以匹配注释，但是写出来的pattern无法处理lines变量的增减。

1. **初始**版本

```
star	\*
other 	[^\*]
other1	[^\*\/]
comment	\/\*{other}*({star}+{other1}{other}*)*{star}+\/
```

2. **最终**版

   设置了一个状态变量cmFlag。有0，1，2三个状态。
   在检测到`/*`的时候cmFlag置0，然后使用`input()`函数循环读入下一个字符，若读入一个`*`则将cmFlag置1，连续读到`*`则维持cmFlag=1不变，中途遇到其他字符将cmFlag复位为0. 只有在状态为1的情况下读入`/`才将cmFlag=2. 状态到达2时退出循环。

```c
\/\*        {   //cmFlag is the state varible, handle all kinds of comments
                cmFlag = 0;
                pos_end += strlen(yytext);
                char c;
                do {
                    c = input();
                    pos_end++;
                    if (c == '\n') {
                        pos_end = 1;
                        lines++;
                    }
                    if (cmFlag == 0 && c == '*') cmFlag = 1;
                    else if (cmFlag == 1 && c == '*') cmFlag = 1;
                    else if (cmFlag == 1 && c == '/') cmFlag = 2;
                    else cmFlag = 0;
                } while (cmFlag != 2);
                return COMMENT;
            }
```

> ref: [flex_manual](http://dinosaur.compilertools.net/flex/manpage.html)
>
>  -      input( ) 函数
> 	 -      reads the next  character from  the  input  stream.

- **TESTCASE**
  - 开始为了先让程序跑起来， 设置了不含注释的`tryNoComments.cminus`的测试案例
  - 与`gcd.cminus`match之后设置了`multiline_comments.cminus`和`cm-inside-expr`分别测试多行注释的`lines`变化和行内注释的pos_end变化
  - `ID-NUM.cminus`, `keywords.cminus`, `special-chars.cminus`只是用来测试gcd中没有出现的其他字符。代码本身完全不符合语法，只是为了写tokens或者目测正确性方便。
  - `bookP496-A3`来自**Compiler Construction**的附录。用来和同学对比了一下tokens输出。

## 2 problems & solutions

- 读目录文件操作不会，阅读`readdir()`文档解决。
- 一开始完全没有理解`yylex()`函数的运作机制。写actions的时候采用了`else	{token = ESLE; }`的做法，虽然编译没有报错但是文件完全没有输出。
- 以为是文件操作问题，把fprintf改成printf后依然毫无反应，翻了文档才发现理解错误，改成return值就好了。
- 注释的处理参考了flex manual上给的循环处理字符匹配c注释的方式，增加了状态变量并处理换行。

## 3 analyze

​	对不了解的部分如flex和c minus语言主要采用阅读manual和examples加深理解再处理问题方式，一些字符串处理，文件处理上的问题人工模拟解决: )。写testcase基本就偷懒了，尝试了一下各种输出没有在乎语法。

## 4 time 

周二晚上了解了flex和 c minus `2h?`

实际从周三下午开始搞，写到编译完成但是结果不对差不多到了晚饭时间（中途学习了文件操作复习了字符串处理库函数等）`3h?`

然后中途出去听了ngs的宣讲回来接着debug，到gcd.minus的tokens match就可以睡觉了。`3h?`

星期四上午各种check写testcase加写doc。`2h？`

大概 `10h`吧（包括摸鱼时间），比较废柴。。。