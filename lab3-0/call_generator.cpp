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
    auto module = new Module("call", context);  // module name = assign
    // callee函数
   // 函数参数类型的vector
    std::vector<Type *> Ints(1, TYPE32);
    auto calleeFun = Function::Create(FunctionType::get(TYPE32, Ints, false),
                                 GlobalValue::LinkageTypes::ExternalLinkage,
                                 "callee", module);
    auto bb = BasicBlock::Create(context, "entry", calleeFun);
    builder.SetInsertPoint(bb); 
    auto retAlloca = builder.CreateAlloca(TYPE32);
    auto aAlloca = builder.CreateAlloca(TYPE32);    // 参数a的空间分配
    std::vector<Value *> args;  //获取callee函数的参数,通过iterator
    for (auto arg = calleeFun->arg_begin(); arg != calleeFun->arg_end(); arg++) {
        args.push_back(arg);
    }
    builder.CreateStore(args[0], aAlloca);  //将参数a store下来
    auto aLoad = builder.CreateLoad(aAlloca);           //将参数a load上来
    // CreateNSWMul LHS must be ‘llvm::Value*’ type
    // store const 2 in temp
    auto tempAlloca = builder.CreateAlloca(TYPE32);
    builder.CreateStore(CONST(2), tempAlloca);
    auto tempLoad = builder.CreateLoad(tempAlloca);
    auto mul = builder.CreateNSWMul(tempLoad, aLoad);  // NSWMUL - mul with NSW flags 2 * a
    builder.CreateStore(mul, retAlloca);
    auto retLoad = builder.CreateLoad(retAlloca);
    builder.CreateRet(retLoad);

    // main函数
    auto mainFun = Function::Create(FunctionType::get(TYPE32, false),
                                    GlobalValue::LinkageTypes::ExternalLinkage,
                                    "main", module);
    bb = BasicBlock::Create(context, "entry", mainFun);
    builder.SetInsertPoint(bb);
    auto call = builder.CreateCall(calleeFun, {CONST(10)});
    builder.CreateRet(call);
    builder.ClearInsertionPoint();
    module->print(outs(), nullptr);
    delete module;
    return 0;
}