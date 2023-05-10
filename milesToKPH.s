# FileName: milesToKPH.s
# Author: Matthew Green
# Date: 10/24/2022
# Purpose: To convert hours + miles into kilometers per hour

.text
.global main
main:
    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # get hours from user
    LDR r0, =prompt1
    BL printf

    LDR r0, =format1
    SUB sp, sp, #4
    MOV r1, sp
    BL scanf
    LDR r4, [sp]
    ADD sp, sp, #4

    # get miles from user
    LDR r0, =prompt2
    BL printf

    LDR r0, =format1
    SUB sp, sp, #4
    MOV r1, sp
    BL scanf
    LDR r5, [sp]
    ADD sp, sp, #4

    # call kph with hours, miles
    MOV r0, r4
    MOV r1, r5
    BL kph

    # print the result from kph
    MOV r1, r0
    LDR r0, =output1
    BL printf

    # pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Enter the number of hours: "
    prompt2: .asciz "Enter the number of miles: "
    format1: .asciz "%d"
    output1: .asciz "The resulting KPH is %d\n"
