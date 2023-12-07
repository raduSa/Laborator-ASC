.data
matrix: .space 1600
m: .space 4
n: .space 4
p: .space 4
left: .space 4
right: .space 4
fs: .asciz "%d"
fp: .asciz "%d "
newLine: .asciz "\n"

.text
.global main
main:
// citire var
push $m
push $fs
call scanf
add $8, %esp

push $n
push $fs
call scanf
add $8, %esp

push $p
push $fs
call scanf
add $8, %esp



// populare cu puncte
mov p, %ecx

et_loop:
push %ecx
push $left
push $fs
call scanf
add $8, %esp

push $right
push $fs
call scanf
add $8, %esp
pop %ecx

lea matrix, %edi
// linia
mov n, %eax
xor %edx, %edx
mull left
// linia + coloana
add right, %eax

movl $1, (%edi, %eax, 4)

loop et_loop



// afisare matrice
afisare:
lea matrix, %edi
xor %ecx, %ecx
xor %esi, %esi
xor %eax, %eax

for_line:
cmp %ecx, m
je fin_afisare

for_col:
cmp %esi, n
je nxt_line

lea (%edi, %eax, 4), %ebx
push %eax
push %ecx

push (%ebx)
push $fp
call printf
add $8, %esp

push $0
call fflush
pop %ebx

pop %ecx
pop %eax

inc %eax
inc %esi

jmp for_col

nxt_line:

inc %eax
xor %esi, %esi
inc %ecx

push %eax
push %ecx

push $newLine
call printf
add $4, %esp

push $0
call fflush
pop %ebx

pop %ecx
pop %eax
jmp for_line

fin_afisare:




mov $1, %eax
mov $0, %ebx
int $0x80










