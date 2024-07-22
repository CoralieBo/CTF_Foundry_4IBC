# Solutions

## function 1 : flip
Vue qu'il y a un require qui empeche de lancer la tx dans le meme block il faut attendre qu'il y en ai un nouveau. Vue qu'il y a très peu de chance de tomber sur true j'ai mis false car j'avais la flemme de faire le calcul pour trouver le resultat.

## function 2 : addPoint
Vue que tx.orign (c'est a dire le signer) doit etre different du msg.sender (c'est a dire le caller de la fonction) j'ai utiliser un proxy pour que le msg.sender soit le proxy

## function 3 : transfer
Avant la version 8 il fallait utiliser safeMath pour gerer les calculs car un uint256 ne peut pas etre négatif. Du coup ça entraine un underflow et on peut transferer plus que ce qu'on a.

## function 4 : goTo
Vue qu'il y a juste une interface de Building et que le contract import Building a l'address msg.sender, il suffit de créer un contract en mettant ce qu'on veut dans la fonction isLastFloor et d'appeler la fonction avec ce contract.

## function 5 : sendKey
On doit accéder à data[12] du coup il faut lire le storage du contract. Et data[12] est en 16e.

## function 6 : sendPassword
Pareil que sendKey, juste la variable password est en 3e.

## function 7 : receive
Ici il fallait contribuer pour pouvoir envoyer de l'argent donc j'ai lancer la fonction contribute en mettant moins de 0.001 car sinon la fonction est revert