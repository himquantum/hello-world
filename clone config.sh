#!/bin/bash

NAMESPACE="<your-namespace>"  # Replace with your actual namespace
INPUT_FILE="mycon.txt"        # File containing original ConfigMap names

# Loop through each ConfigMap name in the file
while IFS= read -r CONFIGMAP; do
    echo "Cloning ConfigMap: $CONFIGMAP"

    # Fetch existing ConfigMap and create -streaming clone
    kubectl get configmap "$CONFIGMAP" -n "$NAMESPACE" -o yaml | \
    sed "s/name: $CONFIGMAP/name: ${CONFIGMAP}-streaming/g" | \
    sed '/uid:/d' | sed '/resourceVersion:/d' | sed '/creationTimestamp:/d' | \
    kubectl apply -f -

    # Fetch existing ConfigMap and create -batch clone
    kubectl get configmap "$CONFIGMAP" -n "$NAMESPACE" -o yaml | \
    sed "s/name: $CONFIGMAP/name: ${CONFIGMAP}-batch/g" | \
    sed '/uid:/d' | sed '/resourceVersion:/d' | sed '/creationTimestamp:/d' | \
    kubectl apply -f -

    echo "Created ${CONFIGMAP}-streaming and ${CONFIGMAP}-batch"
done < "$INPUT_FILE"

echo "All ConfigMaps cloned successfully!"