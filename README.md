# DOKUMENDID #

IDU0200 (2014) Praktikaülesanne "DOKUMENDID".


## Ülevaade andmetest ja funktsionaalsusest ##

Tegemist on dokumentide metaandmete hoidmise süsteemiga.

Süsteemi keskseks infoobjektiks on DOKUMENT. Dokumendil on tüüp, mis määrab ära millised on
dokumendi atribuudid atribuutide tabelis. Dokumendi, kui infoobjekti, andmed on jagatud dokumendi
tabeli ja atribuudi tabeli kirjete vahel.

Dokument asub dokumendi kataloogis. Dokumenti on võimalik liigutada ühest kataloogist teise.

Dokumente on võimalik seostada isikute ja ettevõtetega SUBJEKTIDE allsüsteemist.

Dokumente saab otsida süsteemis põhiandmete (nimi, kirjeldus), seotud subjektide, kataloogi, tüübi,
staatuse ja atribuudi andmete järgi (täpsem kirjeldus järgneb allpool).

Dokumendi staatuse muutmisel (täpsemalt - selle muudatuse salvestamisel) lisatakse see uus staatus
ka dokumendi staatuste ajaloo tabelisse ja lõpetatakse selles tabelis eelmise staatuse kehtivus.


## Kasutatavad andmetabelid ##

| Nimi | Allsüsteem | Loe | Lisa | Muuda | Kustuta |
| ---- | --- |:---:|:---:|:---:|:---:|
| `atr_type_selection_value` | DOKUMENDID | &#10004; | | | |
| `data_type` | DOKUMENDID | &#10004; | | | |
| `doc_attribute` | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| `doc_attribute_type` | DOKUMENDID | &#10004; | | | |
| `doc_catalog` | DOKUMENDID | &#10004; | | &#10004; | |
| `doc_catalog_type` | DOKUMENDID | | | | |
| `doc_status` | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| `doc_status_type` | DOKUMENDID | &#10004; | | | |
| `doc_subject` | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| `doc_subject_relation_type` | DOKUMENDID | &#10004; | | | |
| `doc_subject_type` | DOKUMENDID | &#10004; | | | |
| `doc_type` | DOKUMENDID | &#10004; | | | |
| `doc_type_attribute` | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| `document` | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| `document_doc_catalog` | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| `document_doc_type` | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| `customer` | SUBJEKTID | &#10004; | | | |
| `employee` | SUBJEKTID | &#10004; | | | |
| `enterprise` | SUBJEKTID | &#10004; | | | |
| `person` | SUBJEKTID | &#10004; | | | |
| `user_account` | SUBJEKTID | &#10004; | | | |


## Andmetabelite ja väljade kirjeldused ##

### atr_type_selection_value ###

Dokumendi atribuudi tüübi valikväärtused.

Mingi dokumendi atribuudi tüübi valikväärtused (sellel atribuudi tüübil peab `data_type=4`), mille
hulgast kasutaja saab ekraanivormil valida atribuutidele väärtuseid. Väärtused ei ole kasutaja poolt
sisestatavad, vaid ta saab ainult etteantud loendist valida.

Antud tabelisse ei ole selles ülesandes vaja läbi rakenduse andmeid lisada. Andmed sisestatakse
`INSERT`-lausetega otse andmebaasi.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `atr_type_selection_value` | Võtmeväli, sisu autonummerduv |
| | `value_text` | Valikväärtuse nimetus |
| | `orderby` | Järjekord - näitab, millises järjekorras näidatakse kasutajale valikväärtusi (näiteks "combo-box"-is) |


### data_type ###

Dokumendi atribuudi andmetüüp.

Tabelites `doc_attribute_type` ja `doc_attribute` viidatakse sellele andmetüübile.

Võimalikud väärtused:

1. atribuut on teksti tüüpi
2. atribuut on number tüüpi
3. atribuut on kuupäev/*timestamp* tüüpi
4. atribuut on valiku tüüpi

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `data_type` | Võtmeväli, sisu ei ole autonummerduv |
| | `type_name` | Andmetüübi nimi |


### doc_attribute ###

Dokumendi tunnus/omadus/atribuut.

Dokumendi atribuut sisaldab väärtust, mille sisestab ekraanivormilt kasutaja ja atribuudi tüüpi
(mida väärtus tähendab). Igal dokumendil võib süsteemis olla 0&hellip;N atribuuti. Dokumendi
atribuut on seotud atribuudi tüübiga tabelis `doc_attribute_type`.

`doc_attribute_type` määrab

* mis on atribuudi tüübi nimi ("vastamise tähtaeg", "turvatase")
* mis on atribuudi andmetüüp (string, number, kuupäev või valik nimekirjast)
* mis on atribuudi vaikimisi väärtus teksti tüüpi atribuudi korral
* mis on atribuudi väärtus valiku-tüüpi atribuudi korral (`default_selection_id_fk`)

Et ülesanne ei läheks liiga keeruliseks, ütleme, et kehtivad järgmised eeldused:

* dokumendil saab olla ainult üks tüüp (andmebaasi skeem võimaldab dokumendile korraga mitu tüüpi,
  aga teeme nii, et paneme sinna iga dokumendi puhul ainult ühe seose tabeliga `doc_type`)
* dokumendi tüüp pannakse paika dokumendi lisamisel ja seda ekraanivormilt hiljem muuta ei saa
* dokumendi atribuudid sisestatakse andmebaasi dokumendi lisamisel ja neid hiljem lisada või
  kustutada ei saa (saab ainult väärtust "tühjaks" teha kui selle atribuudi `required=false`). See
  tähendab - dokumendi struktuur, tema atribuudid ja nende atribuutide järjestus pannakse paika
  dokumendi lisamisel ja seda hiljem muuta ei saa.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_attribute` | Võtmeväli, autonummerduv |
| | `atr_type_selection_value_fk` | Viit atribuudi väärtusele kui valikule, tabelisse `atr_type_selection_value`. Täidetud juhul, kui `data_type=4` (valiku-tüüpi atribuut). |
| | `doc_attribute_type_fk` | Viit dokumendi atribuudi tüübile tabelisse `doc_attribute_type_fk` |
| | `document_fk` | Viit dokumendile, mille atribuudiga on tegemist, tabelisse `document` |
| | `type_name` | Dokumendi atribuudi tüübi nimi. Tegelikult on see kirjas tabelis `doc_attribute_type`, aga soovi korral (atribuudi lisamisel) võib selle tüübi nime siia ka dubleerida. |
| | `value_text` | Atribuudi väärtus. Kasutaja sisestab siis andmeid ekraanivormilt. Täidetud siis, kui tegemist on tekst-tüüpi atribuudiga (`data_type=1`) |
| | `value_number` | Atribuudi väärtus. Kasutaja sisestab siia andmeid ekraanivormilt. Täidetud siis, kui tegemist on number-tüüpi atribuudiga (`data_type=2`) |
| | `value_date` | Atribuudi väärtus. Kasutaja sisestab siia andmeid ekraanivormilt. Täidetud siis, kui tegemist on kuupäev- või *timestamp*-tüüpi atribuudiga (`data_type=3`) |
| | `data_type` | Atribuudi andmetüüp<br />`data_type=1` - teksti-tüüpi atribuut<br />`data_type=2` - number-tüüpi atribuut<br />`data_type=3` - kuupäeva-tüüpi atribuut<br />`data_type=4` - valiku-tüüpi atribuut<br />Selle välja sisust sõltub, millisest andmeväljast näidatakse andmeid ekraanivormil ja millisesse andmevälja kirjutatakse kasutaja muudetud andmed tagasi (samuti päringud oskavad atribuudi väärtust selle välja järgi õigest andmeväljast vaadata) |
| | `orderby` | Järjekord - näitab millises järjekorras näidatakse atribuute ekraanivormil. Võetakse atribuudi lisamisel tabelist `doc_attribute_type` |
| | `required` | Näitab, kas kasutaja tohib andmeid sisestades ja muutes ekraanivormil selle atribuudi väärtust tühjaks jätta (`required=false`) või mitte (`required=true`). Võetakse atribuudi lisamisel tabelist `doc_attribute_type` |


### doc_attribute_type ###

Dokumendi atribuudi tüüp.

Dokumentidel võib süsteemis olla erinevaid atribuute. Atribuutidel on tüübid. Tüüp määrab, mis on
selle atribuudi tähendus ja mis informatsiooni antud tüüpi atribuut hoiab. Millised atribuudid on
seotud milliste dokumendi tüüpidega on kirjas tabelis `doc_type_attribute`.

Üks atribuudi tüüp võib olla seotud mitme dokumenditüübiga.

Dokumendi atribuudi tüüp määrab ka ära, mis on seda tüüpi atribuudi andmetüüp (tekst, number,
kuupäev, valik) ja mis on vaikimisi atribuudi väärtus (kui tegemist on teksti-tüüpi või valiku-tüüpi
atribuudiga).

Sellesse tabelisse ei ole antud ülesandes vaja läbi rakenduse andmeid lisada, andmed sisestatakse
`INSERT`-lausetega otse andmebaasi.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_attribute_type` | Võtmeväli, autonummerduv |
| | `default_selection_id_fk` | Vaikimisi valiku id, viit tabelisse `atr_type_selection_value` ("atribuudi tüübi valikväärtused") |
| | `type_name` | Atribuudi tüübi nimi |
| | `data_type_fk` | Andmetüüp, viit tabelisse `data_type` |
| | `multiple_attributes` | Selles ülesandes ei kasuta |
| | `default_value_text` | Seda tüüpi dokumendi atribuudi vaikimisi väärtus. Võib olla täidetud siis, kui `data_type=1` |


### doc_catalog ###

Dokumendi kataloog.

Selles tabelis hoitakse dokumendi kataloogide hierarhiat ("puud"). Kõige ülemisel tasemel `level=1`
ja `upper_catalog_fk=0`.

Andmeid sisestades võiks tekitada maksimaalselt kolmetasemelise kataloogipuu, rohkem pole vaja.

Dokumendi lisamisel võiks teha nii, et (uue) dokumendi salvestamisel on alati mingi kataloog
kataloogipuust valitud - ja sellele kataloogile hakkab siis viitama kirje, mis seostab dokumendi
selle kataloogiga, kus ta on - tabelis `document_doc_catalog`. Uue dokumendi lisamise tuleb
tabelisse `document_doc_catalog` seega selline seostav kirje lisada.

Dokumendi kataloogil on kaks andmevälja, mille sisu tuleb uuendada siis, kui muutub kataloogi sisu
või selles kataloogis olevate dokumentide (kui andmebaasi kirjete) sisu.

* `content_updated` - kataloogi sisu muutmise aeg, *timestamp*
* `content_updated_by` - kes sisselogitud töötajatest muutis kataloogi sisu

Neid välju tuleb uuendada siis, kui:

1. kataloogi lisatakse uus dokument
2. kataloogi tõstetakse olemasolev dokument mõnest teisest kataloogist
3. kustutatakse dokument, mis asub selles kataloogis
4. kataloogist tõstetakse dokument ära mõnda teise kataloogi (*cut and paste*)
5. salvestatakse dokument, mis asub selles kataloogis

**NB!** Kui peate keeruliseks kasutajaliidesel näidata avatavate harudega kataloogipuud (ming haru
avaneb siis, kui tema peal klõpsata), siis võite selle kataloogipuu ka tervikuna, koos kõigi
harudega välja joonistada veebilehel (nii nagu ülemisel joonisel on näha).

Sellesse tabelisse ei ole antud ülesandes vaja läbi rakenduse andmeid lisada, andmed sisestatakse
`INSERT`-lausetega otse andmebaasi.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_catalog` | Võtmeväli, sisu on autonummerduv |
| | `catalog_owner_fk` | Ei ole selles ülesandes kasutusel |
| | `doc_catalog_type_fk` | Ei ole selles ülesandes kasutusel |
| | `name` | Kataloogi nimi |
| | `description` | Kataloogi kirjeldus, ei ole vaja kasutada |
| | `level` | Kataloogi tase kataloogipuus, kõige esimesel tasemel `level=0` |
| | `content_updated` | Millal kataloogi sisu viimati muutus, *timestamp* |
| | `upper_catalog_fk` | Viit ülemkataloogile samasse tabelisse `doc_catalog` |
| | `content_updated_by` | Viit sisseloginud töötajale, kes muutis viimati kataloogi sisu, viit SUBJEKTIDE allsüsteemi tabelisse `employee` |
| | `folder` | Kataloogile vastav failikataloog serveri failisüsteemis. Kui teete selles ülesandes dokumendifailide üleslaadimise (mida ei ole otseselt nõutud), siis saab selles väljas hoida failikataloogide *path*-i (sellise andmebaasis hoitava virtuaalse `doc_catalog`-iga võib seostada reaalse failisüsteemis oleva kataloogi, milles hoitakse siis sellesse kataloogi *uploaditud* dokumendifaile) |


### doc_catalog_type ###

Dokumendi kataloogi tüüp.

Ei ole selles ülesandes kasutusel

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_catalog_type` | |
| | `type_name` | |


### doc_status ###

Dokumendi staatuste ajaloo ja jooksva staatuse tabel.

Dokumendi peaks saama ekraanivormil valida dokumendi staatust. Mis need staatuse tüübid on - see
pole tähtis, suvalised.

Kui kasutaja vajutab dokumendi salvestamise nuppu, siis tuleb muuta dokumendi staatust dokumendi
tabelis `document.doc_status_type_fk` ja lisada jooksva staatuse kohta kirje tabelisse `doc_status`.
Staatuse `status_begin` alguseks salvestamise hetk ja staatuse lõpp määramata `status_end=NULL`.

Kui dokumendil juba eelnevalt oli staatus, siis tuleb tabelis `doc_status` vana staatus lõpetada -
täita ära `doc_status.status_end` vanal kirjel. Vana staatuse lõpetamise ajaks on uue staatuse
algus.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_status` | Võtmeväli, sisu autonummerduv |
| | `document_fk` | Viit dokumendile, mille staatusega on tegemist, tabelisse `document` |
| | `doc_status_type_fk` | Viit staatuse tüübile tabelisse `doc_status_type` |
| | `status_begin` | Staatuse algus. *Timestamp* tüüpi |
| | `status_end` | Staatuse lõpp. Täidetakse siis, kui tekib uus staatus |
| | `created_by` | Viit dokumendi sisestanud sisse logitud töötajale, viit SUBJEKTID allsüsteemi tabelisse `employee` |


### doc_status_type ###

Dokumendi seisundi tüüp.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_status_type` | Võtmeväli, sisu autonummerduv |
| | `type_name` | Dokumendi seisundi tüübi nimetus |


### doc_subject ###

Dokumendi seos ettevõtte või isikuga SUBJEKTIDE allsüsteemist.

Dokumendiga peab olema võimalik siduda ettevõtteid ja isikuid. Selleks, et siduda, tuleb need isikud
või ettevõtted subjektide andmebaasist välja otsida. Otsinguvorm võib olla väga lihtne - otsitakse
ainult ühe andmevälja järgi.

Selline nime järgi otsing tähendab, et otsitakse ettevõtete hulgast selliseid, millel "name" on
selline nagu otsinguvormil ja isikute hulgast selliseid, kelle `last_name` on selline nagu
otsinguvormil.

Kui andmebaasist on isik või ettevõte leitud, siis peaks saama teda seostada dokumendiga.
Seostamisel sisestatakse kirje tabelisse `doc_subject`. Seosed peab saama ka kustutada.

Seosel on mingi tähendus - roll. Seda rolli saab seose loomisel määrata. Rollid on tabelis
`doc_subject_relation_type`.

Olemasolevate seoste muutmise võimalust pole vaja teha (ainus asi, mis seal muuta saaks oleks seose
roll ja välja `note` sisu. Aga pole vaja seda muuta.)

Kui seos lisatakse tabelisse `doc_subject`, peab rakendus kirje välja `doc_subject_type_fk` panema
väärtuseks 1 või 2 - sõltuvalt sellest, kas valitud subjekt oli ettevõte `enterprise` või isik
`person`.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_subject` | Võtmeväli, sisu autonummerduv |
| | `doc_subject_relation_type_fk` | Viit dokumendi ja subjekti vahelise seose tüübile tabelisse `doc_subject_relation_type` |
| | `doc_subject_type_fk` | Viit subjekti tüübile (kas isik või ettevõte) tabelisse `doc_subject_type` |
| | `subject_fk` | Viit subjektidele SUBJEKTIDE allsüsteemi tabelisse `person` või `enterprise` (kummale tabelile viidatakse, see sõltub subjekti tüübist väljas `doc_subject_type_fk`) |
| | `document_fk` | Viit dokumendile, mis on subjektiga seotud, viit tabelisse `document` |
| | `note` | Märkus - mingi suvaline tekst selle seose kohta |


### doc_subject_relation_type ###

Dokumendi ja subjekti vahelise seose tüüp.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_subject_relation_type` | Võtmeväli, sisu on autonummerduv |
| | `type_name` | Seose tüübi nimi |


### doc_subject_type ###

Dokumendi subjekti tüüp. Näitab, kas seosetabeli `doc_subject` kirje viitab SUBJEKTIDE allsüsteemi
isikule `person` või ettevõttele `enterprise`.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_subject_type` | Võtmeväli, sisu ei ole autonummerduv |
| | `type_name` | Subjekti tüübi nimi: "ettevõte", "isik" |


### doc_type ###

Dokumendi tüüp. Kahetasemeline hierarhia, ülemtüübid ja alamtüübid. Konkreetse dokumendi tüübiks
sobib teise taseme tüüp (`level=2`).

Määratakse dokumendi lisamise ajal - kas enne dokumendi lisamise vormi kuvamist (see tähendab - enne
kui rakendus näitab dokumendi lisamise vormi, küsib ta kasutaja käest, millist tüüpi dokumenti ta
tahab sisestada) või dokumendi lisamise vormil.

**NB!** Kuna dokumendi lisamise ekraanivorm genereeritakse valitud dokumendi tüübi alusel, siis
tuleb see ekraanivorm ilmselt uuesti genereerida/kuvada, kui kasutaja valib ja vahetab lisamise
vormil dokumendi tüüpi.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_type` | Võtmeväli, sisu autonummerduv |
| | `type_name` | Dokumendi tüübi nimi |
| | `level` | Dokumendi tüübi tase (`level=1` - ülemtüüp, `level=2` - mingi ülemtüübi alamtüüp) |
| | `super_type_fk` | Viit ülemtüübile samasse tabelisse `doc_type`. Kui `level=1`, siis väärtuseks 0 |


### doc_type_attribute ###

Dokumendi tüübi atribuut (atribuudi tüüp), seosetabel. Näitab, millised atribuudi tüübid on seotud
millise dokumendi tüübiga. Kui rakendus sisestab tabelisse `document` uue dokumendi, siis peab
rakendus sellest tabelist lugema, millised atribuudi tüübid sellisel dokumendi tüübil on ja
sisestama vastava arvu kirjeid tabelisse `doc_attribute`.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `doc_type_attribute` | Võtmeväli, sisu on autonummerduv |
| | `doc_attribute_type_fk` | Viit dokumendi atribuudi tüübile tabelisse `doc_attribute_type` |
| | `doc_type_fk` | Viit dokumendi tüübile tabelisse `doc_type` |
| | `orderby` | Dokumendi atribuudi järjestus ekraanivormil. Selle välja sisu kopeeritakse tabelisse `doc_attribute.orderby`, kui seda tüüpi dokumendi atribuut andmebaasi lisatakse |
| | `required` | Kas seda tüüpi atribuudi väärtus peab kindlasti olema täidetud (selle dokumendi tüübi puhul). Selle välja sisu kopeeritakse tabelisse `doc_attribute.required` kui seda tüüpi dokumendi atribuut andmebaasi lisatakse |
| | `created_by_default` | Alati 'Y'. Sisuliselt ei ole selles ülesandes kasutuses |


### document ###

Dokument on selle allsüsteemi põhiobjekt.

Dokumendi, kui infoobjekti, omadused:

* dokumendil on tüüp (seos tüübiga vahetabelis) ja tüübist sõltuvad atribuudid
* dokument asub dokumendi kataloogis (seos vahetabeli kaudu)
* dokument on seotud subjektidega (isikute ja ettevõtetega) SUBJEKTIDE allsüsteemist
* dokumendil on staatus, staatuste ajalugu hoitakse eraldi tabelis `doc_status`

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `document` | Võtmeväli, sisu autonummerduv |
| | `doc_status_type_fk` | Dokumendi praegu kehtiv staatus. Kehtivale staatusele vastab ka kirje tabelis `doc_status`, mille `status_end` on `NULL`. Staatuse muutmisel lõpetatakse tabelis `doc_status` eelmine staatus (`status_end=NOW()`) ja sisestatakse uus jooksev staatus (`status_begin=NOW()`). Viit tabelisse `doc_status_type` |
| | `doc_nr` | Ei ole selles ülesandes kasutusel |
| | `name` | Dokumendi nimi, suvaline tekst |
| | `description` | Dokumendi kirjeldus, suvaline tekst |
| | `filename` | Dokumendi failinimi. Kui teete rakendusse ka dokumendifailide üleslaadimise (mida ei ole nõutud), siis sellesse välja saab salvestada faili nime. Muidu tühi |
| | `created` | Dokumendi andmebaasi sisestamise aeg |
| | `created_by` | Viit dokumendi sisestanud sisse logitud töötajale, viit SUBJEKTIDE allsüsteemi tabelisse `employee` |
| | `updated` | Dokumendi andmete salvestamise aeg |
| | `updated_by` | Viit dokumendi andmeid salvestanud sisse logitud töötajale, viit SUBJEKTIDE allsüsteemi tabelisse `employee` |


### document_doc_catalog ###

