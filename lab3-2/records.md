# 团队工作记录

记录团队的学习过程和讨论过程，

## 学习过程

描述队长如何安排成员进行学习工作，并描述完成情况

## 讨论1

时间：12月1日 15时到17时
地点：西区图书馆
参与者：小组全体人员
主题：Kick off session

初步讨论该试验的具体事项，阅读讨论关于Pass的文档。

经过讨论，我们自主了解了上课没有提到的尾递归，计划对他进行实验。

### TRE

* `static bool canTRE(Function &F)` 中有一行注释： 

  * 该函数用于检测有没有动态分配内存

  ```c
  // Because of PR962, we don't TRE dynamic allocas.
  ```

* http://lists.llvm.org/pipermail/llvm-commits/Week-of-Mon-20160530/361707.html 里有记录

* ```
  FIXME: The code generator produces really bad code when an 'escaping
  -  // alloca' is changed from being a static alloca to being a dynamic alloca.
  -  // Until this is resolved, disable this transformation if that would ever
  -  // happen.  This bug is PR962.
  ```

* 设计了简单的测试案例：递归求阶乘
  * 一开始直接在测试的程序中求10！，因为太大溢出了

[讨论的照片或截图]

### 过程描述


### 结论

