; ModuleID = 'cminus'
source_filename = "../testcase/array_as_argument.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @callee(i32*) {
callee:
  %1 = alloca i32*
  store i32* %0, i32** %1
  %2 = alloca i32
  store i32 1, i32* %2
  %3 = load i32, i32* %2
  %4 = load i32*, i32** %1
  %5 = getelementptr i32, i32* %4, i32 %3
  %6 = alloca i32
  %7 = load i32, i32* %5
  store i32 %7, i32* %6
  %8 = load i32, i32* %6
  %9 = alloca i32
  store i32 0, i32* %9
  %10 = load i32, i32* %9
  %11 = load i32*, i32** %1
  %12 = getelementptr i32, i32* %11, i32 %10
  %13 = alloca i32
  %14 = load i32, i32* %12
  store i32 %14, i32* %13
  %15 = load i32, i32* %13
  %16 = add i32 %15, %8
  ret i32 %16
}
