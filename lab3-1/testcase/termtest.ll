; ModuleID = 'cminus'
source_filename = "../testcase/termtest.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @main() {
main:
  %0 = alloca i32
  %1 = alloca i32
  store i32 1, i32* %1
  %2 = load i32, i32* %1
  store i32 %2, i32* %0
  %3 = alloca i32
  %4 = load i32, i32* %0
  store i32 %4, i32* %3
  %5 = alloca i32
  store i32 2, i32* %5
  %6 = load i32, i32* %5
  %7 = load i32, i32* %3
  %8 = mul i32 %6, %7
  store i32 %8, i32* %0
  %9 = alloca i32
  %10 = load i32, i32* %0
  store i32 %10, i32* %9
  %11 = load i32, i32* %9
  ret i32 %11
}
