; ModuleID = 'cfill.c'
target datalayout = "e-p:32:32-i64:64"
target triple = "le32-unknown-nacl"

@main.s = private unnamed_addr constant [80 x i8] c"hello world\0A\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 1
@.str = private unnamed_addr constant [5 x i8] c"%s \0A\00", align 1

; Function Attrs: nounwind
define void @cfill(i8* %s1, i8 signext %c, i32 %pos) #0 {
  %1 = alloca i8*, align 4
  %2 = alloca i8, align 1
  %3 = alloca i32, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  %i2 = alloca i32, align 4
  store i8* %s1, i8** %1, align 4
  store i8 %c, i8* %2, align 1
  store i32 %pos, i32* %3, align 4
  store i32 0, i32* %i, align 4
  %4 = load i8** %1, align 4
  %5 = call i32 @strlen(i8* %4)
  %6 = udiv i32 %5, 2
  store i32 %6, i32* %i1, align 4
  %7 = load i32* %3, align 4
  %8 = sdiv i32 %7, 2
  store i32 %8, i32* %i2, align 4
  store i32 0, i32* %i, align 4
  br label %9

; <label>:9                                       ; preds = %22, %0
  %10 = load i32* %i, align 4
  %11 = load i32* %3, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %25

; <label>:13                                      ; preds = %9
  %14 = load i8* %2, align 1
  %15 = load i32* %i1, align 4
  %16 = load i32* %i2, align 4
  %17 = sub nsw i32 %15, %16
  %18 = load i32* %i, align 4
  %19 = add nsw i32 %17, %18
  %20 = load i8** %1, align 4
  %21 = getelementptr inbounds i8* %20, i32 %19
  store i8 %14, i8* %21, align 1
  br label %22

; <label>:22                                      ; preds = %13
  %23 = load i32* %i, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, i32* %i, align 4
  br label %9

; <label>:25                                      ; preds = %9
  ret void
}

declare i32 @strlen(i8*) #1

; Function Attrs: nounwind
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %s = alloca [80 x i8], align 1
  store i32 0, i32* %1
  %2 = bitcast [80 x i8]* %s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %2, i8* getelementptr inbounds ([80 x i8]* @main.s, i32 0, i32 0), i32 80, i32 1, i1 false)
  %3 = getelementptr inbounds [80 x i8]* %s, i32 0, i32 0
  call void @cfill(i8* %3, i8 signext 46, i32 3)
  %4 = getelementptr inbounds [80 x i8]* %s, i32 0, i32 0
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str, i32 0, i32 0), i8* %4)
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture, i8* nocapture readonly, i32, i32, i1) #2

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Raspbian clang version 3.5.0-10+rpi1 (tags/RELEASE_350/final) (based on LLVM 3.5.0)"}
