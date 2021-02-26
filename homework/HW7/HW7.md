#  HW7

### 4.6b

> 下列文法产生由+作用于整常数或实常数的表达式. 两个整数相加时,结果是整型, 否则是实型.
>
> ```
> E -> E + T | T
> T -> num.num | num
> ```
>
> (b) 扩充(a)的语法制导定义, 既决定类型, 又把表达式翻译成后缀表示. 使用一元算符**inttoreal**把整数变成等价的实数, 使得后缀式中+的两个对象有同样的类型.

**(b)**

```c
E -> E1 + T 			if(E1.type == real && T.type == int) 
	                       {E.type = real; print(T.lexeme); print('inttoreal')}
				else if (E1.type == int && T.type == real) 
                                {E.type = real; print('inttoreal'); print(T.lexeme)}
				else {E.type = E1.type; print(T.lexeme)}
			        print('+')
E -> T				E.type = T.type; print(T.lexeme)
T -> num.num		       T.type = real; T.lexeme = num.num.lexeme
T -> num 			T.type = int; T.lexeme = num.lexeme;

```



### 4.11

> 由下列文法产生的表达式包括赋值表达式
>
> ```
> S -> E
> E -> E=E | E+E | (E) | id
> ```
>
> 表达式的语义和C语言的一样, 即b=c是把c的值赋给b的赋值表达式,而且a=(b=c)把c的值赋给b,然后再赋给a. 构造一个语法制导定义,它检查赋值表达式的左部是否为左值.

综合属性val表示E是否是左值表达式,其取值可以是lvalue和rvalue,分别表示左值、右值

```c
S -> E
E -> E1 = E2						if(E1.val == rvalue) print("error"); E.val = rvalue
E -> E1 + E2						E.val = rvalue
E -> (E1)						E.val = E1.val
E -> id							E.val = lvalue
```



### 4.14b

> 程序的文法如下:
>
> ```
> P -> D
> D -> D;D | id : T | proc id;D;S
> ```
>
> (b)写一个翻译方案,打印该程序每个变量id的嵌套深度.

```c
P -> {D.l = 1;} D
D -> {D1.l = D.l;}D1; {D2.l = D.l;} D2
D -> id : T {print(id.name, D.l);}
D -> proc id; {D1.l = D.l+1;} D1; S
```

