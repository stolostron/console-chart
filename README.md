[comment]: # ( Copyright Contributors to the Open Cluster Management project )

# console-chart

[![License](https://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)

## What is console-chart?
A Helm chart for Open Cluster Management [console](https://github.com/open-cluster-management/console).

Go to the [Contributing guide](CONTRIBUTING.md) to learn how to get involved.

## Testing chart changes

To test chart changes against a running open-cluster-management kubernetes cluster:
NOTE: The following commands assume a namespace of `open-cluster-management`

- Login to the open-cluster-management cluster

  ```
  oc login
  ```

- Push the new chart onto the existing cluster:

  ```
  oc annotate mch multiclusterhub mch-pause=true -n open-cluster-management --overwrite

  helm get values  -n open-cluster-management `helm ls -n open-cluster-management | cut -d' ' -f1 | grep console-chart` > old-values.yaml

  oc delete appsub console-chart-sub  -n open-cluster-management

  helm install console-chart stable/console-chart -f old-values.yaml -n open-cluster-management
  ```

- Make sure the `helm install` command worked and the console is still working.

- To revert the changes and use the original chart

  ```
  helm uninstall console-chart -n open-cluster-management

  oc annotate mch multiclusterhub mch-pause=false -n open-cluster-management --overwrite
  ```



## References
`console-chart` is part of the open-cluster-management community. For more information, visit: [open-cluster-management.io](https://open-cluster-management.io)
