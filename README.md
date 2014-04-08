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
| `doc_catalog` | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| `doc_catalog_type` | DOKUMENDID | &#10004; | | | |
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

*Dokumendi atribuudi tüübi valikväärtused.*

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

*Dokumendi atribuudi andmetüüp.*

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

*Dokumendi tunnus/omadus/atribuut.*

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

*Dokumendi atribuudi tüüp.*

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

*Dokumendi kataloog.*


## Vana ##

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
