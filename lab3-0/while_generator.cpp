#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/Verifier.h>

#include <iostream>
#include <memory>

using namespace llvm;  // 指明命名空间为llvm
#define CONST(num) \
  ConstantInt::get(context, APInt(32, num))  //得到常数值的表示,方便后面多次用到

int main() {
    LLVMContext context;
    Type *TYPE32 = Type::getInt32Ty(context);
    IRBuilder<> builder(context);
    auto module = new Module("while", context);  // module name = while
    // main函数
    auto mainFun = Function::Create(FunctionType::get(TYPE32, false),
                                  GlobalValue::LinkageTypes::ExternalLinkage,
                                  "main", module);
    auto mainbb = BasicBlock::Create(context, "entry", mainFun);
    builder.SetInsertPoint(mainbb);
    auto aAlloca = builder.CreateAlloca(TYPE32);    // 参数a的空间分配
    auto iAlloca = builder.CreateAlloca(TYPE32);    // 参数i的空间分配
    builder.CreateStore(CONST(10), aAlloca);        // a存入常数10
    builder.CreateStore(CONST(0), iAlloca);         // i存入常数0
    // store const 10 in temp
    auto tempAlloca = builder.CreateAlloca(TYPE32);
    builder.CreateStore(CONST(10), tempAlloca);
    auto tempLoad = builder.CreateLoad(tempAlloca);
    // store const 1 in one
    auto oneAlloca = builder.CreateAlloca(TYPE32);
    builder.CreateStore(CONST(1), oneAlloca);
    auto oneLoad = builder.CreateLoad(oneAlloca);

    auto condition = BasicBlock::Create(context, "condition", mainFun);  //condition分支
    auto while_body = BasicBlock::Create(context, "while_body", mainFun);    // while_body分支
    auto end_while = BasicBlock::Create(context, "end_while", mainFun);  // end_while分支

    builder.CreateBr(condition);
    builder.SetInsertPoint(condition);  // condition branch
    auto aLoad = builder.CreateLoad(aAlloca);
    auto iLoad = builder.CreateLoad(iAlloca);
    auto icmp = builder.CreateICmpSLT(iLoad, tempLoad);  // i和10的比较,slt
    auto br = builder.CreateCondBr(icmp, while_body, end_while);  // 条件BR

    builder.SetInsertPoint(while_body);  // while_body branch
    auto i_plus_one = builder.CreateNSWAdd(iLoad, oneLoad);  // i=i+1
    auto new_a = builder.CreateNSWAdd(aLoad, i_plus_one);   //a=a+i
    builder.CreateStore(i_plus_one, iAlloca);
    builder.CreateStore(new_a, aAlloca);
    builder.CreateBr(condition);

    builder.SetInsertPoint(end_while); //end_while branch
    builder.CreateRet(aLoad); //return a

    builder.ClearInsertionPoint();
    module->print(outs(), nullptr);
    delete module;
    return 0;
}