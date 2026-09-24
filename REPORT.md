# REPORT.md

This report documents the analysis and answers for the Operating Systems
assignment: Building a Multi-file C Project with Static and Dynamic Libraries.

Repository: BSDSF23M009-OS-A01

## Feature-2 Report Questions

### 1. Linking rule: $(TARGET): $(OBJECTS)
This rule states that the final executable ($(TARGET)) is produced by
directly compiling and linking all the object files ($(OBJECTS)) together —
no intermediate library is created. The compiler locates each .o file and
links them all directly together to produce the executable.

A Makefile rule that links against a library instead (e.g.,
$(TARGET): $(OBJECTS) $(LIBS)) uses the -L (library path) and -l (library
name) flags, which tell the linker to locate and link against a precompiled
.a (static) or .so (dynamic) library, instead of directly linking raw object
files. This improves code reusability and modularity.

### 2. Git Tag
A Git tag marks a specific commit as an important point in the project's
history, such as a stable release version. It is useful because it allows
specific versions to be easily identified and checked out without needing to
remember commit hashes.

A simple tag is just a label (a pointer to a commit), whereas an annotated
tag is a full Git object that stores the tagger's name, email, date, and a
message — similar to a mini commit. Annotated tags are recommended for
releases because they carry additional metadata and support signing.

### 3. GitHub Release
The purpose of creating a "Release" on GitHub is to distribute a stable,
versioned snapshot of the project to users, which can include a changelog
and attached compiled files.

The significance of attaching a binary (such as the client executable) is
that end-users do not need to compile the source code themselves — they can
directly download a ready-made, tested executable and use it. This is
especially helpful for users who do not have build tools (compiler, make)
installed on their system.

## Feature-3 Report Questions

### 1. Makefile comparison (Part 2 vs Part 3)
In Part 2's Makefile, all object files (main.o, mystrfunctions.o,
myfilefunctions.o) were linked directly to produce the executable:

    $(TARGET): $(OBJECTS)
        $(CC) $(OBJECTS) -o $(TARGET)

In Part 3, the library functions (mystrfunctions.o, myfilefunctions.o) are
first bundled into a static library (libmyutils.a) using the ar utility, and
then only main.o is linked against that library:

    $(TARGET): $(MAIN_OBJECT) $(LIB)
        $(CC) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $(TARGET)

Key differences: new variables AR (archiver tool) and ARFLAGS (rcs flags)
were added. A new rule was added to build the library using the ar command.
In the linking step, the -L (library search path) and -l (library name)
flags were added, which link against the compiled library instead of
directly linking the object files.

### 2. The ar command and ranlib
The ar (archiver) command combines multiple object (.o) files into a single
archive file (.a), which is used to create a static library. The "rcs"
flags mean: r (insert/replace files), c (create the archive silently),
s (generate an index/symbol table).

ranlib generates/updates an index (symbol table) inside the archive, which
allows the linker to quickly determine which object file contains a given
symbol (function), without scanning the entire archive. Since the "s" flag
was used along with ar (as in ARFLAGS = rcs), ranlib runs automatically —
so there was no need to run a separate ranlib command.

### 3. nm on client_static
Yes, when nm bin/client_static | grep mystrlen was run, the mystrlen
function's symbol was found present inside the executable (with type 'T',
meaning it is defined in the text/code section).

This shows that during static linking, the linker extracted the functions
that are actually used from the library (libmyutils.a) — such as mystrlen,
wordCount, etc. — and copied/embedded them directly into the final
executable. This is why a statically linked executable is larger in size,
but does not require any external .so file at runtime — everything is
self-contained within the executable.

Note: readelf -d bin/client_static shows libc.so.6 listed as a NEEDED
shared library. This means that while our own custom functions (mystrlen,
wordCount, etc.) are embedded into the executable statically, the system's
standard C library (libc) is still dynamically linked by default, unless
the -static flag is explicitly used.
