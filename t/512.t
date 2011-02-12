use strict;
use warnings;
use Test::More tests => 68;
use Digest::CubeHash::XS qw(cubehash_512 cubehash_512_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::CubeHash::XS->new(512)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            cubehash_512_hex($data), $digest,
            "cubehash_512_hex: $len bits of $msg"
        );
        ok(
            cubehash_512($data) eq pack('H*', $digest),
            "cubehash_512: $len bits of $msg"
        );
    }

    my $md = Digest::CubeHash::XS->new(512)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $len bits of $msg");
}
continue { $len++ }

__DATA__
00|4A1D00BBCFCB5A9562FB981E7F7DB3350FE2658639D948B9D57452C22328BB32F468B072208450BAD5EE178271408BE0B16E5633AC8A1E3CF9864CFBFC8E043A
00|027700FEAE2DC80E408899FDD06339D32338CBB521F595FDF93D557666DB8EE8A443E1DC6992BA5C198E50EB1437310F9916D1F5C2F6A918619AB2BF8720E231
C0|C522C3077B5C3566E8E949C720D11207143BE70FA65E8010912C36B3D56A940F453816CF71D6F31C7BBF86C99060190F71DF1CF70A02343660223DCDCD32EF12
C0|3F65D646518EAE9267B597A3FD874ADF7B93DC0F4EAB7834B89713460974D2966896685D7C5CF59AEE79BF63C527BCA39C714B23335C8605D8F78DA291A64EF8
80|78983DF13197297E295B0FA9B427BEFEFD75437B7E072A9A341D071A0E63872BF9E518FBBF39A20F2C5C70B4E08337857EBB44AED8DA08D68FAA70AC8F3552D8
48|2319CCDA3CF8680BF4F6EF9E2E1B17D9F7A762B6C69EA71FD41FC66063831EA2727F612D7A7354F3E654C9EE45A44B48D62A119B89850B06D9E4695EBC49D25C
50|8F23849A400A4B9648CA1E3E1CBED15C834FCDBF16DE8E716505D25CA12262182C46D9BBEB69CD2850C9D048946CAE60777F20F37839319EB9B1D6AB40B13FCD
98|092EF397D6DC30F319BBB60B93D8087AF40858C1DC158173523A07A02744A97BBCEE7FA14E78F830091519EF4AB2B9580549BB9C295853E9C91B2195F3E31A6E
CC|5C3019F2ABC3471ED3A19648071CF2311503DC4202508F8D3EFCB1023FD895505C4D634C1AE9D9F81DE6394690366154C715BF8D68242B2C64E1EBB1E538B330
9800|E09E9144587965CF1E5BFB042474D875D37EF768878F33B9BC156ECB969DDD7E28F124DAE6188F3BD3F8C58540E6D8FDE08B9195BCE6BFD90BEF5860186CA50A
9D40|5C31EBA3A040CBB8FEF92BEAB3761600F8CF310A75F76330C6D8B1336FEA2D25E72270883230688328BBB2420A2D1129410418C95CBF214CC2103E3F6DDFDCB7
AA80|01AE2F489364B1F296E469853CE9A5D3893823C1BC2C0913FA137440A173EE16736FED3E47488B8098243136D286885B10B2917AF034FC8020985E74ED274A16
9830|323304CFAE2C16644F6A5F6C774444F07B4C791331AAACD0B262A79D68C8AA99BF217A52FF73421D5DE8D52DB7C9D77195EB14F072716CC80AF8FC187AAE0355
5030|74F03D71DC16422EB4662C2A51B0BAB50480D1A6BAFDCC26CC7352D04C00A8FA0AA773374AE30A28F8943476A5E6D25EC3C5294E88355C0702DB893626DC8D48
4D24|2F2D28004FF7A7145DF54FA161E36D486A9231E641A9341B9A1C7DAC553421B44CDA7AB931BEC0966AB89AC22D77DC6217B85C615286AFE8761C16BBDB9AC4EB
CBDE|042CE928832A3B9E89D9FD2B35BC066347AD2E0AEED075EF5B578D811EB4B52592B76CD2D6C74E8E33FE4E5A1F6756A21858756210681D75CD8F6F1E66D717EE
41FB|7C38A32185665D3806FF1D0D7B278ABE0B759230E4DB6F78A80EFC2CBFD50CE6AAC477240E1B38888156B4E00946D1FD8E2E853F88C0EA6E29D4326003A67FA1
4FF400|EF0CBECDE58720F97DEFEC25F9CECEE97BF1686B9B996D57A833C533AD59D7C93CF7C4C02A745946907958B91F50B433A4860D25F8BE8E733D3EEACBC8EC4E9A
FD0440|23E60BA0157509CFABCBB3D89EA2C46700CFD8B5D966A5C54FF9A53254FB33EE7DC5D8F9D59B7580592C39C5DD6ABD7258F449BD7CF1341DC65662E9DB5BD733
424D00|975AD84C547069B3CA617495B308A999CD5481D4698AACB869ECEC0A6544A79A7E63759A5E9692545778C9531A45C8B516B9984A8DD4FA04EFDBA67582834E2B
3FDEE0|86E58B34149C9EC98A91EAC767E73B679A0A9662500016EB14B67A1A9EB5F0A1DDEE1ED2CD0DEB995AF65735F17D3D5DB81980FE00FC1075D5704B5B1097EB87
335768|4B7A69E11BA44C2990EF0BBADA9FB4D54BFF90B3E84E6A9CF6F7D87CA1DA9EB32B64A88E307A17D795AE2EA6D1D28EB2A66CB83A95CDFBD38CE73102907B3249
051E7C|CCDCCFFE3823DCD94C622E4A45E4A1C70D40C89C47DD83067F4BEB262EADD60CBF74F39D1FC7BB4D5783B5FF7AF747A17E176CA98444783EE6DC655F76C339E0
717F8C|7E22EDE4C51835433529F1BEA5B425DB53E77111DA742748028A3284F298B9E0BC5737CA5298804D482699A872C9315F29FE16697023CF33C3002AC5FC218614
1F877C|9D626B36A1E9A849B5F1B2594B53F761BA3B3E2734CD9812849B7510FC284EFC0474E4AD40DE57361F695F15B8D79A7F7C8A3AE5C48AC94900BC2132340E77C5
EB35CF80|22ABF5BA44A9644EED34EC148107242D264EBD2F43529438D1308496F52DAF6A2F76B0CE2F722E40618A2603B58E4FD5E2859BAD9C92554E9AD2E68A4A66A334
B406C480|2055FD5EE1A17DF89B0B07E2E83F83B18BB4D755627823D3622FAB692BD9E1657F981D3B1769B9AE3DBB3C8E7A4B72BB4BC5FD2A8F5506128505801E0438A836
CEE88040|764109416A7AAD068B41636673F91FC431AE1485C1DE732488907287DE4C345C47A390F38DE640214E541B30E1C5A835F3C950F4514BD056F5040C8635DCF868
C584DB70|61D96F06047E4DC7FDABB41A3A6795696901DF0B5FBA3201C75D5EB3A963D6696F4A80C8E8FCFB6C50BF1E93F093BD894EA1B2FA3850EAD2C1E7421DEB4D3368
53587BC8|550BEE38B2C55479A6D397CA27811B8AECC087613A299050B6BB30904359C237685D9E0D31BCF06DC78A375E9E1F363473B0D92E610B9A9E2D80C9185051B8BC
69A305B0|94C34C4EF810416598667C7CF5D4A438D7F2BAD9A78053C8A8E20099C51C7BE7B69C25B20010F655943E64A6FF0AEA40750264E488BAFBBF627918CEFCF0A4E3
C9375ECE|0B7C98CB2BC819B4BF052484659E0174ECF9BF8C6A6C87C095AA6977131CD5FD2A0012AC8A15FB6EF4C77F29AB3F99686FC7AD1F14A6B0C44B422F0F869A2361
C1ECFDFC|1F6148D7DC4EA7D4BBADC89CCD3F2E62232AD7EF0D4964F3FB69D62AB2A704D93A3FAEA98F7EC05EADFFD418687BDD337AE61C3170595642EE92A3CC386A241E
8D73E8A280|B02913327AEE5495773CB1F6FFD6FF3896FF6DCAA0DFEFCC0FB92AFC255DB55D67D8998BC5869E4A7B1FDB6631F6AB9956BCDA9021190685445D8400107C254D
06F2522080|E4E719F99E20AEC1DEB8F427C66ED5BD7CAA47141728F994B125BE7E4E13117686B966157F72F13C27EB1CEBB20B7770BD25867A085DF48DFF04C4089FA6C31D
3EF6C36F20|A819A7C5E460BABCB50FE2BFA74ED03082B154CB9D93227392B0950D62E0D6C89C38AC371279F49E89A14B5B276605364B6C24BFB5A6C6C75601BFA07C71A408
0127A1D340|7BBAAE162D278F3B014F2F0F662ABF9730B6CAA0AFCE5A3CD15DBA79CDE5BB8BB1D50B907FE208063FC002F364C61AD094C580926537EA65059677342DDB4501
6A6AB6C210|361EDC4B1657F8D9E282162387EAEFE12F575F764B586EF24E7D48896A63556A2ED433980E164436C6BBA8A8653AA9313EA5A96DA76F642344B61EF9DDC20085
AF3175E160|2FCEA8157996E5445A1B06FC911BE363853C271FE29933F92B9320B1C327A607CC251BA9C8D945E2F69283DB0EDA0DFC0DF357426763B443F5CA8B313D0BC9E9
B66609ED86|48CE8E3B1086E6377D327AFFBF952A5F840E1391174097563683304B2534A5616490DE428BF992795A05B74E693D690FF80E1DD982935E398891F4866D057BA8
21F134AC57|010F8501C34F05F31C606ADF2B2561C6E31F8580D925F9CE077533250AD7C669CA5B7A56EF514728AD402D854166F80BF061E8F1B6901A2112E0A0828276C5C8
3DC2AADFFC80|DD75B71330AAEB2E81C1099E9E61B7C21683576E48013A6C2BC2F17831A1777FC1DB962D56E19F9278B324D6E1C627148B5BA2AAECD6148837C0996070288D1D
9202736D2240|90B90BA145E2F715D668331EAF3101C62BF6325ECEC5F720AFA3BFAE5761F267E838BDF3B2D49A1F05FC4658441AF54994306E9A66F9D19B76FDE65C9AA9333E
F219BD629820|248D0D520671640CA12740923CFE388B299C2CA3E0210DB38071461504511A758B0F6160410D7B5557F13959317D5BB6A14C92DF5CC96BE32AF65C74C130EB70
F3511EE2C4B0|471E34E3376CE0E120CB33064C6082B4A75688590CA80673B1C4AFB629ECA024772BB9C8F6203B0FA0EED6191160831A2F42F11F2A5549113C5AE3393785C935
3ECAB6BF7720|005DDD096E09650ACDBD6FDD5EDF88219EA2D8908E15501D2B2832E2B7D5F8F1850E1E22CB67B2CE7F38BF2F372A96A83C36F7ECF439F92A944E97809D7FC2FA
CD62F688F498|906655B47BD16EA7AE5BA2099792BBE4AA49330FCF9F93B48F1B8973251477FFCC544CABFF401C44E1A81DDF837C3E45A96BE1A0E312F0D7F32FD2684742B1A0
C2CBAA33A9F8|22C7F0684CE9F90D598D8435AEDFA8B777AE561AE73D5F74975D44A34E5678FB4DF0AA97AC4C769D429153F36E769275CDB5E6213557BBD9DB15D00DC954289E
C6F50BB74E29|5CF5A9486B2C001A1FAE79CABAC4437025408466D885C95A3EA3BF171E032335070511E940EEDE3429EDF976D48BF219F1430AE85A098CD46CDD29179698EBD1
79F1B4CCC62A00|3CDD5BC8C260CE5CDBFE570DA22059DF43C46CD1773E7484E60B2FB37053ED24983AFF7A091E2E0ECB91DCAD0ECC01470C759AC1A4959116948113959FEAA78B