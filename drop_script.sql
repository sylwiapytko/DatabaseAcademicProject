drop function fn_losuj;
drop function fn_model_cena;
drop function fn_produkt_nazwa;
drop function fn_cena_m;
drop procedure pr_utworz_produkt;

drop function fn_losuj_klienta;
drop function fn_losuj_produkt;
drop function fn_pobierz_cene;

//drop trigger tr_ins_faktura_detale;

drop procedure pr_utworz_pozycje;
drop procedure pr_utworz_fakture;

drop procedure pr_generowanie_faktur;

drop sequence seq_n_z6_06_id_klienta;
drop sequence seq_n_z6_06_id_kolekcji;
drop sequence seq_n_z6_06_id_rozmiaru;
drop sequence seq_n_z6_06_id_rodzaju;
drop sequence seq_n_z6_06_id_modelu;
drop sequence seq_n_z6_06_id_materialu;
drop sequence seq_n_z6_06_id_produktu;
drop sequence seq_n_z6_06_id_faktury;


drop view koniec_gwarancji;
drop view model_o_rozmiarze;

drop materialized view m_ile_zakupow_klient;
drop materialized view m_zarobek_kolekcji;
drop materialized view m_wybrany_material;
drop materialized view m_wybrany_material_przed_30;




drop table faktura_naglowek;
drop table faktura_detale;
drop table klient;
drop table produkt;
drop table material;
drop table model;
drop table kolekcja;
drop table rodzaj;
drop table rozmiar;