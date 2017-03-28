

/* 
Skrypt wdro¿eniowy bazy danych
Temat: Sklep Tapicerski
 
SYLWIA PYTKO
I4Z6S1
2016r.

*/


//Stworzenie tabel wraz z ich atrybutami



CREATE TABLE faktura_detale
  (
    faktura_naglowek_id_faktury NUMERIC (6) NOT NULL ,
    pozycja                     NUMERIC (2) NOT NULL ,
    liczba                      NUMERIC (4) NOT NULL ,
    cena_zakupu                 NUMERIC (5,2) NOT NULL ,
    produkt_id_produktu         NUMERIC (4) NOT NULL
  ) ;
ALTER TABLE faktura_detale ADD CONSTRAINT faktura_detale_PK PRIMARY KEY ( pozycja, faktura_naglowek_id_faktury ) ;


CREATE TABLE faktura_naglowek
  (
    id_faktury        NUMERIC (6) NOT NULL ,
    data_faktury      DATE NOT NULL ,
    wartosc_faktury   NUMERIC (7,2) NOT NULL ,
    klient_id_klienta NUMERIC (4) NOT NULL
  ) ;
ALTER TABLE faktura_naglowek ADD CONSTRAINT faktura_naglowek_PK PRIMARY KEY ( id_faktury ) ;


CREATE TABLE klient
  (
    id_klienta    NUMERIC (4) NOT NULL ,
    nazwa_klienta VARCHAR (20) NOT NULL ,
    miasto        VARCHAR (20) NOT NULL ,
    adres         VARCHAR (40) NOT NULL
  ) ;
ALTER TABLE klient ADD CONSTRAINT klient_PK PRIMARY KEY ( id_klienta ) ;


CREATE TABLE kolekcja
  (
    id_kolekcji    NUMERIC (4) NOT NULL ,
    nazwa_kolekcji VARCHAR (20) NOT NULL ,
    rok            NUMERIC (4) NOT NULL ,
    projektant     VARCHAR (20) NOT NULL
  ) ;
ALTER TABLE kolekcja ADD CONSTRAINT kolekcja_PK PRIMARY KEY ( id_kolekcji ) ;


CREATE TABLE material
  (
    id_materialu    NUMERIC (4) NOT NULL ,
    nazwa_materialu VARCHAR (20) NOT NULL ,
    wzor            VARCHAR (20) NOT NULL ,
    kolor           VARCHAR (20) NOT NULL
  ) ;
ALTER TABLE material ADD CONSTRAINT material_PK PRIMARY KEY ( id_materialu ) ;


CREATE TABLE model
  (
    id_modelu            NUMERIC (4) NOT NULL ,
    nazwa_modelu         VARCHAR (20) NOT NULL ,
    kolekcja_id_kolekcji NUMERIC (4) NOT NULL ,
    rodzaj_id_rodzaju    NUMERIC (4) NOT NULL ,
    rozmiar_id_rozmiaru  NUMERIC (4) NOT NULL
  ) ;
ALTER TABLE model ADD CONSTRAINT model_PK PRIMARY KEY ( id_modelu ) ;


CREATE TABLE produkt
  (
    id_produktu           NUMERIC (4) NOT NULL ,
    nazwa_produktu        VARCHAR (20) NOT NULL ,
    cena_produktu         NUMERIC (5,2) NOT NULL ,
    model_id_modelu       NUMERIC (4) NOT NULL ,
    material_id_materialu NUMERIC (4) NOT NULL
  ) ;
ALTER TABLE produkt ADD CONSTRAINT produkt_PK PRIMARY KEY ( id_produktu ) ;


CREATE TABLE rodzaj
  (
    id_rodzaju    NUMERIC (4) NOT NULL ,
    nazwa_rodzaju VARCHAR (20) NOT NULL ,
    przeznaczenie VARCHAR (20) NOT NULL ,
    gwarancja     NUMERIC (2) NOT NULL
  ) ;
ALTER TABLE rodzaj ADD CONSTRAINT rodzaj_PK PRIMARY KEY ( id_rodzaju ) ;


CREATE TABLE rozmiar
  (
    id_rozmiaru NUMERIC (4) NOT NULL ,
    wymiar_x    NUMERIC (4) NOT NULL ,
    wymiar_y    NUMERIC (4) NOT NULL ,
    wymiar_z    NUMERIC (4) NOT NULL
  ) ;
ALTER TABLE rozmiar ADD CONSTRAINT rozmiar_PK PRIMARY KEY ( id_rozmiaru ) ;





//Dodanie relacji miêdzy tabelami


ALTER TABLE faktura_detale ADD CONSTRAINT faktura_detale_faktura_FK FOREIGN KEY ( faktura_naglowek_id_faktury ) REFERENCES faktura_naglowek ( id_faktury ) ;

ALTER TABLE faktura_detale ADD CONSTRAINT faktura_detale_produkt_FK FOREIGN KEY ( produkt_id_produktu ) REFERENCES produkt ( id_produktu ) ;

ALTER TABLE faktura_naglowek ADD CONSTRAINT faktura_naglowek_klient_FK FOREIGN KEY ( klient_id_klienta ) REFERENCES klient ( id_klienta ) ;

ALTER TABLE model ADD CONSTRAINT model_kolekcja_FK FOREIGN KEY ( kolekcja_id_kolekcji ) REFERENCES kolekcja ( id_kolekcji ) ;

ALTER TABLE model ADD CONSTRAINT model_rodzaj_FK FOREIGN KEY ( rodzaj_id_rodzaju ) REFERENCES rodzaj ( id_rodzaju ) ;

ALTER TABLE model ADD CONSTRAINT model_rozmiar_FK FOREIGN KEY ( rozmiar_id_rozmiaru ) REFERENCES rozmiar ( id_rozmiaru ) ;

ALTER TABLE produkt ADD CONSTRAINT produkt_material_FK FOREIGN KEY ( material_id_materialu ) REFERENCES material ( id_materialu ) ;

ALTER TABLE produkt ADD CONSTRAINT produkt_model_FK FOREIGN KEY ( model_id_modelu ) REFERENCES model ( id_modelu ) ;








//Utworzenie sekwencji i przypisanie wartoœci defaultowych

alter table material
modify wzor DEFAULT 'G³adki'; //Wiêkszoœæ materia³ów nie bêdzie mia³a wzoru

alter table rodzaj
modify gwarancja DEFAULT 24; //wiêkszoœæ rodzaji bêdzie mia³a 2 letni¹ gwarancjê


//Dla ka¿dej tabeli (oprócz fakturowych) tworze sekwencjê licz¹c¹ klucz g³ówny

CREATE SEQUENCE "seq_n_z6_06_id_klienta" MINVALUE 1 MAXVALUE 1000 INCREMENT BY 1 CYCLE CACHE 50;
alter table klient
modify id_klienta default (seq_n_z6_06_id_klienta.nextval);

CREATE SEQUENCE "seq_n_z6_06_id_rozmiaru" MINVALUE 1 MAXVALUE 1000 INCREMENT BY 1 CYCLE CACHE 50;
alter table rozmiar
modify id_rozmiaru default (seq_n_z6_06_id_rozmiaru.nextval);

CREATE SEQUENCE "seq_n_z6_06_id_rodzaju" MINVALUE 1 MAXVALUE 1000 INCREMENT BY 1 CYCLE CACHE 50;
alter table rodzaj
modify id_rodzaju default (seq_n_z6_06_id_rodzaju.nextval);

CREATE SEQUENCE "seq_n_z6_06_id_modelu" MINVALUE 1 MAXVALUE 1000 INCREMENT BY 1 CYCLE CACHE 50;
alter table model
modify id_modelu default (seq_n_z6_06_id_modelu.nextval);

CREATE SEQUENCE "seq_n_z6_06_id_materialu" MINVALUE 1 MAXVALUE 1000 INCREMENT BY 1 CYCLE CACHE 50;
alter table material
modify id_materialu default (seq_n_z6_06_id_materialu.nextval);

CREATE SEQUENCE "seq_n_z6_06_id_kolekcji" MINVALUE 1 MAXVALUE 1000 INCREMENT BY 1 CYCLE CACHE 50;
alter table kolekcja
modify id_kolekcji default (seq_n_z6_06_id_kolekcji.nextval);

CREATE SEQUENCE "seq_n_z6_06_id_produktu" MINVALUE 1 MAXVALUE 1000 INCREMENT BY 1 CYCLE CACHE 50;
alter table produkt
modify id_produktu default (seq_n_z6_06_id_produktu.nextval);






//Wprowadzenie danych do tabel

//1. Klient


//1
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Abacki',
'Warszawa',
'ul. D³uga 78/12'
);


//2
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Babacki',
'Warszawa',
'ul. Mi³a 23/2'
);

//3
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Cabacki',
'Toruñ',
'ul. Radosna 22/2'
);

//4
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Dabacki',
'Pruszków',
'ul. Jana Olbrachta 13'
);

//5
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Kowalski',
'Toruñ',
'ul. Radosna 22/2'
);

//6
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Hotel Zamkowy',
'Toruñ',
'ul. Podmurna 24'
);


//7
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Hotel Monet',
'Toruñ',
'ul. Leœna 24'
);

//8
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Leœniczówka',
'Z³otoria',
'ul. Daleka 124'
);

//9
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Queen',
'Z³otoria',
'ul. Poleg³a 14'
);



//9
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Jogolot',
'Turzno',
'ul. Iglasta 14'
);


//10
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Queen',
'Z³otoria',
'ul. Poleg³a 14'
);



//11
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'NOCH',
'Toruñ',
'ul. œw. Emilii 102/3'
);

//12
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'DamgMar',
'Toruñ',
'ul. Kartonowa 2/12'
);

//13
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Mister Ron',
'Kowalewo Pomorskie',
'ul. Witaminowa 20/1'
);


//14
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Domki Miodzio',
'Kamionki',
'ul. Jeziorna 5'
);


//15
insert into klient
(nazwa_klienta, miasto, adres)
values
(
'Hostel Dworcowy',
'Kowalewo Pomoskie',
'ul. Kolejowa 10/5'
);


//2. Kolekcja


//1
insert into kolekcja
(nazwa_kolekcji, rok, projektant)
values
(
'Classy',
2015,
'Witkowski Micha³'
);

//2
insert into kolekcja
(nazwa_kolekcji, rok, projektant)
values
(
'Modern',
2015,
'Nosal Adam'
);

//3
insert into kolekcja
(nazwa_kolekcji, rok, projektant)
values
(
'Vintage',
2015,
'Witkowski Micha³'
);

//4
insert into kolekcja
(nazwa_kolekcji, rok, projektant)
values
(
'Sonata',
2015,
'Kostka Robert'
);

//5
insert into kolekcja
(nazwa_kolekcji, rok, projektant)
values
(
'Contra',
2015,
'Nosal Adam'
);

//6
insert into kolekcja
(nazwa_kolekcji, rok, projektant)
values
(
'Forte',
2016,
'Mi³o Aneta'
);




//3. Rodzaj


//1
insert into rodzaj
(nazwa_rodzaju, przeznaczenie)
values
(
'Sofa',
'Salon'
);

//2
insert into rodzaj
(nazwa_rodzaju, przeznaczenie, gwarancja)
values
(
'Naro¿nik',
'Salon',
30
);


//3
insert into rodzaj
(nazwa_rodzaju, przeznaczenie)
values
(
'Fotel',
'Salon'
);

//4
insert into rodzaj
(nazwa_rodzaju, przeznaczenie, gwarancja)
values
(
'Pufa',
'Salon',
12
);

//5
insert into rodzaj
(nazwa_rodzaju, przeznaczenie, gwarancja)
values
(
'Podnó¿ek',
'Salon',
12
);

//6
insert into rodzaj
(nazwa_rodzaju, przeznaczenie)
values
(
'£awa',
'Salon'
);

//7
insert into rodzaj
(nazwa_rodzaju, przeznaczenie, gwarancja)
values
(
'Fotel biurowy',
'Biuro',
18
);

//8
insert into rodzaj
(nazwa_rodzaju, przeznaczenie)
values
(
'£ó¿ko',
'Sypialna'
);







//4. Rozmiar


/*Notatki do którego rodzaju dany wymiar siê najlepiej nadaje by³y przydatne do wybierania rozmiaru dla modelu, 
w rzeczywistym œwiecie, osoba sprzedaj¹ca meble dok³adnie wiedzia³a by jakie rozmiary mo¿e przyjmowaæ np. Sofa 
i wybra³a by odpowiednie z listy (lub wprowadzi³a nowe)*/


//Sofa
//1
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	150,60,60
);

//Sofa
//2
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	170,60,60
);

//Sofa
//3
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	250,60,60
);

//Naro¿nik, £ó¿ko
//4
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	180,60,150
);


//Naro¿nik, £ó¿ko
//5
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	230,60,200
);

//Naro¿nik, £ó¿ko
//6
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	250,50,200
);

//Fotel
//7
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	100,120,100
);

//Fotel
//8
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	90,140,100
);

//Pufa, Podnó¿ek, £awa
//9
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	100,60,100
);

//Pufa, Podnó¿ek, £awa
//10
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	90,60,80
);

//Pufa, Podnó¿ek, £awa
//11
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	70,40,50
);

//Fotel biurowy
//12
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	60,120,60
);

//Fotel biurowy
//13
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	70,140,60
);

//Fotel biurowy
//14
insert into rozmiar
(wymiar_x, wymiar_y, wymiar_z)
values
(
	70,150,60
);






//5. Model

//Dla ka¿dej kolekcji jest wprowadzane kilka modeli




//Classy
insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Ania', 1, 1, 1 //sofa
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Amanda', 1, 1, 3 //sofa
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Ala', 1, 3, 7//Fotel
);


insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Alicja', 1, 4, 10//Pufa
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Alina', 1, 4, 9//Pufa
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Alona', 1, 5, 11//Podnó¿ek
);



//Modern


insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Paris', 2, 2, 4//Naro¿nik
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Berlin', 2, 2, 6//Naro¿nik
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'London', 2, 6, 11//£awa
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'NewYork', 2, 7, 12//Fotel biurowy
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Boston', 2, 7, 14//Fotel biurowy
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Atlanta', 2, 3, 13//Fotel
);


//Vintage


insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Aster', 3, 1, 2//Sofa
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Jaskier', 3, 1, 1//Sofa
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Ró¿a', 3, 3, 8//Fotel
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Lilia', 3, 8, 4//£ó¿ko
);


//Sonata

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Maria', 4, 2, 5//Naro¿nik
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Monika', 4, 8, 6//£ó¿ko
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Magdalena', 4, 6, 9//£awa
);



insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Ma³orzata', 4, 6, 11//£awa
);

//Contra

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Natalia', 5, 1, 2//Sofa
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Nina', 5, 3, 8//Fotel
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Natasza', 5, 7, 13//Fotel biurowy
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Nora', 5, 7, 12//Fotel Biurowy
);



// Forte

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Wanda', 6, 1, 1//Sofa
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Weronika', 6, 3, 7//Fotel
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Wiktoria', 6, 5, 10//Podnó¿ek
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Wiola', 6, 5, 11//Podnó¿ek
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Wioletta', 6, 8, 5//£ó¿ko
);

insert into model
(nazwa_modelu, kolekcja_id_kolekcji,
	 rodzaj_id_rodzaju, rozmiar_id_rozmiaru)
values
(
'Waleria', 6, 7, 12//Fotel biorowy
);

//6. Materia³


//1
insert into material
(nazwa_materialu, kolor)
values
(
'Skóra',
'Czarny'
);


//2
insert into material
(nazwa_materialu, kolor)
values
(
'Skóra',
'Czewony'
);


//3
insert into material
(nazwa_materialu, kolor)
values
(
'Skóra',
'Br¹zowy'
);


//4
insert into material
(nazwa_materialu, kolor)
values
(
'Skóra',
'Kremowy'
);


//5
insert into material
(nazwa_materialu, wzor, kolor)
values
(
'Skóra',
'Karbowany',
'Czarny'
);

//6
insert into material
(nazwa_materialu,wzor, kolor)
values
(
'Skóra',
'Karbowany',
'Br¹zowy'
);

//7
insert into material
(nazwa_materialu, kolor)
values
(
'Zamsz',
'Czarny'
);

//8
insert into material
(nazwa_materialu, kolor)
values
(
'Zamsz',
'Br¹zowy'
);

//9
insert into material
(nazwa_materialu,wzor, kolor)
values
(
'Zamsz',
'Kwiatowy',
'Br¹zowy'
);

//10
insert into material
(nazwa_materialu,wzor, kolor)
values
(
'Zamsz',
'Geometryczny',
'Br¹zowy'
);

//11
insert into material
(nazwa_materialu,wzor, kolor)
values
(
'Tkanina',
'Kwiatowy',
'Czerwony'
);

//12
insert into material
(nazwa_materialu,wzor, kolor)
values
(
'Tkanina',
'Kwiatowy',
'Br¹zowy'
);

//12
insert into material
(nazwa_materialu,wzor, kolor)
values
(
'Tkanina',
'Geometryczny',
'Czerwony'
);

//14
insert into material
(nazwa_materialu, kolor)
values
(
'Tkanina',
'Czerwony'
);

//15
insert into material
(nazwa_materialu, kolor)
values
(
'Tkanina',
'Czarny'
);




//7. Produkt – wprowadzanie procedur¹

/* Aby uzyskaæ efekt, ¿e ka¿dy model mo¿na zakupiæ w ka¿dym z materia³ów 
stworzy³am procedurê wkonuj¹c¹ pêtlê w pêtli.
Dodatkowo procedura ta wywo³uje funkcjê tworz¹c¹ nazwê produktu jako zlepek 
nazwy modelu oraz atrybutów u¿ytego materia³u 
aby ka¿dy produkt mia³ ³atwy do odszyfrowania „kod” czym tak naprawde jest.
Procedura ta wykorzystuje równie¿ funkcjê która losuje cene. Jest to cena 
„podstawowa” produktu – przypisana modelowi. 
Przedzia³ losuj¹cy cenê ró¿ni siê zale¿nie od rodzaju jakim jest dany model.
Na cenê dodatkowo ma wp³yw wybrany materia³, jeœli jest to skóra podnosi cenê produktu o 20% natomiast jeœli zamsz to o 10%. 
Tak jest przypisywana ostateczna cena dla konkretnego produktu.*/

/*na pocz¹tek musia³am zmieniæ typ danych dotycz¹cych cen poniewa¿ pocz¹tkowy model mia³ zbyt ma³y przedzia³*/

alter table produkt
modify cena_produktu numeric(10,2);
alter table faktura_detale
modify cena_zakupu numeric(10,2);
alter table faktura_naglowek
modify wartosc_faktury numeric(10,2);




//funkcja losuj¹ca



create or replace function fn_losuj
(v_min integer, v_max integer)
returns numeric(10)
begin
declare v_wylosowana integer;
set v_wylosowana = round(v_min +(v_max- v_min)* rand(),2);
return v_wylosowana;
end;


//funkcja losuj¹ca cenê podstawow¹ produktu bior¹c pod uwagê jego rodzaj

create or replace function fn_model_cena
(v_id_modelu integer)
returns numeric(10,2)
begin
declare v_model_rodzaj integer;
declare v_model_cena numeric(10,2);
select rodzaj_id_rodzaju into v_model_rodzaj
from model
where id_modelu = v_id_modelu;
case v_model_rodzaj
when 1 then set v_model_cena=fn_losuj(400,3000)
when 2 then set v_model_cena=fn_losuj(1000,6000)
when 3 then set v_model_cena=fn_losuj(200,2000)
when 4 then set v_model_cena=fn_losuj(50,200)
when 5 then set v_model_cena=fn_losuj(30,200)
when 6 then set v_model_cena=fn_losuj(100,500)
when 7 then set v_model_cena=fn_losuj(200,2000)
when 8 then set v_model_cena=fn_losuj(800,6000)
end case;
return v_model_cena;
end;


//funkcja tworz¹ca nazwê produktu wed³ug opisanego wy¿ej wzoru

create or replace function fn_produkt_nazwa
(v_id_modelu integer,v_id_materialu integer)
returns varchar(20)
begin
declare v_produkt_nazwa varchar(20);
declare v_model_nazwa varchar(20);
declare v_material_nazwa varchar(20);
declare v_material_wzor varchar(20);
declare v_material_kolor varchar(20);

select nazwa_modelu into v_model_nazwa
from model
where id_modelu = v_id_modelu;
select substring(nazwa_materialu,1,1) into v_material_nazwa
from material
where id_materialu = v_id_materialu;
select substring(wzor,1,2) into v_material_wzor
from material
where id_materialu = v_id_materialu;
select substring(kolor,1,3) into v_material_kolor
from material
where id_materialu = v_id_materialu;
set v_produkt_nazwa = v_model_nazwa||'_'||v_material_nazwa||'_'||v_material_wzor||v_material_kolor;
return v_produkt_nazwa;
end;
//funkcja tworz¹ca cene bior¹c pod uwagê materia³
create or replace function fn_cena_m
(v_id_materialu integer,v_cena numeric(10,2))
returns numeric(10,2)
begin
declare v_material_nazwa varchar(20);
declare v_cena_m numeric(10,2);
select nazwa_materialu into v_material_nazwa
from material
where id_materialu = v_id_materialu;
case v_material_nazwa
when 'Skóra' then set v_cena_m = v_cena+(0.2*v_cena)
when 'Zamsz' then set v_cena_m = v_cena+(0.1*v_cena)
else set v_cena_m=v_cena
end case;
return v_cena_m;
end;


//funkcja uzupe³niaj¹ca tabele produkt wszystkimi mo¿liwymi wariacjami
create or replace procedure pr_utworz_produkt
()
begin

declare v_max_model integer;
declare v_max_material integer;
declare v_nazwa_produktu varchar(20);
declare v_cena numeric(10,2);
declare v_cena_m numeric(10,2);
declare cnt_model integer = 1;
declare cnt_material integer = 1;
select max(id_modelu) into v_max_model
from model;
select max(id_materialu) into v_max_material
from material;
while (cnt_model <= v_max_model) loop
set v_cena=fn_model_cena(cnt_model);
set cnt_material=1;
while (cnt_material <= v_max_material) loop
set v_nazwa_produktu =fn_produkt_nazwa(cnt_model,cnt_material);
set v_cena_m=fn_cena_m(cnt_material,v_cena);
// message v_nazwa_produktu|| ' '||v_cena_m to client;
insert into produkt
(nazwa_produktu,cena_produktu,model_id_modelu,material_id_materialu)
values
(
v_nazwa_produktu,
v_cena_m,
cnt_model,
cnt_material
);
set cnt_material = cnt_material + 1;
end loop;
set cnt_model = cnt_model + 1;
end loop;
end;

//wywo³anie funkcji uzupe³niaj¹cej tabele produkt
begin
call pr_utworz_produkt();
end;


//Generator faktury

// 1. sekwencja tworz¹ca klucze g³ówne dla faktur
CREATE SEQUENCE "seq_n_z6_06_id_faktury" MINVALUE 1 MAXVALUE 1000 INCREMENT BY 1 CYCLE CACHE 50;
alter table faktura_naglowek
modify id_faktury default (seq_n_z6_06_id_faktury.nextval);

// 2. funkcja losuj¹ca klienta z przedzia³u ich id
create or replace function fn_losuj_klienta()
returns integer
begin
declare v_min integer;
declare v_max integer;
declare v_wylosowana integer;
select min(id_klienta), max(id_klienta) into v_min, v_max
from klient;
set v_wylosowana = fn_losuj(v_min, v_max);
return v_wylosowana;
end;

// 3. funkcja losuj¹ca produkt z przedzia³u ich id
create or replace function fn_losuj_produkt
()
returns integer
begin
declare v_min integer;
declare v_max integer;
declare v_wylosowana integer;
select min(id_produktu), max(id_produktu) into v_min, v_max
from produkt;
set v_wylosowana = fn_losuj(v_min, v_max);
return v_wylosowana;
end;

// 4. funkcja pobieraj¹ca cene wybranego produktu
create or replace function fn_pobierz_cene
(v_id_produktu integer)
returns integer
begin
declare v_cena integer;
select cena_produktu into v_cena
from produkt
where id_produktu = v_id_produktu;
return v_cena;
end;

// 5. wyzwalacz na isert
/* update-uj¹cy wartoœæ faktury przy dodaniu nowej pozycji do niej
(przy tworzeniu faktury wartoœæ =0)*/

create or replace trigger tr_ins_faktura_detale
before insert on faktura_detale
referencing new as new_rec
for each row
begin
update faktura_naglowek
set wartosc_faktury=wartosc_faktury + new_rec.cena_zakupu
where id_faktury = new_rec.faktura_naglowek_id_faktury
end;

// 6. funkcja tworz¹ca pozycjê:
//losuje produkt, pobiera cene, losuje iloœæ produktu,
// mno¿y j¹ przez cene, i robi insert w³¹czaj¹c dzia³anie wyzwalacza

create or replace procedure pr_utworz_pozycje
(v_id_faktura integer ,v_id_pozycja integer)
begin
declare v_id_produktu integer;
declare v_cena_produktu numeric(10,2);
declare v_cena_zakupu numeric(10,2);
declare v_liczba integer;
set v_id_produktu=fn_losuj_produkt();
set v_cena_produktu=fn_pobierz_cene(v_id_produktu);
set v_liczba=fn_losuj(1,50);
set v_cena_zakupu= v_cena_produktu * v_liczba;
insert into faktura_detale
values
(
v_id_faktura,
v_id_pozycja,
v_liczba,
v_cena_zakupu,
v_id_produktu
);
end;



// 7. funkcja tworz¹ca now¹ fakturê:

/*Przyjmuje obecn¹ datê, losuje klienta, przypisuje wartoœæi 0 – 
bêziie to zmieniane wyzwalaczem przy dodawaniu pozycji do faktura_detale, 
nastêpnie jest losowane ile bêdzie mia³a pozycji i dodawane s¹ pozycjê 
odpowiedni¹ procedur¹ wywo³ywan¹ w pêtli*/

create or replace procedure pr_utworz_fakture
()
begin
declare v_id_faktury integer;
declare v_data date;
declare v_klient integer;
declare v_wartosc_faktury integer;
declare cnt_pozycja integer;
declare max_pozycja integer;
set v_data = current date;
set v_klient=fn_losuj_klienta();
set v_wartosc_faktury=0;
insert into faktura_naglowek
(data_faktury, wartosc_faktury,klient_id_klienta)
values
(
v_data,
v_wartosc_faktury,
v_klient
);
select max(id_faktury) into v_id_faktury
from faktura_naglowek;
set max_pozycja=fn_losuj(1,10);
set cnt_pozycja =1;
while (cnt_pozycja <= max_pozycja ) loop
call pr_utworz_pozycje(v_id_faktury, cnt_pozycja);
set cnt_pozycja = cnt_pozycja + 1;
end loop;
end;


//6. Perspektywy klasyczne

//1. Prespektywa koniec_gwarancji
/* perspektywa maj¹ca na celu pokazywaæ dla ka¿dego klienta okres gwarancji 
zakupionych produktów, 
klient zazwyczaj bardziej patrzy na rodzaj mebla ewentualnie jego ogolny 
wyglad (z jakiej kolekcji pochodzi) ni¿ ¿e ten produkt mia³ jak¹œ tam nazwê.
Perspektywa pokazuje tylko produkty które nie straci³y swojej gwarancji. */

create or replace view koniec_gwarancji as
select faktura_naglowek.klient_id_klienta as [klient], klient.nazwa_klienta as [nazwa klienta],
rodzaj.nazwa_rodzaju as [rodzaj],
kolekcja.nazwa_kolekcji as [kolekcja], faktura_detale.cena_zakupu as [cena zakupu],
faktura_naglowek.data_faktury ||' - '||date(date(data_faktury)+(gwarancja/12)*365) as [okres gwarancji]
from faktura_naglowek, faktura_detale,produkt,model, kolekcja, rodzaj, klient
where faktura_naglowek.id_faktury=faktura_detale.faktura_naglowek_id_faktury
and faktura_detale.produkt_id_produktu=produkt.id_produktu
and produkt.model_id_modelu=model.id_modelu
and model.rodzaj_id_rodzaju=rodzaj.id_rodzaju
and model.kolekcja_id_kolekcji=kolekcja.id_kolekcji
and faktura_naglowek.klient_id_klienta=klient.id_klienta
and date(date(data_faktury)+(gwarancja/12)*365)>=current date;



//2. Perspektywa model_o_rozmiarze

/* perspektywa ta ma na celu u³atwiæ wyszukiwanie mebli po ich wymiarach, 
stworzona w celu „mam n na m miejsca w salonie, chce tam coœ wstawiæ” dlatego
 te¿ przedstawia ona modele z przeznaczeniem do salonu z wy³¹czeniem podnó¿ka
Mo¿na te¿ dziêki niej wyszukiwaæ po rodzaju aby dowiedzieæ sie o wszystkich 
mo¿liwych modelach (ewentualnie w danym rozmiarze)*/



create or replace view model_o_rozmiarze as
select distinct model.nazwa_modelu as [model], rodzaj.nazwa_rodzaju as [rodzaj],
rozmiar.wymiar_x as [x], rozmiar.wymiar_y as [y], rozmiar.wymiar_z as [z],
str((rozmiar.wymiar_x*rozmiar.wymiar_z)/10000,3,2) as [powierzchnia m2]
from model, rodzaj, rozmiar
where model.rodzaj_id_rodzaju=rodzaj.id_rodzaju
and model.rozmiar_id_rozmiaru=rozmiar.id_rozmiaru
and nazwa_rodzaju != 'Podnó¿ek'
and przeznaczenie ='Salon';





//7. Perspektywy zmaterializowane


//1. Perspektywa zmaterializowana m_wybrany_material_przed_30

/* perspektywa ta pokarze ile razy zosta³ wybrany dany typ materia³u 
(nazwa_materialu) przez klientów, nie biorê pod uwagê u¿ytych metrów 
materia³u a sam fakt jego „popularnoœci”
Ta perspektywa zawiera okres czasu do 30.01.2016 z wy³¹czeniem tego dnia*/

create materialized view m_wybrany_material_przed_30 as
select nazwa_materialu as [material] ,sum(liczba) as [ile razy wybrany]
from faktura_detale, produkt, material,faktura_naglowek
where faktura_detale.produkt_id_produktu= produkt.id_produktu
and produkt.material_id_materialu= material.id_materialu
and faktura_detale.faktura_naglowek_id_faktury=faktura_naglowek.id_faktury
and date(data_faktury) <= date('2016-01-29')
group by nazwa_materialu;

REFRESH MATERIALIZED VIEW m_wybrany_material_przed_30;




//2. Perspektywa zmaterializowana m_wybrany_material
/* Perspektywa ta dzia³a tak jak perspektywa m_wybrany_material_przed_30 
z tym ¿e bierze pod uwagê ca³y okres dzia³alnoœci sklepu */

create materialized view m_wybrany_material as
select nazwa_materialu as [material] ,sum(liczba) as [ile razy wybrany]
from faktura_detale, produkt, material,faktura_naglowek
where faktura_detale.produkt_id_produktu= produkt.id_produktu
and produkt.material_id_materialu= material.id_materialu
and faktura_detale.faktura_naglowek_id_faktury=faktura_naglowek.id_faktury
group by nazwa_materialu;

REFRESH MATERIALIZED VIEW m_wybrany_material;





//3. Perspektywa zmaterializowana m_zarobek_kolekcji

/* W tej perspektywie bedzie pokazywane ile dana kolekcja zarobi³a 
od pocz¹tku dzia³alnoœci sklepu
Dziêki temu mo¿na wyodrêbniæ np najlepsz¹ i najgorsz¹ kolekcjê. 
I póŸniej wykorzystaæ tak¹ informacjê przy wyborze projektantów 
czy tworzeniu nowych kolekcji*/

create materialized view m_zarobek_kolekcji as
select nazwa_kolekcji as [kolekcja] ,sum(cena_zakupu) as [zarobiona suma]
from faktura_detale, produkt, model, kolekcja
where faktura_detale.produkt_id_produktu=produkt.id_produktu
and produkt.model_id_modelu=model.id_modelu
and model.kolekcja_id_kolekcji=kolekcja.id_kolekcji
group by nazwa_kolekcji;

REFRESH MATERIALIZED VIEW m_zarobek_kolekcji;




//4. Perspektywa zmaterializowana m_ile_zakupów_klient

/* Tutaj zostanie pokazane ile ró¿nych produktów kupi³ klient . 
Brane jest jednak pod uwagê uproszczenie ¿e drugi raz kupiony produkt 
(czy to w tej samej czy innej fakturze) traktowany jest jako inny produkt. 
Liczenie odbywa siê poprzez zliczanie pozycji w fakturach na teo klienta Nie 
jest tutaj brana pod uwagê iloœæ zakupionych produktów . */

create materialized view m_ile_zakupow_klient as
select nazwa_klienta as [klient] ,count(pozycja) as [ile zakupów]
from faktura_detale, faktura_naglowek, klient
where faktura_detale.faktura_naglowek_id_faktury=faktura_naglowek.id_faktury
and faktura_naglowek.klient_id_klienta=klient.id_klienta
group by nazwa_klienta;
REFRESH MATERIALIZED VIEW m_ile_zakupow_klient;




//Procedura wywo³uj¹ca utworzenie faktury i zrefreshowanie perspektyw zmaterializowanych 

/*
create or replace procedure pr_generowanie_transakcji 
()
begin

call pr_utworz_fakture();

REFRESH MATERIALIZED VIEW m_wybrany_material;
REFRESH MATERIALIZED VIEW m_zarobek_kolekcji;
REFRESH MATERIALIZED VIEW m_ile_zakupow_klient;

end;

**/

//Procedura wywo³uj¹ca utworzenie faktury i zrefreshowanie perspektyw zmaterializowanych 

create or replace procedure pr_generowanie_faktur 
()
begin

declare v_ile integer;
declare cnt integer;

set v_ile=fn_losuj(1,10);
set cnt=1;

while cnt<=v_ile loop
call pr_utworz_fakture();
set cnt=cnt+1
end loop;

REFRESH MATERIALIZED VIEW m_wybrany_material;
REFRESH MATERIALIZED VIEW m_zarobek_kolekcji;
REFRESH MATERIALIZED VIEW m_ile_zakupow_klient;

end;


call pr_generowanie_faktur();


