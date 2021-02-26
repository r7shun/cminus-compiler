; ModuleID = 'cminus'
source_filename = "../testcase/gcd.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @gcd(i32, i32) {
gcd:
  %2 = alloca i32
  store i32 %0, i32* %2
  %3 = alloca i32
  store i32 %1, i32* %3
  %4 = alloca i32
  %5 = load i32, i32* %3
  store i32 %5, i32* %4
  %6 = load i32, i32* %4
  %7 = alloca i32
  store i32 0, i32* %7
  %8 = load i32, i32* %7
  %9 = icmp eq i32 %6, %8
  br i1 %9, label %10, label %14

; <label>:10:                                     ; preds = %gcd
  %11 = alloca i32
  %12 = load i32, i32* %2
  store i32 %12, i32* %11
  %13 = load i32, i32* %11
  ret i32 %13

; <label>:14:                                     ; preds = %gcd
  %15 = alloca i32
  %16 = load i32, i32* %3
  store i32 %16, i32* %15
  %17 = load i32, i32* %15
  %18 = alloca i32
  %19 = load i32, i32* %3
  store i32 %19, i32* %18
  %20 = alloca i32
  %21 = load i32, i32* %3
  store i32 %21, i32* %20
  %22 = alloca i32
  %23 = load i32, i32* %2
  store i32 %23, i32* %22
  %24 = load i32, i32* %22
  %25 = load i32, i32* %20
  %26 = sdiv i32 %24, %25
  %27 = load i32, i32* %18
  %28 = mul i32 %26, %27
  %29 = alloca i32
  %30 = load i32, i32* %2
  store i32 %30, i32* %29
  %31 = load i32, i32* %29
  %32 = sub i32 %31, %28
  %33 = call i32 @gcd(i32 %17, i32 %32)
  %34 = alloca i32
  store i32 %33, i32* %34
  %35 = load i32, i32* %34
  ret i32 %35

; <label>:36:                                     ; preds = <null operand!>, <null operand!>
  ret i32 1
}

define void @main() {
main:
  %0 = alloca i32
  %1 = alloca i32
  %2 = alloca i32
  %3 = call i32 @input()
  %4 = alloca i32
  store i32 %3, i32* %4
  %5 = load i32, i32* %4
  store i32 %5, i32* %0
  %6 = call i32 @input()
  %7 = alloca i32
  store i32 %6, i32* %7
  %8 = load i32, i32* %7
  store i32 %8, i32* %1
  %9 = alloca i32
  %10 = load i32, i32* %0
  store i32 %10, i32* %9
  %11 = load i32, i32* %9
  %12 = alloca i32
  %13 = load i32, i32* %1
  store i32 %13, i32* %12
  %14 = load i32, i32* %12
  %15 = icmp slt i32 %11, %14
  br i1 %15, label %16, label %26

; <label>:16:                                     ; preds = %main
  %17 = alloca i32
  %18 = load i32, i32* %0
  store i32 %18, i32* %17
  %19 = load i32, i32* %17
  store i32 %19, i32* %0
  %20 = alloca i32
  %21 = load i32, i32* %1
  store i32 %21, i32* %20
  %22 = load i32, i32* %20
  store i32 %22, i32* %1
  %23 = alloca i32
  %24 = load i32, i32* %2
  store i32 %24, i32* %23
  %25 = load i32, i32* %23
  store i32 %25, i32* %2
  br label %26

; <label>:26:                                     ; preds = %16, %main
  %27 = alloca i32
  %28 = load i32, i32* %0
  store i32 %28, i32* %27
  %29 = load i32, i32* %27
  %30 = alloca i32
  %31 = load i32, i32* %1
  store i32 %31, i32* %30
  %32 = load i32, i32* %30
  %33 = call i32 @gcd(i32 %29, i32 %32)
  %34 = alloca i32
  store i32 %33, i32* %34
  %35 = load i32, i32* %34
  store i32 %35, i32* %1
  %36 = alloca i32
  %37 = load i32, i32* %2
  store i32 %37, i32* %36
  %38 = load i32, i32* %36
  call void @output(i32 %38)
  %39 = alloca i32
  %40 = load i32, i32* %39
  ret void
}
