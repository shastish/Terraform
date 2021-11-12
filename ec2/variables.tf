variable "vpcid" {
    default = "vpc-01266b519bf4c8813"
}
variable "subnetCIDRblock" {
    default = "subnet-0f44ac1bacfdcc23b"
}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
