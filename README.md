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

Informatsioon dokumendi muutmise vormi näitamiseks võetakse kokku 6-st tabelist:

1. Tabelist `document` dokumendi põhiandmed (nimi, kirjeldus)
2. Tabelitest `document_doc_type` ja `doc_type` dokumendi tüüp
3. Tabelist `doc_attribute` dokumendi atribuutide väärtused ("saatjad", "vastamise tähtaeg",
   "formaat")
4. Tabelist `doc_attribute_type` atribuutide nimed (mis tüüpi atribuudiga on tegemist). Kuigi seda
   tüübi nime võib dubleerida ka dokumendi atribuudi kirjes, tabelis `doc_attribute` on selle jaoks
   väli `type_name`.
5. Tabelist `atr_type_selection_value` valikväärtused juhul kui atribuudi andmetüüp on "valik"
   (`data_type=4`). Olemuselt on ikka tegemist number-tüübiga, aga numbrid selle atribuudi tüübi
   väärtusena on tegelikult viited tabelisse `atr_type_selection_value`.

Valikväärtused tabelis `atr_type_selection_value` on seotud atribuudi tüübiga `doc_attribute_type`
nii et kui me teame dokumendi atribuudi tüüpi, siis me saame alati küsida `atr_type_selection_value`
tabelist, mis on sellele atribuudi tüübile vastavad valikud.

**Millal sisestatakse dokumendi atribuudid tabelisse `doc_attribute`?**

Lühike vastus on - dokumendi sisestamisel tabelisse `document`, siis kui kasutaja vajutab "Sisesta
uus dokument" nuppu.

Dokumendi atribuudid sisestatakse dokumendi lisamisel. Millised atribuudid tuleb dokumendile lisada
sõltub dokumendi tüübist. Igal dokumendi tüübiga on seotud atribuudid tüübid. Seda seost hoitakse
tabelis `doc_type_attribute` ("dokumendi tüübi atribuudid"). Selles ülesandes on tehtud selline
eeldus, et dokumendi lisamisel (lisamisvormi avamisel) on alati teada (on valitud) dokumendi tüüp.
Kui dokukmendi tüüp on teada siis on võimalik lugeda tabelist `doc_type_attribute`, millised
atribuudi tüübid on selle dokumendi tüübiga seotud ja millises järjekorras tuleb neid atribuute
ekraanivormil näidata (`doc_type_attribute.orderby`). See informatsioon on piisav et genereerida
dokumendi sisestamise vorm nii, et seal oleksid ka väljad selle dokumendi tüübi atribuutide jaoks.

Näiteks dokumendi tüüp 10 puhul saame sellise atribuudi tüüpide komplekti:

```SQL
SELECT  DAT.doc_attribute_type,
        DAT.type_name,
        DTA.orderby,
        DTA.required,
        DTA.created_by_default,
        DAT.default_selection_id_fk AS valiku_id,
        DAT.data_type_fk
  FROM  doc_attribute_type DAT
        INNER JOIN  doc_type_attribute DTA
                ON  DAT.doc_attribute_type = DTA.doc_attribute_type_fk
 WHERE  DTA.doc_type_fk = 10;
```

Kui on tegemist atribuudiga mille andmetüübiks on 4 ("valik"), siis peame tabelist
`atr_type_selection_value` küsima selle atribuudi tüübiga seotud valikud *combobox*-is näitamiseks:

```SQL
  SELECT  ATSV.atr_type_selection_value,
          ATSV.value_text
    FROM  atr_type_selection_value ATSV
   WHERE  ATSV.doc_attribute_type_fk = 2
ORDER BY  orderby;
```

Kui kasutaja nüüd vajutab dokumendi lisamise vormil lisamise nuppu tuleb rakenduses teha 6
`INSERT`-lauset.

1. `INSERT` tabelisse `document`
2. `INSERT` tabelisse `document_doc_catalog` (eeldame et dokumendi lisamisel on mingi dokumendi
   kataloog alati valitud), et siduda dokument dokumendikataloogiga
3. `INSERT` tabelisse `document_doc_type`, et siduda dokument tema tüübiga
4. neli `INSERT`-i tabelisse `document_attribute`. Atribuudi väärtused võetakse dokumendi lisamise
   vormilt. Ilmselt on sellesse vormi peidetud väljadesse (*hidden fields*) võimalik vormi
   genereerimisel lisada ka infot selle kohta mis tüüpi atribuudiga on tegemist ja seda infot saab
   siis `INSERT` lausete konstrueerimisel rakenduse kasutada.

Lisaks tuleks uue dokumendi lisamisel uuendada dokumendi kataloogi tabelis `doc_catalog` selle
kataloogi sisu uuendamise aega (`content_updated`) ja kes sisu uuendas (`content_updated_by`).

Atribuudi lisamisel loetakse tabelist `doc_type_attribute` ka info selle kohta kas selle dokumendi
tüübi puhul on selle atribuudi väärtus nõutud (st. kasutaja ei tohi seda välja ekraanivormil tühjaks
jätta) ja millises järjekorras atribuute ekraanivormil kuvatakse. Ja see info kopeeritakse
`doc_attribute` tabelisse ka.

    doc_type_attribute.required = doc_attribute.required
    doc_type_attribute.orderby = doc_attribute.orderby

**Atribuudi väärtused erinevatesse andmeväljadesse tabelis `doc_attribute`.**

Andmebaasi sisestatud dokumendi andmed saame (muutmisvormi genereerimiseks) kätte nüüd sellise
päringuga:

```SQL
  SELECT  D.document,
          DAT.type_name,
          DA.value_text,
          DA.doc_attribute_type_fk,
          DA.value_number,
          DA.value_date,
          DA.atr_type_selection_value_fk
    FROM  document D
           LEFT JOIN  doc_attribute DA
                  ON  D.document = DA.document_fk
          INNER JOIN  doc_attribute_type DAT
                  ON  DA.doc_attribute_type_fk = DAT.doc_attribute_type
   WHERE  D.document = 1
ORDER BY  DA.orderby;
```

Ülemiselt pildilt näete et erinevat tüüpi atribuutide (tekst, number, kuupäev, valik) väärtused
tuleb salvestada erinevatesse andmeväljadesse tabelis `doc_attribute`.

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
| | `atr_type_selection_value_fk` | Viit atribuudi väärtusele kui valikule, tabelisse `atr_type_selection_value`. Täidetud juhul, kui `data_type=4` (valiku-tüüpi atribuut).<br />Atribuudi väärtus (see tähendab viide tabeli `atr_type_selection_value` võib olla atribuudi lisamisel andmebaasi juba olla täidetud – juhul kui sellel atribuudi tüübil on vaikimisi väärtus olemas – `doc_attribute_type.default_selection_id_fk` |
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

Dokumendi kataloog. Näitab, millises kataloogis dokument on.

Kuigi skeem võimaldab ühte dokumenti siduda mitme dokumendi kataloogiga, võtame selles ülesandes
eelduseks, et dokument saab korraga olla ainult ühes kataloogis.

Dokumendi kataloog salvestatakse siia tabelisse dokumendi lisamisel (rakendus võiks olla tehtud nii,
et dokumendi lisamisel on mingi kataloog alati valitud).

Dokumenti peaks olema võimalik ka ühest kataloogist teise tõsta (*"cut and paste"*). Vaata selle
kohta täpsemalt altpoolt, funktsionaalsetest nõuetest. Dokumendi tõstmisel ühest kataloogist teise
kustutatakse vana seos tabelist `document_doc_catalog` ja lisatakse uus seos tabelisse
`document_doc_catalog`, mis nüüd viitab juba dokumendi uuele kataloogile. Muudatustele selles
tabelis peavad kaasnema ka muudatused dokumendi kataloogis `doc_catalog` - kui siit tabelist midagi
kustutatakse või lisatakse, siis tuleb salvestada tabelisse `doc_catalog` selle kataloogi viimase
muutmise aeg ja viimane muutja (sisselogitud kasutaja), sest kataloogi sisu muutus
(`doc_catalog.updated` ja `doc_catalog.updated_by`)

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `document_doc_catalog` | Võtmeväli, sisu autonummerduv |
| | `doc_catalog_fk` | Viit dokumendi kataloogile tabelisse `doc_catalog` |
| | `document_fk` | Viit dokumendile tabelisse `document` |
| | `catalog_time` | Dokumendi kataloogi lisamise aeg (aeg, millal tehti selle kirje `INSERT` lause) |


### document_doc_type ###

Dokumendi tüüp.

Dokumendi tüüp ei ole salvestatud dokumendi tabelisse `document`, vaid dokumendi tüübi `doc_type` ja
dokumendi vahetabelisse - `document_doc_type`.

Kuigi skeem võimaldab ühte dokumenti siduda mitme dokumenditüübiga, võtame selles ülesandes
eelduseks, et dokumendil saab olla ainult üks tüüp.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `document_doc_type` | Võtmeväli, sisu autonummerduv |
| | `doc_type_fk` | Viit dokumendi tüübile tabelisse `doc_type` |
| | `document_fk` | Viit dokumendile, mille tüübiga on tegemist, viit tabelisse `document` |


### customer ###

Klient. Kui isikul või ettevõttel on klient, siis tuleb andmebaasi lisada kirje sellesse tabelisse.
`subject_fk` ja `subject_type_fk` näitavad, kas tegemist on isiku või ettevõttega ja viitavad
vastavale kirjele `person` või `enterprise` tabelis.

Kõik seosed, mis viitavad kõikides ülesande variantides kliendile, peavad viitama tabelisse
`customer`.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `customer` | Võtmeväli, sisu autonummerduv |
| | `subject_type_fk` | Viit tabelisse `subject_type`. Näitab, millisest tabelist tuleb otsida kliendi andmeid. Kui `subject_type_fk=1`, siis viitab väli `subject_fk` tabelisse `person`. Kui `subject_type_fk=2`, siis viitab väli `subject_fk` tabelisse `enterprise` |
| | `subject_fk` | Viit tabelisse `person` või `enterprise`, viitab ettevõttele või isikule, kes on klient. Millisesse tabelisse konkreetse aadressi kirje puhul viidatakse seda näitab välja `subject_type_fk` sisu. |


### employee ###

Töötaja andmed. Kõikide ülesannete variantide andmebaasides, kus on tabelites väljad `updated_by` ja
`created_by` viitavad need väljad `employee` tabelisse.

Kõik ülesande variandid kasutavad sisselogimiseks tabelite `employee` ja `user_account` andmeid. Kui
kasutaja sisestab kasutajanime ja parooli, siis otsitakse seda kasutajanime ja parooli tabelist
`user_account` ja kui leitakse, siis leitakse ka sellele kasutajakontole vastava `employee`
identifikaator (`user_account.employee_fk`). Sisselogimisel leitud viidet `employee` tabeli kirjele
kasutatakse vajadusel rakenduses `created_by` ja `updated_by` väljade täitmiseks.

Üldiselt on soovitatav parooli väljas `passw` hoida paroole krüpteeritult (nt. MD5).

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `employee` | Võtmeväli, sisu autonummerduv |
| | `struct_unit_fk` | Ei ole kasutusel |
| | `enterprise_fk` | Viit tabelisse `enterprise`. Viit ettevõttele, mille töötajaga on tegemist |
| | `person_fk` | Viit tabelisse `person`. Viit isikule, kes on töötaja |
| | `active` | Kas töötaja on selles ettevõttes praegu töötaja (`Y`) või on seal kunagi olnud töötaja (`N`) |


### enterprise ###

Ettevõte.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `enterprise` | Võtmeväli, ettevõtte id. Sisu on autonummerduv |
| | `name` | Ettevõtte nimi |
| | `full_name` | Ettevõtte pikk, ametlik nimi |
| | `created_by` | Rakendusse sisseloginud töötaja, kelle poolt ettevõte sisestatud. Viit tabelisse `employee` |
| | `updated_by` | Sisseloginud töötaja, kelle poolt ettevõtte andmed (sealhulgas aadressid, kontaktid või atribuudid) on viimasena muudetud. Viit tabelisse `employee` |
| | `created` | Ettevõtte sisestamise aeg (andmebaasi). Uuendatakse koos väljaga `created_by` |
| | `updated` | Ettevõtte andmete muutmise aeg (uuendatakse koos väljaga `updated_by`) |


### person ###

Tabel isikute andmete hoidmiseks.

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `person` | Võtmeväli, sisu autonummerduv |
| | `first_name` | Eesnimi |
| | `last_name` | Perekonnanimi |
| | `identity_code` | Isikukood |
| | `birth_date` | Sünniaeg |
| | `created_by` | Sisseloginud töötaja, kelle poolt isik sisestatud. Viit tabelisse `employee` |
| | `updated_by` | Sisseloginud töötaja, kelle poolt isiku andmed (sealhulgas aadressid, kontaktid või atribuudid) on viimasena muudetud. Viit tabelisse `employee` |
| | `created` | Isiku andmebaasi sisestamise aeg (uuendatakse koos väljaga `created_by`) |
| | `updated` | Isiku andmete viimase muutmise aeg (uuendatakse koos väljaga `updated_by`) |


### user_account ###

Töötaja kasutajakonto. Selleks, et rakendusse sisse logida, peavad tabelisse `employee` olema
sisestatud töötajad ja nendel töötajatel (kes saavad sisse logida), peab olema üks konto tabelis
`user_account`.

Kõik ülesande variandid kasutavad sisselogimiseks tabelite `employee` ja `user_account` andmeid. Kui
kasutaja sisestab kasutajanime ja parooli, siis otsitakse seda kasutajanime ja parooli tabelist
`user_account` ja kui leitakse, siis leitakse ka sellele kasutajakontole vastava `employee`
identifikaator (`user_account.employee_Fk`). Sisselogimisel leitud viidet `employee` tabeli kirjele
kasutatakse vajadusel rakenduses `created_by` ja `updated_by` väljade täitmiseks.

Üldiselt on soovitatav parooli väljas `passw` hoida paroole krüpteeritult (nt. MD5).

| PK | Andmeväli | Kirjeldus |
| --- | --- | --- |
| &#10004; | `user_account` | Võtmeväli, sisu autonummerduv |
| | `subject_type_fk` | Alati 3 (see tähendab, et `subject_fk` viitab alati tabelisse `employee`) |
| | `subject_fk` | Viit tabelisse `employee` - töötaja, kelle kontoga on tegemist |
| | `username` | Kasutajanimi |
| | `passw` | Parool. Soovitatav hoida krüpteeritult. Kui parooli hoitakse andmebaasis krüpteeritult, siis autentimisel krüpteeritakse sama algoritmiga (nt. MD5) ära ka kasutaja sisestatud parool ja kontrollitakse nende võrdsust |
| | `status` | Kas konto on kehtiv või mitte |
| | `valid_from` | Konto kehtivuse algus (võib langeda kokku konto loomise ajaga) |
| | `valid_to` | Konto kehtivuse lõpp (kui täitmata, siis tähendab, et kehtib määramata aja) |
| | `created_by` | Kelle poolt konto on loodud. Viit tabelisse `employee` |
| | `created` | Konto loomise aeg |
| | `password_never_expires` | `Y` - parool ei aegu, `N` - parool aegub (mingi aja pärast, millal aegub pole oluline siin) |


## Rakenduselt oodatav funktsionaalsus ##

### Funktsionaalsuste loetelu ###

#### Dokumendi tüüpide ettevalmistamine `INSERT`-lausetega ####

Lisage `INSERT`-lausetega dokumendi atribuudi tüüpide tabelisse `doc_attribute_type` **16-20**
atribuudi tüüpi. Lisage selliseid tüüpe, mis on string tüübid (atribuudi väärtus salvestatakse
`doc_attribute` tabelis `value_text` välja), aga lisage ka mõned atribuudi tüübid, millel
`data_type=2` (atribuudi väärtus salvestatakse `doc_attribute` tabelis `value_number` välja),
`data_type=3` (atribuudi väärtus salvestatakse `doc_attribute` tabelis `value_date` välja) ja
`data_type=4` (atribuudi väärtused võetakse valikväärtustena tabelist `atr_type_selection_value`).

```SQL
INSERT INTO  doc_attribute_type
             (type_name, data_type_fk, multiple_attributes)
     VALUES  ('saatjad', 1, 'N');

INSERT INTO  doc_attribute_type
             (type_name, data_type_fk, default_selection_id_fk, multiple_attributes)
     VALUES  ('vastamise tahtaeg', 4, 4, 'N');

INSERT INTO  doc_attribute_type
             (type_name, data_type_fk, multiple_attributes)
     VALUES  ('formaat', 1, 'N');
```

Kui lisasite atribuudi tüüpe, millele on valikväärtused, siis lisage ka nendele tüüpidele vastavad
valikväärtused tabelisse `atr_type_selection_value`.

```SQL
INSERT INTO  atr_type_selection_value
             (doc_attribute_type_fk, value_text, orderby)
     VALUES  (2, 'kahe paeva jooksul', 1);

INSERT INTO  atr_type_selection_value
             (doc_attribute_type_fk, value_text, orderby)
     VALUES  (2, 'nadala jooksul', 2);

INSERT INTO  atr_type_selection_value
             (doc_attribute_type_fk, value_text, orderby)
     VALUES  (2, 'kuu aja jooksul', 3);

INSERT INTO  atr_type_selection_value
             (doc_attribute_type_fk, value_text, orderby)
     VALUES  (2, 'maaramata', 4);
```

Rakenduse töö ettevalmistamiseks valige nüüd välja vähemalt 4 dokumendi tüüpi (`doc_type`) ja siduge
iga tüübiga vähemalt **4-5** atribuudi tüüpi (andmebaasis tähendab see `INSERT` lauseid
`doc_type_attribute` tabelisse). Sisestage andmed nii, et erinevatel dokumendi tüüpidel vähemalt
mõned atribuudi tüübid kattuvad.

```SQL
INSERT INTO  doc_type_attribute
             (doc_type_fk, doc_attribute_type_fk, created_by_default, orderby, required)
     VALUES  (10, 1, 'Y', 1, 'N');

/* doc_attribute_type-fk=2 (vastamise tahtaeg) */
INSERT INTO  doc_type_attribute
             (doc_type_fk, doc_attribute_type_fk, created_by_default, orderby, required)
     VALUES  (10, 2, 'Y', 2, 'Y');

/* doc_attribute_type-fk=3 (dokumendi formaadi kohta mingid tapsemad andmed) */
INSERT INTO  doc_type_attribute
             (doc_type_fk, doc_attribute_type_fk, created_by_default, orderby, required)
     VALUES  (10, 3, 'Y', 3, 'N');
```

&hellip;


#### Dokumentide lisamine, muutmine ja kustutamine ####

Dokumentide sisestamisel eeldame, et:

* sisestamisel on alati määratud dokumendi tüüp, sellest tüübist sõltub dokumendi sisestamise ja
  muutmise vormi sisu
* sisestamisel on alati valitud dokumendi kataloog

Dokumendi andmete muutmisel dokumendi tüüpi muuta ei saa, *read-only*.

Dokumenti peab saama kustutada. Kustutamisel kustutatakse ära ka kõik dokumendiga seotud kirjed
atribuutide, staatuste, kataloogi-seoste ja subjekti-seoste tabelitest.

Dokumendi lisamisel, kustutamisel ja andmete salvestamisel tuleb muuta dokumendi kataloogi andmeid
tabelis `doc_catalog`, et salvestada kataloogi sisu muutmise aeg ja viimane muutja.

**Dokumendi lisamise ja andmete salvestamise kohta vaata kindlasti tabeli `doc_attribute` selgitust.**


#### Dokumentide seostamine subjektidega SUBJEKTIDE allsüsteemist ####

**NB!** Need, kes teevad ülesannet üksi, võivad selle punkti vahele jätta.

Dokumentidele peab saama lisada seoseid SUBJEKTIDE allsüsteemi isikutega `person` ja ettevõtetega
`enterprise`. Seose loomisel peab saama määrata seose tüüpi (seose tähendus, semantika) ja peab
saama sisestada märkust seose kohta (`note`).

Dokumendi seoseid subjektidega peab saama kustutada.

Dokumendi seoste andmete muutmist pole vaja teha.


#### Dokumentide otsing

Dokumentide otsinguvormil on kaks võimalikku olekut:

1. siis kui mingi dokumendi tüüp (mille seast otsida) on valimata
2. siis kui dokumendi tüüp on valitud

**Dokumendi tüüp valimata:**

Otsida tuleks:

* dokumendi (andmebaasi) id järgi
* dokumendi nime järgi
* dokumendi kirjelduse järgi
* viimase muutja perekonnanime järgi (`employee` -> `person.last_name`)
* kataloogi nime järgi, kus dokument asub
* dokumentidega seotud subjektide nime järgi (`enterprise.name`, `person.last_name`)
* dokumendi staatuse järgi
* dokumendi atribuudi väärtuste järgi. Kuna atribuudi tüüpi pole siin otsinguvormil määratud, siis
  tuleks vaadata kõikide selle dokumendiga seotud atribuudi andmetesse, väljadesse `value_text`,
  `value_number` ja `value_date`. Millisest atribuudi väärtuse väljadest otsime, see sõltub nüüd
  mõnevõrra ka sisestatud atribuudi väärtusest - kui sisestatud on "Tallinn", siis ei ole ilmselt
  mõtet vaadata atribuute, mille sisu on number-tüüpi.

**NB!** Kui selle päringu atribuutide osa ja eriti erinevatel juhtudel erinevatest atribuudi
andmeväljadest otsimine tundub teile keeruline, siis tehke lihtsamalt - otsige ainult `value_text`
väljast. Te võite atribuudi andmete salvestamisel `value_number` ja `value_date` väljade sisu alati
dubleerida ka `value_text` välja ja nii saate te otsinguga sellest tabelist andmeid kätte kui
vaatate alati ainult `value_text` välja sisse. Aga siis peate mõnevõrra täiendama atribuudi andmete
salvestamist.

**Dokumendi tüüp valitud:**

Kui otsinguvormil on dokumendi tüüp valitud, siis otsinguvormi atribuutide osa muutub - nüüd on
teada, mis tüüpi atribuudid antud tüüpi dokumendil on ja saab nende atribuutide järgi ka otsingut
teha.

Muu otsinguloogika jääb samaks, mis dokumendi tüübita otsingu puhul. Atribuutide tabelis
`doc_attribute` andmete otsimise loogika aga muutub täpsemaks:

Tekstiotsinguid sisaldavad päringud peaksid üldjuhul olema tõstutundetud, mis tähendab, et
PostgreSQL-i `SELECT` lauseid tuleb täiendada `UPPER()` või `LOWER()` funktsioonidega, kuna
vaikimisi on PostgreSQL-i `LIKE` päring tõstutundlik. PostgreSQL-i täistekstipäring (*full-text
search*) ei ole tõstutundlik.

**Kui kataloogipuust on dokumendi kataloog valitud:**

Siis võiks otsing vaikimisi toimuda selle valitud dokumendi kataloogi dokumentide hulgast - kui
otsinguvormi väli "kataloogi nimi" on täitmata.

Kataloogipuus peaks olema võimalik vajutada mingile juurharule (`/root`), mis tühistaks kataloogi
valiku kasutajaliidesel - siis saaksid otsingud toimuda üle kõikide kataloogide (see tähendab,
sellisel juhul, et kataloogi arvestatakse ainult siis, kui kasutaja täidab "kataloogi nimi" välja,
jooksvat kataloogi ei ole valitud).

**Kuidas otsida:**

Kui tegemist on selliste tekstiväljadega, mis sisaldavad ühte stringi (dokumendikataloogi nimi,
toote kood, kliendi nimi, &hellip;), siis võiks otsida sõna alguse järgi `LIKE`-tüüpi päringuga.
Kuna PostgreSQL-i `LIKE`-otsing on vaikimisi tõstutundlik (*case-sensitive*), siis on mõistlik
`WHERE`-klausli mõlemad pooled näiteks `UPPER()`-funktsiooniga teisendada. Tekstiotsingus me
tavaliselt ei taha tõstutundlikkust.

Kui tegemist on selliste tekstiväljadega, mis sisaldavad pikemat teksti (mitu sõna), siis võiks
otsida täistekstiotsinguga, mis tähendab, et otsitakse, kas otsitavad sõnad sisalduvad väljas.
Näiteks aadressid, märkused, tegevusalad vms.

Kui tegemist on kuupäevade ja numbritega (summad, aastaarvud), mille puhul on mõistlik otsingul ette
anda vahemik, siis võiks seda teha (kuid kohustust nii teha ei ole).

**Otsinguvormil sisestatud andmete säilitamine pärast otsingu nupule vajutamist:**

Otsinguvormile sisestatud andmed peaksid olema sellel otsinguvormil alles ka pärast nupule "Otsi"
vajutamist (pärast veebilehe ümberlaadimist). Otsinguvorm ise võiks ka muidugi ekraanile alles
jääda, et uue otsingu tegemiseks ei (?)


#### Dokumentide tõstmine puhvrisse ja puhvrist liigutamine uude kataloogi (*cut and paste*)

&hellip;


#### Dokumendifailide üles- ja allalaadimine veebilehitsejas

Dokumendifailide üleslaadimist ei ole selles rakenduses vaja teha. Kui selle siiski lisate
rakendusse (nii, et saab dokumendifaili veebilehitsejast üles laadida ja seda faili pärast alla
tõmmata) saate kindlasti *mitteformaalseid* plusspunkte. Aga tegeleda selle teemaga oleks mõtet
(kui üldse) alles siis, kui kõik ülejäänud osad on tehtud.


#### Töötaja autentimine (sisse- ja väljalogimine)

Rakendust saab kasutada peale sisselogimist. Kasutajanime ja parooli kontrollimiseks
(autentimispäring) kasutatakse andmeid SUBJEKTID allsüsteemi tabelist `user_account`.

Kõik ülesande variandid kasutavad sisselogimiseks tabelite `employee` ja `user_account` andmeid. Kui
kasutaja sisestab kasutajanime ja parooli, siis otsitakse seda kasutajanime ja parooli tabelist
`user_account` ja kui leitakse, siis leitakse ka sellele kasutajakontole vastava `employee`
identifikaator (`user_account.employee_fk`). Sisselogimisel leitud viidet `employee` tabeli kirjele
kasutatakse vajadusel rakenduses `created_by` ja `updated_by` väljade täitmiseks.

Üldiselt on soovitatav parooli väljas `passw` hoida paroole krüpteeritult (nt. MD5).

```SQL
/* tootaja kasutajanimega 'marten' logib systeemi sisse */
SELECT  E.employee, UA.user_account, P.first_name, P.last_name
  FROM  employee E
        INNER JOIN  user_account UA
                ON  E.employee = UA.subject_fk
        INNER JOIN  person P
                ON  E.person_fk = P.person
 WHERE      UA.subject_type_fk = 3
        AND UA.username = 'marten'
        AND UA.passw = '37b4931088193a73b6561bae19bf06d9';
```

Rakenduses peab olema tehtud ka väljalogimine.


### Ärireeglid ja andmete kontrollid (10 reeglit)

Praktikaülesande üldistes nõuetes on kirjas, et tuleb rakendusse teha ka *validaator* tüüpi objektid
(klassid), mis kontrollivad sisendandmete õigsust. Millised need reeglid on, millele andmed peavad
vastama - need mõelge ise välja.

Mõelge välja vähemalt 10 reeglit, millele sisendandmed peavad vastama ja kontrollige rakenduses neid
reegleid (kui kasutajad andmeid sisestavad või muudavad) ning andke kasutajale ekraanivormidel teada
kui sisend-andmed neid kontrolli reegleid ei rahulda. Mõned reeglid on selle praktikatöö juhendis
erinevates kohtades ka juba toodud, neid võib ka 10 hulka arvestada.

Näiteks:

* millised väljad ei tohi olla tühjad
* milliseid andmeid ei tohi kustutada kuna nendele andmetele viidatakse teistes tabelites
* millised summad või kuupäevad peavad jääma teatud piiridesse
* millal võib tellimusele teha arvet
* millal võib tellimust kustutada
* &hellip;


## Mida teha siis, kui mingi osa ülesande funktsionaalsusest tundub ebaselge

Kui midagi jääb ebaselgeks või midagi ei ole täpselt kirjeldatud, siis võib alati harjutustunnis
küsida, aga võib ka ise otsustada ebaselgetes situatsioonides, kuidas rakendus peaks toimima.
Ilmselt on mõistlik otsustada nii, et peaks vähem programmeerima, et rakenduse toimimine oleks
lihtsam.


## Täiendavad disainimustrid

RubyOnRailsi raamistikku sisseehitatud mustrid:

* ActiveRecord
* Convention over configuration
* RESTful routing
* DRY
* ...


## Kasutatav SQL protseduur

```SQL
CREATE OR REPLACE FUNCTION delete_document (document_id IN NUMERIC(10), user_id IN NUMERIC(10))
RETURNS void AS
$$
BEGIN
  UPDATE doc_catalog SET content_updated_by = user_id, content_updated = NOW() WHERE doc_catalog IN (
    SELECT doc_catalog_fk FROM document_doc_catalog WHERE document_fk = document_id
  );
  DELETE FROM document_doc_catalog WHERE document_fk = document_id;
  DELETE FROM document_doc_type WHERE document_fk = document_id;
  DELETE FROM doc_attribute WHERE document_fk = document_id;
  DELETE FROM doc_status WHERE document_fk = document_id;
  DELETE FROM document WHERE document = document_id;
END;
$$
LANGUAGE 'plpgsql';
```
