MK_DEPENDS := Makefile.1
MK_SOURCES := Makefile.2
MK_CONF := Makefile.conf
SH_MKDEPENDS := makedepends.sh

-include $(MK_CONF)


-include $(MK_SOURCES)

#$(SRCS)の.cppを.oに変換して格納
OUTS := $(SRCS:%.cpp=%.o)


#デフォルト生成規則
#makedependを実行し、test_implを生成する
$(TARGET) : $(OUTS) mkdep
	$(MAKE) target_impl

#実際のバイナリ生成
target_impl : $(OUTS)
	$(LD) $(OUTS) -o $(TARGET) $(LDFLAGS)

#依存関係
-include $(MK_DEPENDS)

#サフィックスルール
.cpp.o: 
	$(CXX) -c $< -o $@ $(CXXFLAGS)

#コマンド一覧
.PHONY : clean mkdep run

clean :
	find $(SRCDIR) -name "*.o" | while read -r f; do rm -f $$f; done
	rm -f $(TARGET) $(MK_DEPENDS) $(MK_SOURCES)

mkdep :
	bash $(SH_MKDEPENDS)

run : $(TARGET)
	$(TARGET)
