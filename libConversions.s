# FileName: libConversions.s
# Author: Matthew Green
# Date: 10/24/2022
# Purpose: Functions for use on for Module 8 exercises and assignment

.global miles2kilometers
.global kph
.global CToF
.global InchesToFt
.global K2M
.global MPH
.global KtoMPH
.global PrintScaledInt
.global Ft2Inches
.global F2C

##################################
# Function: miles2kilometers
# Purpose: to convert miles to kilometers
# Input: r0 - an integer value of miles
# Output: r0 - a pointer to a number that represents the miles converted to
#              kilometers, which is done as follows: kilometers = miles * 16 / 10
#              We multiply by 16 and divide by 10 rather than multiply
#              by 1.6 because floating point numbers require more
#              computer resources to do the equivalent operations

.text
miles2kilometers:
    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # do the conversion
    MOV r1, #16
    MUL r0, r0, r1
    MOV r1, #10
    BL __aeabi_idiv

    # pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr


.data

#END miles2kilometers

########################
# Function: kph
# Purpose: to first convert miles to kilometers, then divide 
#          kilometers by hours and return a pointer to the result
# Input: r0 - integer value of hours
# Input: r1 - integer value of miles
# Output: r0 - pointer to a number that represents kilometers / hours

.text
kph:
    # push and store the lr and r0 (hours) so that we can first convert
    # miles (currently in r1) into km
    SUB sp, sp, #8
    STR lr, [sp]
    STR r0, [sp, #4]

    #convert miles to kilometers
    MOV r0, r1
    BL miles2kilometers

    #divide kilometers by hours
    LDR r1, [sp, #4]
    BL __aeabi_idiv

    # pop
    LDR lr, [sp]
    ADD sp, sp, #8
    MOV pc, lr

.data

#END kph

###############
# Function: CToF
# Purpose: to convert celsius to farhenheit
# Input: r0 - integer value of cesius
# Output: r0 - integer value of farhenheit, throught the
#             following conversion: F = C * 9 / 5 + 32

.text
CToF:
    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # convert celsius to farhenheit
    MOV r1, #9
    MUL r0, r0, r1
    MOV r1, #5
    BL __aeabi_idiv
    MOV r1, #32
    ADD r0, r0, r1

    # pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data

#END CToF


##############
# Function: InchesToFt
# Purpose: to convert inches to feet
# Input: r0 - integer value of inches
# Output: r0 - inches * 100 / 12, hence representing feet * 100, which can then be
#              converted into a decimal via PrintScaledInt

.text
InchesToFt:
    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # Multiply inches by 100 then divide by 12
    MOV r1, #100
    MUL r0, r0, r1
    MOV r1, #12
    BL __aeabi_idiv

    #pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data

#END InchesToFt

##################
# Function: K2M
# Purpose: to convert kilometers to miles
# Input: r0 - value of kilometers
# Output: r0 - pointer to a number that represents 
#              the conversion, which is kilometers * 10 / 16

.text
K2M:
    # push:
    SUB sp, sp, #4
    STR lr, [sp]

    # do the conversion
    MOV r1, #10
    MUL r0, r0, r1
    MOV r1, #16 
    BL __aeabi_idiv

    # pop:
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
# END K2M

####################
# Function: MPH
# Purpose: to convert miles and hours into miles per hour
# Input: r0 - int miles
#        r1 - int hours
# Output: r0 - miles * 100 / hours - the calling function must 
#              then call PrintScaleToInt with scaler 100

.text
MPH:
    # Push
    SUB sp, sp, #4
    STR lr, [sp]
 
    MOV r2, #100
    MUL r0, r0, r2
    BL __aeabi_idiv

    # Pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
# END MPH

##############
# Function: KtoMPH
# Purpose: to convert Kilometers and hours to KPH by first 
#          converting Kilometers to miles, and then calling MPH
# Input: r0 - value in kiloemters
#        r1 - int hours
# Output: r0 - MPH multiplied by 100

.text
KtoMPH:
    # push
    SUB sp, sp, #8
    STR lr, [sp]
    STR r1, [sp, #4]

    BL K2M
    LDR r1, [sp, #4]

    BL MPH

    # pop
    LDR lr, [sp]
    ADD sp, sp, #8
    MOV pc, lr

.data

#END KtoMPH
    
################
# Function: PrintScaledInt
# Purpose: to print a scaled integer value with the 
#          decimal point in the correct place
# Input: r0 - value to print
#        r1 - scale in
#
# Output: none - it prints and is done

.text
PrintScaledInt:
    # push
    SUB sp, #12
    STR lr, [sp]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    MOV r4, r0
    MOV r5, r1

    # get whole part and save in r7
    BL __aeabi_idiv // r0/r1, result in r0 
    MOV r6, r0
    
    # get decimal part and save in r7
    MUL r7, r5, r6
    SUB r7, r4, r7 // subtract the integer amount, r7, from the whole amt, r4, and store in r7

    # print the whole part
    LDR r0, =__PSI_format
    MOV r1, r6
    BL printf

    # print the dot
    LDR r0, =__PSI_dot
    BL printf
    
    # print the decimal part
    LDR r0, = __PSI_format2
    MOV r1, r7
    BL printf

    # pop and return
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    LDR lr, [sp]
    ADD sp, #12
    MOV pc, lr

.data
    __PSI_format: .asciz "%d"
    __PSI_dot: .asciz "."
    __PSI_format2: .asciz "%d\n"

#END PrintScaledInt


##############
# Function: F2C
# Purpose: to convert farhenheit to celsius
# Input: r0 - integer farhenheit
# Output: r0 - integer celsius

.text
F2C:
     # push the stack
     SUB sp, sp, #4
     STR lr, [sp]

     #Formula: r0 = (r0-32)*5/9
     MOV r1, #-32
     ADD r0, r0, r1
     MOV r1, #5
     MUL r0, r0, r1
     MOV r1, #9
     BL __aeabi_idiv

     # push the stack
     LDR lr, [sp]
     ADD sp, sp, #4    
     MOV pc, lr


.data

#END F2C


##############
# Function: Ft2Inches
# Purpose: to convert feet into inches
# Input: r0 - integer in feet
# Output: r0 - integer in inches

.text
Ft2Inches:

     # push the stack
     SUB sp, sp, #4
     STR lr, [sp]

     # Convert feet to inches
     MOV r1, #12
     MUL r0, r0, r1
  
     # push the stack
     LDR lr, [sp]
     ADD sp, sp, #4   
     MOV pc, lr

.data

#END Ft2Inches
