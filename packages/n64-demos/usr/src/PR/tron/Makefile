#!smake -k
# --------------------------------------------------------------------
#        Copyright (C) 1997,1998 Nintendo. (Originated by SGI)
#
#        $RCSfile: Makefile,v $
#        $Revision: 1.29 $
#        $Date: 1999/04/02 10:14:28 $
# --------------------------------------------------------------------
#
# Makefile for application test case 'tron'
#

include /usr/include/n64/make/PRdefs

FINAL = YES
ifeq ($(FINAL), YES)
OPTIMIZER       = -O2 -std=gnu90
LCDEFS          = -DNDEBUG -D_FINALROM -DF3DEX_GBI_2
N64LIB          = -lultra_rom
else
OPTIMIZER       = -g -std=gnu90
LCDEFS          = -DDEBUG -DF3DEX_GBI_2
N64LIB          = -lultra_d
endif

APP =		tron.out

TARGETS =	tron.n64

HFILES =	tron.h

CODEFILES =	tron.c dram_stack.c dram_yield.c
CODEOBJECTS =	$(CODEFILES:.c=.o)

DATAFILES =	dynamic.c zbuffer.c init.c cfb.c grid.c
DATAOBJECTS =	$(DATAFILES:.c=.o)

CODESEGMENT =	codesegment.o

OBJECTS =	$(CODESEGMENT) $(CODEOBJECTS) $(DATAOBJECTS)

LCINCS =	-I. -I/usr/include/n64 -I/usr/include/n64/PR
LCOPTS =	-mno-shared -G 0
LDIRT  =	$(APP)

LDFLAGS =	$(MKDEPOPT)  -L/usr/lib/n64 -L/usr/lib/n64/PR \
			$(N64LIB) -L$(N64_LIBGCCDIR) -lgcc -lnustd

SOURCES =	Makefile spec $(HFILES) $(CODEFILES) \
		dynamic.c zbuffer.c init.c cfb.c makegrid.c

default:	$(TARGETS)

include $(COMMONRULES)

$(CODESEGMENT):	$(CODEOBJECTS)
		$(LD) -o $(CODESEGMENT) -r $(CODEOBJECTS) $(LDFLAGS)

ifeq ($(FINAL), YES)
$(TARGETS) $(APP):      spec $(OBJECTS) 
	$(MAKEROM) -s 9 -r $(TARGETS) -e $(APP) spec
	makemask $(TARGETS)
else
$(TARGETS) $(APP):      spec $(OBJECTS) 
	$(MAKEROM) -r $(TARGETS) -e $(APP) spec
endif


