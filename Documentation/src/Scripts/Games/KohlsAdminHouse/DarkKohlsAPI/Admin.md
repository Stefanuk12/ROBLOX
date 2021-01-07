# Admin Module

## Regenerate Admin
```
<<boolean success>, <string error>> KohlsAPI.Admin.RegenerateAdmin()
```
Regenerates the admin

## Get Admin
```
<<boolean success>, <string error>> KohlsAPI.Admin.GetAdmin(<Instance> SpecifyPad)
```
Automatically gets admin, and if specified, it tries to get the `SpecifyPad`

## Permanant Admin
```
<<boolean success>, <string error>>  KohlsAPI.SettingGetSet("AdminPermanantAdmin", Value);
```
Gets admin as soon as it is regenerated