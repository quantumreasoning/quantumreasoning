### How to test packages local

```bash
cd packages/core/installer
make image-quantumreasoning REGISTRY=YOUR_CUSTOM_REGISTRY
make apply
kubectl delete pod dashboard-redis-master-0 -n quantum-dashboard
kubectl delete po -l app=source-controller -n quantum-fluxcd
```
