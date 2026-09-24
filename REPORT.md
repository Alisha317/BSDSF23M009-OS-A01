
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
