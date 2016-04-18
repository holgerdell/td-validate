CXXFLAGS=-std=c++11 -O3 -march=native -Wall -Wextra

.PHONY: all
all: td-validate

.PHONY: test
test: td-validate
	./run_test.sh

.PHONY: clean
clean:
	rm -f td-validate
