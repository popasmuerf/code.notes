## Collation and Character Sets


- Beause not everyone wants to store English strings
- It's important that a database server be able to manage non-English characcters 
and different ways of sorting characters 
- When youy are comparing or sorting strings, how MySQL evaluates the 
result depnds on the character set and collation used 
- collation defines how strings are ordered
- Different collations for different languages
- For example, the poistion of the character ٱ or 
    * A collation defines how strings ordered
    * thre are different collations for different languages
    * the position of the character ü in the alphabet is different in two 
    Geman orderings, and different again in Swedish and Finnish
- The collation defaults for MySQL currently are 
    * character set  : latin1
    * collation : latin1_swedish_ci
- MySQL can be configured to use different character sets and collation orders at levels :
    * character sets 
    * collation 
    * connection
    * database
    * table 
    * column levels 

- You an list the character sets via 

    mysql> SHOW CHARACTER SET

    /*
        Displays a short description for 
            - each character set 
            - default collation 
            - maximum number of bytes for ech character n that character set
    */

    'armscii8', 'ARMSCII-8 Armenian', 'armscii8_general_ci', '1'
    'ascii', 'US ASCII', 'ascii_general_ci', '1'
    'big5', 'Big5 Traditional Chinese', 'big5_chinese_ci', '2'
    'binary', 'Binary pseudo charset', 'binary', '1'
    'cp1250', 'Windows Central European', 'cp1250_general_ci', '1'
    'cp1251', 'Windows Cyrillic', 'cp1251_general_ci', '1'
    'cp1256', 'Windows Arabic', 'cp1256_general_ci', '1'
    'cp1257', 'Windows Baltic', 'cp1257_general_ci', '1'
    'cp850', 'DOS West European', 'cp850_general_ci', '1'
    'cp852', 'DOS Central European', 'cp852_general_ci', '1'
    'cp866', 'DOS Russian', 'cp866_general_ci', '1'
    'cp932', 'SJIS for Windows Japanese', 'cp932_japanese_ci', '2'
    'dec8', 'DEC West European', 'dec8_swedish_ci', '1'
    'eucjpms', 'UJIS for Windows Japanese', 'eucjpms_japanese_ci', '3'
    'euckr', 'EUC-KR Korean', 'euckr_korean_ci', '2'
    'gb18030', 'China National Standard GB18030', 'gb18030_chinese_ci', '4'
    'gb2312', 'GB2312 Simplified Chinese', 'gb2312_chinese_ci', '2'
    'gbk', 'GBK Simplified Chinese', 'gbk_chinese_ci', '2'
    'geostd8', 'GEOSTD8 Georgian', 'geostd8_general_ci', '1'
    'greek', 'ISO 8859-7 Greek', 'greek_general_ci', '1'
    'hebrew', 'ISO 8859-8 Hebrew', 'hebrew_general_ci', '1'
    'hp8', 'HP West European', 'hp8_english_ci', '1'
    'keybcs2', 'DOS Kamenicky Czech-Slovak', 'keybcs2_general_ci', '1'
    'koi8r', 'KOI8-R Relcom Russian', 'koi8r_general_ci', '1'
    'koi8u', 'KOI8-U Ukrainian', 'koi8u_general_ci', '1'
    'latin1', 'cp1252 West European', 'latin1_swedish_ci', '1'
    'latin2', 'ISO 8859-2 Central European', 'latin2_general_ci', '1'
    'latin5', 'ISO 8859-9 Turkish', 'latin5_turkish_ci', '1'
    'latin7', 'ISO 8859-13 Baltic', 'latin7_general_ci', '1'
    'macce', 'Mac Central European', 'macce_general_ci', '1'
    'macroman', 'Mac West European', 'macroman_general_ci', '1'
    'sjis', 'Shift-JIS Japanese', 'sjis_japanese_ci', '2'
    'swe7', '7bit Swedish', 'swe7_swedish_ci', '1'
    'tis620', 'TIS620 Thai', 'tis620_thai_ci', '1'
    'ucs2', 'UCS-2 Unicode', 'ucs2_general_ci', '2'
    'ujis', 'EUC-JP Japanese', 'ujis_japanese_ci', '3'
    'utf16', 'UTF-16 Unicode', 'utf16_general_ci', '4'
    'utf16le', 'UTF-16LE Unicode', 'utf16le_general_ci', '4'
    'utf32', 'UTF-32 Unicode', 'utf32_general_ci', '4'
    'utf8mb3', 'UTF-8 Unicode', 'utf8mb3_general_ci', '3'
    'utf8mb4', 'UTF-8 Unicode', 'utf8mb4_0900_ai_ci', '4'

For example, the latin1 character set is actually 
the Windows code page 1252 that supports West European languages.
the default collation for this character set is 

    latin1_swedish_ci

which follows Swedish conventions to sort accented characters 
(English is handled as you would expect).  This 
collation is case-insensitive, as indicated by the 
leters ci.  Finally, weach character takes up one byte.
By comparision, if you use the ucs2 character set, each character
would take up to two bytes of storage.



You an list the available collations via  

    mysql> SHOW COLLATION ;

    /*
        Displays a short description for 
            - each character set 
            - default collation 
            - maximum number of bytes for ech character n that character set
    */


    'armscii8_bin','armscii8','64','','Yes','1','PAD SPACE'
    'armscii8_general_ci','armscii8','32','Yes','Yes','1','PAD SPACE'
    'ascii_bin','ascii','65','','Yes','1','PAD SPACE'
    'ascii_general_ci','ascii','11','Yes','Yes','1','PAD SPACE'
    'big5_bin','big5','84','','Yes','1','PAD SPACE'
    'big5_chinese_ci','big5','1','Yes','Yes','1','PAD SPACE'
    'binary','binary','63','Yes','Yes','1','NO PAD'
    'cp1250_bin','cp1250','66','','Yes','1','PAD SPACE'
    'cp1250_croatian_ci','cp1250','44','','Yes','1','PAD SPACE'
    'cp1250_czech_cs','cp1250','34','','Yes','2','PAD SPACE'
    'cp1250_general_ci','cp1250','26','Yes','Yes','1','PAD SPACE'
    'cp1250_polish_ci','cp1250','99','','Yes','1','PAD SPACE'
    'cp1251_bin','cp1251','50','','Yes','1','PAD SPACE'
    'cp1251_bulgarian_ci','cp1251','14','','Yes','1','PAD SPACE'
    'cp1251_general_ci','cp1251','51','Yes','Yes','1','PAD SPACE'
    'cp1251_general_cs','cp1251','52','','Yes','1','PAD SPACE'
    'cp1251_ukrainian_ci','cp1251','23','','Yes','1','PAD SPACE'
    'cp1256_bin','cp1256','67','','Yes','1','PAD SPACE'
    'cp1256_general_ci','cp1256','57','Yes','Yes','1','PAD SPACE'
    'cp1257_bin','cp1257','58','','Yes','1','PAD SPACE'
    'cp1257_general_ci','cp1257','59','Yes','Yes','1','PAD SPACE'
    'cp1257_lithuanian_ci','cp1257','29','','Yes','1','PAD SPACE'
    'cp850_bin','cp850','80','','Yes','1','PAD SPACE'
    'cp850_general_ci','cp850','4','Yes','Yes','1','PAD SPACE'
    'cp852_bin','cp852','81','','Yes','1','PAD SPACE'
    'cp852_general_ci','cp852','40','Yes','Yes','1','PAD SPACE'
    'cp866_bin','cp866','68','','Yes','1','PAD SPACE'
    'cp866_general_ci','cp866','36','Yes','Yes','1','PAD SPACE'
    'cp932_bin','cp932','96','','Yes','1','PAD SPACE'
    'cp932_japanese_ci','cp932','95','Yes','Yes','1','PAD SPACE'
    'dec8_bin','dec8','69','','Yes','1','PAD SPACE'
    'dec8_swedish_ci','dec8','3','Yes','Yes','1','PAD SPACE'
    'eucjpms_bin','eucjpms','98','','Yes','1','PAD SPACE'
    'eucjpms_japanese_ci','eucjpms','97','Yes','Yes','1','PAD SPACE'
    'euckr_bin','euckr','85','','Yes','1','PAD SPACE'
    'euckr_korean_ci','euckr','19','Yes','Yes','1','PAD SPACE'
    'gb18030_bin','gb18030','249','','Yes','1','PAD SPACE'
    'gb18030_chinese_ci','gb18030','248','Yes','Yes','2','PAD SPACE'
    'gb18030_unicode_520_ci','gb18030','250','','Yes','8','PAD SPACE'
    'gb2312_bin','gb2312','86','','Yes','1','PAD SPACE'
    'gb2312_chinese_ci','gb2312','24','Yes','Yes','1','PAD SPACE'
    'gbk_bin','gbk','87','','Yes','1','PAD SPACE'
    'gbk_chinese_ci','gbk','28','Yes','Yes','1','PAD SPACE'
    'geostd8_bin','geostd8','93','','Yes','1','PAD SPACE'
    'geostd8_general_ci','geostd8','92','Yes','Yes','1','PAD SPACE'
    'greek_bin','greek','70','','Yes','1','PAD SPACE'
    'greek_general_ci','greek','25','Yes','Yes','1','PAD SPACE'
    'hebrew_bin','hebrew','71','','Yes','1','PAD SPACE'
    'hebrew_general_ci','hebrew','16','Yes','Yes','1','PAD SPACE'
    'hp8_bin','hp8','72','','Yes','1','PAD SPACE'
    'hp8_english_ci','hp8','6','Yes','Yes','1','PAD SPACE'
    'keybcs2_bin','keybcs2','73','','Yes','1','PAD SPACE'
    'keybcs2_general_ci','keybcs2','37','Yes','Yes','1','PAD SPACE'
    'koi8r_bin','koi8r','74','','Yes','1','PAD SPACE'
    'koi8r_general_ci','koi8r','7','Yes','Yes','1','PAD SPACE'
    'koi8u_bin','koi8u','75','','Yes','1','PAD SPACE'
    'koi8u_general_ci','koi8u','22','Yes','Yes','1','PAD SPACE'
    'latin1_bin','latin1','47','','Yes','1','PAD SPACE'
    'latin1_danish_ci','latin1','15','','Yes','1','PAD SPACE'
    'latin1_general_ci','latin1','48','','Yes','1','PAD SPACE'
    'latin1_general_cs','latin1','49','','Yes','1','PAD SPACE'
    'latin1_german1_ci','latin1','5','','Yes','1','PAD SPACE'
    'latin1_german2_ci','latin1','31','','Yes','2','PAD SPACE'
    'latin1_spanish_ci','latin1','94','','Yes','1','PAD SPACE'
    'latin1_swedish_ci','latin1','8','Yes','Yes','1','PAD SPACE'
    'latin2_bin','latin2','77','','Yes','1','PAD SPACE'
    'latin2_croatian_ci','latin2','27','','Yes','1','PAD SPACE'
    'latin2_czech_cs','latin2','2','','Yes','4','PAD SPACE'
    'latin2_general_ci','latin2','9','Yes','Yes','1','PAD SPACE'
    'latin2_hungarian_ci','latin2','21','','Yes','1','PAD SPACE'
    'latin5_bin','latin5','78','','Yes','1','PAD SPACE'
    'latin5_turkish_ci','latin5','30','Yes','Yes','1','PAD SPACE'
    'latin7_bin','latin7','79','','Yes','1','PAD SPACE'
    'latin7_estonian_cs','latin7','20','','Yes','1','PAD SPACE'
    'latin7_general_ci','latin7','41','Yes','Yes','1','PAD SPACE'
    'latin7_general_cs','latin7','42','','Yes','1','PAD SPACE'
    'macce_bin','macce','43','','Yes','1','PAD SPACE'
    'macce_general_ci','macce','38','Yes','Yes','1','PAD SPACE'
    'macroman_bin','macroman','53','','Yes','1','PAD SPACE'
    'macroman_general_ci','macroman','39','Yes','Yes','1','PAD SPACE'
    'sjis_bin','sjis','88','','Yes','1','PAD SPACE'
    'sjis_japanese_ci','sjis','13','Yes','Yes','1','PAD SPACE'
    'swe7_bin','swe7','82','','Yes','1','PAD SPACE'
    'swe7_swedish_ci','swe7','10','Yes','Yes','1','PAD SPACE'
    'tis620_bin','tis620','89','','Yes','1','PAD SPACE'
    'tis620_thai_ci','tis620','18','Yes','Yes','4','PAD SPACE'
    'ucs2_bin','ucs2','90','','Yes','1','PAD SPACE'
    'ucs2_croatian_ci','ucs2','149','','Yes','8','PAD SPACE'
    'ucs2_czech_ci','ucs2','138','','Yes','8','PAD SPACE'
    'ucs2_danish_ci','ucs2','139','','Yes','8','PAD SPACE'
    'ucs2_esperanto_ci','ucs2','145','','Yes','8','PAD SPACE'
    'ucs2_estonian_ci','ucs2','134','','Yes','8','PAD SPACE'
    'ucs2_general_ci','ucs2','35','Yes','Yes','1','PAD SPACE'
    'ucs2_general_mysql500_ci','ucs2','159','','Yes','1','PAD SPACE'
    'ucs2_german2_ci','ucs2','148','','Yes','8','PAD SPACE'
    'ucs2_hungarian_ci','ucs2','146','','Yes','8','PAD SPACE'
    'ucs2_icelandic_ci','ucs2','129','','Yes','8','PAD SPACE'
    'ucs2_latvian_ci','ucs2','130','','Yes','8','PAD SPACE'
    'ucs2_lithuanian_ci','ucs2','140','','Yes','8','PAD SPACE'
    'ucs2_persian_ci','ucs2','144','','Yes','8','PAD SPACE'
    'ucs2_polish_ci','ucs2','133','','Yes','8','PAD SPACE'
    'ucs2_romanian_ci','ucs2','131','','Yes','8','PAD SPACE'
    'ucs2_roman_ci','ucs2','143','','Yes','8','PAD SPACE'
    'ucs2_sinhala_ci','ucs2','147','','Yes','8','PAD SPACE'
    'ucs2_slovak_ci','ucs2','141','','Yes','8','PAD SPACE'
    'ucs2_slovenian_ci','ucs2','132','','Yes','8','PAD SPACE'
    'ucs2_spanish2_ci','ucs2','142','','Yes','8','PAD SPACE'
    'ucs2_spanish_ci','ucs2','135','','Yes','8','PAD SPACE'
    'ucs2_swedish_ci','ucs2','136','','Yes','8','PAD SPACE'
    'ucs2_turkish_ci','ucs2','137','','Yes','8','PAD SPACE'
    'ucs2_unicode_520_ci','ucs2','150','','Yes','8','PAD SPACE'
    'ucs2_unicode_ci','ucs2','128','','Yes','8','PAD SPACE'
    'ucs2_vietnamese_ci','ucs2','151','','Yes','8','PAD SPACE'
    'ujis_bin','ujis','91','','Yes','1','PAD SPACE'
    'ujis_japanese_ci','ujis','12','Yes','Yes','1','PAD SPACE'
    'utf16le_bin','utf16le','62','','Yes','1','PAD SPACE'
    'utf16le_general_ci','utf16le','56','Yes','Yes','1','PAD SPACE'
    'utf16_bin','utf16','55','','Yes','1','PAD SPACE'
    'utf16_croatian_ci','utf16','122','','Yes','8','PAD SPACE'
    'utf16_czech_ci','utf16','111','','Yes','8','PAD SPACE'
    'utf16_danish_ci','utf16','112','','Yes','8','PAD SPACE'
    'utf16_esperanto_ci','utf16','118','','Yes','8','PAD SPACE'
    'utf16_estonian_ci','utf16','107','','Yes','8','PAD SPACE'
    'utf16_general_ci','utf16','54','Yes','Yes','1','PAD SPACE'
    'utf16_german2_ci','utf16','121','','Yes','8','PAD SPACE'
    'utf16_hungarian_ci','utf16','119','','Yes','8','PAD SPACE'
    'utf16_icelandic_ci','utf16','102','','Yes','8','PAD SPACE'
    'utf16_latvian_ci','utf16','103','','Yes','8','PAD SPACE'
    'utf16_lithuanian_ci','utf16','113','','Yes','8','PAD SPACE'
    'utf16_persian_ci','utf16','117','','Yes','8','PAD SPACE'
    'utf16_polish_ci','utf16','106','','Yes','8','PAD SPACE'
    'utf16_romanian_ci','utf16','104','','Yes','8','PAD SPACE'
    'utf16_roman_ci','utf16','116','','Yes','8','PAD SPACE'
    'utf16_sinhala_ci','utf16','120','','Yes','8','PAD SPACE'
    'utf16_slovak_ci','utf16','114','','Yes','8','PAD SPACE'
    'utf16_slovenian_ci','utf16','105','','Yes','8','PAD SPACE'
    'utf16_spanish2_ci','utf16','115','','Yes','8','PAD SPACE'
    'utf16_spanish_ci','utf16','108','','Yes','8','PAD SPACE'
    'utf16_swedish_ci','utf16','109','','Yes','8','PAD SPACE'
    'utf16_turkish_ci','utf16','110','','Yes','8','PAD SPACE'
    'utf16_unicode_520_ci','utf16','123','','Yes','8','PAD SPACE'
    'utf16_unicode_ci','utf16','101','','Yes','8','PAD SPACE'
    'utf16_vietnamese_ci','utf16','124','','Yes','8','PAD SPACE'
    'utf32_bin','utf32','61','','Yes','1','PAD SPACE'
    'utf32_croatian_ci','utf32','181','','Yes','8','PAD SPACE'
    'utf32_czech_ci','utf32','170','','Yes','8','PAD SPACE'
    'utf32_danish_ci','utf32','171','','Yes','8','PAD SPACE'
    'utf32_esperanto_ci','utf32','177','','Yes','8','PAD SPACE'
    'utf32_estonian_ci','utf32','166','','Yes','8','PAD SPACE'
    'utf32_general_ci','utf32','60','Yes','Yes','1','PAD SPACE'
    'utf32_german2_ci','utf32','180','','Yes','8','PAD SPACE'
    'utf32_hungarian_ci','utf32','178','','Yes','8','PAD SPACE'
    'utf32_icelandic_ci','utf32','161','','Yes','8','PAD SPACE'
    'utf32_latvian_ci','utf32','162','','Yes','8','PAD SPACE'
    'utf32_lithuanian_ci','utf32','172','','Yes','8','PAD SPACE'
    'utf32_persian_ci','utf32','176','','Yes','8','PAD SPACE'
    'utf32_polish_ci','utf32','165','','Yes','8','PAD SPACE'
    'utf32_romanian_ci','utf32','163','','Yes','8','PAD SPACE'
    'utf32_roman_ci','utf32','175','','Yes','8','PAD SPACE'
    'utf32_sinhala_ci','utf32','179','','Yes','8','PAD SPACE'
    'utf32_slovak_ci','utf32','173','','Yes','8','PAD SPACE'
    'utf32_slovenian_ci','utf32','164','','Yes','8','PAD SPACE'
    'utf32_spanish2_ci','utf32','174','','Yes','8','PAD SPACE'
    'utf32_spanish_ci','utf32','167','','Yes','8','PAD SPACE'
    'utf32_swedish_ci','utf32','168','','Yes','8','PAD SPACE'
    'utf32_turkish_ci','utf32','169','','Yes','8','PAD SPACE'
    'utf32_unicode_520_ci','utf32','182','','Yes','8','PAD SPACE'
    'utf32_unicode_ci','utf32','160','','Yes','8','PAD SPACE'
    'utf32_vietnamese_ci','utf32','183','','Yes','8','PAD SPACE'
    'utf8mb3_bin','utf8mb3','83','','Yes','1','PAD SPACE'
    'utf8mb3_croatian_ci','utf8mb3','213','','Yes','8','PAD SPACE'
    'utf8mb3_czech_ci','utf8mb3','202','','Yes','8','PAD SPACE'
    'utf8mb3_danish_ci','utf8mb3','203','','Yes','8','PAD SPACE'
    'utf8mb3_esperanto_ci','utf8mb3','209','','Yes','8','PAD SPACE'
    'utf8mb3_estonian_ci','utf8mb3','198','','Yes','8','PAD SPACE'
    'utf8mb3_general_ci','utf8mb3','33','Yes','Yes','1','PAD SPACE'
    'utf8mb3_general_mysql500_ci','utf8mb3','223','','Yes','1','PAD SPACE'
    'utf8mb3_german2_ci','utf8mb3','212','','Yes','8','PAD SPACE'
    'utf8mb3_hungarian_ci','utf8mb3','210','','Yes','8','PAD SPACE'
    'utf8mb3_icelandic_ci','utf8mb3','193','','Yes','8','PAD SPACE'
    'utf8mb3_latvian_ci','utf8mb3','194','','Yes','8','PAD SPACE'
    'utf8mb3_lithuanian_ci','utf8mb3','204','','Yes','8','PAD SPACE'
    'utf8mb3_persian_ci','utf8mb3','208','','Yes','8','PAD SPACE'
    'utf8mb3_polish_ci','utf8mb3','197','','Yes','8','PAD SPACE'
    'utf8mb3_romanian_ci','utf8mb3','195','','Yes','8','PAD SPACE'
    'utf8mb3_roman_ci','utf8mb3','207','','Yes','8','PAD SPACE'
    'utf8mb3_sinhala_ci','utf8mb3','211','','Yes','8','PAD SPACE'
    'utf8mb3_slovak_ci','utf8mb3','205','','Yes','8','PAD SPACE'
    'utf8mb3_slovenian_ci','utf8mb3','196','','Yes','8','PAD SPACE'
    'utf8mb3_spanish2_ci','utf8mb3','206','','Yes','8','PAD SPACE'
    'utf8mb3_spanish_ci','utf8mb3','199','','Yes','8','PAD SPACE'
    'utf8mb3_swedish_ci','utf8mb3','200','','Yes','8','PAD SPACE'
    'utf8mb3_tolower_ci','utf8mb3','76','','Yes','1','PAD SPACE'
    'utf8mb3_turkish_ci','utf8mb3','201','','Yes','8','PAD SPACE'
    'utf8mb3_unicode_520_ci','utf8mb3','214','','Yes','8','PAD SPACE'
    'utf8mb3_unicode_ci','utf8mb3','192','','Yes','8','PAD SPACE'
    'utf8mb3_vietnamese_ci','utf8mb3','215','','Yes','8','PAD SPACE'
    'utf8mb4_0900_ai_ci','utf8mb4','255','Yes','Yes','0','NO PAD'
    'utf8mb4_0900_as_ci','utf8mb4','305','','Yes','0','NO PAD'
    'utf8mb4_0900_as_cs','utf8mb4','278','','Yes','0','NO PAD'
    'utf8mb4_0900_bin','utf8mb4','309','','Yes','1','NO PAD'
    'utf8mb4_bg_0900_ai_ci','utf8mb4','318','','Yes','0','NO PAD'
    'utf8mb4_bg_0900_as_cs','utf8mb4','319','','Yes','0','NO PAD'
    'utf8mb4_bin','utf8mb4','46','','Yes','1','PAD SPACE'
    'utf8mb4_bs_0900_ai_ci','utf8mb4','316','','Yes','0','NO PAD'
    'utf8mb4_bs_0900_as_cs','utf8mb4','317','','Yes','0','NO PAD'
    'utf8mb4_croatian_ci','utf8mb4','245','','Yes','8','PAD SPACE'
    'utf8mb4_cs_0900_ai_ci','utf8mb4','266','','Yes','0','NO PAD'
    'utf8mb4_cs_0900_as_cs','utf8mb4','289','','Yes','0','NO PAD'
    'utf8mb4_czech_ci','utf8mb4','234','','Yes','8','PAD SPACE'
    'utf8mb4_danish_ci','utf8mb4','235','','Yes','8','PAD SPACE'
    'utf8mb4_da_0900_ai_ci','utf8mb4','267','','Yes','0','NO PAD'
    'utf8mb4_da_0900_as_cs','utf8mb4','290','','Yes','0','NO PAD'
    'utf8mb4_de_pb_0900_ai_ci','utf8mb4','256','','Yes','0','NO PAD'
    'utf8mb4_de_pb_0900_as_cs','utf8mb4','279','','Yes','0','NO PAD'
    'utf8mb4_eo_0900_ai_ci','utf8mb4','273','','Yes','0','NO PAD'
    'utf8mb4_eo_0900_as_cs','utf8mb4','296','','Yes','0','NO PAD'
    'utf8mb4_esperanto_ci','utf8mb4','241','','Yes','8','PAD SPACE'
    'utf8mb4_estonian_ci','utf8mb4','230','','Yes','8','PAD SPACE'
    'utf8mb4_es_0900_ai_ci','utf8mb4','263','','Yes','0','NO PAD'
    'utf8mb4_es_0900_as_cs','utf8mb4','286','','Yes','0','NO PAD'
    'utf8mb4_es_trad_0900_ai_ci','utf8mb4','270','','Yes','0','NO PAD'
    'utf8mb4_es_trad_0900_as_cs','utf8mb4','293','','Yes','0','NO PAD'
    'utf8mb4_et_0900_ai_ci','utf8mb4','262','','Yes','0','NO PAD'
    'utf8mb4_et_0900_as_cs','utf8mb4','285','','Yes','0','NO PAD'
    'utf8mb4_general_ci','utf8mb4','45','','Yes','1','PAD SPACE'
    'utf8mb4_german2_ci','utf8mb4','244','','Yes','8','PAD SPACE'
    'utf8mb4_gl_0900_ai_ci','utf8mb4','320','','Yes','0','NO PAD'
    'utf8mb4_gl_0900_as_cs','utf8mb4','321','','Yes','0','NO PAD'
    'utf8mb4_hr_0900_ai_ci','utf8mb4','275','','Yes','0','NO PAD'
    'utf8mb4_hr_0900_as_cs','utf8mb4','298','','Yes','0','NO PAD'
    'utf8mb4_hungarian_ci','utf8mb4','242','','Yes','8','PAD SPACE'
    'utf8mb4_hu_0900_ai_ci','utf8mb4','274','','Yes','0','NO PAD'
    'utf8mb4_hu_0900_as_cs','utf8mb4','297','','Yes','0','NO PAD'
    'utf8mb4_icelandic_ci','utf8mb4','225','','Yes','8','PAD SPACE'
    'utf8mb4_is_0900_ai_ci','utf8mb4','257','','Yes','0','NO PAD'
    'utf8mb4_is_0900_as_cs','utf8mb4','280','','Yes','0','NO PAD'
    'utf8mb4_ja_0900_as_cs','utf8mb4','303','','Yes','0','NO PAD'
    'utf8mb4_ja_0900_as_cs_ks','utf8mb4','304','','Yes','24','NO PAD'
    'utf8mb4_latvian_ci','utf8mb4','226','','Yes','8','PAD SPACE'
    'utf8mb4_la_0900_ai_ci','utf8mb4','271','','Yes','0','NO PAD'
    'utf8mb4_la_0900_as_cs','utf8mb4','294','','Yes','0','NO PAD'
    'utf8mb4_lithuanian_ci','utf8mb4','236','','Yes','8','PAD SPACE'
    'utf8mb4_lt_0900_ai_ci','utf8mb4','268','','Yes','0','NO PAD'
    'utf8mb4_lt_0900_as_cs','utf8mb4','291','','Yes','0','NO PAD'
    'utf8mb4_lv_0900_ai_ci','utf8mb4','258','','Yes','0','NO PAD'
    'utf8mb4_lv_0900_as_cs','utf8mb4','281','','Yes','0','NO PAD'
    'utf8mb4_mn_cyrl_0900_ai_ci','utf8mb4','322','','Yes','0','NO PAD'
    'utf8mb4_mn_cyrl_0900_as_cs','utf8mb4','323','','Yes','0','NO PAD'
    'utf8mb4_nb_0900_ai_ci','utf8mb4','310','','Yes','0','NO PAD'
    'utf8mb4_nb_0900_as_cs','utf8mb4','311','','Yes','0','NO PAD'
    'utf8mb4_nn_0900_ai_ci','utf8mb4','312','','Yes','0','NO PAD'
    'utf8mb4_nn_0900_as_cs','utf8mb4','313','','Yes','0','NO PAD'
    'utf8mb4_persian_ci','utf8mb4','240','','Yes','8','PAD SPACE'
    'utf8mb4_pl_0900_ai_ci','utf8mb4','261','','Yes','0','NO PAD'
    'utf8mb4_pl_0900_as_cs','utf8mb4','284','','Yes','0','NO PAD'
    'utf8mb4_polish_ci','utf8mb4','229','','Yes','8','PAD SPACE'
    'utf8mb4_romanian_ci','utf8mb4','227','','Yes','8','PAD SPACE'
    'utf8mb4_roman_ci','utf8mb4','239','','Yes','8','PAD SPACE'
    'utf8mb4_ro_0900_ai_ci','utf8mb4','259','','Yes','0','NO PAD'
    'utf8mb4_ro_0900_as_cs','utf8mb4','282','','Yes','0','NO PAD'
    'utf8mb4_ru_0900_ai_ci','utf8mb4','306','','Yes','0','NO PAD'
    'utf8mb4_ru_0900_as_cs','utf8mb4','307','','Yes','0','NO PAD'
    'utf8mb4_sinhala_ci','utf8mb4','243','','Yes','8','PAD SPACE'
    'utf8mb4_sk_0900_ai_ci','utf8mb4','269','','Yes','0','NO PAD'
    'utf8mb4_sk_0900_as_cs','utf8mb4','292','','Yes','0','NO PAD'
    'utf8mb4_slovak_ci','utf8mb4','237','','Yes','8','PAD SPACE'
    'utf8mb4_slovenian_ci','utf8mb4','228','','Yes','8','PAD SPACE'
    'utf8mb4_sl_0900_ai_ci','utf8mb4','260','','Yes','0','NO PAD'
    'utf8mb4_sl_0900_as_cs','utf8mb4','283','','Yes','0','NO PAD'
    'utf8mb4_spanish2_ci','utf8mb4','238','','Yes','8','PAD SPACE'
    'utf8mb4_spanish_ci','utf8mb4','231','','Yes','8','PAD SPACE'
    'utf8mb4_sr_latn_0900_ai_ci','utf8mb4','314','','Yes','0','NO PAD'
    'utf8mb4_sr_latn_0900_as_cs','utf8mb4','315','','Yes','0','NO PAD'
    'utf8mb4_sv_0900_ai_ci','utf8mb4','264','','Yes','0','NO PAD'
    'utf8mb4_sv_0900_as_cs','utf8mb4','287','','Yes','0','NO PAD'
    'utf8mb4_swedish_ci','utf8mb4','232','','Yes','8','PAD SPACE'
    'utf8mb4_tr_0900_ai_ci','utf8mb4','265','','Yes','0','NO PAD'
    'utf8mb4_tr_0900_as_cs','utf8mb4','288','','Yes','0','NO PAD'
    'utf8mb4_turkish_ci','utf8mb4','233','','Yes','8','PAD SPACE'
    'utf8mb4_unicode_520_ci','utf8mb4','246','','Yes','8','PAD SPACE'
    'utf8mb4_unicode_ci','utf8mb4','224','','Yes','8','PAD SPACE'
    'utf8mb4_vietnamese_ci','utf8mb4','247','','Yes','8','PAD SPACE'
    'utf8mb4_vi_0900_ai_ci','utf8mb4','277','','Yes','0','NO PAD'
    'utf8mb4_vi_0900_as_cs','utf8mb4','300','','Yes','0','NO PAD'
    'utf8mb4_zh_0900_as_cs','utf8mb4','308','','Yes','0','NO PAD'



* We can see the current defaults on your server as follows :

    mysql> SHOW VARIABLES LIKE 'c%' ;

    'caching_sha2_password_auto_generate_rsa_keys','ON'
    'caching_sha2_password_digest_rounds','5000'
    'caching_sha2_password_private_key_path','private_key.pem'
    'caching_sha2_password_public_key_path','public_key.pem'
    'character_set_client','utf8mb4'
    'character_set_connection','utf8mb4'
    'character_set_database','utf8mb4'
    'character_set_filesystem','binary'
    'character_set_results','utf8mb4'
    'character_set_server','utf8mb4'
    'character_set_system','utf8mb3'
    'character_sets_dir','/rdsdbbin/mysql-8.0.33.R4/share/charsets/'
    'check_proxy_users','OFF'
    'collation_connection','utf8mb4_0900_ai_ci'
    'collation_database','utf8mb4_0900_ai_ci'
    'collation_server','utf8mb4_0900_ai_ci'
    'completion_type','NO_CHAIN'
    'concurrent_insert','AUTO'
    'connect_timeout','10'
    'connection_memory_chunk_size','8912'
    'connection_memory_limit','18446744073709551615'
    'core_file','ON'
    'create_admin_listener_thread','OFF'
    'cte_max_recursion_depth','1000'





When you are creating a database, you can set the default character
set and sort order for the database and its tables.  For example,
if you want to use the latin1 character set and the latin1_swedish_cs (cs : 'case sensative')

    mysql> CREATE DATABASE rose DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_cs ;

The above is the default and isn't required if your installed MySQL correctly for your 
language and region and you aren't interested in internationalizing your application.
You can also control the character set and collation for individual tables or columns, but we 
won't go into the detail of how to do that here. 


### Creating temporary tables 

    mysql> CREATE TEMPORARY TABLE ;
- Will be dropped when the monitor connection is closed.
- This is useful for copying and reformatting data because you don't have to remember to 
clean up. 
- Again....temporary tables allow you to create emphemeral tables without having to deal with 
garbage collection. 



### Control over index structures 

Since MySQL 4.1 , for osme table tyeps, 
    - You have been able to control what type of internal structure -- such as
        * B-Trees 
        * Hash tables 
    That MySQL uses for its indexes 
    - You can instruct MySQL that you want a full text or spatial data index on a 
    column, allowing special types of search.



    mysql> SHOW CREATE TABLE artist_b ;



## Column Types 

This section describes the column types you can use in MySQL.
It explians when each should be used and any limitations it has.

### Common Column types 

The following are the six commonly used column types
in MySQL 

INT[(width)][UNSIGNED][ZEROFILL]

- The most commonly used numberic type.
- Stores integer(whole number) values in the range
- value range (signed) :
    2,147,483,648 
        to
    2,147,483,647
- vlaue range (unsigned)
    0
        to 
    4,294,967,295

- the keyword INT is shot for INTEGER
- INT columns requires four bytes of storage
- You can also include optional arguments to left-pad the values with zerors up to the specified length.
    - ZEROFILL
    - maximum width is 255 





