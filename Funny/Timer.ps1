$s=$m=$h=0;$e=":";for(1){cls;function x($v){if($v-lt10){return "0"+$v}return "$v"}if($s-eq60){$s=0;$m++;if($m-eq60){$m=0;$h++}}$a=x $s;$b=x $m;$c=x $h;$t="$c$e$b$e$a";"$t";$s++;Start-Sleep -S 1}
