#!/bin/bash

# This script simulates a simplified GitOps reconciliation loop.
# It compares a 'desired state' (from a simulated Git repo) with an 'actual state' (on a simulated cluster)
# and applies changes if they differ, mimicking how tools like Argo CD or Flux work.

# --- Simulate Desired State (from Git repository) ---
# In a real GitOps setup, this content would be fetched from a Git repository.
# We'll create a temporary file for demonstration.
DESIRED_STATE_FILE="desired_state.yaml"
cat << 'EOF_DESIRED' > "$DESIRED_STATE_FILE"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gitops-nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 2 # GitOps: This is our desired number of replicas
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21.0 # GitOps: This is our desired image version
        ports:
        - containerPort: 80
EOF_DESIRED

echo "--- Desired State (from 'Git') ---"
cat "$DESIRED_STATE_FILE"
echo ""

# --- Simulate Actual State (on the 'cluster') ---
# In a real GitOps setup, this would be fetched from the Kubernetes API.
# We'll use another temporary file to represent the current state on the cluster.
ACTUAL_STATE_FILE="actual_state.yaml"

# Initialize actual state if it doesn't exist or is empty, simulating an initial deployment or drift.
if [ ! -f "$ACTUAL_STATE_FILE" ] || [ ! -s "$ACTUAL_STATE_FILE" ]; then
    echo "Initializing actual state (first run or empty, simulating a previous state or drift)."
    cat << 'EOF_ACTUAL_INITIAL' > "$ACTUAL_STATE_FILE"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gitops-nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 1 # Simulating an actual state with 1 replica (different from desired)
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.20.0 # Simulating an actual image version (different from desired)
        ports:
        - containerPort: 80
EOF_ACTUAL_INITIAL
fi

echo "--- Current Actual State (on 'cluster') ---"
cat "$ACTUAL_STATE_FILE"
echo ""

# --- GitOps Reconciliation Loop ---
echo "--- Running GitOps Reconciliation ---"

# Compare desired and actual states. `cmp -s` returns 0 if files are identical, non-zero otherwise.
if cmp -s "$DESIRED_STATE_FILE" "$ACTUAL_STATE_FILE"; then
    echo "Desired state matches actual state. No changes needed."
else
    echo "Desired state differs from actual state. Applying changes..."
    # In a real GitOps tool (like Argo CD or Flux), this would be `kubectl apply -f desired_state.yaml`
    # Here, we simulate by updating the actual_state.yaml to match the desired_state.
    cp "$DESIRED_STATE_FILE" "$ACTUAL_STATE_FILE"
    echo "Changes applied. Actual state updated to match desired state."
fi

echo ""
echo "--- New Actual State (after reconciliation) ---"
cat "$ACTUAL_STATE_FILE"
echo ""

echo "To demonstrate further, modify '$DESIRED_STATE_FILE' (simulating a Git commit) or"
echo "'$ACTUAL_STATE_FILE' (simulating cluster drift) manually and re-run this script."
