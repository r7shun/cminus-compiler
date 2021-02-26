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
    auto module = new Module("assign", context);  // module name = assign
    // main函数
    auto mainFun = Function::Create(FunctionType::get(TYPE32, false),
                                  GlobalValue::LinkageTypes::ExternalLinkage,
                                  "main", module);
    auto mainbb = BasicBlock::Create(context, "entry", mainFun);
    builder.SetInsertPoint(mainbb);
    auto aAlloca = builder.CreateAlloca(TYPE32);    // 参数a的空间分配
    builder.CreateStore(CONST(1), aAlloca);         // 存入常数1
    auto aLoad = builder.CreateLoad(aAlloca);       // 将参数a load上来
    builder.CreateRet(aLoad);                       // 返回a
    builder.ClearInsertionPoint();
    module->print(outs(), nullptr);
    delete module;
    return 0;
}