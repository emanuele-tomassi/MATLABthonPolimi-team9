Nella cartella sono presenti:
-lo script principale
-uno script di prova
-un'immagine per il messaggio finale
-i dati GPS delle nostre pizzerie preferite
-script che salva dati delle pizzerie in formato .mat


L'idea di base è di mostrare dati in tempo reale: percorso tramite GPS, accelerazione, velocità.
Un'ulteriore output sono i numero di passi effettuati.

Si runna il codice su Matlab, in contemporanea lo smartphone invia al programma i dati registrati dal sensore.
Tramite un ciclo while si ottiene il plot in tempo reale, fino a quando non si interrompe la comunicazione dal telefono (di default sono impostate 2 h di limite).


Un utilizzo del codice, con i dovuti perfezionamenti, potrebbe essere quello di supporto per un runner, in modo tale che lo aiuti a tener traccia delle sue performance.


Informazioni Tecniche:
Il dato di posizione viene ottenuto tramite i dati forniti dal sistema GPS e plottati su una mappa centrata sulla posizione dell'utilizzatore. Edifici e ambienti chiusi disturbano il segnale del satellite, per questo si consiglia l'utilizzo all'aperto del programma.
Per quanto concerne il calcolo delle velocità, si ottengono le accelerazioni tramite gli accelerometri posti nel cellulare e tramite metodo di integrazione dei trapezi, si ricava l'andamento della velocità nel tempo. 
|| NOTA || data la sensibilità degli accelerometri, il grafico è di difficile interpretazione, si guardi la linea ROSSA ottenuta tramite filtrazione dei dati ottenuti.
Al termine del programma si ottengono dati sulla distanza percorsa ed il numero di passi fatti.

Easter egg: al termine del percorso uscirà qual è la pizzeria più vicino da un elenco delle tue preferite.