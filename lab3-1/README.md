# Records

## Time line

```mermaid
gantt
dateFormat YYYY-MM-DD
title Lab 3-1
section Work
First Meeting : done, des1, 2019-11-16,4h
Programming: active, des2,2019-11-16,2019-11-21
Debuging and doc writing: after des2, 3d
```



## Global Variables definitions

* Remember to add definitions as below!

```c
std::vector<llvm::Type *> function_input_params__global_vector_llvmtype_p;
//存储当前处理到的function的下层的调用参数列表的类型
llvm::BasicBlock* current_basicblock__global_llvmbasicblock_p; // = llvm::BasicBlock::Create(context,"entry",calleeFun);
//当前的basicblock

llvm::Function* current_function__global_llvmfunction_p; 
//当前的function

int current_num__global_int;
//NUM 
llvm::Value* current_var_id__global_llvmvalue_p; 
//var  
llvm::Value* current_expression_result__global_llvmvalue_p;
//where the result of an expression stores
enum current_factor_type {EXPRESSION_FACTOR = 1, VAR_FACTOR = 2, CALL_FACTOR = 3, NUM_FACTOR = 4};
current_factor_type current_factor_type__global_enum;
//determine the factor type
llvm::Value* current_term_result__global_llvmvalue_p;
//term value
//注意到上面的current的含义是：譬如你需要var的值的时候，调用相关的函数，你需要的值会被放在全局变量里头。
//譬如说 如果你写的需要一个expression的的值的函数（通常是存储他们结果的位置）
//，那么你需要调用处理expression的accpet 然后计算expression的llvm ir 会被插入
//，并在current_expression_result__global_llvmvalue_p里有你需要的结果的储存地址
std::string declared_id_in_factor__global_string;
//used in factor 
llvm::CallInst* callee_return__global_llvmcallinst_p;
//store for using of callee return value in factor
llvm::Value* current_additive_expression_result__global_llvmvalue_p;
//additive expression result value
llvm::Value* current_simple_expression_result__global_llvmvalue_p;
//current simple expression result value
bool callee_function_void_flag = false;
bool branching_return_searching_flag = false; 
bool braching_return_found_flag = false;
bool variable_not_in_function = true;
```


## Function documents

* Remember to add function definitions and documents here!
* 

##  20191116

## 代码功能与程序问题

* Scope是具体干什么的？
* 设计全局变量
* struct syntax_tree_xxxxx定义在 syntax_tree.hpp
* visitor.visit(node) -> builder.visit(node)


## 函数分工

```c
#include "cminus_builder.hpp"
#include <iostream>
#define __DEBUG__
#define __DEBUG_PRINT(str)    std::cout<< str << "\n"; 
// You can define global variables here
// to store state

std::vector<llvm::Type *> function_input_params__global_vector_llvmtype_p;
//存储当前处理到的function的下层的调用参数列表的类型
llvm::BasicBlock* current_basicblock__global_llvmbasicblock_p; // = llvm::BasicBlock::Create(context,"entry",calleeFun);
//当前的basicblock
int current_num__global_int;
//NUM 
llvm::Value* current_var_id__global_llvmvalue_p; 
//var  
llvm::Value* current_expression_result__global_llvmvalue_p;
//where the result of an expression stores
enum current_factor_type {EXPRESSION_FACTOR = 1, VAR_FACTOR = 2, CALL_FACTOR = 3, NUM_FACTOR = 4};
current_factor_type current_factor_type__global_enum;
//determine the factor type
llvm::Value* current_term_result__global_llvmvalue_p;
//term value
//注意到上面的current的含义是：譬如你需要var的值的时候，调用相关的函数，你需要的值会被放在全局变量里头。
//譬如说 如果你写的需要一个expression的的值的函数（通常是存储他们结果的位置）
//，那么你需要调用处理expression的accpet 然后计算expression的llvm ir 会被插入
//，并在current_expression_result__global_llvmvalue_p里有你需要的结果的储存地址
std::string declared_id_in_factor__global_string;
//used in factor 
llvm::CallInst* callee_return__global_llvmcallinst_p;
//store for using of callee return value in factor
llvm::Value* current_additive_expression_result__global_llvmvalue_p;
//additive expression result value
llvm::Value* current_simple_expression_result__global_llvmvalue_p;
//current simple expression result value
llvm::Function* current_function__llvmfunction_p;
bool callee_function_void_flag = false;
bool branching_return_searching_flag = false; 
bool braching_return_found_flag = false;
bool variable_not_in_function = true;

#ifdef __DEBUG__
syntax_tree_printer printer = syntax_tree_printer();
#endif

void CminusBuilder::visit(syntax_program &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_program.")
    printer.visit(node);
    #endif
    for (auto decl: node.declarations) 
    {
        decl -> accept(*this);
    }
    builder.ClearInsertionPoint();

    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_program.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_num &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_num.")
    printer.visit(node);
    #endif
    current_num__global_int = node.value;
    current_factor_type__global_enum = NUM_FACTOR;

    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_num.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_var_declaration &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_var_declaration.")
    printer.visit(node);
    #endif
    if(node.num == nullptr)
    {
        if (variable_not_in_function) { //global variable declaration
           auto Zero = ConstantInt::get(Type::getInt32Ty(context),0,true);
           global_var = new llvm::GlobalVariable(*(module.get()),Type::getInt32Ty(context),false,
             GlobalValue::LinkageTypes::ExternalLinkage,Zero);
        }
        else {
            //Int
            auto alloc = builder.CreateAlloca(llvm::Type::getInt32Ty(context));
            //auto temp_store = builder.CreateStore(alloc, alloc);
            scope.push(node.id, alloc);
        }
    }
    else
    {
        if (variable_not_in_function) { //global array declaration
               
        }
        else {
             //Array
            llvm::ArrayType* arrayType = llvm::ArrayType::get(llvm::Type::getInt32Ty(context), node.num.get()->value);
            //auto arrayPtr = new llvm::AllocaInst(arrayType, "", current_basicblock__global_llvmbasicblock_p);
            scope.push(node.id, builder.CreateAlloca(arrayType));
        }
    }
    
    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_var_declaration.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_fun_declaration &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_fun_declaration.")
    printer.visit(node);
    #endif
    //处理参数 使得有一个可用的参数列表 
    int param_num = 0;
    for(auto param: node.params)
    {
        //Otherwise dangling pointer if input is void!
        if (param != nullptr)
        {
            param -> accept(*this);
            ++ param_num;
        }
    }
    llvm::Function* fun;
    llvm::FunctionType* type;
    if (node.type == TYPE_INT)
    {
        auto TyInt32 = llvm::Type::getInt32Ty(context);
        
        if (param_num != 0)
            type = llvm::FunctionType::get(TyInt32, function_input_params__global_vector_llvmtype_p, false);
        else
            type = llvm::FunctionType::get(TyInt32, false);
        
        fun = llvm::Function::Create(
            type,
            llvm::GlobalValue::LinkageTypes::ExternalLinkage,
            node.id,
            module.get());
    }
    else
    {
        auto TyVoid = llvm::Type::getVoidTy(context);
        if (param_num != 0)
            type = llvm::FunctionType::get(TyVoid, function_input_params__global_vector_llvmtype_p, false);
        else
            type = llvm::FunctionType::get(TyVoid, false);
        
        fun = llvm::Function::Create(
            type,
            llvm::GlobalValue::LinkageTypes::ExternalLinkage,
            node.id,
            module.get()); 
    }
    scope.push(node.id, fun);
    scope.enter();
    //change variable_not_in_function flag value to false
    variable_not_in_function = false;

    //Patching the function declaration code
    current_basicblock__global_llvmbasicblock_p = llvm::BasicBlock::Create(context, node.id, fun);
    builder.SetInsertPoint(current_basicblock__global_llvmbasicblock_p);
    std::vector<llvm::Value *> args;  //获取函数的参数,通过iterator
    for (auto arg = fun->arg_begin(); arg != fun->arg_end(); arg++) {
        args.push_back(arg);
    }
    for (int i = 0; i < args.size(); i++)
    {   
        if(node.params[i].get() -> isarray)
        {
            //array as param!
            auto temp_alloca = builder.CreateAlloca(llvm::Type::getInt32Ty(context) -> getPointerTo() ) ;
            auto temp_array_id = builder.CreateStore(args[i],  temp_alloca);
            scope.push(node.params[i].get() -> id, temp_alloca);
        }
        else
        {
            auto temp_alloca = builder.CreateAlloca(llvm::Type::getInt32Ty(context));
            auto temp_id = builder.CreateStore(args[i], temp_alloca);
            scope.push(node.params[i].get() -> id, temp_alloca);
        }
    }
    current_function__llvmfunction_p = fun;
    node.compound_stmt->accept(*this);
    
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
    //change variable_not_in_function flag value to true
    variable_not_in_function = true;

    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_fun_declaration.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_param &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_param.")
    printer.visit(node);
    #endif
    if (node.isarray)
    {
        if (node.type == TYPE_INT)
        {
            auto type = llvm::Type::getInt32Ty(context) -> getPointerTo();
            function_input_params__global_vector_llvmtype_p.push_back(type);
        }
    }
    else
    {
        //void or int
        if (node.type == TYPE_INT)
        {
            auto type = llvm::Type::getInt32Ty(context);
            function_input_params__global_vector_llvmtype_p.push_back(type);
        }
        else
        {
            auto type = llvm::Type::getVoidTy(context);
            function_input_params__global_vector_llvmtype_p.push_back(type);
        } 
    }
    
    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_param.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_compound_stmt &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_compound_stmt.")
    printer.visit(node);
    #endif
    for (auto var_decl : node.local_declarations)
        var_decl -> accept(*this);
    for (auto syntax_statement: node.statement_list )
        syntax_statement -> accept(*this);
    
    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_compound_stmt.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_expresion_stmt &node)
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_expression_stmt.")
    printer.visit(node);
    #endif
    if (node.expression != nullptr)
    {
        node.expression->accept(*this);
    }

    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_expression_stmt.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_selection_stmt &node)
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_selection_stmt.")
    printer.visit(node);
    #endif
    if (node.else_statement != nullptr)
    {
        auto thenBB = llvm::BasicBlock::Create(context, "", current_function__llvmfunction_p);
        auto elseBB = llvm::BasicBlock::Create(context, "", current_function__llvmfunction_p);
        auto endBB = llvm::BasicBlock::Create(context, "", current_function__llvmfunction_p);
        node.expression->accept(*this);
        builder.CreateCondBr(current_expression_result__global_llvmvalue_p,thenBB,elseBB);
        builder.SetInsertPoint(thenBB);
        current_basicblock__global_llvmbasicblock_p = thenBB;
        node.if_statement->accept(*this);
        builder.CreateBr(endBB);
        builder.SetInsertPoint(elseBB);
        current_basicblock__global_llvmbasicblock_p = elseBB;
        node.else_statement->accept(*this);
        builder.CreateBr(endBB);
        builder.SetInsertPoint(endBB);
        current_basicblock__global_llvmbasicblock_p = endBB;
    }
    else
    {
        auto thenBB = llvm::BasicBlock::Create(context, "", current_function__llvmfunction_p);
        auto endBB = llvm::BasicBlock::Create(context, "", current_function__llvmfunction_p);
        node.expression->accept(*this);
        builder.CreateCondBr(current_expression_result__global_llvmvalue_p,thenBB,endBB);
        builder.SetInsertPoint(thenBB);
        current_basicblock__global_llvmbasicblock_p = thenBB;
        node.if_statement->accept(*this);
        builder.CreateBr(endBB);
        builder.SetInsertPoint(endBB);
        current_basicblock__global_llvmbasicblock_p = endBB;
    }

    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_selection_stmt.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_iteration_stmt &node)
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_iteration_stmt.")
    printer.visit(node);
    #endif
    auto condBB = llvm::BasicBlock::Create(context, "", current_function__llvmfunction_p);
    auto bodyBB = llvm::BasicBlock::Create(context, "", current_function__llvmfunction_p);
    auto nextBB = llvm::BasicBlock::Create(context, "", current_function__llvmfunction_p);
    builder.CreateBr(condBB);
    builder.SetInsertPoint(condBB);
    current_basicblock__global_llvmbasicblock_p = condBB;
    node.expression->accept(*this);
    builder.CreateCondBr(current_expression_result__global_llvmvalue_p,bodyBB,nextBB);
    builder.SetInsertPoint(bodyBB);
    current_basicblock__global_llvmbasicblock_p = bodyBB;
    node.statement->accept(*this);
    builder.CreateBr(condBB);
    builder.SetInsertPoint(nextBB);
    current_basicblock__global_llvmbasicblock_p = nextBB;

    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_iteration_stmt.")
    printer.visit(node);
    #endif
}



void CminusBuilder::visit(syntax_return_stmt &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_return_stmt.")
    printer.visit(node);
    #endif
    if (node.expression == nullptr)
    {
        builder.CreateRetVoid();
    }
    else
    {
        node.expression -> accept(*this);

        //auto temp_alloca = builder.CreateAlloca(llvm::Type::getInt32Ty(context));
        //builder.CreateStore(expression_load, temp_alloca);
        #ifdef __DEBUG__
        __DEBUG_PRINT("Before expression for return loaded!")
        #endif 

        //auto expression_load = builder.CreateLoad(current_expression_result__global_llvmvalue_p);
        
        //auto temp_load = builder.CreateLoad(temp_alloca);

        #ifdef __DEBUG__
        __DEBUG_PRINT("Expression for return loaded!")
        #endif 

        builder.CreateRet(current_expression_result__global_llvmvalue_p);
    }
    builder.ClearInsertionPoint();

    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_return_stmt.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_var &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_var.")
    printer.visit(node);
    #endif
    // var -> ID | ID[expression]
    // var used in:
    //expression -> var = expression ∣ simple-expression
    //factor -> ( expression ) ∣ var ∣ call ∣ NUM
    if( node.expression == nullptr )
    {
        //INT
        current_var_id__global_llvmvalue_p = scope.find(node.id);
        declared_id_in_factor__global_string = node.id;
    }
    else
    {
        //Notice: Array!
        node.expression -> accept(*this);
        auto temp_array_index = current_expression_result__global_llvmvalue_p;
        auto temp_array = scope.find(node.id);
        auto zero = llvm::ConstantInt::get(llvm::Type::getInt32Ty(context),0,true);
        std::vector<llvm::Value *> ind_list;
        ind_list.push_back(zero);
        ind_list.push_back(temp_array_index);
        auto array_ptr = builder.CreateGEP(temp_array, ind_list);
        current_var_id__global_llvmvalue_p = array_ptr;
    }
    current_factor_type__global_enum = VAR_FACTOR;

    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_var.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_assign_expression &node) 
{
    // if( node.var->expression == nullptr)
    // {
    //     // var is int id
    //     node.var -> accept(*this);
    //     //auto temp_load = builder.CreacceptateLoad( current_var_id__global_llvmvalue_p );
    //     node.expression -> accept(*this);
    //     builder.CreateStore(current_expression_result__global_llvmvalue_p, current_var_id__global_llvmvalue_p);
    // }
    // else
    // {
    //     // var is array
    //     
    //     node.var -> expression -> accept(*this);
    //     auto temp_array_id = current_expression_result__global_llvmvalue_p;
    //     auto alloca_index = builder.CreateAlloca(llvm::Type::getInt32Ty(context));
    //     auto index = builder.CreateStore(current_expression_result__global_llvmvalue_p, alloca_index);
    //     auto array = scope.find(node.var->id);
    //     //llvm::ConstantInt::get(index->getType(), 0)
    //     //llvm::Value* index_list[1] = {index};
    //     llvm::GetElementPtrInst::Create(llvm::ArrayType::get(llvm::Type::getInt32Ty(context), ),array, {index}, "array", current_basicblock__global_llvmbasicblock_p);
    // }
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_assign_expression.")
    printer.visit(node);
    #endif
    node.var -> accept(*this);
    auto var_load = current_var_id__global_llvmvalue_p;
    node.expression -> accept(*this);
    auto expression_load = current_expression_result__global_llvmvalue_p;
    //auto temp_load = builder.CreateLoad(current_expression_result__global_llvmvalue_p);
    builder.CreateStore(expression_load, var_load);
    current_factor_type__global_enum = EXPRESSION_FACTOR;

    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_assign_expression.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_simple_expression &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_simple_expression.")
    printer.visit(node);
    if (node.additive_expression_l == nullptr)
        __DEBUG_PRINT("Additive l null")
    if (node.additive_expression_r == nullptr)
        __DEBUG_PRINT("Additive r null")
    #endif

    if ( node.additive_expression_r == nullptr)
    {
        node.additive_expression_l -> accept(*this);
        current_simple_expression_result__global_llvmvalue_p = current_additive_expression_result__global_llvmvalue_p;
    }
    else
    {
        node.additive_expression_l -> accept(*this);
        auto lload = current_additive_expression_result__global_llvmvalue_p;
        node.additive_expression_r -> accept(*this);
        auto rload = current_additive_expression_result__global_llvmvalue_p;
        //auto lload = builder.CreateLoad(temp_lvalue);
        //auto rload = builder.CreateLoad(temp_rvalue);
        switch (node.op)
        {
        case OP_LE:
            {
                
                current_simple_expression_result__global_llvmvalue_p = builder.CreateICmpSLE(lload, rload);
            }
            break;
        case OP_LT:
            {
                current_simple_expression_result__global_llvmvalue_p = builder.CreateICmpSLT(lload, rload);
            }
            break;
        case OP_GT:
            {
                current_simple_expression_result__global_llvmvalue_p = builder.CreateICmpSGT(lload, rload);
            }
            break;
        case OP_GE:
            {
                current_simple_expression_result__global_llvmvalue_p = builder.CreateICmpSGE(lload, rload);
            }
            break;
        case OP_EQ:
            {
                current_simple_expression_result__global_llvmvalue_p = builder.CreateICmpEQ(lload, rload);
            }
            break;
        case OP_NEQ:
            {
                current_simple_expression_result__global_llvmvalue_p = builder.CreateICmpNE(lload, rload);
            }
            break;
        default:
            std::cout << "Relop Error!";
            break;
        }
    }
    
    
    current_factor_type__global_enum = EXPRESSION_FACTOR;
    current_expression_result__global_llvmvalue_p = current_simple_expression_result__global_llvmvalue_p;
    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_simple_expression.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_additive_expression &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_additive_expression.")
    printer.visit(node);
    if (node.additive_expression == nullptr)
        __DEBUG_PRINT("additive nullptr")
    if (node.term == nullptr)
        __DEBUG_PRINT("term nullptr")
    #endif
    node.term -> accept(*this);
    auto term_load = current_term_result__global_llvmvalue_p;
    if (node.additive_expression == nullptr)
    {
        // only term
        current_additive_expression_result__global_llvmvalue_p = current_term_result__global_llvmvalue_p;
    }
    else
    {
        // additive-expression addop term
        node.additive_expression -> accept(*this);
        //auto additive_load = builder.CreateLoad(current_additive_expression_result__global_llvmvalue_p);
        auto additive_load = current_additive_expression_result__global_llvmvalue_p;
        //auto term_load = builder.CreateLoad(current_term_result__global_llvmvalue_p);
        
        if( node.op == OP_PLUS)
        {
            current_additive_expression_result__global_llvmvalue_p = builder.CreateAdd(additive_load, term_load);
        }
        else if( node.op == OP_MINUS)
        {
            current_additive_expression_result__global_llvmvalue_p = builder.CreateSub(additive_load, term_load);
        }
    }
    current_factor_type__global_enum = EXPRESSION_FACTOR;
    //current_expression_result__global_llvmvalue_p = current_additive_expression_result__global_llvmvalue_p;
    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_additive_expression.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_term &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_term.")
    printer.visit(node);
    #endif
    node.factor -> accept(*this);
    //Notice: Dependent in other accept functions! 

    llvm::AllocaInst* temp_factor_result = builder.CreateAlloca(llvm::Type::getInt32Ty(context));

    #ifdef __DEBUG__
    __DEBUG_PRINT("Factor type:")
    __DEBUG_PRINT(current_factor_type__global_enum)
    __DEBUG_PRINT("Num:")
    __DEBUG_PRINT(current_num__global_int)
    #endif

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
            auto temp = scope.find(declared_id_in_factor__global_string);
            
            #ifdef __DEBUG__
            __DEBUG_PRINT("Id Found:")
            __DEBUG_PRINT(temp)
            #endif

            auto var_load = builder.CreateLoad(temp); 
            //Dead here!
            #ifdef __DEBUG__
            __DEBUG_PRINT("Var load done!")
            #endif

            builder.CreateStore(var_load, temp_factor_result);

            #ifdef __DEBUG__
            __DEBUG_PRINT("Var factor done!")
            #endif

            //Array todo!
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
    //Notice: condition may be wrong?
    if( node.term != nullptr )
    {
        node.term -> accept(*this);
        auto term_load = current_term_result__global_llvmvalue_p;
        //auto term_load = builder.CreateLoad(current_term_result__global_llvmvalue_p);
        auto factor_load = builder.CreateLoad(temp_factor_result);
        if( node.op == OP_MUL )
        {
            current_term_result__global_llvmvalue_p = builder.CreateMul(term_load, factor_load);
        }
        else if (node.op == OP_DIV)
        {
            current_term_result__global_llvmvalue_p = builder.CreateSDiv(term_load, factor_load);
        }
    }
    else
    {
        // only factor
        current_term_result__global_llvmvalue_p = builder.CreateLoad(temp_factor_result);
    }
    
    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_term.")
    printer.visit(node);
    #endif
}

void CminusBuilder::visit(syntax_call &node) 
{
    #ifdef __DEBUG__
    __DEBUG_PRINT("Visiting sytax_call.")
    printer.visit(node);
    #endif
    auto temp_callee_function = scope.find(node.id);
    #ifdef __DEBUG__
    if(temp_callee_function == nullptr)
    {
        __DEBUG_PRINT(node.id+": Cannot be found.")
    }
    else
    {
        __DEBUG_PRINT(node.id+": Found.")
    }
    #endif
    std::vector<llvm::Value*> temp_args_vector;
    //deal with node.args;
    int args_num = 0;
    for (auto arg : node.args)
    {
        if (arg != nullptr)
        {
            arg -> accept(*this);
            temp_args_vector.push_back(current_expression_result__global_llvmvalue_p);
            ++ args_num;
        }
    }
    #ifdef __DEBUG__
    __DEBUG_PRINT("Args Num: ")
    printf("%d\n",args_num);
    __DEBUG_PRINT(callee_return__global_llvmcallinst_p)
    #endif
    if (args_num == 0)
    {
        callee_return__global_llvmcallinst_p = builder.CreateCall(temp_callee_function);
    }
    else
    {
        callee_return__global_llvmcallinst_p = builder.CreateCall(temp_callee_function, temp_args_vector);
    }
    
    current_factor_type__global_enum = CALL_FACTOR;
    
    if (((llvm::Function*)temp_callee_function) -> getReturnType()  == llvm::Type::getVoidTy(context))
        callee_function_void_flag = true;
    else
        callee_function_void_flag = false;
    
    #ifdef __DEBUG__
    __DEBUG_PRINT("Finished visiting sytax_call.")
    printer.visit(node);
    #endif
}



```

### 增加的语法与语义

* 数组

* 调用与函数声明做了区分

* 局部变量

* 返回语句单独出来

* `output`函数在输出数字后会同时输出一个换行符`\n`（该部分助教已经实现）

* 当访问越界时（即，下标小于0），要调用内置函数`void neg_idx_except(void)`来输出异常并终止程序（**重要**）

* 全局变量需要利用"llvm::ConstantAggregateZero"初始化为全0（**重要**）

   

  ## 2019 11 19

  * syntax_var_declaration syntax_fun_declaration 继承了 syntax_declaration

  * 注意到源代码中智能指针的使用

  * 注意到syntax_var 中， 指向expression 的vector为nullptr的话就是INT

  

  
  
  ## 2019 11 23
  
  * Cminus 中变量的声明要放到一个函数的开头！ （编写测试案例时注意到的）因此不会中间突然声明什么的。
  * forget to deal with global variable...
  
  
