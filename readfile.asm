    .model small

    .stack  100h 

    .data 
            filename    db 255 dup(0)   ;deklarasikan namafile
            text        db 255 dup(0)
            char        db ?
            line        db 255 dup(0)           

            filehandle  dw ?            ;cek file, sudah di buka atau belum

    .code 
            newline macro    ;baris baru 
                             ;
            mov dl, 10       ;
            mov ah, 02h      ;                   
            int 21h          ;
                             ;
            mov dl, 13       ;
            mov ah, 02h      ;
            int 21h          ;                
            endm             ;baris baru
    main:   

            mov ax, @data    
            mov ds, ax   

            lea si, filename
            mov ah, 01h      ;baca file per baris

    char_input:

            int 21h         

            cmp al, 0dh      ;baris baru     
            je zero_terminator

            mov [si], al    
            inc si

            jmp char_input  

    zero_terminator:

            mov [si], 0 

    open_file:

            lea dx, filename         
            mov al, 0          
            mov ah, 3Dh      ;buka file
            int 21h  

            mov filehandle, ax

            lea si, text   

            newline

    read_line:
            mov ah, 3Fh      ;baca file
            mov bx, filehandle  
            lea dx, char         
            mov cx, 1  

            int 21h  

            cmp ax, 0       ;EOF            
            je EO_file

            mov al, char        

            cmp al, 0ah     ;temp feed
            je LF  

            mov [si], al
            inc si      

            jmp read_line:

    EO_file:

            lea dx, text
            mov ah, 40h     ;cetak! 
            mov cx, 255
            mov bx, 1       
            int 21h

            mov ah, 4ch     
            int 21h 

    LF:       
            lea dx, text
            mov ah, 40h     ;print
            mov cx, 255
            mov bx, 1

            int 21h

            inc si
            jmp read_line

     end main  
