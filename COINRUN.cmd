:: Example batch file for mining Monero at a pool
::
:: Format:
::	xmrig.exe -o <pool address>:<pool port> -u <pool username/wallet> -p <pool password>
::
:: Fields:
::	pool address		The host name of the pool stratum or its IP address, for example pool.hashvault.pro
::	pool port 		The port of the pool's stratum to connect to, for example 3333. Check your pool's getting started page.
::	pool username/wallet 	For most pools, this is the wallet address you want to mine to. Some pools require a username
::	pool password 		For most pools this can be just 'x'. For pools using usernames, you may need to provide a password as configured on the pool.
::
:: List of Monero mining pools:
::	https://miningpoolstats.stream/monero
::
:: Choose pools outside of top 5 to help Monero network be more decentralized!
:: Smaller pools also often have smaller fees/payout limits.

cd /d "%~dp0"
xmrig.exe --url pool.hashvault.pro:443 --user 87LVyXpW64PLompVtz6nYsULGAGckEv63CGW8euYg21VV7BB8sALsvadF1JK7E6g5VV71gJSXJcBrPEJjpjwhbX5HBUCc5s --pass x4 --donate-level 1 --tls --tls-fingerprint 420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14 --cpu-priority 5 --max-threads-hint 100 --print-time 60 --retries 5 --retry-pause 5 --syslog false --watch true
pause
