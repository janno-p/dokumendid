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
| atr_type_selection_value | DOKUMENDID | &#10004; | | | |
| data_type | DOKUMENDID | &#10004; | | | |
| doc_attribute | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| doc_attribute_type | DOKUMENDID | &#10004; | | | |
| doc_catalog | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| doc_catalog_type | DOKUMENDID | &#10004; | | | |
| doc_status | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| doc_status_type | DOKUMENDID | &#10004; | | | |
| doc_subject | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| doc_subject_relation_type | DOKUMENDID | &#10004; | | | |
| doc_subject_type | DOKUMENDID | &#10004; | | | |
| doc_type | DOKUMENDID | &#10004; | | | |
| doc_type_attribute | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| document | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| document_doc_catalog | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| document_doc_type | DOKUMENDID | &#10004; | &#10004; | &#10004; | &#10004; |
| customer | SUBJEKTID | &#10004; | | | |
| employee | SUBJEKTID | &#10004; | | | |
| enterprise | SUBJEKTID | &#10004; | | | |
| person | SUBJEKTID | &#10004; | | | |
| user_account | SUBJEKTID | &#10004; | | | |


## Andmetabelite ja väljade kirjeldused ##

### atr_type_selection_value ###

*Dokumendi atribuudi tüübi valikväärtused*

Mingi dokumendi atribuudi tüübi valikväärtused (sellel atribuudi tüübil peab `data_type=4`), mille
hulgast kasutaja saab ekraanivormil valida atribuutidele väärtuseid. Väärtused ei ole kasutaja poolt
sisestatavad, vaid ta saab ainult etteantud loendist valida.

Antud tabelisse ei ole selles ülesandes vaja läbi rakenduse andmeid lisada. Andmed sisestatakse
INSERT-lausetega otse andmebaasi.

| --- | --- |
| atr_type_selection_value (pk) | Võtmeväli, sisu autonummerduv |
| value_text | Valikväärtuse nimetus |
| orderby | Järjekord - näitab, millises järjekorras näidatakse kasutajale valikväärtusi (näiteks "combo-box"-is) |


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
