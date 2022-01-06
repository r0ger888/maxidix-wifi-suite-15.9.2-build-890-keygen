To keygen this app :
- get the length and buffer of the name string
- concatenate the name string with the specific bytes (which can also be converted in ASCII) - erh$4S38*d]f^g+.
- initiate them with the variable that saves the sha-1 hashing (in this case i've used some other SHA-1 routine without the cryptohash lib which i've got it from github)
- calculate the length of SHA-1 hashing with lstrlen and create a new variable for the sha length
- compute the SHA hashing on both of the name and hardcored string (which in my case were converted in ascii codes) - i mean, the SHA-1 hashing variable should be created for that.
- convert the hexadecimal chars loaded from SHA hashing to unicode (with Hex2ch or HexToChar) - maximum 20 chars on the length of hex values as the length of the serial should be 20 chars - all the SHA-1 chars should be lowercase only.
- use the Base64 routine and encode the whole SHA string with it - and then save it in the Base64 encoding buffer (you need to create that one on .data?). in this instance, i'd recommend the modified version of it, bug-fixed by Jowy (special 10x to him!) , got it from his keygen for Revenge crew trial 2006 keygenme, which is also on github - but i'm gonna lend the file here since the modified version is indeed a ripped one) (NOTE : encode it only from the SHA digest,not the SHA string itself!)
- and as usual, clean the whole memory for the name string, SHA hash variable,SHA name variable and the Base64 encoding buffer with RtlZeroMemory.

Yeah,it was a little medium from the point of view of difficulty, but not that "challenging" as i expected to be..but anyway that's how I wrote an sha-1 keygen with Base64 encoding.
