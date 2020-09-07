resource "kubernetes_namespace" "spark" {
  metadata {
    name = "spark-operator"
  }
}

resource "helm_release" "spark_op" {
  repository      = "http://storage.googleapis.com/kubernetes-charts-incubator"
  chart           = "sparkoperator"
  name            = "sparkoperator"
  namespace       = kubernetes_namespace.spark.metadata[0].name
  cleanup_on_fail = true
  atomic          = true
  wait            = true
}