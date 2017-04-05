
#!/usr/bin/env bash
# Description: get transmission/received data amount of current net interface


wget -q -t 2 -T 5 -O- "https://www.mvg.de/dienste/betriebsaenderungen.html#1" | sed -nr '200,400{/table-row-betriebsaenderungen betriebsaenderungen-highlight/,+20{/line-summary (sbahn|ubahn)/,+1{/(U|S)/p}; /data-title="Zeitraum"/,+1{/[0-9]{2}\.[0-9]{2}\.[0-9]{4}/p}; s/<b>(.*)<\/b>/\1/p}}';

#wget -q -t 2 -T 5 -O- "https://img.srv2.de/customer/sbahnMuenchen/newsticker/newsticker.html" | sed -n '50,150{/var apgWxInfoObj/,+10 s/.*cu:.*hi: .\([0-9-]*\).*/\1°C/p}';

exit 0


