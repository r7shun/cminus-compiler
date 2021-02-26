; ModuleID = 'cminus'
source_filename = "../testcase/while.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @main() {
main:
  %0 = alloca i32
  %1 = alloca i32
  %2 = alloca i32
  store i32 10, i32* %2
  %3 = load i32, i32* %2
  store i32 %3, i32* %0
  %4 = alloca i32
  store i32 0, i32* %4
  %5 = load i32, i32* %4
  store i32 %5, i32* %1
  br label %6

; <label>:6:                                      ; preds = %13, %main
  %7 = alloca i32
  %8 = load i32, i32* %1
  store i32 %8, i32* %7
  %9 = load i32, i32* %7
  %10 = alloca i32
  store i32 10, i32* %10
  %11 = load i32, i32* %10
  %12 = icmp slt i32 %9, %11
  br i1 %12, label %13, label %27

; <label>:13:                                     ; preds = %6
  %14 = alloca i32
  store i32 1, i32* %14
  %15 = load i32, i32* %14
  %16 = alloca i32
  %17 = load i32, i32* %1
  store i32 %17, i32* %16
  %18 = load i32, i32* %16
  %19 = add i32 %18, %15
  store i32 %19, i32* %1
  %20 = alloca i32
  %21 = load i32, i32* %1
  store i32 %21, i32* %20
  %22 = load i32, i32* %20
  %23 = alloca i32
  %24 = load i32, i32* %0
  store i32 %24, i32* %23
  %25 = load i32, i32* %23
  %26 = add i32 %25, %22
  store i32 %26, i32* %0
  br label %6

; <label>:27:                                     ; preds = %6
  %28 = alloca i32
  %29 = load i32, i32* %0
  store i32 %29, i32* %28
  %30 = load i32, i32* %28
  ret i32 %30
}
