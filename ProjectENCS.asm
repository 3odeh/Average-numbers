.model small
.stack 1000
.data

    
    
    
    msg1 db "Please enter the size of numbers: $"
    msg2 db "Please enter the number of numbers: $"
    msg3 db "Please enter the number : $"
    msg4 db "The Sumation = $"
    msg5 db "The Avarege = $"
    
    errorMsg1 db 0DH,0AH,"Error, please enter number not char: $" 
    errorMsg2 db 0DH,0AH,"Error, please enter number is not zero: $"
    errorMsg3 db 0DH,0AH,"Error, the size of byte is full",0DH,0AH ,"Please enter the number:$" 
    newLine db 0DH,0AH,"$"
    
    n db ? 
    size db ?
    
    inputSize db ? 
    
    Sumation db ?    
    sum db 50 dup(0)
    
.code
.startup


     call getValueN
    
     lea dx , newLine 
     call print
     
     call getSize 
       
     lea dx , newLine 
     call print     
      
     mov cl ,n
     mov ch,0     
     loopingHere:

        push cx
                                 
        call getNumberFromUser 
        lea dx , newLine 
        call print
        
        pop cx
     
     loop loopingHere  
    
     
     call checkSumation     
     
     lea dx,msg4
     call print
     call printSum 
     
     lea dx,newLine
     call print
     
     
     call calculateAva 
     
     lea dx,msg5
     call print
     call printAva
  
   
     call theEnd
     
     
         
          
print: 
     
    mov Ah,9
    int 21h
    ret      
   
printChar: 

    mov Ah,2
    int 21h
    ret 
    
read:
     
    mov Ah , 0Ah             
    int 21h
    ret
    
readChar: 

    mov Ah , 01h             
    int 21h
    ret 
         
         
getValueN: 

    mov si , 0
    mov bx , 0
    mov cx , 0 
    lea dx,msg2          
    call print 
  
    
    
    valueGetNumber:
     
        
     call readChar 
     
     cmp al ,0Dh ; when user pres enter
     je valueEndGetNumber
     
     cmp al,30h 
     jl valueError ; if input is less then 0 in ascii
     cmp al,39h
     jg valueError ; if input is grater then 9 in ascii
     
     
        
     mov ah,0   
     push ax     
     inc si
     
     jmp valueGetNumber
     
    valueError: 
    
    
        lea dx,errorMsg1
        call print
        call clearStackData 
         
        mov si , 0
        mov bx , 0
        mov cx , 0
        jmp valueGetNumber  

    valueEndGetNumber:

    
    mov cx , si 
    mov si , 0
    mov ax , 0 
    
    cmp cx,0 ; when user does not enter number
    je valueIsEmpty
   
    valueL1:
         pop dx
         sub dx,30h
         
         mov bl , 10 
         
         push ax
         
         mov ax , 1
         
         cmp si , 0
         je valueSkipL2   
         
         push cx  
         mov cx , si
         
        
         valueL2:
            
            mul bl
            
         loop valueL2          
         pop cx 
         
         valueSkipL2:
         mul dl
                  
         pop bx
         
         add ax , bx
        
         inc si
    loop valueL1     

    
    valueCon1: 
    
    cmp al , 0
    je valueIsEmpty
    
    
    
    mov [n] ,al
    mov si , 0
    mov bx , 0
    mov cx , 0
    
    ret
    
    valueIsEmpty: 
  
    lea dx,errorMsg2
    call print
    mov si , 0
    mov bx , 0
    mov cx , 0
    jmp valueGetNumber



getSize:

    mov si , 0
    mov bx , 0
    mov cx , 0 
    lea dx,msg1          
    call print
    
    sizeGetNumber:
     
        
     call readChar 
     
     cmp al ,0Dh ; when user pres enter
     je sizeEndGetNumber
     
     cmp al,30h 
     jl sizeError ; if input is less then 0 in ascii
     cmp al,39h
     jg sizeError ; if input is grater then 9 in ascii
        
     mov ah,0   
     push ax     
     inc si
     
     jmp sizeGetNumber
     
    sizeError: 
    
    
        lea dx,errorMsg1
        call print
        call clearStackData 
         
        mov si , 0
        mov bx , 0
        mov cx , 0
        jmp sizeGetNumber  

    sizeEndGetNumber:

    
    mov cx , si 
    mov si , 0
    mov ax , 0 
    
    cmp cx,0 ; when user does not enter number
    je sizeIsEmpty
   
    sizeL1:
         pop dx
         sub dx,30h
         
         mov bl , 10 
         
         push ax
         
         mov ax , 1
         
         cmp si , 0
         je sizeSkipL2   
         
         push cx  
         mov cx , si
         
        
         sizeL2:
            
            mul bl
            
         loop sizeL2          
         pop cx 
         
         sizeSkipL2:
         mul dl
                  
         pop bx
         
         add ax , bx
        
         inc si
    loop sizeL1     

    
    sizeCon1: 
    
    cmp al , 0
    je sizeIsEmpty
    
    
    
    mov [size] ,al
    mov si , 0
    mov bx , 0
    mov cx , 0
    
    ret
    
    sizeIsEmpty: 
  
    lea dx,errorMsg2
    call print
    mov si , 0
    mov bx , 0
    mov cx , 0
    jmp sizeGetNumber

                
         
         
getNumberFromUser: 

    mov si , 0
    mov bx , 0
    mov cx , 0 
    lea dx,msg3          
    call print
    
    
       
    getNumber:
     
        
     call readChar 
     
     cmp al ,0Dh
     je endGetNumber
     
     cmp al,30h 
     jl error ; if input is less than 0 in ascii
     cmp al,39h
     jg error ; if input is grater than 9 in ascii   
     
      
     mov dl , [size]
     mov dh,0     
     cmp si , dx
     jge error2 ; if input is grater than size
        
     mov ah,0   
     push ax     
     inc si
     
  
     
     
     jmp getNumber
     
    error: 
    
    
        lea dx,errorMsg1
        call print
        call clearStackData 
         
        mov si , 0
        mov bx , 0
        mov cx , 0 
        
        jmp getNumber
    
    error2: 
    
    
        lea dx,errorMsg3
        call print
        call clearStackData 
         
        mov si , 0
        mov bx , 0
        mov cx , 0
        jmp getNumber      

    endGetNumber:

    
    mov cx , si
    mov [inputSize] , cl
    mov si , 0 
    
    cmp cx,0
    je con1
   
    l1:
         pop dx
         sub dx,30h
         mov al , [sum + si]
         add al , dl
         
         cmp al , 09 ; the sumation is more than 9
         jle con         
         mov bl , al
         mov bh , 0
         
         add al , 6
         
         and al,0FH 
         
         push si
         
         inc si
         mov bl , [sum + si]
         inc bl         
         mov [sum + si] , bl         
         pop si  
         
     
         con:
         mov [sum + si] , al
        
         inc si
         
    loop l1     
    mov al ,[Sumation]
    mov ah,0
    
    cmp ax , si
    jg con1 
    
    mov ax ,si 
    inc ax   
    mov [Sumation] ,al 
    
    con1:
    mov si , 0
    mov bx , 0
    mov cx , 0
    
    ret 
    
    
             
checkSumation:
    
    mov cl , Sumation
    mov ch , 0
    
    mov si , 0 
    
    add cx, 1
    
    
    checkSumationLoop1:
    
        mov dl , [sum + si] 
        cmp dl , 9
        jng checkSumationLoopEnd
        
        add dl , 6
        and dl,0FH
        inc si
        
        mov al , [sum + si]
        inc al       
        mov [sum + si] , al
        
        dec si
        mov [sum + si] ,dl 
              
        checkSumationLoopEnd:
        
        inc si
    loop checkSumationLoop1
    ret               
               
clearStackData:  
    
    pop ax
    mov cx , si
    
    cmp cx, 0
    je leave
    clearLoop:
            
        pop dx
        
    loop clearLoop
    
    
    leave:
    mov dx ,0 
    
    push ax   
    ret  
    
    
    
    
clearSumData:
    pop dx  
    mov cl , Sumation
    mov ch , 0
    mov si , 0     
    cmp cx , 0
    je skipClearSumDataLoop1    
    clearSumDataLoop1:        
        mov al , [sum + si]
        mov ah, 0
        push ax     
        mov  [sum + si] , ah       
        inc si   
    loop clearSumDataLoop1   
    push dx
    ret   
    skipClearSumDataLoop1:       
    push dx 
    ret  
    
         

    
printSum: 

    mov cl , Sumation
    mov ch , 0
    mov si , cx
    dec si 
    cmp cx , 0
    je skipLoopToPrint
    loopToPrint:
    
        mov dl , [sum + si] 
        add dl , 30h
        call printChar
        dec si
    loop loopToPrint 
    
    ret
    
    skipLoopToPrint:
    
    mov dl , 30h
    call printChar
    
    ret 
    
     
    
    
printAva: 

    mov cl , Sumation
    mov ch , 0    
    mov si , 0
    
    cmp cx , 0 
    je skipLoopToPrintAva   
    loopToPrintAva:
    
        mov dl , [sum + si] 
        add dl , 30h
        call printChar
        inc si
    loop loopToPrintAva
    
    ret 
    
    skipLoopToPrintAva:
    
    mov dl , 30h
    call printChar
    
    ret 
    
        

calculateAva:
    
    call clearSumData
    
    mov cl , Sumation

    mov ch , 0

    mov si , 0
    

    mov bl , [n]
    
    mov ax , 0 
    
    
    cmp cx , 0
    je skipAvaLoop1  
    avaLoop1:
        
        pop di
        
        mov dx , 10 
        
        mul dl  
        
        add ax , di
        
        div bl
        
        mov [sum +si] , al
        
        
        mov al,ah
        
        mov ah, 0
        

        inc si 
    loop avaLoop1
    
    skipAvaLoop1:
    ret       
            
        
theEnd:
    .exit
    end 

    
    