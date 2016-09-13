ex2:
	ozc -c ex2.oz
	ozengine ex2.ozf
ex1:
	ozc -c ex1.oz
	ozengine ex1.ozf
all:
	ozc -c main.oz
	ozengine main.ozf
