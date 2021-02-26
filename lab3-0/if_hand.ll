; ModuleID = 'if.c'
source_filename = "if.c"
; neglect target informantion

;Func
define i32 @main() {
entry:
    %cond = icmp sgt i32 2, 1
    br i1 %cond, label %trueBB, label %falseBB ; br 用来将控制流转交给另一个BB
trueBB:
    ret i32 1
falseBB:
    ret i32 0
}