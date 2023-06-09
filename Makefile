.PHONY: clean

TAG := pam_donau_adopt.so

SRC := $(wildcard  *.c)
OBJ := $(patsubst %.c,%.o,$(SRC))

C_FLAGS := -fstack-protector-strong -D_FORTIFY_SOURCE=2 -O2 -ftrapv -fstack-check -fPIC
LD_FLAGS := -Wl,-z,now,-z,noexecstack,-z,relro -s

all:$(OBJ)
	$(CC) -shared $< -o $(TAG) $(LD_FLAGS)

%.o:%.c
	$(CC) -c $< $(C_FLAGS)

clean:
	$(RM) *.o $(TAG)

install:
	if [ -d /lib64/security ]; then chown root:root $(TAG); chmod 500 $(TAG); \cp -p $(TAG) /lib64/security; fi;
	if [ -d /lib/aarch64-linux-gnu/security ]; then chown root:root $(TAG); chmod 500 $(TAG); \cp -p $(TAG) /lib/aarch64-linux-gnu/security; fi;
