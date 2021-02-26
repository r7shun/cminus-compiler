; ModuleID = 'call.c'
source_filename = "call.c"
; neglect target information

; Func callee()
define i32 @callee(i32 %a) {
    %res = mul nsw i32 2, %a
    ret i32 %res
}

; Func main
define i32 @main() {
    %res = call i32 @callee(i32 10) ; call func callee
    ret i32 %res
}

