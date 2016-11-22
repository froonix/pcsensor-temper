all:	pcsensor

CFLAGS = -O2 -Wall

pcsensor:	pcsensor.c
	${CC} -DUNIT_TEST -o $@ $^ -lusb

clean:
	rm -f pcsensor *.o
