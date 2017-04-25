###################################################
# Recipes auto-generated by gendeps.py script.    #
# These recipes should not be edited by hand; any #
# changes will be overwritten.                    #
###################################################

$(ODIR)/agent/agent.o: $(SDIR)/agent/agent.cpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/agent/hooks.hpp $(SDIR)/log.hpp $(SDIR)/output.hpp $(SDIR)/var.hpp
	$(CXX) -c -o $@ $(SDIR)/agent/agent.cpp $(CXXFLAGS)

$(ODIR)/util.o: $(SDIR)/util.cpp $(SDIR)/util.hpp
	$(CXX) -c -o $@ $(SDIR)/util.cpp $(CXXFLAGS)

$(ODIR)/msa.o: $(SDIR)/msa.cpp $(SDIR)/msa.hpp $(SDIR)/agent/agent.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/agent/hooks.hpp $(SDIR)/input/input.hpp $(SDIR)/input/hooks.hpp $(SDIR)/cmd/cmd.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/event/dispatch.hpp $(SDIR)/log.hpp $(SDIR)/output.hpp $(SDIR)/string.hpp $(SDIR)/plugin.hpp
	$(CXX) -c -o $@ $(SDIR)/msa.cpp $(CXXFLAGS)

$(ODIR)/event/event.o: $(SDIR)/event/event.cpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp
	$(CXX) -c -o $@ $(SDIR)/event/event.cpp $(CXXFLAGS)

$(ODIR)/event/handler.o: $(SDIR)/event/handler.cpp $(SDIR)/event/handler.hpp $(SDIR)/msa.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp
	$(CXX) -c -o $@ $(SDIR)/event/handler.cpp $(CXXFLAGS)

$(ODIR)/event/dispatch.o: $(SDIR)/event/dispatch.cpp $(SDIR)/event/dispatch.hpp $(SDIR)/msa.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util.hpp $(SDIR)/log.hpp
	$(CXX) -c -o $@ $(SDIR)/event/dispatch.cpp $(CXXFLAGS)

$(ODIR)/input/input.o: $(SDIR)/input/input.cpp $(SDIR)/input/input.hpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/input/hooks.hpp $(SDIR)/event/dispatch.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/util.hpp $(SDIR)/log.hpp
	$(CXX) -c -o $@ $(SDIR)/input/input.cpp $(CXXFLAGS)

$(ODIR)/string.o: $(SDIR)/string.cpp $(SDIR)/string.hpp
	$(CXX) -c -o $@ $(SDIR)/string.cpp $(CXXFLAGS)

$(ODIR)/cfg/cfg.o: $(SDIR)/cfg/cfg.cpp $(SDIR)/cfg/cfg.hpp $(SDIR)/string.hpp
	$(CXX) -c -o $@ $(SDIR)/cfg/cfg.cpp $(CXXFLAGS)

$(ODIR)/cmd/cmd.o: $(SDIR)/cmd/cmd.cpp $(SDIR)/cmd/cmd.hpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/event/dispatch.hpp $(SDIR)/string.hpp $(SDIR)/agent/agent.hpp $(SDIR)/agent/hooks.hpp $(SDIR)/log.hpp
	$(CXX) -c -o $@ $(SDIR)/cmd/cmd.cpp $(CXXFLAGS)

$(ODIR)/log.o: $(SDIR)/log.cpp $(SDIR)/log.hpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/string.hpp $(SDIR)/util.hpp
	$(CXX) -c -o $@ $(SDIR)/log.cpp $(CXXFLAGS)

$(ODIR)/output.o: $(SDIR)/output.cpp $(SDIR)/output.hpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/log.hpp $(SDIR)/string.hpp
	$(CXX) -c -o $@ $(SDIR)/output.cpp $(CXXFLAGS)

$(ODIR)/var.o: $(SDIR)/var.cpp $(SDIR)/var.hpp
	$(CXX) -c -o $@ $(SDIR)/var.cpp $(CXXFLAGS)

$(ODIR)/plugin.o: $(SDIR)/plugin.cpp $(SDIR)/plugin.hpp $(SDIR)/msa.hpp $(SDIR)/cmd/cmd.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/log.hpp $(SDIR)/agent/agent.hpp $(SDIR)/agent/hooks.hpp $(SDIR)/string.hpp
	$(CXX) -c -o $@ $(SDIR)/plugin.cpp $(CXXFLAGS)

