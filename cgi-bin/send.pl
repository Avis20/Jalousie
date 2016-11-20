#!/usr/bin/perl
use uni::perl qw/:dumper/;

use Net::SMTP::SSL;

print "Content-type:text/html\n\n";
print "<body>";
print "<html>";

# Читаем post данные и делаем из строки хеш
my $from_data;
read(STDIN,$from_data,$ENV{'CONTENT_LENGTH'});
my @res = split '&', $from_data;
my %aha = map {split '=', $_} @res;

# $msg .= "Пользователь хочет: " . $aha{what};
# =head
print "<h2>hi</h2>";
print "<h2>$aha{what}</h2>";
print "<h2>$ENV{'QUERY_STRING'}</h2>";
print "</body>";
print "</html>";

# Отправляем письмо
my $user = 'orlov.avis20@gmail.com';
my $pass = '1234567890google';

my $smtp;
$smtp = Net::SMTP::SSL->new('smtp.googlemail.com', Port=>465) or die "Can't connect";
$smtp->auth($user, $pass) or die "Can't authenticate:".$smtp->message();
$smtp->mail('orlov.avis20@gmail.com') or die "Error:".$smtp->message();
$smtp->to('orlov.avis@yandex.ru') or die "Error:".$smtp->message();
$smtp->data() or die "Error:".$smtp->message();
$smtp->datasend("Content-type: text/html\nSubject: Заявка с сайта жалюзи\nTo: orlov.avis20\@gmail.com\nFrom: orlov.avis\@yandex.ru\n");
$smtp->datasend("\n");
$smtp->datasend("A simple test message<br>$aha{what} <br />$aha{name} <br />$aha{phone} ");
# $smtp->datasend($msg) or die "Error:".$smtp->message();
$smtp->dataend() or die "Error:".$smtp->message();
$smtp->quit() or die "Error:".$smtp->message();
=cut