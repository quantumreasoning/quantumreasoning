NAME=platform
NAMESPACE=quantum-system

show:
	quantumpkg show -n $(NAMESPACE) $(NAME) --plain

apply:
	quantumpkg show -n $(NAMESPACE) $(NAME) --plain | kubectl apply -f-
	kubectl delete helmreleases.helm.toolkit.fluxcd.io -l quantumreasoning.io/marked-for-deletion=true -A

reconcile: apply

namespaces-show:
	quantumpkg show -n $(NAMESPACE) $(NAME) --plain -s templates/namespaces.yaml

namespaces-apply:
	quantumpkg show -n $(NAMESPACE) $(NAME) --plain -s templates/namespaces.yaml | kubectl apply -f-

diff:
	quantumpkg show -n $(NAMESPACE) $(NAME) --plain | kubectl diff -f-
