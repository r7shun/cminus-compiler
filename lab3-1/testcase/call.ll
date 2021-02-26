; ModuleID = 'cminus'
source_filename = "../testcase/call.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @callee(i32) {
callee:
  %1 = alloca i32
  store i32 %0, i32* %1
  %2 = alloca i32
  %3 = load i32, i32* %1
  store i32 %3, i32* %2
  %4 = alloca i32
  store i32 2, i32* %4
  %5 = load i32, i32* %4
  %6 = load i32, i32* %2
  %7 = mul i32 %5, %6
  ret i32 %7
}

define i32 @main() {
main:
  %0 = alloca i32
  store i32 10, i32* %0
  %1 = load i32, i32* %0
  %2 = call i32 @callee(i32 %1)
  %3 = alloca i32
  store i32 %2, i32* %3
  %4 = load i32, i32* %3
  ret i32 %4
}
