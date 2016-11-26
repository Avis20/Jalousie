package My::CGI;

use strict;
use IO::File;
use Encode;

sub new {
    my ($self, %common) = @_;
    $self = {
        max_upload => 262144,
        data => {},
        tmp => {},
    };
    $self->{max_upload} = $common{'MAX_UPLOAD'} if $common{'MAX_UPLOAD'};
    $self = &_parse_common_data($self);
    bless $self;
    return $self;
}

sub _parse_common_data {
    my $self = shift;
    if ($ENV{'QUERY_STRING'}){
        $self = &_parse_QUERY_STRING($self, 'GET');
    }
    return $self;
}

sub _parse_QUERY_STRING {
    my ($self, $type) = @_;
    my $data;
    if ($type && $type eq 'POST'){

    } else {
        $data = $ENV{'QUERY_STRING'};
    }
    my @pairs = split(/[\?\&\;]/,$data);
    foreach (@pairs){
        my ($param, $value) = split('=', $_, 2);
        next unless $param && $value;
        $param = Encode::decode('utf8', &URLDecode($param));
        $value = Encode::decode('utf8', &URLDecode($value));
        $self = &_include_data($self, $param, $value);
    }
    return $self;
}

sub URLDecode {
    my $self = shift;
    $self =~ tr/+/ /;
    $self =~ s/%([0-9A-Fa-f]{2})/chr(hex($1))/esg;
    return $self;
}

sub _include_data {
    my ($self, $param, $value) = @_;
    $value =~ s/(\x0d\x0a)|(\x0a\x0d)/\n/g;
    if (exists $self->{data}->{$param}){
        if (ref $self->{data}->{$param}){
            push @{$self->{data}->{$param}}, $value; 
        } else {
            $self->{data}->{$param} = [$self->{data}->{$param}, $value];
        };
    } else {
        $self->{data}->{$param} = $value;
    }
    return $self;
}

1;