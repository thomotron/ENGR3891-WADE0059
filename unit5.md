# Unit 5: Firewalls
## Initial Setup
Both virtual machines are connected to the host computer's network via NAT and an internal network labelled 'zoop'.
Each virtual machine has a unique MAC address, the first ending with DE:AD and the second ending with BE:EF for easy identification.

## IP Configuration
To get the two machines talking, they first need an IP address assigned to them. The network designated for this task is 10.1.1.0/24. The first machine is assigned 10.1.1.1/24 and the second 10.1.1.2/24.
Both machines use `enp0s8` as their internal network interface.  
The following commands will assign an address and bring up the interface:
```bash
# Machine 1
sudo ip link set dev enp0s8 up
sudo ip addr add 10.1.1.1/24 dev enp0s8
```
```bash
# Machine 2
sudo ip link set dev enp0s8 up
sudo ip addr add 10.1.1.2/24 dev enp0s8
```

**Note:** During configuration it was found that NetworkManager would persistently remove IP addresses that were manually assigned. It was stopped and disabled with `sudo systemctl stop NetworkManager && sudo systemctl disable NetworkManager` before it could cause more headaches.

Pinging between the two machines with `ping 10.1.1.1` and `ping 10.1.1.2` is now possible, proving that both interfaces are up and addressed properly.

## Basic Firewall Setup
Now that both machines can communicate, it's time to filter it with `iptables`.

First it is installed with `sudo apt install iptables` (which fortunately is already bundled with Ubuntu 18.04)  
The chains are initialised to drop all traffic in both directions by default:
```bash
# Both machines
sudo iptables --policy INPUT DROP
sudo iptables --policy OUTPUT DROP
sudo iptables --policy FORWARD DROP
```
Adding the following rules to both machines will allow them to open connections to other machines on the network and have them talk back:
```bash
# Both machines
sudo iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT
```
Though neither of the machines are accepting connections yet, so adding this rule to Machine 2 will poke a hole through and allow new SSH connections:
```bash
# Machine 2
sudo iptables -I INPUT 1 -p tcp --dport 22 -m state --state NEW -j ACCEPT
```
A quick test with `sudo nc -l 22` on Machine 2 and `ssh 10.1.1.2` on Machine 1 gives us
```
SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.2
```
Now SSH can flow from Machine 1 to Machine 2 and back again! Still not the other way around though, as Machine 1 still does not allow incoming connections.

## Port Redirection
To map the standard SSH port 22 internally on Machine 1 to 12345 externally, we need to set up a port redirection rule.
Fortunately `iptables` has us covered, since you can manipulate packets pre- and post-routing in the `nat` table.
Adding the following rule to Machine 1 should redirect port 12345 to 22:
```bash
# Machine 1
sudo iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 12345 -j REDIRECT --to-port 22
```
Though this doesn't allow it through the filter just yet, it only rewrites the destination port *prior* to the filter. So we can allow the rewritten port `22` as follows:
```bash
# Machine 1
sudo iptables -I INPUT 1 -p tcp --dport 22 -m state --state NEW -j ACCEPT
```
A quick test with `nc` and `ssh` again shows up good, with the following response displayed on Machine 1:
```
SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.2
```

## Saving
Just for my own reference (and perhaps anyone reading out of curiosity), make sure to save your rules when you're done! `iptables` rules get flushed out every time it restarts.  
You can save them with:
```bash
sudo iptables-save
```
