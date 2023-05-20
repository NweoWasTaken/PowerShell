$s=$m=$h=0;$e=":";for(1){cls;function x($v){if($v-lt10){return "0"+$v}return "$v"}if($s-gt59){$s=0;$m++}if($m-gt59){$m=0;$h++}$a=x $s;$b=x $m;$c=x $h;"$c$e$b$e$a";$s++;Start-Sleep -S 1}
