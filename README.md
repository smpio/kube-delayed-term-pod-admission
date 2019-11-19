# kube-delayed-term-pod-admission


This is [Admission Webhook](https://kubernetes.io/docs/admin/extensible-admission-controllers/#admission-webhooks) that adds Pod `preStop` hook with some delay:

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
