; ----------------------------------------------------------------
; RUNTIME MOTOR - Turing Machine Compiler (Linux x64)
; ----------------------------------------------------------------

section .data
    msg_acc     db " [ACCEPTED]", 10, 0
    len_acc     equ $ - msg_acc
    msg_rej     db " [REJECTED]", 10, 0
    len_rej     equ $ - msg_rej
    msg_lim     db " [LIMIT EXCEEDED]", 10, 0
    len_lim     equ $ - msg_lim
    msg_err_f   db "Error: No se pudo abrir o procesar el archivo.", 10, 0
    len_err_f   equ $ - msg_err_f
    newline     db 10

    global max_steps, step_counter, current_state_is_final, blank_symbol
    max_steps    dq 100
    step_counter dq 0
    blank_symbol db 'B'
    current_state_is_final db 0

section .bss
    tape_buffer  resb 8192
    file_buffer  resb 1
    fd           resq 1
    fd_name      resq 1          ; Puntero al nombre del archivo

section .text
    global _start
    extern run_turing_logic

_start:
    ; --- 1. PROCESAR ARGUMENTOS ---
    pop r15                      ; r15 = argc
    cmp r15, 2
    jl  exit_with_error

    pop rsi                      ; Saltar argv[0] (nombre programa)
    pop rdi                      ; argv[1] -> Nombre del archivo .txt
    mov [fd_name], rdi           ; Guardar puntero al nombre

    ; --- 2. LEER LÍMITE (SI EXISTE) ---
    cmp r15, 3                   ; ¿argc >= 3?
    jl  open_file
    pop rsi                      ; rsi = argv[2] (el número en string)
    call string_to_int
    mov [max_steps], rax

open_file:
    mov rax, 2                   ; sys_open
    mov rdi, [fd_name]           ; Nombre del archivo
    mov rsi, 0                   ; O_RDONLY
    syscall
    test rax, rax
    js  exit_with_error
    mov [fd], rax

read_next_tape:
    ; --- 3. LIMPIAR BUFFER ---
    mov rdi, tape_buffer
    mov al, [blank_symbol]
    mov rcx, 8192
    rep stosb

    ; --- 4. LEER LÍNEA ---
    mov r12, 0                   ; r12 = chars leídos en esta cinta
read_char:
    mov rax, 0                   ; sys_read
    mov rdi, [fd]
    mov rsi, file_buffer
    mov rdx, 1
    syscall

    cmp rax, 0                   ; EOF?
    je  check_empty_finish

    mov al, [file_buffer]
    cmp al, 10                   ; \n?
    je  start_logic

    ; Guardar en buffer
    mov rdi, tape_buffer
    add rdi, r12
    mov [rdi], al
    inc r12
    jmp read_char

check_empty_finish:
    cmp r12, 0
    je  exit_clean

start_logic:
    mov qword [step_counter], 0
    mov byte [current_state_is_final], 0
    mov rdi, tape_buffer
    call run_turing_logic

    push rax                     ; Guardar resultado (posible -1)

    ; --- 5. IMPRIMIR RESULTADO ---
    ; Imprimir solo la parte de la cinta que tiene datos (r12)
    ; o al menos 20 espacios para ver el cambio
    mov rdx, r12
    add rdx, 10                  ; Margen para ver movimiento a la derecha
    mov rax, 1                   ; sys_write
    mov rdi, 1                   ; stdout
    mov rsi, tape_buffer
    syscall

    pop rax
    cmp rax, -1
    je  print_limit
    cmp byte [current_state_is_final], 1
    je  print_accepted
    jmp print_rejected

print_accepted:
    mov rsi, msg_acc
    mov rdx, len_acc
    jmp do_write_status
print_rejected:
    mov rsi, msg_rej
    mov rdx, len_rej
    jmp do_write_status
print_limit:
    mov rsi, msg_lim
    mov rdx, len_lim

do_write_status:
    mov rax, 1
    mov rdi, 1
    syscall
    jmp read_next_tape           ; Intentar leer la siguiente línea

; --- UTILIDADES ---

string_to_int:
    ; Entrada: rsi (puntero a string)
    ; Salida: rax (entero)
    xor rax, rax
.loop:
    movzx rcx, byte [rsi]
    cmp rcx, '0'
    jl  .done
    cmp rcx, '9'
    jg  .done
    sub rcx, '0'
    imul rax, 10
    add rax, rcx
    inc rsi
    jmp .loop
.done:
    ret

exit_clean:
    mov rax, 3                   ; sys_close
    mov rdi, [fd]
    syscall
    mov rax, 60                  ; sys_exit
    xor rdi, rdi
    syscall

exit_with_error:
    mov rax, 1
    mov rdi, 2
    mov rsi, msg_err_f
    mov rdx, len_err_f
    syscall
    mov rax, 60
    mov rdi, 1
    syscall