set @cty_name = "Vilagarcía de Arousa";
set @cty_ctr_cd = "esp";
set @cty_district = "GALICIA";
set @cty_population = 37667;

insert into world.city (`Name`, `CountryCode`, `District`, `Population`)
values (@cty_name, @cty_ctr_cd, @cty_district, @cty_population);

set @cty_name = "cee";
set @cty_ctr_cd = "ESP";
set @cty_district = "galicia";
set @cty_population = 7539;

insert into world.city (`Name`, `CountryCode`, `District`, `Population`)
values (@cty_name, @cty_ctr_cd, @cty_district, @cty_population);

