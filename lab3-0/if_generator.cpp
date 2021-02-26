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

using namespace llvm;  
#define CONST(num) \
  ConstantInt::get(context, APInt(32, num))  

int main() {
    LLVMContext context;
    Type *TYPE32 = Type::getInt32Ty(context);
    IRBuilder<> builder(context);
    auto module = new Module("if", context);  // module name=if
    // main函数
    auto mainFun = Function::Create(FunctionType::get(TYPE32, false),
                                    GlobalValue::LinkageTypes::ExternalLinkage,
                                    "main", module);
    auto ifbb = BasicBlock::Create(context, "entry", mainFun);
    builder.SetInsertPoint(ifbb);                     // ifBB的开始

    auto retAlloca = builder.CreateAlloca(TYPE32);  // 返回值的空间分配

    auto icmp = builder.CreateICmpSGT(CONST(2), CONST(1));  // 2 AND 1 COMPARE,注意SGT
    auto trueBB = BasicBlock::Create(context, "trueBB", mainFun);    // true分支
    auto falseBB = BasicBlock::Create(context, "falseBB", mainFun);  // false分支
    auto retBB = BasicBlock::Create(
        context, "", mainFun);  // return分支,提前create,以便true分支可以br
    auto br = builder.CreateCondBr(icmp, trueBB, falseBB);  // 条件BR

    builder.SetInsertPoint(trueBB);  // if true; 分支的开始需要SetInsertPoint设置
    builder.CreateStore(CONST(1), retAlloca); //return 1
    builder.CreateBr(retBB);  // br retBB

    builder.SetInsertPoint(falseBB);  // if false
    builder.CreateStore(CONST(0), retAlloca); //return 1
    builder.CreateBr(retBB);  // br retBB

    builder.SetInsertPoint(retBB);  // ret分支
    auto retLoad = builder.CreateLoad(retAlloca);
    builder.CreateRet(retLoad);

    builder.ClearInsertionPoint();
    module->print(outs(), nullptr);
    delete module;
    return 0;
}