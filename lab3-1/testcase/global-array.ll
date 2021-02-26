; ModuleID = 'cminus'
source_filename = "../testcase/global-array.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

@0 = global i32 0
@1 = global [1 x i32] zeroinitializer

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define void @foo() {
foo:
  ret void
}

define i32 @main() {
main:
  %0 = alloca i32
  %1 = alloca i32
  store i32 1, i32* %1
  %2 = load i32, i32* %1
  store i32 %2, i32* %0
  %3 = alloca i32
  store i32 0, i32* %3
  %4 = load i32, i32* %3
  %5 = getelementptr [1 x i32], [1 x i32]* @1, i32 0, i32 %4
  %6 = alloca i32
  store i32 2, i32* %6
  %7 = load i32, i32* %6
  store i32 %7, i32* %5
  %8 = alloca i32
  %9 = load i32, i32* %0
  store i32 %9, i32* %8
  %10 = load i32, i32* %8
  %11 = alloca i32
  store i32 0, i32* %11
  %12 = load i32, i32* %11
  %13 = getelementptr [1 x i32], [1 x i32]* @1, i32 0, i32 %12
  %14 = alloca i32
  %15 = load i32, i32* %13
  store i32 %15, i32* %14
  %16 = load i32, i32* %14
  %17 = add i32 %16, %10
  ret i32 %17
}
