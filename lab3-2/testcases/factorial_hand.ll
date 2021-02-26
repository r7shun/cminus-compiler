; ModuleID = 'factorial.cpp'
source_filename = "factorial.cpp"

define i32 @factorial(i32) 
{
  %2 = alloca i32, align 4
  %3 = icmp eq i32 %0, 1
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %1
  store i32 1, i32* %2, align 4
  br label %9

; <label>:5:                                      ; preds = %1
  %6 = sub nsw i32 %0, 1
  %7 = call i32 @factorial(i32 %6)
  %8 = mul nsw i32 %0, %7
  store i32 %8, i32* %2, align 4
  br label %9

; <label>:9:                                     ; preds = %7, %6
  %10 = load i32, i32* %2, align 4
  ret i32 %10
}

; Function Attrs: noinline norecurse optnone uwtable
define i32 @main() 
{
  %1 = call i32 @factorial(i32 5)
  ret i32 %1
}


