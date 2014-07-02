cd ~
rm -r tor-browser_en-US
rm tor-browser-linux64*.tar.xz.asc
rm tor-browser-linux64*.tar.xz
torsocks wget -r -l2 --no-parent -A _en-US.tar.xz https://www.torproject.org/dist/torbrowser/
torsocks wget -r -l2 --no-parent -A _en-US.tar.xz.asc https://www.torproject.org/dist/torbrowser/
mv www.torproject.org/dist/torbrowser/*.*.*/tor-browser-linux64*.tar.xz.asc .
mv www.torproject.org/dist/torbrowser/*.*.*/tor-browser-linux64*.tar.xz .
rm -r www.torproject.org
gpg --verify tor-browser-linux64*.tar.xz.asc
tar -x --xz -f tor-browser-linux64-*.tar.xz
cd tor-browser_en-US
chmod +x start-tor-browser
