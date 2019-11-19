# kube-delayed-term-pod-admission

After marking container as terminating and before sending SIGTERM wait some amount of time until all cluster loadbalancers and proxies stop sending traffic to this pod. See https://github.com/kubernetes/kubernetes/issues/43576#issuecomment-297731021 and https://blog.gruntwork.io/delaying-shutdown-to-wait-for-pod-deletion-propagation-445f779a8304 for details.

Delay depends on size of the cluster. Use the following command from different pod to test traffic failures during rolling update: `while true; do curl -sSO SERVICE_IP/healthz; echo -n '*'; done`.

This [Admission Webhook](https://kubernetes.io/docs/admin/extensible-admission-controllers/#admission-webhooks) adds Pod `preStop` hook with some delay:

```
lifecycle:
  preStop:
    exec:
      command:
      - sleep
      - 30s
terminationGracePeriodSeconds: 60  # default 30 + sleep 30
```

It also increases `terminationGracePeriodSeconds` with that delay.

## Installation

See [Kubernetes docs](https://kubernetes.io/docs/admin/extensible-admission-controllers/#admission-webhooks).


## Usage

Add pod template annotation `k8s.smp.io/delayed-termination=true` to your workloads and new pods will modified.
