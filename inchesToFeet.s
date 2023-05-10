# FileName: inchesToFeet.s
# Author: Matthew Green
# Date: 10/24/2022
# Purpose: to convert inches to feed

.text
.global main
main:
    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # get inches from user
    LDR r0, =prompt1
    BL printf

    LDR r0, =format1
    SUB sp, sp, #4
    MOV r1, sp
    BL scanf
    LDR r0, [sp]
    ADD sp, sp, #4

    # call inchesToFt
    BL InchesToFt
    MOV r4, r0

    # convert output into decimals via PrintScaledInt,
    # and print the result
    LDR r0, =output1
    BL printf

    MOV r0, r4
    MOV r1, #100
    BL PrintScaledInt

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "How many inches: "
    format1: .asciz "%d"
    output1: .asciz "Here it is in feet:\n"
