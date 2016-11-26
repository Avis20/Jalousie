#!/usr/bin/perl
use uni::perl qw/:dumper/;

use Net::SMTP::SSL;
use My::CGI;

my $cgi = My::CGI->new();

=head TODO send post data
# Читаем post данные и делаем из строки хеш
my $from_data;
read(STDIN,$from_data,$ENV{'CONTENT_LENGTH'});
my @res = split '&', $from_data;
my %hash = map {split '=', $_} @res;
=cut

=head STDOUT %ENV
print "<h2>hi</h2>";
foreach (keys %hash){
    print "<p>$_ -> $hash{$_}</p>";
}
print "<h2>$ENV{'QUERY_STRING'}</h2>";
print "</body>";
print "</html>";
=cut

=head Отправляем письмо
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
$smtp->datasend('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">');
$smtp->datasend("<p>Пользователь хочет $cgi->{data}->{what} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>");
$smtp->datasend("<p>Имя $cgi->{data}->{name}</p> &nbsp;&nbsp;&nbsp;&nbsp;");
$smtp->datasend("<p>Телефон $cgi->{data}->{phone} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>");
# $smtp->datasend($msg) or die "Error:".$smtp->message();
$smtp->dataend() or die "Error:".$smtp->message();
$smtp->quit() or die "Error:".$smtp->message();
=cut
print "Content-Type: application/json; charset:utf8\n\n";
print '{"success":"1"}';
