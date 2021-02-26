; ModuleID = 'constprop.ll'
source_filename = "constprop.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @main() {
  %1 = icmp slt i32 2, 3
  ret i32 3
}
