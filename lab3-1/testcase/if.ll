; ModuleID = 'cminus'
source_filename = "../testcase/if.cminus"
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
  br i1 %4, label %5, label %8

; <label>:5:                                      ; preds = %main
  %6 = alloca i32
  store i32 3, i32* %6
  %7 = load i32, i32* %6
  ret i32 %7

; <label>:8:                                      ; preds = <null operand!>, %main
  %9 = alloca i32
  store i32 0, i32* %9
  %10 = load i32, i32* %9
  ret i32 %10
}
