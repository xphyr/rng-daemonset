# RNGD on OpenShift

So you are using up all your randomness and need to seed /dev/random using the rngd util... well here is how you do it:

## Build Container Image and push

Use the included Dockerfile to generate a container image with the rng-tools installed

```
$ podman build -t <myregistry>/rngd-utils:latest .
$ podman push <myregistry>/rngd-utils:latest
```

## Update the rngd-daemonset.yml file

Edit the `k8s/rng-daemonset.yml` file to point to the image you pushed in the previous section:

```
          image: <myregistry>/rngutils/rngutils:latest
```

>**NOTE:** The command line options in the rng-daemonset.yml file are designed to run on Intel Processors that support the Intel RDRAND Instruction set. You may need to tweak the options to meet your hardware needs. See [rng-tools](https://github.com/nhorman/rng-tools) for other options.

## Deploy the DaemonSet

Create a new project for this app to run:

```
$ oc new-project rngtools
```

### Give the default service account the ability to run pods as privileged

You will need to give the default service account the scc privileged policy.

```
$ oc adm policy add-scc-to-user privileged system:serviceaccount:rngtools:default
```

### Create the daemonset

```
$ oc create -f k8s/rng-daemonset.yaml
```