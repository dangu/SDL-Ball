ifndef PREFIX
	PREFIX=/usr/local/
endif

DESTDIR?=$(PREFIX)share/games/sdl-ball/

DATADIR?=themes/
BINDIR=bin/

#append -DWITH_WIIUSE to compile with WIIUSE support!
#append -DNOSOUND to compile WITHOUT sound support
STRIP=strip
CXX?=g++

CXXFLAGS+=-g -Wall `sdl-config --cflags` -DDATADIR="\"$(DATADIR)\""

#append -lwiiuse to compile with WIIUSE support
#remove -lSDL_mixer if compiling with -DNOSOUND
LIBS+=-lGL -lGLU `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer

SOURCES=main.cpp display.cpp
OBJECTS=$(SOURCES:.cpp=.o)

EXECUTABLE=sdl-ball

all: $(SOURCES) $(EXECUTABLE)
	
$(EXECUTABLE): $(OBJECTS)
	$(CXX) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $@
#	$(STRIP) $@
#	$@

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $< -o $@

clean:
	rm -f *.o sdl-ball

install: $(EXECUTABLE) install-bin install-data

install-bin:
	mkdir -p $(DESTDIR)
	cp $(EXECUTABLE) $(DESTDIR)
	ln -s $(DESTDIR)$(EXECUTABLE) $(PREFIX)$(BINDIR)

install-data:
	mkdir -p $(DESTDIR)$(DATADIR)
	cp -p -R themes/* $(DESTDIR)$(DATADIR)

remove:
	rm -R ~/.config/sdl-ball
	
