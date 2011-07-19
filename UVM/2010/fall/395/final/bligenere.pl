#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use crypto;

#Modulus
my $n = 26*26;
#Alphabet
my $A = $crypto::A;
#All possible mappings of pairs of letters into Z/676Z
my $digrams;

my $i = 0;
foreach my $a (@{$A}){
    foreach my $b (@{$A}){
	$digrams->{$i} = "$a$b";
	$i++;
    }
}

#Cycle a vector, V (passed by ref), 1 place.  
sub cycleVector{
    my $V = shift @_;

    my $temp;
    foreach my $i (reverse 0..($#{$V}-1)){
	$temp = $V->[$i];
	$V->[$i] = $V->[$i + 1];
	$V->[$i + 1] = $temp;
    }
}

sub scalarMult{
    my ($V,$a) = (@_);
    
    foreach my $v (@{$V}){
	$v = $a*$v;
    }
}

sub innerProduct{
    my ($V,$W) = (@_);
    
    #Should probably do some better error checking here..
    if ($#{$V} != $#{$W}){
	print "Mismatched dimensions.  Uh oh.\n". 
	    "V:" . $#{$V} . "\n" . 
	    "W:" . $#{$W} . "\n";
	return;
    }

    my $l = $#{$V};
    
    my $retVal = 0;
    foreach my $i (0..$l){
	$retVal += $V->[$i]*$W->[$i];
    }

    return $retVal;
}

#Decrypt
sub decrypt{
    my ($cipherText, $key) = (@_);
    my $keyLen = $#{$key}+1;
    my $plainText;
    foreach my $i (0..$#{$cipherText}){
	my $index = $cipherText->[$i] - $key->[$i % $keyLen] ;
	$index = $index % $n;
	push @{$plainText}, $digrams->{$index};
    }
    
    return $plainText;
}

my $cipherText = ['401','537','498','526','582','598','268','608','216','558','578','209','464','413',
		  '270','637','582','1','481','334','588','14','142','563','112','49','659','560','141',
		  '95','178','229','494','551','599','526','289','101','562','294','301','395','110',
		  '251','425','468','283','392','557','513','545','7','583','277','230','569','14','551',
		  '268','151','451','123','4','539','647','385','557','57','431','396','480','484','608',
		  '351','371','403','583','183','256','413','504','526','530','87','189','324','400',
		  '638','311','564','124','332','510','641','568','202','217','247','561','638','154',
		  '671','449','38','403','308','473','397','657','101','423','567','582','202','214',
		  '453','270','43','467','598','278','348','11','288','287','251','476','52','326','393',
		  '583','212','215','63','217','266','482','481','615','73','400','327','153','212','74',
		  '610','390','264','79','429','605','409','182','551','634','485','464','409','34','199',
		  '49','474','293','344','39','195','517','209','608','346','221','461','651','174','397',
		  '350','425','344','79','28','579','596','390','639','479','213','228','101','301','550',
		  '112','559','583','205','29','304','578','173','476','235','527','304','266','499',
		  '597','454','408','372','520','671','417','246','494','526','286','215','562','334',
		  '36','78','230','573','423','26','315','185','137','202','328','402','571','551','166',
		  '202','228','349','36','331','647','455','68','608','348','643','647','455','73','59',
		  '270','498','605','162','293','23','222','559','357','183','657','1','554','401','79',
		  '43','573','245','104','479','479','598','589','287','327','130','126','399','215',
		  '491','221','476','582','25','228','337','425','189','464','53','609','365','311','368',
		  '246','559','608','348','0','645','671','499','7','673','556','482','129','498','553',
		  '663','429','289','109','498','217','448','204','490','485','186','214','73','311',
		  '368','245','195','242','604','29','291','10','188','476','539','152','523','105','187',
		  '133','12','672','19','578','455','447','338','207','551','71','199','137','344','10',
		  '407','231','553','393','11','390','364','557','79','256','344','234','299','318','277',
		  '404','240','289','185','553','43','589','521','41','472','371','153','10','344','3',
		  '288','473','500','289','53','44','200','162','11','125','232','225','566','246','559',
		  '608','348','290','662','11','169','400','230','394','7','582','209','137','344','286',
		  '316','244','484','401','537','290','273','168','137','229','53','581','7','574','239',
		  '609','283','573','7','568','483','333','449','560','368','357','171','484','21','426',
		  '44','154','559','661','571','234','299','605','149','230','377','490','88','357','146',
		  '120','323','504','97','160','481','562','454','100','651','12','199','568','591','266',
		  '534','368','484','267','413','654','525','582','599','557','69','329','299','293',
		  '563','567','342','335','45','286','486','109','52','207','212','578','420','491','390',
		  '29','558','584','72','228','52','223','200','462','147','110','131','555','303','260',
		  '483','491','516','546','56','229','77','501','49','108','7','192','70','229','27','581',
		  '193','462','596','334','193','425','238','260','488','110','257','321','225','169',
		  '540','621','636','569','300','240','389','224','45','508','368','527','232','192',
		  '244','293','131','71','17','293','11','319','317','166','507','326','448','379','564',
		  '582','251','120','190','646','253','671','388','517','8','586','287','324','202','214',
		  '453','270','56','251','111','601','569','545','14','647','145','484','33','498','526',
		  '257','57','225','377','550','56','245','388','216','365','264','299','537','395','582',
		  '350','65','524','546','77','233','244','289','303','286','85','270','63','3','624',
		  '133','598','120','53','264','572','287','78','254','603','29','291','463','214','289',
		  '64','390','628','371','232','186','344','587','372','129','209','267','65','599','563',
		  '286','494','234','57','585','528','129','202','222','94','65','144','602','333','451',
		  '513','26','403','491','477','125','242','494','200','322','482','222','604','368',
		  '526','293','202','222','440','322','316','479','489','608','230','556','572','246',
		  '598','608','351','30','476','279','151','120','354','430','4','125','495','256','413',
		  '244','199','547','45','303','89','326','368','79','641','204','602','308','56','647',
		  '160','485','543','221','492','474','474','488','350','65','539','157','195','586',
		  '246','308','665','167','177','144','331','545','657','587','395','3','523','425','356',
		  '85','284','68','613','425','563','543','162','486','609','37','559','584','563','189',
		  '49','15','289','476','108','471','286','36','368','230','79','567','49','617','7','569',
		  '47','275','245','327','8','129','169','553','52','316','528','287','388','589','357',
		  '241','305','520','667','70','244','466','648','194','71','549','624','325'];

my $sampleText = 'itwasthewhiterabbittrottingslowlybackagainandlookinganxiouslyaboutasitw' .
    'entasifithadlostsomethingandshehearditmutteringtoitselftheduchesstheduch' .
    'essohmydearpawsohmyfurandwhiskersshellgetmeexecutedassureasferretsarefer' .
    'retswherecanihavedroppedthemiwonderaliceguessedinamomentthatitwaslooking' .
    'forthefanandthepairofwhitekidglovesandsheverygoodnaturedlybeganhuntingab' .
    'outforthembuttheywerenowheretobeseeneverythingseemedtohavechangedsincehe' .
    'rswiminthepoolandthegreathallwiththeglasstableandthelittledoorhadvanishe' .
    'dcompletelyverysoontherabbitnoticedaliceasshewenthuntingaboutandcalledou' .
    'ttoherinanangrytonewhymaryannwhatareyoudoingouthererunhomethismomentandf' .
    'etchmeapairofglovesandafanquicknowandalicewassomuchfrightenedthatsherano' .
    'ffatonceinthedirectionitpointedtowithouttryingtoexplainthemistakeithadma' .
    'dehetookmeforhishousemaidshesaidtoherselfassheranhowsurprisedhellbewhenh' .
    'efindsoutwhoiambutidbettertakehimhisfanandglovesthatisificanfindthemassh' .
    'esaidthisshecameuponaneatlittlehouseonthedoorofwhichwasabrightbrassplate' .
    'withthenamewrabbitengraveduponitshewentinwithoutknockingandhurriedupstai' .
    'rsingreatfearlestsheshouldmeettherealmaryannandbeturnedoutofthehousebefo' .
    'reshehadfoundthefanandgloves';

my $keyLen = crypto::findKeyLength($cipherText);
my $sampleFreqs = crypto::countDigramFrequencies([split '', $sampleText]);
my $strings = crypto::generateStrings($cipherText, $keyLen);

#Vector to count the frequencies of each digram
my $V;

foreach my $subString (@{$strings}){
    my $freqs = crypto::countFrequencies($subString);
    my $temp;
    
    foreach my $i (0..($n-1)){
	my $freq = 0;
	if (exists $freqs->{$i}){
	    $freq = $freqs->{$i};
	}
	
	$temp->[$i] = $freq;
    }

    push @{$V}, $temp;
}

#Baseline frequency count from the sample text
my $W;

foreach my $i (0..($n-1)){
    my $freq = 0;
    if (exists $sampleFreqs->{$digrams->{$i}}){
	$freq = $sampleFreqs->{$digrams->{$i}};
    }
    
    $W->[$i] = $freq;
}

foreach my $v (@{$V}){
    scalarMult($v, 6/$#{$cipherText});
}
scalarMult($W, 2/length($sampleText));

#Guess the key
my $key;
foreach my $v (@{$V}){
    my $temp = {'max' => 0};

    
    foreach my $i (0..($n-1)){
	my $ip = innerProduct($v, $W);
	$temp->{$ip} = $i;
	if ($ip > $temp->{'max'}){
	    $temp->{'max'} = $ip;
	}
	cycleVector($W);
    }

    push @{$key}, $temp->{$temp->{'max'}};
}

print "Key: [";
print join ',', @{$key};
print "]\nPhrase: ";

foreach my $k (@{$key}){
    print $digrams->{$k};
}
print "\nPlain text: ";

my $plainText = decrypt($cipherText, $key);

print join '', @{$plainText};
