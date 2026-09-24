
## Feature-2 Report Questions

### 1. Linking rule: $(TARGET): $(OBJECTS)
Ye rule batata hai ke final executable ($(TARGET)) directly saare object files 
($(OBJECTS)) ko compile aur link kar ke banta hai — koi intermediate library 
nahi banti. Compiler har .o file ko dhoondta hai aur unhe seedha ek saath 
link kar deta hai executable banane ke liye.

Library ke saath link karne wale rule me ($(TARGET): $(OBJECTS) $(LIBS)) 
hum -L (library path) aur -l (library name) flags use karte hain, jisse 
linker pehle se compiled .a (static) ya .so (dynamic) library ko dhoondta 
hai aur usse link karta hai, instead of raw object files ko directly link 
karne ke. Is se code reusability aur modularity behtar hoti hai.

### 2. Git Tag
Git tag ek specific commit ko mark karta hai as an important point in project 
history, jaise ek stable release version. Ye useful hai kyunki ye humein 
specific versions ko easily identify aur checkout karne deta hai without 
remembering commit hashes.

Simple tag sirf ek label hota hai (commit ka pointer), jabke Annotated tag 
ek full Git object hota hai jisme tagger ka naam, email, date, aur ek message 
store hota hai — jaise ek mini commit. Annotated tags releases ke liye 
recommended hain kyunki inme extra metadata aur signing support hoti hai.

### 3. GitHub Release
GitHub pe "Release" banane ka purpose hai project ka ek stable, versioned 
snapshot users ke liye distribute karna, jisme changelog aur compiled files 
attached ho sakti hain.

Binary (jaise client executable) attach karne ki significance ye hai ke 
end-users ko source code compile karne ki zaroorat nahi padti — wo directly 
ready-made, tested executable download kar ke use kar sakte hain, jo especially 
un logon ke liye helpful hai jinke paas build tools (compiler, make) install 
nahi hain.

## Feature-3 Report Questions

### 1. Makefile comparison (Part 2 vs Part 3)
Part 2 ke Makefile me saare object files (main.o, mystrfunctions.o, 
myfilefunctions.o) directly link kar ke executable banaya jata tha:
$(TARGET): $(OBJECTS)
    $(CC) $(OBJECTS) -o $(TARGET)

Part 3 me library functions (mystrfunctions.o, myfilefunctions.o) ko pehle 
ar utility se ek static library (libmyutils.a) me bundle kiya jata hai, aur 
phir sirf main.o us library ke against link hota hai:
$(TARGET): $(MAIN_OBJECT) $(LIB)
    $(CC) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $(TARGET)

Key differences: naye variables AR (archiver tool) aur ARFLAGS (rcs flags) 
add hue. Library banane ka naya rule add hua jo ar command use karta hai. 
Linking step me -L (library search path) aur -l (library name) flags add 
hue, jo directly object files link karne ke bajaye compiled library se 
link karte hain.

### 2. ar command aur ranlib
ar (archiver) command multiple object (.o) files ko ek single archive file 
(.a) me combine karta hai, jo static library banane ke liye use hota hai. 
"rcs" flags: r (insert/replace files), c (create archive silently), 
s (index table generate karo).

ranlib archive ke andar ek index (symbol table) generate/update karta hai, 
jisse linker jaldi se pata laga sake ke konsa symbol (function) kis object 
file me hai, bina poori archive scan kiye. Jab hum ar ke sath "s" flag use 
karte hain (jaise humne ARFLAGS = rcs me kiya), to ranlib automatically 
chal jata hai — isliye separate ranlib command chalane ki zaroorat nahi padi.

### 3. nm on client_static
Haan, jab humne nm bin/client_static | grep mystrlen chalaya, to mystrlen 
function ka symbol executable ke andar maujood mila (type 'T', matlab text/
code section me defined hai). 

Ye batata hai ke static linking ke dauran, linker ne library (libmyutils.a) 
se sirf wo functions nikal kar (jo actually use hue hain, jaise mystrlen, 
wordCount, etc.) unhe directly final executable ke andar copy/embed kar diya. 
Isi wajah se static executable size me bara hota hai lekin run-time pe kisi 
external .so file ki zaroorat nahi padti — sab kuch executable ke andar 
self-contained hota hai.
