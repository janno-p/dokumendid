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


## Andmed ##

Kasutatavad andmebaasitabelid:

DOKUMENDID allsüsteemist

    * atr_type_selection_value
    * data_type
    * doc_attribute
    * doc_attribute_type
    * doc_catalog
    * doc_catalog_type
    * doc_status
    * doc_status_type
    * doc_subject
    * doc_subject_relation_type
    * doc_subject_type
    * doc_type
    * doc_type_attribute
    * document
    * document_doc_catalog
    * document_doc_type

SUBJEKTID allsüsteemist

    * customer
    * employee
    * enterprise
    * person
    * user_account


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
