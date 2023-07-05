-- Definizione degli schemi
CREATE TABLE MAGAZZINO
	(   COD_PROD        	NUMERIC(3) NOT NULL,
	    QTA_DISP           	NUMERIC(5),
	    QTA_RIORD          	NUMERIC(5),
	    PRIMARY KEY (COD_PROD)
	);

CREATE TABLE RIORDINO
	(   COD_PROD           	NUMERIC(3) NOT NULL,
	    DATA               	DATE,
	    QTA_ORD            	NUMERIC(5),
	    PRIMARY KEY (COD_PROD),
	    FOREIGN KEY (COD_PROD) REFERENCES MAGAZZINO (COD_PROD)
	);

-- Stub data
INSERT INTO MAGAZZINO VALUES (1,150,100);
INSERT INTO MAGAZZINO VALUES (3,130,80);
INSERT INTO MAGAZZINO VALUES (4,170,50);
INSERT INTO MAGAZZINO VALUES (5,500,150);

-- Query
create function prelievo(codice_prodotto int, qta_prelievo int) returns int as $$
declare
	qta_disponibile int;
begin
	select qta_disp into qta_disponibile from magazzino where cod_prod = codice_prodotto;
	update magazzino set qta_disp = qta_disponibile - qta_prelievo where cod_prod = codice_prodotto;
	return qta_disponibile - qta_prelievo;
end;
$$
language 'plpgsql';

create function riordino_f() returns trigger as $$
	begin
		if new.qta_disp < 0 then
			raise exception 'Quantità negativa';
		end if;
		
		if new.qta_disp < new.qta_riord then
			insert into riordino values (new.cod_prod, current_date, new.qta_riord);
		end if;
		return new;
	end;
$$
language 'plpgsql';

create trigger riordino_t after update on magazzino for each row when (new.qta_disp < new.qta_riord) execute procedure riordino_f();

select prelievo(4, 150);

create function arrivo_ordine(codice_prodotto int) returns int as $$
	declare
		qr int;  -- Quantità di riordino del prodotto in riordino
		qd int;  -- Quantità disponibile del prodotto in magazzino
	begin
		if not exists (select * from riordino where cod_prod = codice_prodotto) then
			raise exception 'Prodotto non in riordino';
		end if;
		
		select qta_ord into qr from riordino where cod_prod = codice_prodotto;
		select qta_disp into qd from magazzino where cod_prod = codice_prodotto;
		delete from riordino where cod_prod = codice_prodotto;
		update magazzino set qta_disp = qd + qr where cod_prod = codice_prodotto;
		return qd + qr;
	end;
$$ language 'plpgsql';

select arrivo_ordine(4);
