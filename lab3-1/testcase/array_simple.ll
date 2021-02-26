; ModuleID = 'cminus'
source_filename = "../testcase/array_simple.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @main() {
main:
  %0 = alloca [2 x i32]
  %1 = alloca i32
  store i32 0, i32* %1
  %2 = load i32, i32* %1
  %3 = getelementptr [2 x i32], [2 x i32]* %0, i32 0, i32 %2
  %4 = alloca i32
  store i32 1, i32* %4
  %5 = load i32, i32* %4
  store i32 %5, i32* %3
  %6 = alloca i32
  store i32 1, i32* %6
  %7 = load i32, i32* %6
  %8 = getelementptr [2 x i32], [2 x i32]* %0, i32 0, i32 %7
  %9 = alloca i32
  store i32 2, i32* %9
  %10 = load i32, i32* %9
  store i32 %10, i32* %8
  %11 = alloca i32
  store i32 1, i32* %11
  %12 = load i32, i32* %11
  %13 = getelementptr [2 x i32], [2 x i32]* %0, i32 0, i32 %12
  %14 = alloca i32
  %15 = load i32, i32* %13
  store i32 %15, i32* %14
  %16 = load i32, i32* %14
  %17 = alloca i32
  store i32 0, i32* %17
  %18 = load i32, i32* %17
  %19 = getelementptr [2 x i32], [2 x i32]* %0, i32 0, i32 %18
  %20 = alloca i32
  %21 = load i32, i32* %19
  store i32 %21, i32* %20
  %22 = load i32, i32* %20
  %23 = add i32 %22, %16
  ret i32 %23
}
