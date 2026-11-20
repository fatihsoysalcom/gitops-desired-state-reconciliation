# GitOps Desired State Reconciliation

This example demonstrates the core GitOps principle of defining a desired application state and continuously reconciling an actual state to match it. It simulates this process by comparing two local YAML files (representing a Git repository and a Kubernetes cluster) and applying changes when discrepancies are found.

## Language

`bash`

## How to Run

1. Save the code as `gitops_reconcile.sh`.
2. Make it executable: `chmod +x gitops_reconcile.sh`.
3. Run it: `./gitops_reconcile.sh`.
4. Modify `actual_state.yaml` or `desired_state.yaml` (created by the script) and re-run to observe reconciliation.

## Original Article

This example accompanies the Turkish article: [Küçük k3s Kümeleri İçin GitOps: Argo CD, Flux ve Pratik Dengeler](https://fatihsoysal.com/blog/kucuk-k3s-kumeleri-icin-gitops-argo-cd-flux-ve-pratik-dengeler/).

## License

MIT — see [LICENSE](LICENSE).
