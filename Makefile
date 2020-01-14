LIB ?= /usr/local/lib
INC = /usr/local/faust


DESTDIR ?=
PREFIX ?= 

prefix := $(DESTDIR)$(PREFIX)

all: midiPlayer simplePlayer2 mcMidiPlayer
midiPlayer: simpleLecteur.cpp
	$(CXX)  -std=c++17 -O3 simpleLecteur.cpp   -L/c://jack/lib  -ljack64 -lsndfile -I/usr/local/include -L/usr/local/lib -lOSCFaust  -lfaust -I/usr/include/gtk-2.0  -lfontconfig -lfreetype -lpthread `pkg-config --libs --cflags gtk+-2.0 ` -o midiPlayer.exe

simplePlayer2: simpleLecteur2.cpp
	$(CXX)  -std=c++17 -O3 simpleLecteur2.cpp  -L/c://jack/lib   -ljack64 -lsndfile -I/usr/include/gtk-2.0 -I/usr/local/include -L/usr/local/lib -lfaust -lfontconfig -lfreetype -lpthread `pkg-config  --libs --cflags gtk+-2.0  ` -lOSCFaust -o simplePlayer2.exe

 
mcMidiPlayer: main.cpp 
	$(CXX)  -std=c++17 -O3 parametres.cpp parametres.h info.cpp info.h selectFile.cpp selectFile.h Application.cpp main.cpp Application.h   -I$(INC) -lboost_system-mt -lboost_filesystem-mt   -I/usr/include/gtk-2.0 -I/usr/local/include -L/usr/local/lib  -lfaust -lOSCFaust -lsfml-graphics -lsfml-window -lsfml-system -lfontconfig -lfreetype -lpthread `pkg-config  --libs --cflags gtk+-2.0   `  -o mcMidiPlayer.exe


install: 
	cp mcMidiPlayer.sh $(prefix)/bin
	chmod 755 $(prefix)/bin/mcMidiPlayer.sh
	cp mcMidiPlayer.bin  $(prefix)/bin
	chmod 755 $(prefix)/bin/mcMidiPlayer.bin
	mkdir $(prefix)/share/mcMidiPlayer 
	cp -Rfa Themes $(prefix)/share/mcMidiPlayer
	cp -Rfa gui $(prefix)/share/mcMidiPlayer
	cp -Rfa Lang $(prefix)/share/mcMidiPlayer
	cp midiPlayer $(prefix)/share/mcMidiPlayer
	chmod 755 $(prefix)/share/mcMidiPlayer
	cp simplePlayer2 $(prefix)/share/mcMidiPlayer
	chmod 755 $(prefix)/share/mcMidiPlayer
	cp parametres.conf $(prefix)/share/mcMidiPlayer


clean:
	rm -f mcMidiPlayer.bin


