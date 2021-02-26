; ModuleID = 'constprop.cpp'
source_filename = "constprop.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline norecurse nounwind optnone uwtable
define dso_local i32 @main() {
  ;%1 = alloca i32, align 4
  ;%2 = alloca i32, align 4
  ;%3 = alloca i32, align 4
  ;store i32 0, i32* %1, align 4
  ;store i32 1, i32* %2, align 4
  ;store i32 2, i32* %3, align 4
  ;%4 = load i32, i32* %2
  ;%5 = load i32, i32* %3 
  ;%6 = add i32 %4,%5
  ;ret i32 %6
  %1 = add i32 1,2
  %2 = icmp slt i32 2,3
  ret i32 %1
}

