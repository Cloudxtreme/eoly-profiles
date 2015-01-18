class profiles::java {

  class { '::java': }
  contain '::java'
  
}
