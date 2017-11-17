---
title: Come realizzare un Domain Controller Active Directory con Linux e Samba4
css: 'css/custom.css,css/font-awesome.min.css'
scripts: 'scripts/custom.js'
revealOptions:
    transition: 'none'

description: |
  AGENDA:
  1) Samba DC: cosa è, disponibilità su distro Linux
  2) Problematiche su CentOS:
       - Compilazione
       - Compatibilità MIT kerberos
  3) Samba DC e file server, perchè separare i ruoli
  4) Linux containers su CentOS 7
  5) Amministrazione AD su Linux:
    - RSAT Tools
    - Creare una GPO con RSAT
  6) Active Directory e NethServer 7


---

<b style="font-size: 1.1em">Come realizzare<br>
un Domain Controller Active Directory<br>
con Linux e Samba 4</b>

<i class="fa fa-database" aria-hidden="true"></i>

22 Novembre '17 &ndash; *Inside E-Learning*

[@davideprincipi](https://twitter.com/davideprincipi) - [@NethServer](https://twitter.com/NethServer)

---

## Il progetto Samba

*opening windows to a wider world*

* (Re)Implementazione dei protocolli SMB/CIFS per la condivisione di file/stampanti in rete <!-- .element: class="fragment" -->

* Nato in Australia nei primi anni '90 <!-- .element: class="fragment" -->

* Software Libero (licenza GNU/GPLv3) <!-- .element: class="fragment" -->

* Disponibile Unix, OpenVMS, Unix-like...  <!-- .element: class="fragment" --> <span>(Linux)</span> <!-- .element: class="fragment" -->

http://www.samba.org &ndash; fonte [wikipedia](https://en.wikipedia.org/wiki/Samba_(software)

Note:

    - 25 anni di sviluppo

---

## Samba Active Directory

* (Re)Implementazione dei servizi di rete di Microsoft Active Directory&trade; <!-- .element: class="fragment" -->

* <div>smb.conf<br><code style="font-size: smaller">server role =  active directory domain controller</code> &ndash; (DC)</div> <!-- .element: class="fragment" -->

* Disponibile a partire da Samba 4.0.0<br>rilasciata l'11 dicembre '12 <!-- .element: class="fragment" -->

---

### Il ruolo DC su CentOS 7

<span>non c'è <i class="fa fa-frown-o" aria-hidden="true"></i></span> <!-- .element: class="fragment" -->

<div>
I sistemi Fedora e derivati (come RHEL, CentOS) non hanno il ruolo DC disponibile
```text
# rpm -ql samba-dc
/usr/share/doc/samba-dc-4.6.2/README.dc```
</div> <!-- .element: class="fragment" -->

---

``cat README.dc``

> The Samba build in Fedora is using <u>MIT Kerberos</u> implementation in order
> to allow system-wide interoperability between both desktop and server
> applications running on the same machine.

<div style="text-align: right">(continua)</div>

---

(segue)

>  <span class="fragment strike" data-fragment-index="1">At the moment</span> the Samba Active Directory Domain Controller implementation is
> <span class="fragment strike" data-fragment-index="1">not</span> available with <u>MIT Kerberos</u>.

Disponibile dalla 4.7 &ndash; 20 settembre '17 <!-- .element: class="fragment"  data-fragment-index="1" -->

---

### Il ruolo DC su CentOS 7 &ndash; riepilogo

* Disponibile RPM samba-4.6 <span>*senza DC*</span> <!-- .element: class="fragment" -->

* <div>Possibile ricompilare dai sorgenti ufficiali Samba, con incluse le librerie Heimdal Kerberos
```text
$ ./configure
$ make
$ sudo make install
```
</div> <!-- .element: class="fragment" -->

<div>...ma non possiamo installare pacchetti dipendenti da MIT Kerberos <i class="fa fa-frown-o" aria-hidden="true"></i></div> <!-- .element: class="fragment" -->

---

### Il ruolo DC su CentOS 7 &ndash; soluzione <span class="fragment strike" data-fragment-index="1">0</span> <span class="fragment fade-in" data-fragment-index="1">0.1</span>

* Ricompilare dai sorgenti ufficiali Samba

* Macchina (virtuale) dedicata esclusivamente al ruolo DC <span class="fragment strike" data-fragment-index="1">+ file server</span>

* Ruolo di file server su macchina separata (consigliato da Samba in siti grandi) con RPM samba-4.6 di CentOS 7<!-- .element: class="fragment"  data-fragment-index="1" -->

---

### Perché separare i ruoli (1)

> Su siti più grandi il sapere che il file server e il DC possono essere configurati,
> aggiornati e replicati in maniera indipendente sarà di lunga più importante, quindi
> segui il nostro consiglio di separare questi ruoli. &ndash; [Andrew Bartlett](https://lists.samba.org/archive/samba/2013-March/172156.html) (Samba Team)

---

### Perché separare i ruoli (2)

* Almeno per il ruolo di file server i pacchetti ufficiali della distro sono stabili

* Contengono le patch di sicurezza testate

* Aggiornamenti automatici

* <div>Invece, ricompilare "a mano" ci costringe a testare e aggiornare noi: una bella fatica! <i class="fa fa-wrench" aria-hidden="true"></i></div> <!-- .element: class="fragment" -->

---

### Anatomia di NethServer

|   |    | |
| - | ------ | ------------------------ |
| 3 | Web UI | Server Manager ⇨ <b>Nethgui</b> |
| 2 | Configuration manager | DB, events, templates, actions ⇨ <b>e-smith</b> |
| 1 | Upstream distro | CentOS 7 |

---

<i class="fa fa-database" aria-hidden="true"></i>

[@davideprincipi](https://twitter.com/davideprincipi) - [@NethServer](https://twitter.com/NethServer)
