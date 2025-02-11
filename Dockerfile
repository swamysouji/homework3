FROM ubuntu AS hw_build
WORKDIR /BUILD
COPY dummy_serv.c .
RUN apt-get update
RUN apt-get install gcc -y
RUN gcc -o dummyserv -static dummy_serv.c
RUN ls -lh /BUILD

FROM scratch AS hw_sratch
COPY --from=hw_build /BUILD/dummyserv /dummyserv
CMD ["/dummyserv", "8081"]
EXPOSE 8081
