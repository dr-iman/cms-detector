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

system(($^O eq 'MSWin32') ? 'cls' : 'clear');
	
	
print <<logo;                                                        
 _____ _____ _____    ____      _           _           
|     |     |   __|  |    \ ___| |_ ___ ___| |_ ___ ___ 
|   --| | | |__   |  |  |  | -_|  _| -_|  _|  _| . |  _|
|_____|_|_|_|_____|  |____/|___|_| |___|___|_| |___|_|  
logo


print "\nPlease Enter Target List : ";
my $list =<STDIN>;
chomp($list);
open (THETARGET, "<$list") || die "[-] Can't open the Targets List !";
@TARGETS = <THETARGET>;
close THETARGET;
$link=$#TARGETS + 1;
foreach $ma(@TARGETS){

if($ma !~ /http:\/\//,/https:\/\//) { $ma = "http://$ma/"; };
efrez();

sub efrez($ma){
$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");
$ua->timeout (10);

my $efreez = $ua->get("$ma")->content;
if($efreez =~/wp-content\/themes\/|wp-content\/plugins\/|wordpress/) {
    print ("\n[WORDPRESS] $ma\n");
open(save, '>>results/wp.txt');
    print save "$ma\n";
    close(save);
}
elsif($efreez =~/<script type=\"text\/javascript\" src=\"\/media\/system\/js\/mootools.js\"><\/script>|Joomla!|Joomla|joomla/) {
    print ("\n[JOOMLA] $ma\n",);
open(save, '>>results/jom.txt');
    print save "$ma\n";   
    close(save);
    }
elsif($efreez =~/\/modules\/system\/system.menus.css|\/sites\/default\/files\/|<meta name=\"Generator\" content=\"Drupal 7/) {
    print ("\n[DRUPAL] $ma\n",);

open(save, '>>results/Drupal.txt'); 
    print save "$ma\n";   
    close(save);
    }else{
    print "\n[UNKNOWN] $ma\n";
}
}
}
