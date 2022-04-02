#// -----------------------------------------------------------------------------
#/// \file                  Makefile
#/// \brief                 Makefile to build sample application
#/// \author                Sreejith.Naarakathil@gmail.com
#// -----------------------------------------------------------------------------

IDIR =../
CC=gcc
CFLAGS=-I$(IDIR) -DDEBUG

ODIR=.
LDIR =-L../tzdb-2022a/build/usr/lib

LIBS=-ltz

_DEPS = 
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = sample_app.o 
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))


$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

sample_app: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LDIR) $(LIBS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ sample_app