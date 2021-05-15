#!/bin/sh

echo "Enter the pod name" 
read NAME
echo "Enter the pod namespace"
read NAMESPACE

node_id=$(oc get pod $NAME -o jsonpath={.spec.nodeName} -n $NAMESPACE)
echo $node_id

pod_id=$(oc debug node/$node_id -- chroot /host crictl pods --namespace ${NAMESPACE} --name ${NAME} -q)

echo $pod_id

cpid=$(oc debug node/$node_id -- chroot /host bash -c "runc state $pod_id | jq .pid")

echo $cpid

oc debug node/$node_id -- nsenter -t $cpid -n tcpdump -nn -i any -w /host/tmp/${node_id}_pod-${NAME}-$(date +\%d_%m_%Y-%H_%M_%S-%Z).pcap
