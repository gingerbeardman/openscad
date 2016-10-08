# cross compilation unix->win
# depends on MXE_TARGET_DIR set by scripts/setenv-mingw-xbuild.sh

_MXE_TARGET_DIR = $$(MXE_TARGET_DIR)
message($$_MXE_TARGET_DIR mxe target dir)
!isEmpty(_MXE_TARGET_DIR) {
  message(_MXE_TARGET_DIR $$_MXE_TARGET_DIR)
  LIBS += $$_MXE_TARGET_DIR/lib/libglew32s.a 
  LIBS += $$_MXE_TARGET_DIR/lib/libglut.a 
  LIBS += $$_MXE_TARGET_DIR/lib/libopengl32.a 
  LIBS += $$_MXE_TARGET_DIR/lib/libGLEW.a 
#  exists( $$_MXE_TARGET_DIR/lib/libglaux.a ) {
#    LIBS += $$_MXE_TARGET_DIR/lib/libglaux.a
#  }
  LIBS += $$_MXE_TARGET_DIR/lib/libglu32.a 
  LIBS += $$_MXE_TARGET_DIR/lib/libopencsg.a 
  LIBS += $$_MXE_TARGET_DIR/lib/libmpfr.a 
  LIBS += $$_MXE_TARGET_DIR/lib/libgmp.a 
  LIBS += $$_MXE_TARGET_DIR/lib/libCGAL.a
  LIBS += $$_MXE_TARGET_DIR/lib/libfontconfig.a
  LIBS += $$_MXE_TARGET_DIR/lib/libfreetype.a
  LIBS += $$_MXE_TARGET_DIR/lib/libharfbuzz.a
  LIBS += $$_MXE_TARGET_DIR/lib/libbz2.a
  LIBS += $$_MXE_TARGET_DIR/lib/libexpat.a
  LIBS += $$_MXE_TARGET_DIR/lib/libintl.a
  LIBS += $$_MXE_TARGET_DIR/lib/libiconv.a
}

contains( _MXE_TARGET_DIR, shared ) {
  message(_MXE_TARGET_DIR $$_MXE_TARGET_DIR contained shared)
  # on MXE, the shared library .dll files are under 'bin' not 'lib'.
  QMAKE_LFLAGS += -L./$$_MXE_TARGET_DIR/bin
  LIBS += -lglew32 -lglut -lopengl32 -lGLEW -lglu32
  LIBS += -lopencsg -lmpfr -lgmp -lCGAL 
  LIBS += -lfontconfig -lfreetype -lharfbuzz -lbz2 -lexpat -lintl -liconv
}

!isEmpty(_MXE_TARGET_DIR) {
  message(_MXE_TARGET_DIR $$_MXE_TARGET_DIR)
  QMAKE_CXXFLAGS += -fpermissive
  WINSTACKSIZE = 8388608 # 8MB # github issue 116
  QMAKE_CXXFLAGS += -Wl,--stack,$$WINSTACKSIZE
  LIBS += -Wl,--stack,$$WINSTACKSIZE 
  QMAKE_DEL_FILE = rm -f
  QMAKE_CXXFLAGS_WARN_ON += -Wno-unused-local-typedefs #eigen3
}
