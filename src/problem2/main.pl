use strict;
use warnings;

# ライブラリのロードパスを設定
use File::Basename;
use lib dirname(__FILE__).'/lib';
use My::List;

my $list = My::List->new;

$list->append("Hello");
$list->append("World");
$list->append(2008);

my $iter = $list->iterator;
while ($iter->has_next) {
    print $iter->next->value;
}
