.data
matrix: .space 1600
newMatrix: .space 1600
m: .space 4
n: .space 4
p: .space 4
k: .space 4
left: .space 4
right: .space 4
check: .long 1
mSize: .space 4
cript: .space 4
sir: .space 24
fs: .asciz "%d"
fp: .asciz "%d "
fstring: .asciz "%s"
fcriptat: .asciz "0x"
fhex: .asciz "%X"
fchar: .asciz "%c"
newLine: .asciz "\n"
terminator: .asciz "\0"




.text

// afisare matrice
afisare:
mov 4(%esp), %edi
// sar la primul elem
mov n, %eax
add $3, %eax
xor %edx, %edx
mov $4, %ebx
mul %ebx
add %eax, %edi

xor %ecx, %ecx
xor %esi, %esi
xor %eax, %eax

for_line:
mov m, %ebx
cmp %ecx, %ebx 
je fin_afisare

for_col:
mov n, %ebx
cmp %esi, %ebx
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

xor %esi, %esi
add $2, %eax
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

push $0
call fflush
pop %ebx
ret




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
cmp $0, %ecx
je skip_populare

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
add $2, %eax
xor %edx, %edx
mov left, %ebx
inc %ebx
mul %ebx

// linia + coloana
add right, %eax
inc %eax

movl $1, (%edi, %eax, 4)

loop et_loop

skip_populare:



// evolutii
lea k, %ebx
push %ebx
push $fs
call scanf
add $8, %esp
mov k, %ecx

// daca k = 0
cmp $0, %ecx
je no_ev


for_ev:
xor %eax, %eax
cmp %ecx, %eax
je exit_ev
push %ecx

// aleg matricile: edi - matricea curenta, esi - gen viitoare
mov check, %ebx
xor $1, %ebx
cmp %ebx, %eax
jne _2nd
lea matrix, %edi
lea newMatrix, %esi
jmp skip_2nd

_2nd:
lea matrix, %esi
lea newMatrix, %edi

skip_2nd:
mov %ebx, check
// sar la primul element din matricea propriu-zisa
mov n, %eax
add $3, %eax
xor %edx, %edx
mov $4, %ebx
mul %ebx
add %eax, %edi
add %eax, %esi

xor %eax, %eax
xor %ecx, %ecx
xor %edx, %edx



for_l:
mov m, %ebx
cmp %ebx, %ecx
je fin_ev

for_c:
mov n, %ebx
cmp %ebx, %edx
je next_line

// calculez in ebx suma celor 8 vecini
xor %ebx, %ebx

push %ecx
push %eax

mov %eax, %ecx
lea (%edi, %ecx, 4), %eax
add $4, %eax
add (%eax), %ebx
push %eax
sub $8, %eax
add (%eax), %ebx
sub n, %eax
sub n, %eax
sub n, %eax
sub n, %eax
add (%eax), %ebx
sub $4, %eax
add (%eax), %ebx
sub $4, %eax
add (%eax), %ebx
pop %eax
add n, %eax
add n, %eax
add n, %eax
add n, %eax
add (%eax), %ebx
add $4, %eax
add (%eax), %ebx
add $4, %eax
add (%eax), %ebx

pop %eax

// trecem in noua matrice

// verificare daca celula e moarta
lea (%edi, %eax, 4), %ecx
cmpl $0, (%ecx)
je cel_moarta

cel_vie:
lea (%esi, %eax, 4), %ecx

cmp $2, %ebx
je ramane_vie
cmp $3, %ebx
je ramane_vie
movl $0, (%ecx)
jmp skip_ramane_vie

ramane_vie:
movl $1, (%ecx)

skip_ramane_vie:

jmp skip_cel_moarta

cel_moarta:
lea (%esi, %eax, 4), %ecx

cmp $3, %ebx
jne ramane_moarta
movl $1, (%ecx)
jmp skip_ramane_moarta

ramane_moarta:
movl $0, (%ecx)

skip_ramane_moarta:

skip_cel_moarta:

pop %ecx

inc %edx
inc %eax
jmp for_c

next_line:
add $2, %eax
xor %edx, %edx
inc %ecx
jmp for_l

fin_ev:

pop %ecx
dec %ecx
jmp for_ev

exit_ev:

mov n, %eax
add $3, %eax
xor %edx, %edx
mov $4, %ebx
mul %ebx
sub %eax, %esi
push %esi
call afisare
add $4, %esp
jmp skip_no_ev

no_ev:
lea matrix, %esi
push %esi
call afisare
add $4, %esp

skip_no_ev:

push $0
call fflush
pop %ebx

mov $1, %eax
mov $0, %ebx
int $0x80









