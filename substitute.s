# Jason Durant
# substitute.s - substitute one character for another in a string
#
    .data
string: .space 80
orig:   .space 1
new:    .space 1
sprompt: .asciiz    "Enter string:"
oprompt: .asciiz    "Enter character you want to replace:"
nprompt: .asciiz    "Enter replacement character:"
    .text
    .globl  main
main:
    # get string
    la      $a0,sprompt
    la      $a1,string
    li      $a2,80
    li      $v0,54
    syscall
    # get original character
    # since there is no 'inputdialogchar' syscall, use an inputdialogstring
    # syscall. This will read a string but we will just use the first character
    la      $a0,oprompt
    la      $a1,orig
    li      $a2,4
    li      $v0,54
    syscall
    la      $a0,nprompt
    la      $a1,new
    li      $a2,4
    li      $v0,54
    syscall
    
#
# now we are ready to do the real work of substituting every instance of
# 'old' with 'new' in 'string'
# HINT: before you start, initialize the following registers:
# a0 = address of the string
# a1 = char to look for
# a2 = char to replace with
# Have fun!
#
# Translate the following C code to MIPS:
#
#    int i,count=0;
#    for (i=0;string[i]!=0;i++) 
#        if (string[i] == orig) { 
#            string[i]=new;
#            count++;
#        }
#
# last, output string and count using syscalls
#
##################
# YOUR CODE BELOW 
##################
    
    la $t0, string # load  adress of string to $t0
    li $t1, 0 # store current address pointer
    li $t2, 0 # total replacement count
    
    lb $t3  orig
    lb $t4  new
 Loop:
 
    lb $t1, 0($t0) #retrieve current string byte
    beqz $t1, Done #check if byte is 0 meaning end of the contiguous set of characters
    bne	$t1, $t3, Continue #if not current byte and replacement byte are not equal branch
    sb $t4, 0($t0) #store replacement byte a the current address
    addi $t2, $t2, 1 #increment sum counter by 1
    j Continue
    
 Continue:   
    addi $t0, $t0, 1 #increment pointer
    j Loop

Done:
    li $v0, 1
    move $a0 $t2 #print sum 
    syscall
    
    li $v0, 4
    la $a0, string #print new string with replacements
    syscall
    
