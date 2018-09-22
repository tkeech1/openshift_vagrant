;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	ns1.tkeech.io. admin.tkeech.io. (
			      3		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
; name servers - NS records
    IN      NS      ns1.tkeech.io.

; name servers - A records
ns1.tkeech.io.          IN      A      192.168.6.241

; 192.168.6.0/24 - A records
master1.tkeech.io.        IN      A      192.168.6.201
master2.tkeech.io.        IN      A      192.168.6.202
master3.tkeech.io.        IN      A      192.168.6.203
node1.tkeech.io.        IN      A      192.168.6.211
node2.tkeech.io.        IN      A      192.168.6.212
lb1.tkeech.io.        IN      A      192.168.6.221
*.tkeech.io.        300 IN      A      192.168.6.221
