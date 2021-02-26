; ModuleID = 'cminus'
source_filename = "../testcase/if_in_another_if.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @main() {
main:
  %0 = alloca i32
  store i32 2, i32* %0
  %1 = load i32, i32* %0
  %2 = alloca i32
  store i32 1, i32* %2
  %3 = load i32, i32* %2
  %4 = icmp sgt i32 %1, %3
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %main
  %6 = alloca i32
  store i32 4, i32* %6
  %7 = load i32, i32* %6
  %8 = alloca i32
  store i32 5, i32* %8
  %9 = load i32, i32* %8
  %10 = icmp slt i32 %7, %9
  br i1 %10, label %14, label %17

; <label>:11:                                     ; preds = %20, %main
  %12 = alloca i32
  store i32 0, i32* %12
  %13 = load i32, i32* %12
  ret i32 %13

; <label>:14:                                     ; preds = %5
  %15 = alloca i32
  store i32 3, i32* %15
  %16 = load i32, i32* %15
  ret i32 %16

; <label>:17:                                     ; preds = %5
  %18 = alloca i32
  store i32 5, i32* %18
  %19 = load i32, i32* %18
  ret i32 %19

; <label>:20:                                     ; preds = <null operand!>, <null operand!>
  br label %11
}
