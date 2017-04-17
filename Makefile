ALL: parser server 
CC = gcc
CFALGS = -Wall -O2 -g 

SDIR = src
ODIR = obj
TDIR = tool

IDIR = -I$(SDIR) -I$(ODIR) -I$(TDIR)
LDIR = -Llib
LIBS = -lpthread

SRCS = $(wildcard $(SDIR)/*.c)
OBJS = $(patsubst $(SDIR)/%.c,$(ODIR)/%.o,$(wildcard $(SDIR)/*.c))


parser:
	yacc --defines=$(ODIR)/parser.h $(TDIR)/parser.y -o $(ODIR)/parser.tab.c
	lex --outfile=$(ODIR)/parser.lex.c $(TDIR)/parser.l

PARSER_OBJ = $(ODIR)/parser.lex.c $(ODIR)/parser.tab.c


$(ODIR)/%.o:$(SDIR)/%.c
	$(CC) -o $@ -c $(CFLAGS) $< $(IDIR)


server: $(OBJS)
	$(CC) -o server $(CFLAGS) $(OBJS) $(IDIR) \
	$(PARSER_OBJ)


clean:
	rm -rf $(ODIR)/*
	rm -rf server


