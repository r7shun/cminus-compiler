; ModuleID = 'cminus'
source_filename = "../testcase/array.cminus"
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

define i32 @main() {
main:
  %0 = alloca [2 x i32]
  %1 = alloca i32
  %2 = alloca i32
  store i32 0, i32* %2
  %3 = load i32, i32* %2
  %4 = getelementptr [2 x i32], [2 x i32]* %0, i32 0, i32 %3
  %5 = alloca i32
  store i32 1, i32* %5
  %6 = load i32, i32* %5
  store i32 %6, i32* %4
  %7 = alloca i32
  store i32 1, i32* %7
  %8 = load i32, i32* %7
  %9 = getelementptr [2 x i32], [2 x i32]* %0, i32 0, i32 %8
  %10 = alloca i32
  store i32 2, i32* %10
  %11 = load i32, i32* %10
  store i32 %11, i32* %9
  %12 = alloca i32
  store i32 1, i32* %12
  %13 = load i32, i32* %12
  %14 = getelementptr [2 x i32], [2 x i32]* %0, i32 0, i32 %13
  %15 = alloca i32
  %16 = load i32, i32* %14
  store i32 %16, i32* %15
  %17 = load i32, i32* %15
  %18 = alloca i32
  store i32 0, i32* %18
  %19 = load i32, i32* %18
  %20 = getelementptr [2 x i32], [2 x i32]* %0, i32 0, i32 %19
  %21 = alloca i32
  %22 = load i32, i32* %20
  store i32 %22, i32* %21
  %23 = load i32, i32* %21
  %24 = add i32 %23, %17
  store i32 %24, i32* %1
  %25 = alloca i32
  %26 = load [2 x i32], [2 x i32]* %0
  store [2 x i32] %26, i32* %25
  %27 = load i32, i32* %25
  %28 = call i32 @callee(i32 %27)
  %29 = alloca i32
  store i32 %28, i32* %29
  %30 = load i32, i32* %29
  ret i32 %30
}
