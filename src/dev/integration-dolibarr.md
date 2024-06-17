# Intégration Dolibarr

## Idéé générale

Stripe est utilisé pour collecter les paiements.

Pour des raisons de simplicité, on a intérêt à générer les factures des abonnements dans Stripe car les utilisateurs peuvent les télécharger depuis leur compte Stripe.

Pour utiliser Dolibarr pour la compatibilité, il faut une synchro depuis l'appli principale (Aipress24) et depuis Stripe:

- Depuis Aipress24: on créé ou met à jour les tiers (clients et partenaires) dans Dolibarr, à partir des infos connues de Aipress24.
- Depuis Stripe: un script (cron) récupère les factures de Stripe et les importe dans Dolibarr.
- Quoi d'autre ?

### Synchro des tiers

Dolibarr propose un explorateur d'API (par ex: https://dolibarr.aipress24.com/api/index.php/explorer/#!/thirdparties/listThirdparties) mais ne documente pas le détail des structures JSON.

Comme expliqué dans la doc: "Les méthodes et paramètres sont détectées en fonction de l'introspection réalisée dans les classes PHP de l'objet (htdocs/monmodule/class/object.class.php) en utilisant les annotations trouvées dans la classe."

Mais on doit pouvoir s'en tirer en créant les tiers à la main et en regardand le JSON généré.

### Synchro des factures

La liste des factures est accessible depuis Stripe: https://stripe.com/docs/api/invoices/list

Même remarque que ci-dessus pour ce qui concerne Dolibarr.

### Exécution de la synchro

La synchro peut s'effectuer en batch (toutes les nuits) ou au fil de l'eau (à chaque création/modification de tiers ou de facture).

Il nous semble plus simple de procéder par batch.
