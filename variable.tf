variable "cidr_value" {
  type        = string
  default     = "12.0.0.0/16"
}

variable "subnet_value"{
  type = list
  default = ["12.0.1.0/24" , "12.0.2.0/24"]
}

variable "az_values"{
    type = list
    default = [ "ap-south-1a", "ap-south-1b"]
}

variable "sg_ports"{
    type =  list
    default = [22, 80]
}
