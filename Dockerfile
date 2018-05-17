FROM alpine:latest
MAINTAINER Jian Li <gunine@sk.com>

# add ssh and iptables
RUN apk add --no-cache openssh iptables ip6tables iproute2 drill

# add entrypoint script
COPY docker-entrypoint.sh /runssh.sh
RUN chmod +x /runssh.sh

RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

RUN mkdir /var/run/sshd

# permit root ssh
RUN sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin yes/' /etc/ssh/sshd_config

# accept SSH connection
EXPOSE 22

ENTRYPOINT ["/runssh.sh"]
CMD ["/usr/sbin/sshd", "-D"]
