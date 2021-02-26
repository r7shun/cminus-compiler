; ModuleID = 'factorial_tail_recursion.ll'
source_filename = "factorial_tail_recursion.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline uwtable
define dso_local i32 @_Z9factorialii(i32, i32) #0 {
  br label %tailrecurse

tailrecurse:                                      ; preds = %5, %2 stores n
%.tr = phi i32 [ %0, %2 ], [ %6, %5 ]			; stores total
  %.tr6 = phi i32 [ %1, %2 ], [ %7, %5 ]
  %3 = icmp eq i32 %.tr, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %tailrecurse
  br label %8

; <label>:5:                                      ; preds = %tailrecurse
  %6 = sub nsw i32 %.tr, 1
  %7 = mul nsw i32 %.tr, %.tr6
  br label %tailrecurse

; <label>:8:                                      ; preds = %4
  ret i32 %.tr6
}

attributes #0 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1 (tags/RELEASE_801/final)"}
