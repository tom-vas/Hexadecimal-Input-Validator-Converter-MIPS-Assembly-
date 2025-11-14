#	Computer Systems Organization
#	Winter Semester 2021-2022
#	1st Assignment
#
# 	Pseudocode by MARIA TOGANTZH (mst@aueb.gr)
#
# 	MIPS Code by Thomas Vasilas, p3200012@aueb.gr, 3200012
# 	(Please note your name, e-mail and student id number)


	.text
	.globl __start		

# ------------------- Read and Validate Data ------------------------------

__start: lw $t0,counter	  		# counter = 4
loop: beq $t0,0,exit_loop		# while counter != 0 do
	  li $v0,12					#	Read hex character in $v0
	  syscall					# 		
	  blt $v0,'0',exit_on_error	# 	if charakter is not ('0'..'9') and is not ('A'..'F') then
	  bgt $v0,'F',exit_on_error	# 			goto exit_on_error
	  ble $v0,'9',isHex			# 		else 	
	  bge $v0,'A',isHex			# 			goto isHex
	  j exit_on_error		    #		
isHex:	
        sll $t1,$t1,8		    # 	shift left $t1
		or $t1,$t1,$v0			# 	pack $v0 to $t1 
		addi $t0,-1		        # 	counter = counter - 1
		j loop				    #   goto loop
		
# ------------------- Calculate Decimal Number -----------------------------		

exit_loop:	la $a0,CRLF				# print '\n'
			li $v0,4			    #
			syscall			        # 
			lw $t3,result			# result = 0
			addi $t0,4			    # counter = 4
			lw $t4,pow			    # power = 1
			lw $s1,mask			    # $s1 = 255 (mask = 11111111)
loop2:	beq $t0,0,exit_loop2			# while counter != 0 do
		and $t2,$t1,$s1				# 	$t2 =  least significant byte from $t1 (unpack)
		srl $t1,$t1,8				# 	shift right $t1 
		ble $t2,'A',label			# 	if $t2 is letter A..F then 
		addi $t2,-55				# 		$t2 = $t2 - 55
		j endlabel                  #
label:  addi $t2,-48				# 	else 
endlabel:						    #		$t2 = $t2 - 48
		mul $t2,$t2,$t4				# 	$t2 = $t2 * power
		addi $t5, $zero, 16         #   power = power * 16
        mul $t4,$t4,$t5				# 	
		addi $t0,-1				    # 	counter = counter - 1
		add $t3,$t3,$t2			# 	result = result + $t2
		j loop2				        # goto loop2

# ------------------- Print Results ------------------------------------		

exit_loop2:	
           move $a1, $t3		# print result
		   li $v0,1			    #
		   syscall				# 
		   j exit			    # goto exit
exit_on_error:			        # 
		      la $a0,CRLF		# print '\n'
		      li $v0,4			#
		      syscall		    # 
		      la $a2,error		# print error message
		      li $v0,4			#
		      syscall		    #
exit:					        # 
	la $a0,CRLF					# print '\n'
	li $v0,4					#
	syscall					    #			
	li $v0,10                   # exit
    syscall					    # 
						        #

	.data
	
error: .asciiz "Wrong Hex Number ..." 
counter: .word 4
result: .word 0
pow: .word 1
mask: .word 255
CRLF: .asciiz "\n"