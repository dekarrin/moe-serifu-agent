ODIR?=obj
SDIR?=src

CXX?=g++
CXXFLAGS?=-std=c++11 -Wall -Wextra -Wpedantic -pthread -I$(SDIR) -include compat/compat.hpp

DEP_TARGETS?=agent.o util.o msa.o event/event.o event/handler.o event/dispatch.o input.o string.o configuration.o cmd.o log.o
DEP_INCS=$(patsubst %.o,$(SDIR)/%.hpp,$(DEP_TARGETS))
DEP_OBJS=$(patsubst %,$(ODIR)/%,$(DEP_TARGETS))

.PHONY: clean test all debug

all: moe-serifu

debug: CXXFLAGS += -g -O0 -Werror
debug: moe-serifu

test: debug
	valgrind --leak-check=yes --track-origins=yes moe-serifu

clean:
	rm -f $(ODIR)/*.o
	rm -rf $(ODIR)
	rm -f moe-serifu


# -------------- #
#  Dir Recipies  #
# -------------- #

$(ODIR):
	mkdir -p $(ODIR)

$(ODIR)/event: $(ODIR)
	mkdir -p $(ODIR)/event


# ----------------- #
#  Binary Recipies  #
# ----------------- #

moe-serifu: $(ODIR)/main.o $(DEP_OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

$(ODIR)/main.o: $(ODIR) $(SDIR)/main.cpp $(DEP_INCS)
	$(CXX) -c -o $@ $(SDIR)/main.cpp $(CXXFLAGS)

$(ODIR)/msa.o: $(ODIR) $(SDIR)/msa.cpp $(SDIR)/msa.hpp $(SDIR)/input.hpp $(SDIR)/event/dispatch.hpp $(SDIR)/agent.hpp $(SDIR)/configuration.hpp $(SDIR)/cmd.hpp
	$(CXX) -c -o $@ $(SDIR)/msa.cpp $(CXXFLAGS)

$(ODIR)/configuration.o: $(ODIR) $(SDIR)/configuration.cpp $(SDIR)/configuration.hpp $(SDIR)/string.hpp
	$(CXX) -c -o $@ $(SDIR)/configuration.cpp $(CXXFLAGS)

$(ODIR)/string.o: $(ODIR) $(SDIR)/string.cpp $(SDIR)/string.hpp
	$(CXX) -c -o $@ $(SDIR)/string.cpp $(CXXFLAGS)

$(ODIR)/agent.o: $(ODIR) $(SDIR)/agent.cpp $(SDIR)/agent.hpp $(SDIR)/msa.hpp $(SDIR)/configuration.hpp
	$(CXX) -c -o $@ $(SDIR)/agent.cpp $(CXXFLAGS)

$(ODIR)/util.o: $(ODIR) $(SDIR)/util.cpp $(SDIR)/util.hpp
	$(CXX) -c -o $@ $(SDIR)/util.cpp $(CXXFLAGS)

$(ODIR)/input.o: $(ODIR) $(SDIR)/input.cpp $(SDIR)/input.hpp $(SDIR)/msa.hpp $(SDIR)/event/dispatch.hpp  $(SDIR)/configuration.hpp
	$(CXX) -c -o $@ $(SDIR)/input.cpp $(CXXFLAGS)

$(ODIR)/event/handler.o: $(ODIR)/event $(SDIR)/event/handler.cpp $(SDIR)/msa.hpp $(SDIR)/event/event.hpp
	$(CXX) -c -o $@ $(SDIR)/event/handler.cpp $(CXXFLAGS)

$(ODIR)/event/event.o: $(ODIR)/event $(SDIR)/event/event.cpp $(SDIR)/event/event.hpp
	$(CXX) -c -o $@ $(SDIR)/event/event.cpp $(CXXFLAGS)

$(ODIR)/event/dispatch.o: $(ODIR)/event $(SDIR)/event/dispatch.cpp $(SDIR)/msa.hpp $(SDIR)/event/handler.hpp $(SDIR)/util.hpp $(SDIR)/configuration.hpp
	$(CXX) -c -o $@ $(SDIR)/event/dispatch.cpp $(CXXFLAGS)

$(ODIR)/cmd.o: $(ODIR) $(SDIR)/cmd.cpp $(SDIR)/cmd.hpp $(SDIR)/event/dispatch.hpp
	$(CXX) -c -o $@ $(SDIR)/cmd.cpp $(CXXFLAGS)

$(ODIR)/log.o: $(ODIR) $(SDIR)/log.cpp $(SDIR)/log.hpp $(SDIR)/configuration.hpp $(SDIR)/string.hpp $(SDIR)/util.hpp
	$(CXX) -c -o $@ $(SDIR)/log.cpp $(CXXFLAGS)

