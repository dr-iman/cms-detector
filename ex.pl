#!/usr/bin/perl
#Auto cms detector


use HTTP::Request;
use LWP::UserAgent;
use IO::Select;
use HTTP::Response;
use Term::ANSIColor;
use HTTP::Request::Common qw(POST);
use HTTP::Request::Common qw(GET);
use URI::URL;
use IO::Socket::INET;
my $datetime    = localtime;
$results="results";
    if (-e $results) 
    {
    }
    else
    {
        mkdir $results or die "can't creat dir: $results";
    }
	
	system(($^O eq 'MSWin32') ? 'cls' : 'clear');
	
	
$logo="


:'######::'##::::'##::'######::    ********************************                                                
'##... ##: ###::'###:'##... ##:    * Coded By : DR-IMAN           *                                     
 ##:::..:: ####'####: ##:::..::    * Tel : mrar1yan               *                                 
 ##::::::: ## ### ##:. ######::    * site : Guardiran.org         *                                       
 ##::::::: ##. #: ##::..... ##:    * Usage : perl cms.pl list.txt *                                               
 ##::: ##: ##:.:: ##:'##::: ##:    ********************************                                                
. ######:: ##:::: ##:. ######::                                                    
:......:::..:::::..:::......:::                                                    
'########::'########:'########:'########::'######::'########::'#######::'########::
 ##.... ##: ##.....::... ##..:: ##.....::'##... ##:... ##..::'##.... ##: ##.... ##:
 ##:::: ##: ##:::::::::: ##:::: ##::::::: ##:::..::::: ##:::: ##:::: ##: ##:::: ##:
 ##:::: ##: ######:::::: ##:::: ######::: ##:::::::::: ##:::: ##:::: ##: ########::
 ##:::: ##: ##...::::::: ##:::: ##...:::: ##:::::::::: ##:::: ##:::: ##: ##.. ##:::
 ##:::: ##: ##:::::::::: ##:::: ##::::::: ##::: ##:::: ##:::: ##:::: ##: ##::. ##::
 ########:: ########:::: ##:::: ########:. ######::::: ##::::. #######:: ##:::. ##:
........:::........:::::..:::::........:::......::::::..::::::.......:::..:::::..::


";

print $logo;
print "\t";


open(tarrget,"<$ARGV[0]") or die "Please Insert Websites List\n";
while(<tarrget>){
chomp($_);
$site = $_;
if($site !~ /http:\/\//) { $site = "http://$site/"; };
efrez();
}
sub efrez($site){
$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");
$ua->timeout (10);

my $efreez = $ua->get("$site")->content;
if($efreez =~/wp-content\/themes\/|wp-content\/plugins\/|wordpress/) {
    print ("\n[WORDPRESS] $site\n");
open(save, '>>results/wp.txt');
    print save "$site\n";
    close(save);
}
elsif($efreez =~/<script type=\"text\/javascript\" src=\"\/media\/system\/js\/mootools.js\"><\/script>|Joomla!|Joomla|joomla/) {
    print ("\n[JOOMLA] $site\n",);
open(save, '>>results/jom.txt');
    print save "$site\n";   
    close(save);
    }
elsif($efreez =~/\/modules\/system\/system.menus.css|\/sites\/default\/files\/|<meta name=\"Generator\" content=\"Drupal 7/) {
    print ("\n[DRUPAL] $site\n",);

open(save, '>>results/Drupal.txt'); 
    print save "$site\n";   
    close(save);
    }else{
    print "\n[UNKNOWN] $site\n";
}
}


