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
xmrig.exe -o zeph.2miners.com:2222 -u ZEPHs9PhgJ89SmXpnQ6BLN7GWxnk2VUaFY1rddTGfG2YH5ksVvZC4ZmDVHcnEEFpWXZB8p8aaK39bJbFdARKyKb3KjNUK91VqFS.ID_1 -p x
pause
