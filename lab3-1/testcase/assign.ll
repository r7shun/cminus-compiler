; ModuleID = 'cminus'
source_filename = "../testcase/assign.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @main() {
main:
  %0 = alloca i32
  %1 = alloca i32
  store i32 3, i32* %1
  %2 = load i32, i32* %1
  store i32 %2, i32* %0
  %3 = alloca i32
  %4 = load i32, i32* %0
  store i32 %4, i32* %3
  %5 = load i32, i32* %3
  ret i32 %5
}
