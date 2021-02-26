# lab3-1实验报告

小组成员     组长：李宇轩   PB17111560   组员：冷博洋   PB17111571   吴舜钰 

## 实验要求

本次实验中，我们需要使用LLVM将前序实验中得到的语法树翻译到正确的LLVM IR，通过助教提供的框架上正确实现一个C-minus语言的IR生成器 。在实验中要求阅读C-minus语义和框架介绍，了解C-minus语义以及部分扩充。在进行实验时要阅读关于LLVM IR的相关介绍，学习相关的LLVM IR的知识。

## 实验难点

在本次实验中，我们小组遇到了如下难点：

1.设计全局变量时遇到的挑战：由于需要编写的函数数目较多，在设计的时候要声明各种类型的全局变量，同时在后续debug过程中，要解决各种各样的debug需要声明新的全局变量，在全局变量上要花费一些时间同时在处理全局变量的时候也遇到了各种问题，例如判断当前处理到的变量声明语句位于函数内还是函数外；在用到全局变量时要丢到scope里去等等。

2.关于设计 selectio-stmt 遇到的挑战：我们小组在实验中关于 void CminusBuilder::visit(syntax_selection_stmt &node) 函数出现了问题。
在翻译过程中，我们在翻译if是出现问题，在执行if模块时，执行完 if.then 或者是 if.else 时要跳到 if.end ，但当if.end 可是生成的.ll文件里if.end之后没有代码，因为后面没有statement，此时会报错。

3.关于处理文法节点的继承关系遇到的挑战：在处理文法时每个节点都有不同的继承关系，有的节点在继承上要继承给多个不同的节点。所以在设计节点继承时，要考虑不同节点都要继承一个节点时如何根据不同的节点进行不同的节点处理。

4.关于处理数组时遇到的挑战：

## 实验设计

请写明为了顺利完成本次实验，加入了哪些亮点设计，并对这些设计进行解释。
可能的阐述方向有:

1. 如何设计全局变量

   设计一个标志变量`bool variable_not_in_functon`记录当前var-declaration是否在function作用域中，初始化为true, 进入函数scope就置false, 离开函数scope再置true。如果当前var-decl不在则说明当前声明的是一个全局变量。

   在`visit(syntax_var_declaration &node)`的中增加全局变量的处理。

   - 整型

     ```c++
     if (variable_not_in_function) { //global variable declaration
                auto Zero = llvm::ConstantInt::get(llvm::Type::getInt32Ty(context),0,true);
                auto global_var = new llvm::GlobalVariable(*(module.get()),llvm::Type::getInt32Ty(context),false,
                  llvm::GlobalValue::LinkageTypes::ExternalLinkage,Zero);
                scope.push(node.id, global_var);
             }
     ```

     其中 Zero是用来初始化的0常量。 

     使用`GlobalVariable`构造指向全局变量的值映射，再用`scope.push`将变量加入作用域。

   - 指针类型（数组声明）

     ```c++
     if (variable_not_in_function) { //global array declaration
                 llvm::ArrayType* arrayType = llvm::ArrayType::get(llvm::Type::getInt32Ty(context), node.num.get()->value);
                 auto zeroarr = llvm::ConstantAggregateZero::get(arrayType);
                 auto global_array = new llvm::GlobalVariable(*(module.get()),arrayType,false,
                  llvm::GlobalValue::LinkageTypes::ExternalLinkage, zeroarr);
                  scope.push(node.id, global_array);
             }
     ```

     先利用`ArrayType::get`获得指定长度的数组类型，再利用`ConstantAggregateZero`获得初始化常量。

     将上述常量传入`GlobalVariable`获得指向当前变量的指针，再将这个数组声明加入scope作用域。

   - flag处理

      ```c++
     bool variable_not_in_function = true;
     void CminusBuilder::visit(syntax_fun_declaration &node) 
     {
     	...
         llvm::Function* fun;
         ...
         scope.push(node.id, fun);
         scope.enter();
         //change variable_not_in_function flag value to false
         variable_not_in_function = false;
     	...
         builder.ClearInsertionPoint();
         scope.exit();
         //change variable_not_in_function flag value to true
         variable_not_in_function = true;
     }
     ```

     在`scope.push`和`scope.exit`前后处理。

     

2. 关于if has no terminator的问题

   处理if语句时使用了`thenBB`,`elseBB`,`endBB`三个Block。但是在某些if-stat或else-stat没有return的情况下可能会进入空的`endBB`， 而此时`endBB`中没有语句，从而没有terminator产生报错。

   我们组的解决方案是直接在每一个fun-decl中强制加入第二个return，根据函数的返回值类型，再返回一个整型或者返回一个空, 这样任何一个`endBB`之后一定会有一个新的returnBB, 也就避开了`endBB`空语句没有终结符的问题 。由于程序会在遇到第一个return时就返回，多加的return并不会影响程序结果。

   ```c++
   void CminusBuilder::visit(syntax_fun_declaration &node) 
   {
     	...
       if (node.type == TYPE_INT)
       {
           // in case if no terminator
           builder.CreateRet(llvm::ConstantInt::get(context, llvm::APInt(32, 1)) );
       }
       else
       {
           builder.CreateRetVoid();
       }
       builder.ClearInsertionPoint();
       scope.exit();
   	...
   }
   ```

3. 处理factor后继多类型问题

   设计一个枚举类型`current_factor_type`, 分别有`expression`,`var`,`num`,`call`四种

   再设计一个`current_factor_type`的全局指针，遇到不同类型的factor下级节点时存储节点类型。

   ```c++
   enum current_factor_type {EXPRESSION_FACTOR = 1, VAR_FACTOR = 2, CALL_FACTOR = 3, NUM_FACTOR = 4};
   current_factor_type current_factor_type__global_enum;
   //determine the factor type
   ```

   在遇到一个num-node时，将类型置为`NUM_FACTOR`;遇到var-node时, 置`VAR_FACTOR`;

   在`void CminusBuilder::visit(syntax_assign_expression &node) `, `void CminusBuilder::visit(syntax_simple_expression &node) `和`void CminusBuilder::visit(syntax_additive_expression &node) `

   中均置为`EXPRESSION_FACTOR`; call-node置`CALL_FACTOR`

   有了以上前提后，在visit term节点时利用switch分类处理各节点。

   ```c++
   
   void CminusBuilder::visit(syntax_term &node) 
   {
   	...
       switch (current_factor_type__global_enum)
       {
       case EXPRESSION_FACTOR:
           {
     //builder.CreateStore(builder.CreateLoad(current_expression_result__global_llvmvalue_p), temp_factor_result);
               builder.CreateStore(current_expression_result__global_llvmvalue_p, temp_factor_result);
           }
           break;
       case VAR_FACTOR:
           {
               auto var_load = builder.CreateLoad(current_var_id__global_llvmvalue_p); 
               builder.CreateStore(var_load, temp_factor_result);
           }
           break;
       case CALL_FACTOR:
           {
               if (!callee_function_void_flag) //in case the callee function is void
                   builder.CreateStore(callee_return__global_llvmcallinst_p, temp_factor_result);
           }
           break;
       case NUM_FACTOR:
           {
               builder.CreateStore(llvm::ConstantInt::get(context, llvm::APInt(32, current_num__global_int)), temp_factor_result);
           }
           break;
       default:
           std::cout << "Factor type Error!";
           break;
       }
   	...
   }
   
   ```

### 实验总结

这次实验利用LLVM的C++接口完成了从语法树到LLVM IR的自动翻译过程。前期主要是熟悉c++重载和访问者模式的使用，阅读助教写的`include/syntax_tree.hpp`与`src/syntax_tree_cpp/syntax_tree.cpp`了解API作用。

根据拓展的c-文法理解各visit函数访问的先后关系，分配工作。实验过程中需要阅读LLVM官方文档了解`CreateGEP`，`ConstantAggregateZero`等函数的使用，后期利用gdb调试寻找哪里发生了segmentation fault，能正常输出后再利用`-analyze`参数调试。

小组作业需要大家学会阅读commits，了解其他人都干了些什么，充分发挥了gitlab的作用，是一次十分有价值的经历。

### 实验反馈

对本次实验的建议（可选 不会评分）
