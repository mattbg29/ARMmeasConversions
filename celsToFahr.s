# FileName: celsToFahr.s
# Author: Matthew Green
# Date: 10/24/2022
# Purpose: To convert celsius to fahrenheit

.text
.global main
main:

    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # get celsius from user
    LDR r0, =prompt1
    BL printf
   
    LDR r0, =format1
    SUB sp, sp, #4
    MOV r1, sp
    BL scanf
    LDR r4, [sp]
    ADD sp, sp, #4

    # Call CToF, output result to user
    MOV r0, r4
    BL CToF
    MOV r1, r0
    LDR r0, =output1
    BL printf

    # pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Enter celsius: "
    output1: .asciz "This is %d in fahrenheit\n"
    format1: .asciz "%d"
